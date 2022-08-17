################################################################################
# This file contains the top-level rules used to make determinations.
# Remember that base documents (those containing user info, the role tree, and
# the org tree) AND virtual documents (those calculated below) are both
# access via the global variable called "data".
################################################################################
package rules

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
user := object.union(input.user, data.user_data[input.user.name])
