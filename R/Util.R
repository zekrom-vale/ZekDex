#' Recursively wraps a string with specified opening and closing characters
#'
#' This function recursively wraps a string with specified opening and closing characters. It returns a string that is recursively wrapped with the specified opening and closing characters.
#'
#' @param str The string to be wrapped.
#' @param .open The opening character(s) for wrapping, default is "(".
#' @param .close The closing character(s) for wrapping, default is ")?".
#' @return A string that is recursively wrapped with the specified opening and closing characters.
#' @export
#'
#' @importFrom stringr str_length str_sub
#' @importFrom glue glue
#' @examples
#' .recursive_wrap("Zekrom")
.recursive_wrap = function(str, .open="(", .close=")?"){
	if(str_length(str) == 1)return(str)
	return(glue::glue(
		str_sub(str, 1, 1),
		.open,
		.recursive_wrap(str_sub(str, 2, str_length(str)), .open=.open, .close=.close),
		.close
	)|>as.character())
}

#' Vectorized version of the .recursive_wrap function
#'
#' @param str A vector of strings to be wrapped
#'
#' @return A vector of strings that are recursively wrapped with the specified opening and closing characters
#' @export
recursive_wrap = Vectorize(.recursive_wrap, vectorize.args = "str")

#' Returns the shortest string before a match
#'
#' This function returns the shortest string not matching a test string. It uses a recursive wrap function to match the strings.
#'
#' @param str The string to resize.
#' @param test The string to test.
#' @return The shortest string not matching test.
#' @export
#'
#' @importFrom stringr str_extract_all
#' @importFrom magrittr "%>%"
#' @examples
#' str_longest_match("Zekrom", "Zek")
str_longest_match = Vectorize(function(str, test, ..., .open="(", .close=")?"){
	# args = list(...); if(!is.null(args$literal) && args$literal == TRUE)stop("Cannot match anything when literal is true")
	matches = str_extract_all(test, regex(.recursive_wrap(str), ...))|>
		unlist()
	if(length(matches) == 0)return(NA_character_)
	matches[which.max(str_length(matches))]
}, vectorize.args = c("str", "test"))

#' Returns the string before a match
#'
#' This function returns the string before a match. It uses the `str_longest_match` function to find the match and then returns the string before it.
#'
#' @param str The string to resize.
#' @param test The string to test.
#' @return The string before the match.
#' @export
#'
#' @importFrom stringr str_sub
#' @importFrom dplyr if_else
#' @examples
#' str_before_match("Zekrom", "Zek")
str_before_match = function(str, test, ..., .open="(", .close=")?"){
	match = str_longest_match(str, test, ..., .open="(", .close=")?")
	match = if_else(match == str, NA_character_, match)
	substr(str, 0, str_length(match)+1)
}



#' Replaces all accented characters in a string with their unaccented counterparts
#'
#' @param str The string in which to replace accented characters
#'
#' @return A string with all accented characters replaced by their unaccented counterparts
#' @importFrom stringr str_replace_all
#' @export
removeA = function(str){
	replacements = c(
		"\u00E1" = "a", "\u00E9" = "e", "\u00ED" = "i", "\u00F3" = "o", "\u00FA" = "u", # Lowercase á, é, í, ó, ú
		"\u00C1" = "A", "\u00C9" = "E", "\u00CD" = "I", "\u00D3" = "O", "\u00DA" = "U", # Uppercase Á, É, Í, Ó, Ú
		"\u00E0" = "a", "\u00E8" = "e", "\u00EC" = "i", "\u00F2" = "o", "\u00F9" = "u", # Lowercase à, è, ì, ò, ù
		"\u00C0" = "A", "\u00C8" = "E", "\u00CC" = "I", "\u00D2" = "O", "\u00D9" = "U", # Uppercase À, È, Ì, Ò, Ù
		"\u00E4" = "a", "\u00EB" = "e", "\u00EF" = "i", "\u00F6" = "o", "\u00FC" = "u", # Lowercase ä, ë, ï, ö, ü
		"\u00C4" = "A", "\u00CB" = "E", "\u00CF" = "I", "\u00D6" = "O", "\u00DC" = "U"  # Uppercase Ä, Ë, Ï, Ö, Ü
	)

	# Use str_replace_all to replace all instances of the accented characters
	str_replace_all(str, replacements)
}


