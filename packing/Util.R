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
