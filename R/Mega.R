#' Generate Mega Evolution and Primal Reversion Data
#'
#' This function scrapes data from Bulbapedia about Mega Evolutions and Primal Reversions in Pokémon.
#' It processes the data and optionally writes it to a CSV file.
#'
#' @param write Logical, if TRUE, the function writes the data to a CSV file. Default is FALSE.
#' @param root Character, the root directory where the CSV file will be saved. Default is "data/".
#' @param file Character, the name of the CSV file. Default is "PokemonMega".
#'
#' @return A dataframe containing the Mega Evolution and Primal Reversion data.
#' @export
#'
#' @importFrom purrr map map2
#' @importFrom dplyr bind_rows select mutate across where if_else
#' @importFrom stringr str_detect str_replace str_extract str_remove str_to_lower
#' @importFrom tidyr separate_wider_delim
gen_mega = function(write = FALSE, root = "data/", file = "PokemonMega"){
	if(pkgload::is_loading()) return() # If the package 'pkgload' is loading, exit the function
	# Check if the 'rvest' package is installed. If not, stop the function and prompt the user to install it
	if(!requireNamespace("rvest", quietly = TRUE))stop("rvest required.  Use install.packages(\"rvest\")")

	# Define the URLs to scrape data from
	URLS = c("https://bulbapedia.bulbagarden.net/wiki/Mega_Evolution", "https://bulbapedia.bulbagarden.net/wiki/Primal_Reversion")

	nationalDex = read_data("PokemonNational", root, g="nationalDex")

	# Use the 'map' function from the 'purrr' package to apply a function to each URL
	mega = map(URLS, function(URL){
		# URL = "https://bulbapedia.bulbagarden.net/wiki/Mega_Evolution"
		HTML = rvest::read_html(URL) # Read the HTML content of the URL

		# Extract the table from the HTML content
		table = rvest::html_table(rvest::html_elements(HTML, '[align="center"]'))
		# Determine whether the URL is about 'Mega Evolution' or 'Primal Reversion'
		mega = case_when(
			str_detect(URL, "Mega") ~ "Mega",
			str_detect(URL, "Primal") ~ "Primal",
			.default = "Other"
		)
		# Process the table data
		table=table|>
			name_from_row()
		# If the URL is about 'Mega Evolution', add the 'introduced' column
		if(mega == "Mega")
			table = table|>
			map2(
				HTML|>
					rvest::html_elements('h3 [id^="Introduced_in_"] a')|>
					rvest::html_text()|>str_remove("^Pok.mon "),
				function(x,y)mutate(x, introduced = y)
			)
		else if(mega == "Primal")
			# If the URL is not about 'Primal Reversion', add 'Omega Ruby and Alpha Sapphire' to the 'introduced' and 'Dex' columns
			table = table|>
			map(function(x)mutate(x, introduced = "Omega Ruby and Alpha Sapphire", Dex = NA_character_))
		else
			# If the URL is not about 'Mega Evolution', add 'NA' to the 'introduced' and 'Dex' columns
			table = table|>
			map(function(x)mutate(x, introduced = NA_character_, Dex = NA_character_))

		# Further process the table data
		table|>
			bind_rows() |> # Combine all elements of 'table' into a single dataframe
			select(-matches("Image")) |> # Remove the 'Image' column from the dataframe
			rename_with(~"stone", matches("Mega\\s*Stone|Orb")) |> # Rename the 'Mega Stone' or 'Orb' column to 'stone'
			rename(ndex = Dex, name = `Pokémon`) |> # Rename the 'Dex' column to 'ndex' and 'Pokémon' column to 'name'
			rename_with(function(x){
				str_replace(x, "(Type|Ability)(Before|After).*", "\\1\\2") |> # Replace 'TypeBefore', 'TypeAfter', 'AbilityBefore', and 'AbilityAfter' with 'Type' and 'Ability'
					str_replace("Type|Ability", str_to_lower) # Convert 'Type' and 'Ability' to lowercase
			}, matches("Primal\\s*Reversion|Mega\\s*Evolution")) |> # Apply the above replacements to columns that match 'Primal Reversion' or 'Mega Evolution'
			separate_wider_delim(
				starts_with("Type"), # Select columns that start with 'Type'
				delim = regex("\\s+"), # Use one or more spaces as the delimiter
				names = c("", "2"), # Name the resulting columns '' and '2'
				names_sep = "", # Don't use a separator in the column names
				too_few = "align_start" # If there are too few pieces, fill from the start
			) |>
			rename_with(~str_remove(.,"2")|>str_replace("type", "type2"), matches("type.*2")) |> # Remove '2' from the column names and replace 'type' with 'type2' for columns that match 'type.*2'
			mutate(
				ndex = as.integer(str_extract(ndex, "\\d+")), # Extract the numeric part from 'ndex' and convert it to an integer
				MegaOrPrimal = mega # Add a new column 'MegaOrPrimal' with the value of 'mega'
			)
	})|>
		bind_rows()|>
		mutate(
			across(where(is.character), ~if_else(.=="", NA_character_, ., NA_character_)),
			introduced = factor(introduced),
			MegaOrPrimal = factor(MegaOrPrimal),
			across(starts_with("type"), factor_type)
		)|>
		drop_all_na(-c(MegaOrPrimal,introduced))|>
		fill_missing_ndex(nationalDex, name, ndex)

	# If 'write' is TRUE, write the 'mega' dataframe to a CSV file
	if(write)save_data("mega", root, file)

	# Return the 'mega' dataframe
	mega
}