# Make partial name matches
.str_half = function(str, add = .5, div = 2, min = 4){
	substr(str, 0, max(floor(str_length(str)/div+add), min))
}

# Vectorise for dplyr
str_half = Vectorize(.str_half, vectorize.args = "str")

#' Match a string over a regex vector
#' @description
#'
#' takes a vector of names, matches them against patterns using str_detect,
#' and then returns the corresponding values from patternsT[[val]]
#' where the match is TRUE.
#'
#' @param name The value(s) to test
#' @param match What to check for a vector RegEx
#' @param val The value to return
#' @export
fun = function(names_vector, match, val){
	# The Vectorize function then allows this operation to be applied to each element of the “name” argument.
	lapply(names_vector, function(name){
		arr = str_detect(name, match)
		arr = !is.na(arr) & arr
		if(any(arr))return(
			paste(val[which(arr)], collapse = ",")
		)
		else return(NA)  # return NA if there's no match
	})|>
		# unlist to ensure the result is a vector, not a list
		unlist()
}

vLength = function(x){
	purrr::map(x, length)
}

#' Paste Non-Unique Elements
#'
#' This function pastes together elements from two vectors (`vec1` and `vec2`) if the corresponding element in `vec2` is not unique. If the element in `vec2` is unique, it returns the corresponding element from `vec1`.
#'
#' @param vec1 A vector of elements to be pasted with `vec2` if the corresponding element in `vec2` is not unique.
#' @param vec2 A vector of elements to be checked for uniqueness.
#' @param sep A character string to separate the terms. Default is "".
#' @return A vector where each element is either an element from `vec1` (if the corresponding element in `vec2` is unique) or a string resulting from pasting together the corresponding elements from `vec1` and `vec2` (if the element in `vec2` is not unique).
#' @export
#' @examples
#' vec1 <- c("apple", "banana", "cherry")
#' vec2 <- c("fruit", "fruit", "fruit")
#' paste_non_unique(vec1, vec2, sep = " ")
paste_non_unique  = function(vec1, vec2, sep = ""){
	# Identify non-unique elements in vec2
	non_unique = duplicated(vec2) | duplicated(vec2, fromLast = TRUE)

	# Conditionally paste vec1 and vec2
	result = ifelse(non_unique, paste(vec1, vec2, sep = sep), vec1)

	return(result)
}


#' Renames columns of a dataframe based on a specific row
#'
#' @param df A dataframe to operate on
#' @param row_number The row number to use for renaming columns, default is 1
#' @param prepend A string to prepend to the new column names, default is ""
#' @param postpend A string to append to the new column names, default is ""
#' @param test A logical value indicating whether to check for unique column names, default is TRUE
#' @param bind A logical value indicating whether to bind rows with duplicate values, default is TRUE
#'
#' @return A dataframe with renamed columns
#' @importFrom dplyr rename slice
#' @importFrom stringr str_detect
#' @export
#' @examples
#' # Deal with the odd header
#' # A tibble: 152 × 6
#' # 	Ndex  MS    English    Japanese   Japanese    Japanese
#' # <chr> <chr> <chr>      <chr>      <chr>       <chr>
#' # 	1 Ndex  "MS"  English    Kana       Hepburn     Trademarked
#' # 2 #0001 ""    Bulbasaur  フシギダネ Fushigidane Fushigidane
#' # 3 #0002 ""    Ivysaur    フシギソウ Fushigisō   Fushigisou
#' # 4 #0003 ""    Venusaur   フシギバナ Fushigibana Fushigibana
.name_from_row = function(df, row_number = 1, prepend = "", postpend = "", test = TRUE, bind = TRUE){
	# If the input dataframe is NULL, return NULL
	if(is.null(df))return(NULL)
	# Store the original column names of the dataframe
	oldNames = names(df)
	# Check if all column names are unique
	test = test && length(oldNames)==length(unique(oldNames))
	# Clean the column names of the dataframe and convert it to a tibble
	df = as_tibble(df, .name_repair = "unique")
	# If the 'test' condition is TRUE and both 'prepend' and 'postpend' are empty, return the dataframe as is
	if(test){
		if(prepend==""&&postpend=="")return(df)
		# Create a named vector for renaming the columns
		names_vector = setNames(names(df), paste0(prepend, names(df), postpend))
		# Rename the columns of the dataframe using the named vector
		return(
			df|>
				rename(!!!names_vector)
		)
	}
	# Extract the data from the specified row
	row_data = df|>
		slice(row_number)|>
		unlist()|>
		as.character()|>
		paste0(prepend, b=_, c=postpend)
	# Create a named vector for renaming the columns
	names_vector = setNames(names(df), row_data)

	# If there are duplicate values in the row data
	if(length(row_data)!=length(unique(row_data))){
		# If 'bind' is FALSE, print a warning and return the dataframe as is
		if(!bind){
			warning("Dataframe row has duplicate values.  Skiping change")
			return(df)
		}
		# Create a named vector for renaming the columns, handling duplicate values
		names_vector = setNames(names(df), paste_non_unique(row_data, oldNames))
	}

	# Rename the columns of the dataframe using the named vector and remove the specified row
	df|>
		rename(!!!names_vector)|>
		slice(-row_number)
}


