package branch_hierarchy

# TODO this is probably pretty inefficient. It was the first thing I wrote, and the most complicated.

user_permissions := comp {
	perms := {securable_objects[s]: permissions |
		securable_objects := {securable_object |
			role := user.roles[_]
			data.role_data[role][securable_object]
		}

		permissions := [permission_set |
			data.role_data[role][securable_object]
			user.roles[_] = role
			securable_object = s
			permission_set := data.role_data[role][securable_object]
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
