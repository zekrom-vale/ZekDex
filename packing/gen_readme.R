library(glue)
library(tidyverse)
library(yaml)

shortDescription = function(){
	YAML = read_yaml("packing/data.yaml")

	imap(YAML, function(yaml_data, dataset_name){
		# Read the template from a file
		template = read_file("packing/data.readme.template")

		yaml_data$dataset_name = dataset_name

		# Concatenate all values into a single string
		yaml_data = map(yaml_data, ~str_trim(paste(.x, collapse = "\n")))

		# Use glue to fill in the template
		glue_data(yaml_data, template, .sep = "")
	})|>
		paste(collapse = "\n")
}

l = list()
l$DATASETS = shortDescription()
l$ATTRIBUTION = read_file("ATTRIBUTION.md")

glue_data(
	l,
	read_file("README_SRC.md")|>
		str_remove_all(regex("\\s*--.*", multiline = TRUE))
)|>
	write_file("README.md")