#' Renames columns of a dataframe based on a specific row
#'
#' @param df A dataframe to operate on
#' @param row_number The row number to use for renaming columns, default is 1
#' @param prepend A string to prepend to the new column names, default is ""
#' @param postpend A string to append to the new column names, default is ""
#' @param test A logical value indicating whether to check for unique column names, default is TRUE
#' @param bind A logical value indicating whether to bind rows with duplicate values, default is TRUE
#'
#' @return A dataframe with renamed columns
#' @importFrom dplyr rename slice
#' @importFrom stringr str_detect
#' @export
#' @examples
#' # Deal with the odd header
#' # A tibble: 152 × 6
#' # 	Ndex  MS    English    Japanese   Japanese    Japanese
#' # <chr> <chr> <chr>      <chr>      <chr>       <chr>
#' # 	1 Ndex  "MS"  English    Kana       Hepburn     Trademarked
#' # 2 #0001 ""    Bulbasaur  フシギダネ Fushigidane Fushigidane
#' # 3 #0002 ""    Ivysaur    フシギソウ Fushigisō   Fushigisou
#' # 4 #0003 ""    Venusaur   フシギバナ Fushigibana Fushigibana
name_from_row = Vectorize(.name_from_row, vectorize.args = "df", SIMPLIFY = FALSE)

#' Drops all rows with NA values in specified columns
#'
#' This function drops all rows with NA values in specified columns from a dataframe. If no columns are specified, all columns are checked.
#'
#' @param df A dataframe to operate on.
#' @param ... Columns to check for NA values. If no columns are specified, all columns are checked.
#' @return A dataframe with rows containing NA values in the specified columns removed.
#' @export
#'
#' @importFrom rlang enquos
#' @importFrom dplyr filter across everything
#' @importFrom purrr reduce
#' @importFrom tibble tribble
#' @examples
#' library(tibble)
#' drop_all_na(tribble(
#'   ~a, ~b,
#'   1, 3,
#'   2, NA,
#'   NA, 5
#' ))
drop_all_na = function(df, ...) {
	cols = enquos(...)

	df|>
		filter(
			!reduce(
				across(
					if (length(cols) == 0) everything() else !!!cols,
					is.na
				),
				`&`
			)
		)
}

#' Drops all columns with NA values in a dataframe
#'
#' @param df A dataframe to operate on
#'
#' @return A dataframe with columns containing NA values removed
#' @importFrom dplyr select_if
#' @export
drop_na_columns = function(df) {
	df|>
		select_if(~!all(is.na(.)))
}

