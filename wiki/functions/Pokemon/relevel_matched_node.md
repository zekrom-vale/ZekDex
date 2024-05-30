# Relevels the structure of a list of xml_nodes and xml_nodesets (`relevel_matched_node`)



## Paramaters
 - `lst` The list to modify
 - `level` The current level of recursion
 - `tags` The tags to move down (Note: this is not built to move things up)
 - `return` The modified list

## Usage
```r
relevel_matched_node(lst, level = 1, tags = c("h2", "h3", "h4"))
```

## Examples
```r
\dontrun{
new_node = function(tag, val){
xml2::read_html(glue::glue("<{tag}>{val}</{tag}>"))|>
   xml2::xml_child()|>
   xml2::xml_child()
}

# example data
t = list(
   list(
       list(
           new_node("h2", "hi"),
           new_node("div", "hi")
       )
	  )
)
# > [[1]]
# > [[1]][[1]]
# > [[1]][[1]][[1]]
# > {html_node}
# > <h2>
# >
# > 	[[1]][[1]][[2]]
# > {html_node}
# > <div>
v = t|>
	recursive_xml_map2(relevel_matched_node)
# > [[1]]
# > [[1]][[1]]
# > {html_node}
# > <h2>
# >
# > [[1]][[2]]
# > [[1]][[2]][[1]]
# > {html_node}
# > <div>
}
```
