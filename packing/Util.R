shortDescription = function(template){

	# Read the template from a filetemplate = read_file(template)
	YAML = read_yaml("packing/data.yaml")

	template = read_file(template)

	imap(YAML, function(yaml_data, dataset_name){
		yaml_data$dataset_name = dataset_name

		# Concatenate all values into a single string
		yaml_data = map(yaml_data, ~str_trim(paste(.x, collapse = "\n")))

		# Use glue to fill in the template
		glue_data(yaml_data, template, .sep = "")
	})|>
		paste(collapse = "\n")
}


genWikiData = function(){
	YAML = read_yaml("packing/data.yaml")

	iwalk(YAML, function(yaml_data, dataset_name){
		# Read the template from a file
		template = read_file("packing/data.md.template")

		# Format the source field to be multiline
		if("source" %in% names(yaml_data)) {
			yaml_data$source = paste("  -", yaml_data$source, collapse = "\n")
		}
		else yaml_data$source = "  - Other datasets"

		# Format the references field to be multiline
		if("references" %in% names(yaml_data)) {
			yaml_data$references = paste("  -", yaml_data$references, collapse = "\n")
		}
		else yaml_data$references = "  - Nothing"

		# Extract variables and format them
		variables = yaml_data$describe|>
			map_chr(function(x){
				glue(
					"  - {x[1]}: (`{x[2]}`) {x[3]}"
				)
			})

		# Add formatted variables to yaml_data
		yaml_data$variables = paste(variables, collapse = "\n")

		yaml_data$dataset_name = dataset_name

		# Concatenate all values into a single string
		yaml_data = map(yaml_data, ~paste(.x, collapse = "\n"))

		if(!"examples" %in% names(yaml_data))yaml_data$examples = glue("data({dataset_name})")
		yaml_data$examples = str_trim(yaml_data$examples)

		# Use glue to fill in the template
		glue_data(yaml_data, template, .sep = "")|>
			write_file(glue("wiki/data/{dataset_name}.md"))
	})
}

renmoveComments = function(str){
	str_remove_all(str, regex("\\s*--.*", multiline = TRUE))
}

remove_empty_dirs <- function(dir_path) {
	# List all directories recursively
	dirs <- list.dirs(dir_path, recursive = TRUE, full.names = TRUE)

	# Reverse the order of directories to handle nested empty directories
	dirs <- rev(dirs)

	# Loop over each directory
	for (dir in dirs) {
		# List all files in the directory, including hidden ones
		files <- list.files(dir, all.files = TRUE)

		# Remove '.' and '..' from the list of files
		files <- files[!files %in% c(".", "..")]

		# If the directory is empty, remove it
		if (length(files) == 0) {
			unlink(dir, recursive = TRUE)
		}
	}
}