#' Filters rows of a dataframe based on non-unique values in specified columns
#'
#' This function filters rows of a dataframe based on non-unique values in specified columns. If no columns are specified, all columns are checked.
#'
#' @param df A dataframe to operate on.
#' @param ... Columns to check for non-unique values. If no columns are specified, all columns are checked.
#' @return A dataframe with rows containing non-unique values in the specified columns removed.
#' @export
#'
#' @importFrom rlang enquos
#' @importFrom dplyr group_by across filter ungroup n everything
#' @examples
#' library(tibble)
#' filter_non_unique(
#'   tribble(
#'     ~a, ~b,
#'     1, 3,
#'     2, 4,
#'     2, 4
#'   )
#' )
filter_non_unique = function(df, ...){
	cols = enquos(...)

	df|>
		group_by(across(if (length(cols) == 0) everything() else !!!cols))|>
		filter(n() > 1)|>
		ungroup()
}


#' Checks for non-unique values in a vector
#'
#' @param x A vector to check for non-unique values
#'
#' @return A logical vector indicating which values are non-unique
#' @export
non_unique = function(x) duplicated(x) | duplicated(x, fromLast = TRUE)

#' Filters rows of a dataframe based on non-unique values in each specified column
#'
#' @param df A dataframe to operate on
#' @param ... Columns to check for non-unique values. If no columns are specified, all columns are checked.
#'
#' @return A dataframe with rows containing non-unique values in each of the specified columns
#' @importFrom rlang enquos
#' @importFrom dplyr filter across
#' @export
filter_non_unique_each = function(df, ...) {
	cols = enquos(...)
	df|>
		filter(rowSums(across(if (length(cols) == 0) everything() else !!!cols, non_unique)) > 0)
}

#' Splits a list at elements that satisfy a condition
#'
#' This function splits a list at elements that satisfy a condition. It returns a list of lists, split at elements where the condition is TRUE.
#'
#' @param lst A list to split.
#' @param condition A condition function that returns TRUE for elements where the list should be split.
#' @return A list of lists, split at elements where the condition is TRUE.
#' @export
#'
#' @importFrom purrr map_lgl map2
#' @importFrom magrittr "%>%"
#' @examples
#' split_at(list(1, 2, 3, 4, 5), function(x) x %% 2 == 0)
split_at = function(lst, condition) {
	# Return as is if it's length 1
	if(length(lst)==1)return(lst)
	# Find the location of the condition
	condition_result = map_lgl(lst, condition)
	# If not found return as is
	# Unfortunately, this breaks things as the function will get a element and not a list
	# If I check that class(lst[[1]]) == externalptr it just flattens the list
	# if(!all(condition_result))return(lst)
	ends = which(condition_result)
	starts = c(1, ends)
	ends = c(ends - 1, length(lst))

	# Add an extra end point if necessary
	if (length(starts) > length(ends)) {
		ends <- c(ends, length(lst))
	}
	ret = map2(starts, ends, ~ lst[.x:.y])
	ret
}

#' Splits a list at each specified tag
#'
#' This function splits a list at each specified tag. It returns a list of lists, split at each specified tag.
#'
#' @param lst A list to split.
#' @param tags A vector of tags at which to split the list.
#' @return A list of lists, split at each specified tag.
#' @export
#'
#' @importFrom purrr map
#' @importFrom magrittr "%>%"
#' @examples
#' split_each(list("h1", "h2", "h3", "h4"), c("h2", "h3", "h4"))
split_each = function(lst, tags = c("h2", "h3", "h4")) {
	# If it has external pointers as a type just return it as it is
	if (length(tags) == 1) {
		cur = split_at(lst, ~ rvest::html_name(.) == tags[1])
		return(cur)
	}
	tag = tags[1]; tags = tags[-1]
	cur = lst|>
		split_at(~rvest::html_name(.) == tag)
	cur = cur%>%
		map(~ split_each(., tags))
	return(cur)
}

#' Recursively modifies a list
#'
#' @param lst A list to operate on
#' @param fun A function to operate on the end of the lst
#'
#' @return The modified lst
#' @export
#'
#' @importFrom purrr map
recursive_xml_map = function(lst, fun){
	purrr::map(lst, function(x){
		if (is.list(x) && !inherits(x, c("xml_node", "xml_nodeset")))
			recursive_xml_map(x, fun)
		else if (inherits(x, "xml_node"))
			fun(x)
		else if (inherits(x, "xml_nodeset")){
			return(map(rvest::html_children(x), fun))
		}
		else x
	})
}

