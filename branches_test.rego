package branch_hierarchy

import future.keywords

test_edge_path if {
	edge_path("001") == ["001", "East", "Lumber Company", "XYZ Lumber"]
	edge_path("003") == ["003", "East", "Lumber Company", "XYZ Lumber"]
	edge_path("004") == ["004", "Southeast", "Lumber Company", "XYZ Lumber"]
	edge_path("005") == ["005", "Southeast", "Lumber Company", "XYZ Lumber"]
	edge_path("101") == ["101", "Canada", "Lumber Co of Canada", "XYZ Lumber"]
}
