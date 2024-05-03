# Load the necessary libraries
library(tidyverse)
library(glue)

#' Convert Roxygen2 Dataset Documentation to Markdown
#'
#' This function converts Roxygen2 dataset documentation in an R file to a Markdown format.
#' It reads the text from an input R file, performs the necessary conversions,
#' and writes the converted text to a Markdown format
#'
#' @param input_file A character string specifying the path to the input R file.
#'
#' @importFrom readr read_lines
#' @importFrom stringr str_starts str_split str_c str_remove str_detect str_extract str_trim
#' @importFrom glue glue
#' @importFrom base ifelse
#'
#' @return The markdown text
convert_text = function(input_file) {
	# Read the input file
	input_text = read_lines(input_file)

	# Add a special marker for lines that start a new section
	input_text = ifelse(str_starts(input_text, "#'") & !str_starts(lag(input_text, default = ""), "#'"), "<<<<<NEWSECTION>>>>>", input_text)

	# Split the input text into sections
	sections = str_split(str_c(input_text, collapse = "\n"), "<<<<<NEWSECTION>>>>>", simplify = TRUE)

	# Initialize an empty character vector for the output text
	output_text = character()

	# Iterate over the sections
	for (section in sections) {
		# Trim the section
		section = str_trim(section)

		# Initialize a flag for tracking whether we are inside a \describe block
		inside_describe = FALSE

		# Initialize an empty character vector for the current section output
		section_output = character()

		# Extract the quoted string at the end of the section
		quoted_string = str_extract(section, "\"([^\"]*)\"\\s*$", group = 1)

		# If it's not found skip it
		if(is.na(quoted_string)) next

		# Add the quoted string to the top of the section output with ### added before it
		section_output = c(section_output, glue("\n\n### {quoted_string}"))

		# Iterate over the lines in the section
		for (line in str_split(section, "\n")[[1]]) {
			# Remove the #' prefix
			line = str_remove(line, "^#'\\s*")
			# Remove format
			if(str_detect(line, "@format")) next

			# Check if inside a \describe block
			if (str_detect(line, "\\\\describe\\{")) {
				inside_describe = TRUE
				next
			}
			# If not in describe and line is empty skip
			if(!inside_describe && line == "")next

			# Check if reached the end of a \describe block
			if (inside_describe && str_detect(line, "^\\s*\\}")) {
				inside_describe = FALSE
				break
			}

			# If inside a \describe block, replace \item with -
			if (inside_describe){
				line = str_replace_all(line, "\\\\item\\{([^}]*)\\}\\{`([^`]*)` (.*)\\}", "- `\\1` (`\\2`): \\3")
			}

			# Add the line to the section output
			section_output = c(section_output, line)
		}

		# Add the section output to the output text
		output_text = c(output_text, section_output)
	}
	output_text
}

#' Render README.md file
#'
#' This function generates a README.md file based on tags.
#' It reads from a source file, replaces specific tags with content, and writes to a destination file.
#'
#' @param from Character string specifying the path to the source file. Default is "README_SRC.md".
#' @param to Character string specifying the path to the destination file. Default is "README.md".
#' @importFrom readr read_file
#' @importFrom readr write_file
#' @importFrom stringr str_replace
#' @return NULL
#' @examples
#' render_readme("README_SRC.md", "README.md")
render_readme = function(from = "README_SRC.md", to = "README.md"){
	file = read_file(from)
	file = file|>
		str_remove_all(regex("\\s*--.*", multiline = TRUE))
	file = file|>
		str_replace(
			"<<<<<DATASETS>>>>>",
			paste(convert_text("R/data.R"), collapse = "\n")
		)
	file = file|>
		str_replace(
			"<<<<<ATTRIBUTION>>>>>",
			read_file("ATTRIBUTION.md")
		)

	# Use the function to convert the text
	write_file(
		file,
		to
	)
}

render_readme()
