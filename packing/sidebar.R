library(tidyverse)
library(glue)

# Get a list of all .md files in the "wiki" directory and its subdirectories
files <- list.files("wiki", pattern = ".md", recursive = TRUE)

# Remove the .md extension from each file
files <- str_remove(files, ".md")

# Split the file paths to get nested directories
split_files <- str_split(files, "/")

# Recursive function to build a nested list
build_nested_list <- function(paths, lst) {
	if (length(paths) == 0) {
		return(lst)
	}

	path <- paths[[1]]
	paths <- paths[-1]

	if (length(path) == 1) {
		lst[[path[[1]]]] <- path[[1]]  # Use the file name to represent a file
	} else {
		if (!path[1] %in% names(lst)) {
			lst[[path[1]]] <- list()
		}
		lst[[path[1]]] <- build_nested_list(list(path[-1]), lst[[path[1]]])
	}

	return(build_nested_list(paths, lst))
}

# Build the nested list
nested_list <- build_nested_list(split_files, list())

# Function to generate HTML for a list
generate_html <- function(x, name = NULL) {
	if (is.list(x) && length(x) > 0) {
		files_html <- map_chr(x[!sapply(x, is.list)], ~glue("<li><a href='{.}.md'>{.}</a></li>"))
		dirs_html <- imap_chr(x[sapply(x, is.list)], ~generate_html(.x, name = .y))
		inner_html <- c(files_html, unlist(dirs_html))
		inner_html <- paste(inner_html, collapse = "")

		if (!is.null(name)) {
			return(glue("<li>{name}<ul>{inner_html}</ul></li>"))
		} else {
			return(glue("<ul>{inner_html}</ul>"))
		}
	} else {
		return(glue("<li><a href='{x}.md'>{x}</a></li>"))
	}
}

# Generate HTML for each file
html <- generate_html(nested_list)

# Combine all HTML into a single list
glue("<ul>{html}</ul>")|>
	write_file("wiki/_Sidebar.html")
