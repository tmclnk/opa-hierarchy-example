package branch_hierarchy

# Path, as array[string], of the branch_names from the given branch back to the root node.
# Each node can only have a single parent.
edge_path(branch_name) := graph.reachable_paths(org_parent_graph, {branch_name})[_]

# A digraph for each node and its children.
# map[string, set[string]]
org_parent_graph[entity_name] := set {
	node := data.org_chart_data[entity_name]
	set := {node.parent}
}