#' Extract Roxygen2 Documentation from R Functions
#'
#' This function extracts Roxygen2 documentation from R functions in a given R file.
#' It uses glue templates inside of templates to generate the documentation.
#'
#' @section Syntax:
#' `{<tag>:<glue template accessing each tag parameters>}`: This is the basic
#' syntax for accessing tag parameters. The `<tag>` is the name of the Roxygen2
#' tag (such as `@param`, `@return`, etc.) and the
#' `<glue template accessing each tag parameters>` is a glue template that
#' accesses the parameters of the tag. For example,
#' `{param: - `{val$name}` {val$description}}` will generate a list of
#' parameters with their names and descriptions.
#'
#' `{!{<Access entire block>}}`: This syntax is used to access the entire
#' Roxygen2 block. The `<Access entire block>` is a glue template that accesses
#' the entire Roxygen2 block. For example, `{!{object$topic}}` will access the
#' topic of the Roxygen2 block.
#'
#' `<? <Remove if empty> ?>`: This syntax is used to remove a section if it is
#' empty. The `<Remove if empty>` is the section that will be removed if it is
#' empty. For example, `<? {examples:{val}} ?>` will remove the examples section
#' if it is empty.
#'
#' @param input_file A character string specifying the path to the input R file.
#' @param template A character string specifying the glue template for generating the documentation.
#' @param .removeTag The utiltiy tag to use for removal defults to `!!REMOVE!!`
#' @param .exportOnly When true only returns blocks with `@export`, default `TRUE`
#' @param .noTitle `keep` keeps things without a title, anything else discards it
#'
#' @importFrom roxygen2 parse_file
#' @importFrom readr read_lines
#' @importFrom stringr str_starts str_split str_c str_remove str_detect str_extract str_trim
#' @importFrom glue glue
#' @importFrom purrr map
#'
#' @return A list of Roxygen2 documentation for each function in the input file.
#'
#' @examples
#' \dontrun{
#' extract_roxygen("R/damage.R",
#' "# `{!{object$topic}}` {title:{val}}
#'
#' {description:{val}}
#'
#' ## Parameters
#' {param: - `{val$name}` {val$description}}
#' {return:{val}}
#'
#' ## Usage
#' ```r
#' {usage:{val}}
#' ```
#' <?
#'
#' ## Examples
#' ```r
#' {examples:{val}}
#' ```
#' ?>"
#' )
#' }
extract_roxygen <- function(input_file, template, .removeTag = "!!REMOVE!!", .exportOnly = TRUE, .noTitle = "discard") {
	# roxygen2::block_get_tags(roxygen2::parse_file("R/damage.R")[[1]], "usage")
	# Parse the R file
	parsed_file <- roxygen2::parse_file(input_file)

	# Remove unamed blocks
	parsed_file = parsed_file|>
		discard(~is.null(.$object))

	if(.exportOnly){
		parsed_file = parsed_file|>
			keep(~roxygen2::block_has_tags(., "export"))
	}

	if(.noTitle != "keep"){
		parsed_file = parsed_file|>
			keep(~roxygen2::block_has_tags(., "title"))
	}

	# Name the chunks
	names(parsed_file) <- parsed_file|>
		map_chr(~.$object$topic)

	# Use map to iterate over the parsed file and extract the Roxygen2 documentation
	purrr::map(parsed_file, function(roxygen) {
		# Do glue stuff here
		glue(template,
			 .transformer = function(text, envir = parent.frame()){
			 	if(str_detect(text, "^[!:]")){
			 		text = str_remove(text, "^[!:]")
			 		return(glue(text, .envir = envir))
			 	}
			 	text = unlist(str_split(text, "\\s*:"))
			 	tag = text[1]
			 	template = text[2]
			 	tags = roxygen2::block_get_tags(envir, tag)

			 	if(length(tags)==0)return(.removeTag)

			 	map(tags, function(e){
			 		glue(template, .envir = e)
			 	})|>
			 		paste(collapse = "\n")
			 }, .envir = roxygen)
	})|>
		map(
			function(x) {
				# Create a replacement list to prevent errors
				replacement = c("'" = "!!&#39;!!", '"' = "!!&quot;!!")
				x|>
					str_replace_all(replacement)|>
					glue(.open = "<?", .close = "?>", .transformer = function(text, envir){
						if(str_detect(text, .removeTag))return("")
						return(text)
					})|>
					str_remove_all(.removeTag)|>
					str_replace_all(reverseNames(replacement))
			}
		)
}

reverseNames = function(v){
	n = names(v)
	names(v) <- NULL
	names(n) <- v
	n
}


