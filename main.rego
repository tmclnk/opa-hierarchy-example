################################################################################
# This file contains the top-level rules used to make determinations.
# Remember that base documents (those containing user info, the role tree, and
# the org tree) AND virtual documents (those calculated below) are both
# access via the global variable called "data".
################################################################################
package rules

# Look up the user's level for the given securable object.
# Example Input:
# { "user": { "name": "rob", "current_branch": "001" }, "securable_object":"CM_ENTRY"}
main = msg {
	msg := effective_security_level[input.securable_object]
}

# Path, as array[string], of the branch_names from the given branch back to the root node.
# Each node can only have a single parent.
edge_path(branch_name) := graph.reachable_paths(org_parent_graph, {branch_name})[_]

# A digraph for each node and its children.
# map[string, set[string]]
org_parent_graph[entity_name] := set {
	node := data.dataset.org_chart_data[entity_name]
	set := {node.parent}
}

# TODO this is probably pretty inefficient. It was the first thing I wrote, and the most complicated.

user_permissions := comp {
	perms := {securable_objects[s]: permissions |
		securable_objects := {securable_object |
			role := user.roles[_]
			data.dataset.role_data[role][securable_object]
		}

		permissions := [permission_set |
			data.dataset.role_data[role][securable_object]
			user.roles[_] = role
			securable_object = s
			permission_set := data.dataset.role_data[role][securable_object]
		]
	}

	comp := flattened_perms(perms)
}

flattened_perms(permission_map) := comp {
	comp := {key: securable_objects |
		permission_map[key]
		so = key
		securable_objects := {branch_level: security_levels |
			permission_map[_][_][branch_level]
			security_levels := {sl |
				sl := permission_map[so][_][branch_level]
			}
		}
	}
}

levels := {
	"full": 3,
	"limited": 2,
	"read_only": 1,
	null: 0,
}

inverse_levels := {k: v | k = levels[v]}

max_of(set) := inverse_levels[max({val | val := levels[set[_]]})]

# This is the primary rule. It will return the string-valued security_level
# for the securable_object. If the user doesn't have access to the securable_object,
# the rule is undefined.
effective_security_level[securable_object] := max_of(user_permissions[securable_object][sprintf("%v", [effective_branch_level])])

# The set of security_levels the user has for the given securable_object,
# sans any rollup, i.e. this may have {"full", "limited"} even though
# the effective level is full. See effective_security_level for the final rollup.
effective_security_levels[securable_object] := user_permissions[securable_object][sprintf("%v", [effective_branch_level])]

# Shows which level's security_level should be used. This is a number
# from 1-n, where n is the "level" of the root node, e.g. the "company".
# By convention, "branches" are level 1.
effective_branch_level := [k |
	def := edge_path(user.default_branch)
	cur := edge_path(user.current_branch)
	cur[k] = def[k]
][0] + 1

# We're combining user info here, which is probably a bad idea
user := object.union(input.user, data.dataset.user_data[input.user.name])
