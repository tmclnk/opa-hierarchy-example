package rules

import future.keywords

test_username if {
	"sam" == principal.username with input as {"session_id": "CB00828C-B260-4441-9CE9-2B40B6F2D2D2"}
}

test_http if {
	1 == effective_branch_level with input as {"session_id": "CB00828C-B260-4441-9CE9-2B40B6F2D2D2"}
	"full" == effective_security_level.SO_ENTRY with input as {"session_id": "CB00828C-B260-4441-9CE9-2B40B6F2D2D2"}

	2 == effective_branch_level with input as {"session_id": "51C8F090-4AEF-487A-99D3-B61161365643"}
	"full" == effective_security_level.SO_ENTRY with input as {"session_id": "51C8F090-4AEF-487A-99D3-B61161365643"}

	"full" == effective_security_level.PRINT_ACKNOWLEDGEMENTS with input as {"session_id": "581E6D0F-FAEF-41EB-9A61-21E077575326"}
	4 == effective_branch_level with input as {"session_id": "581E6D0F-FAEF-41EB-9A61-21E077575326"}
}
