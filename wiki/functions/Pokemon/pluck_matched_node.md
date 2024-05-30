# Extracts all xml_nodes matching the tag and all other elements that don''t (`pluck_matched_node`)



## Paramaters
 - `lst` A list or xml_nodeset of xml_nodes to extract from
 - `tag` The tag to extract form the set
 - `return` A list of
	matched_elements that have the matching xml_nodes
	other_elements that have the updated list without the matched elements

## Usage
```r
pluck_matched_node(lst, tag)
```