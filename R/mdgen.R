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
#' @return NULL
#' @export
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

# Use the function to convert the text
write_file(
	str_replace(
		read_file("README_SRC.md"),
		"<<<<<DATASETS>>>>>",
		paste(convert_text("R/data.R"), collapse = "\n")
	),
	"README.md"
)