#' Recursively modifies a list on each list
#'
#' @param lst A list to operate on
#' @param fn A function to operate on chunks of the lst
#' ```
#'		x: the current chunk of the list
#'		level: How deep recursion is currently
#'		return: A modified list chunk used in the next recursions and returned by recursive_xml_map2
#' ```
#' @param level How deep recursion is currently, starts at 1 by default.  Increments every recursion
#'
#' @return The modified lst
#' @export
#'
#' @importFrom purrr map
recursive_xml_map2 = function(lst, fn, level = 1){
	if(inherits(lst, c("xml_node"))) return(lst)
	purrr::map(lst, function(x){
		# Again it will not recurce into xml_nodesets
		if (is.list(x) && !inherits(x, c("xml_node"))) {
			nx <- fn(x, level)
			recursive_xml_map2(nx, fn, level + 1)
		} else x
	})
}

#' Save Data to CSV and/or RDA
#'
#' This function saves a given data frame to a CSV and/or RDA file.
#'
#' @param sym The name of the data frame to save.
#' @param root The root directory where the file should be saved.
#' @param file The name of the file (without extension).
#' @param csv Logical, should the data be saved as a CSV file? Default is TRUE.
#' @param rda Logical, should the data be saved as an RDA file? Default is TRUE.
#'
#' @importFrom readr write_csv
#' @importFrom readr write_rds
#' @importFrom glue glue
#' @export
save_data = function(
		sym,
		root = stop("'root' must be specified"),
		file = stop("'file' must be specified"),
		csv = TRUE, rda = TRUE
){
	if(pkgload::is_loading()) return()
	if(rda)save(list = sym, file = glue("{root}/{file}.rda"), envir = parent.frame())
	if(csv)write_csv(get(sym, envir = parent.frame()), glue("{root}/{file}.csv"))
	if(!csv&&!rda)warning("Nothing saved")
}

#' Read Data from CSV or RDA
#'
#' This function reads data from a CSV or RDA file, or from a package namespace.
#'
#' @param data The name of the data to load.
#' @param root The root directory where the file is located.
#' @param ns The namespace from which to load the data.
#' @param one Is there one item in the rda file?
#'
#' @importFrom readr read_csv
#' @importFrom glue glue
#' @export
read_data = function(data, root, ns = asNamespace("ZekDex"), one = TRUE, g=NULL){
	if(pkgload::is_loading()) return()
	if(!is.null(root)){
		if(file.exists(glue("{root}{data}.rda"))){
			e <- new.env()
			load(glue("{root}{data}.rda"), envir = e)
			if(one)return(e[[ls(e)[1]]])
			else return(e)
		}
		if(file.exists(glue("{root}{data}.csv"))){
			return(read_csv(glue("{root}{data}.csv")))
		}
	}
	if(!is.null(g) && exists(g, where = ns)){
		return(get(g, envir = ns))
	}
	if(exists(data, where = ns)){
		return(get(data, envir = ns))
	}
}

#' Regional Form Function
#'
#' This function provides a list or a regex pattern of Pokémon regional forms.
#'
#' @param re A logical value. If TRUE, the function returns a regex pattern. If FALSE, it returns a list. Default is FALSE.
#' @param ext A logical value. If TRUE, the function includes extended regional forms in the output. Default is FALSE.
#'
#' @return If re is TRUE, a character string representing a regex pattern of Pokémon regional forms. If re is FALSE, a character vector of Pokémon regional forms.
#'
#' @examples
#' regionalForm(re = TRUE, ext = TRUE)
#' regionalForm(re = FALSE, ext = FALSE)
#'
#' @export
regionalForm = function(re = FALSE, ext = FALSE){
	L = c("Alolan","Galarian","Hisuian","Paldean")
	if(ext) L = c(L, "Kantonian","Hoennian","Unovan","Kalosian")
	if(re) return(paste(L, collapse = "|"))
	L
}
