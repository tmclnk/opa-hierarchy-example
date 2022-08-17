package rules

import future.keywords

test_example_1 if {
	1 == effective_branch_level with input as {"user": {"name": "sam", "current_branch": "001"}}
	"full" == effective_security_level.SO_ENTRY with input as {"user": {"name": "sam", "current_branch": "001"}}

	2 == effective_branch_level with input as {"user": {"name": "sam", "current_branch": "002"}}
	"read_only" == effective_security_level.SO_ENTRY with input as {"user": {"name": "sam", "current_branch": "002"}}
	2 == effective_branch_level with input as {"user": {"name": "sam", "current_branch": "003"}}
	"read_only" == effective_security_level.SO_ENTRY with input as {"user": {"name": "sam", "current_branch": "003"}}

	3 == effective_branch_level with input as {"user": {"name": "sam", "current_branch": "004"}}
	"read_only" == effective_security_level.SO_ENTRY with input as {"user": {"name": "sam", "current_branch": "004"}}
	"read_only" == effective_security_level.SO_ENTRY with input as {"user": {"name": "sam", "current_branch": "005"}}
	"read_only" == effective_security_level.SO_ENTRY with input as {"user": {"name": "sam", "current_branch": "006"}}

	"read_only" == effective_security_level.CM_ENTRY with input as {"user": {"name": "sam", "current_branch": "004"}}
	"read_only" == effective_security_level.CM_ENTRY with input as {"user": {"name": "sam", "current_branch": "005"}}
	"read_only" == effective_security_level.CM_ENTRY with input as {"user": {"name": "sam", "current_branch": "006"}}
}

test_example_2 if {
	1 == effective_branch_level with input as {"user": {"name": "rob", "current_branch": "001"}}
	"full" == effective_security_level.SO_ENTRY with input as {"user": {"name": "rob", "current_branch": "001"}}
	"full" == effective_security_level.CANCEL_SOS with input as {"user": {"name": "rob", "current_branch": "001"}}
	"full" == effective_security_level.CANCEL_CMS with input as {"user": {"name": "rob", "current_branch": "001"}}
	"full" == effective_security_level.PO_ENTRY with input as {"user": {"name": "rob", "current_branch": "001"}}

	2 == effective_branch_level with input as {"user": {"name": "rob", "current_branch": "002"}}
	"full" == effective_security_level.PO_ENTRY with input as {"user": {"name": "rob", "current_branch": "002"}}
	"full" == effective_security_level.CM_ENTRY with input as {"user": {"name": "rob", "current_branch": "002"}}
	"full" == effective_security_level.PO_ENTRY with input as {"user": {"name": "rob", "current_branch": "002"}}

	2 == effective_branch_level with input as {"user": {"name": "rob", "current_branch": "003"}}
	"full" == effective_security_level.PO_ENTRY with input as {"user": {"name": "rob", "current_branch": "003"}}
	"full" == effective_security_level.CM_ENTRY with input as {"user": {"name": "rob", "current_branch": "003"}}
	"full" == effective_security_level.PO_ENTRY with input as {"user": {"name": "rob", "current_branch": "003"}}

	3 == effective_branch_level with input as {"user": {"name": "rob", "current_branch": "004"}}
	"read_only" == effective_security_level.SO_ENTRY with input as {"user": {"name": "rob", "current_branch": "004"}}
	"read_only" == effective_security_level.CM_ENTRY with input as {"user": {"name": "rob", "current_branch": "004"}}
	"read_only" == effective_security_level.PO_ENTRY with input as {"user": {"name": "rob", "current_branch": "004"}}
	3 == effective_branch_level with input as {"user": {"name": "rob", "current_branch": "005"}}
	"read_only" == effective_security_level.SO_ENTRY with input as {"user": {"name": "rob", "current_branch": "005"}}
	"read_only" == effective_security_level.CM_ENTRY with input as {"user": {"name": "rob", "current_branch": "005"}}
	"read_only" == effective_security_level.PO_ENTRY with input as {"user": {"name": "rob", "current_branch": "005"}}
	3 == effective_branch_level with input as {"user": {"name": "rob", "current_branch": "006"}}
	"read_only" == effective_security_level.SO_ENTRY with input as {"user": {"name": "rob", "current_branch": "006"}}
	"read_only" == effective_security_level.CM_ENTRY with input as {"user": {"name": "rob", "current_branch": "006"}}
	"read_only" == effective_security_level.PO_ENTRY with input as {"user": {"name": "rob", "current_branch": "006"}}

	4 == effective_branch_level with input as {"user": {"name": "rob", "current_branch": "103"}}
	"read_only" == effective_security_level.SO_ENTRY with input as {"user": {"name": "rob", "current_branch": "103"}}
	"read_only" == effective_security_level.CM_ENTRY with input as {"user": {"name": "rob", "current_branch": "103"}}
	"read_only" == effective_security_level.PO_ENTRY with input as {"user": {"name": "rob", "current_branch": "103"}}
}

test_example_3 if {
	1 == effective_branch_level with input as {"user": {"name": "bob", "current_branch": "001"}}
	"full" == effective_security_level.SO_ENTRY with input as {"user": {"name": "bob", "current_branch": "001"}}
	"full" == effective_security_level.ENTER_PAYMENTS_IN_SO_CM_ENTRY with input as {"user": {"name": "bob", "current_branch": "001"}}

	2 == effective_branch_level with input as {"user": {"name": "bob", "current_branch": "002"}}
	"full" == effective_security_level.SO_ENTRY with input as {"user": {"name": "bob", "current_branch": "002"}}
	2 == effective_branch_level with input as {"user": {"name": "bob", "current_branch": "003"}}
	"full" == effective_security_level.SO_ENTRY with input as {"user": {"name": "bob", "current_branch": "003"}}

	3 == effective_branch_level with input as {"user": {"name": "bob", "current_branch": "004"}}
	"full" == effective_security_level.SO_ENTRY with input as {"user": {"name": "bob", "current_branch": "004"}}
	3 == effective_branch_level with input as {"user": {"name": "bob", "current_branch": "005"}}
	"full" == effective_security_level.SO_ENTRY with input as {"user": {"name": "bob", "current_branch": "005"}}

	4 == effective_branch_level with input as {"user": {"name": "bob", "current_branch": "101"}}
	"read_only" == effective_security_level.SO_ENTRY with input as {"user": {"name": "bob", "current_branch": "101"}}
	4 == effective_branch_level with input as {"user": {"name": "bob", "current_branch": "102"}}
	"read_only" == effective_security_level.SO_ENTRY with input as {"user": {"name": "bob", "current_branch": "102"}}
	4 == effective_branch_level with input as {"user": {"name": "bob", "current_branch": "103"}}
	"read_only" == effective_security_level.SO_ENTRY with input as {"user": {"name": "bob", "current_branch": "103"}}
}
