package branch_hierarchy

import future.keywords

test_max_of if {
	max_of(["read_only", "full", "limited"]) == "full"
	max_of(["read_only", "full", null]) == "full"
	max_of([null, "limited", "read_only", null]) == "limited"
	max_of(["read_only", null]) == "read_only"
	max_of([null, null]) == null
}