#' Extract a list of lists based on a template
#'
#' The `glue_list` function is designed to extract lists using glue templates inside of templates.
#' This is particularly useful for generating documentation or any other content based on a template.
#'
#' @section Syntax:
#'
#' The function supports several syntax options for flexibility:
#'
#' - `{<item>:<sub_template>}`: This uses the `glue` function with the environment of `root[[item]][[n]]`,
#'   using `sub_template` as the glue template. For example, `{variables: - '{n1}' {n2} {n3}}` will access
#'   `variables[[n]]$n1`, `variables[[n]]$n2`, and `variables[[n]]$n3`.
#'
#' - `{!{<template>}}`: This uses the `glue` function with the environment of `root`, using `template` as the glue template.
#'
#' - `{.}`: This accesses the name of the root list, i.e., `names(root[n])`.
#'
#' - `<? <remove_if_empty> ?>`: This syntax is used to remove a section if it is empty. The `<remove_if_empty>` is the section
#'   that will be removed if it is empty or if the template runs into an error (like if something doesn't exist). This can be
#'   anything from the above syntax options.
#'
#' @param lists A list to process. This should be a list of lists, where each sublist will be processed according to the template.
#' @param template A character string specifying the glue template for generating the documentation. This template will be used
#'   to process each sublist in `lists`.
#' @param .removeTag A character string specifying the utility tag to use for removal. Defaults to `!!REMOVE!!`. If a section
#'   of the template results in this tag, it will be removed from the final output.
#' @param .comment A character string specifying what to use as a comment. Defaults to `--`. This will be used as the comment
#'   character in the `glue` function calls.
#'
#' @importFrom roxygen2 parse_file
#' @importFrom readr read_lines
#' @importFrom stringr str_starts str_split str_c str_remove str_detect str_extract str_trim
#' @importFrom glue glue
#' @importFrom purrr map
#'
#' @return A list where each element is a string generated by processing a
#' sublist of `lists` with the `template`.
#' @export
#'
#' @examples
#' # Example 1: Using {<item>:<sub_template>} syntax
#' glue_list(
#'   list(list(variables = list(list(n1 = "x", n2 = "is", n3 = "10")))),
#'   "{variables: - '{n1}' {n2} {n3}}"
#' )
#' # This will output: "- 'x' is 10"
#'
#' # Example 2: Using {!{<template>}} syntax
#' glue_list(
#'   list(list(name = "John", age = 30)),
#'   "My name is {!{name}} and I am {!{age}} years old."
#' )
#' # This will output: "My name is John and I am 30 years old."
#'
#' # Example 3: Using {.} syntax
#' glue_list(
#'   list(list(name = "John", age = 30)),
#'   "{.}"
#' )
#' # This will output: "1" (the name of the root list, which is its index in this case)
#'
#' # Example 4: Using <? <remove_if_empty> ?> syntax
#' glue_list(
#'   list(list(name = "John", age = 30)),
#'   "{!{name}} <?{age}?>"
#' )
#' # The age section is removed because it's not empty, so this will output: "John "
glue_list <- function(lists, template, .removeTag = "!!REMOVE!!", .comment = "--") {

	try_transformer = function(text, envir = parent.frame()){
		tryCatch(
			identity_transformer(text, envir),
			error = function(e).removeTag
		)
	}

	# Use map to iterate over the parsed file and extract the Roxygen2 documentation
	purrr::imap(lists, function(lst, name) {
		# Do glue stuff here
		glue(template,
			 .transformer = function(text, envir = parent.frame()){
			 	if(text == ".")return(name)
			 	if(str_detect(text, "^[!:]")){
			 		text = str_remove(text, "^[!:]")
			 		t = glue(text, .envir = envir, .comment = .comment, .transformer = try_transformer)
			 		return(t)
			 	}
			 	text = unlist(str_split(text, "\\s*:"))
			 	tag = text[1]
			 	template = text[2]
			 	tags = pluck(envir, tag)

			 	if(length(tags)==0)return(.removeTag)

			 	map(tags, function(e){
			 		if(is.null(names(e))){
			 			e = as.list(e)
			 			names(e) <- paste0("n", seq(1, length(e)))
			 		}
			 		glue(template, .envir = e, .comment = .comment, .transformer = try_transformer)
			 	})|>
			 		paste(collapse = "\n")
			 }, .envir = lst, .literal = TRUE)
	})|>
		map(
			function(x) {
				# Create a replacement list to prevent errors
				replacement = c("'" = "!!&#39;!!", '"' = "!!&quot;!!")
				x|>
					str_replace_all(replacement)|>
					glue(.open = "<?", .close = "?>", .transformer = function(text, envir){
						if(str_detect(text, .removeTag))return("")
						return(text)
					}, .comment = .comment, .literal = TRUE)|>
					str_remove_all(.removeTag)|>
					str_replace_all(reverseNames(replacement))
			}
		)
}

# glue_list(
# 	list(
# 		list(
# 			x = list(
# 				list(1,2),
# 				list(3,4)
# 			),
# 			y = list(
# 				list(
# 					n = "22"
# 				)
# 			)
# 		)
# 	),
# 	"{x: x is {n1} {n2}}
# 	{y: y is {n}}"
# )
