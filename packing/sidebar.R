library(tidyverse)
library(glue)

# Get a list of all .md files in the "wiki" directory and its subdirectories
files <- list.files("wiki", pattern = ".md", recursive = TRUE)

# Remove the .md extension from each file
files <- str_remove(files, ".md")

# Exclude the _Sidebar file
files <- files[files != "_Sidebar"]

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

# Function to generate Markdown for a list
generate_markdown <- function(x, name = NULL, level = 0) {
  if (is.list(x) && length(x) > 0) {
    files_md <- map_chr(x[!sapply(x, is.list)], ~glue("{paste(rep('  ', level), collapse = '')}- [{.}](https://github.com/zekrom-vale/ZekDex/wiki/{.})"))
    dirs_md <- imap_chr(x[sapply(x, is.list)], ~generate_markdown(.x, name = .y, level = level + 1))
    inner_md <- c(files_md, unlist(dirs_md))
    inner_md <- paste(inner_md, collapse = "\n")

    if (!is.null(name)) {
      return(glue("{paste(rep('  ', level-1), collapse = '')}- {name}\n{inner_md}"))
    } else {
      return(inner_md)
    }
  } else {
    return(glue("{paste(rep('  ', level), collapse = '')}- [{x}](https://github.com/zekrom-vale/ZekDex/wiki/{x})"))
  }
}

# Generate Markdown for each file
markdown <- generate_markdown(nested_list)

# Write the Markdown to the _Sidebar.md file
write_file(markdown, "wiki/_Sidebar.md")
