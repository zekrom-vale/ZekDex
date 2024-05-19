library(tidyverse)
# Due to filter conflict do not library(plotly)

# Plot physical attributes with color representing type
ZekDex::physicalAttr|>
	ggplot(aes(x=m, y=kg, color = type))+  # Set aesthetics for the plot
	geom_jitter(size = 3)+  # Add jitter to the points and set their size
	ZekDex::ggtypes()+  # Set color scale
	scale_x_log10()+  # Set x-axis to log scale
	scale_y_log10()  # Set y-axis to log scale

# Plot physical attributes with color representing type and add a smooth line
ZekDex::physicalAttr|>
	ggplot(aes(x=m, y=kg, color = type)) +  # Set aesthetics for the plot
	ZekDex::ggtypes()+  # Set color scale
	scale_x_log10()+  # Set x-axis to log scale
	scale_y_log10()+  # Set y-axis to log scale
	geom_smooth(se = FALSE)  # Add a smooth line to the plot

# Plot physical attributes with color representing type2
ZekDex::physicalAttr|>
	ggplot(aes(x=m, y=kg, color = type2)) +  # Set aesthetics for the plot
	geom_jitter(size = 3)+  # Add jitter to the points and set their size
	ZekDex::ggtypes()+  # Set color scale
	scale_x_log10()+  # Set x-axis to log scale
	scale_y_log10()  # Set y-axis to log scale

# Plot physical attributes with color representing type2 and add a smooth line
ZekDex::physicalAttr|>
	ggplot(aes(x=m, y=kg, color = type2)) +  # Set aesthetics for the plot
	ZekDex::ggtypes()+  # Set color scale
	scale_x_log10()+  # Set x-axis to log scale
	scale_y_log10()+  # Set y-axis to log scale
	geom_smooth(se = FALSE)  # Add a smooth line to the plot

# Create an animated plot of Pokemon stats
p = ZekDex::stats|>
	filter(is.na(MegaOrPrimal))|>  # Filter out rows where MegaOrPrimal is NA
	select(-c(MegaOrPrimal, Mega))|>  # Select all columns except MegaOrPrimal and Mega
	left_join(ZekDex::nationalDex, by = c("ndex", "name"), relationship = "many-to-many")|>  # Join with nationalDex
	mutate(
		Gen = factor(Gen, levels = c("I", "II-V", "VI", "VII", "VIII", "IX")),  # Convert Gen to a factor with specified levels
		PokemonType = case_when(  # Create a new variable PokemonType based on conditions
			isLegendary ~ "Legendary",
			isMythical ~ "Mythical",
			isUltraBeast ~ "UltraBeast",
			TRUE ~ "Regular"
		)
	)|>
	ggplot(aes(x=ndex, y=Average, color = PokemonType, frame = Gen, text = paste("name:", name)))+  # Set aesthetics for the plot
	geom_jitter()  # Add jitter to the points

# Convert the ggplot object to a plotly object to make it interactive
plotly::ggplotly(p)

# Load the 'typeChart' dataset from the ZekDex package
ZekDex::typeChart|>
	# Add a new column 'text' based on the 'Effectiveness' column
	mutate(
		text = if_else(Effectiveness == 1, ".", paste0("x", Effectiveness)) # If 'Effectiveness' is 1, then 'text' is ".", else it's "x" followed by the 'Effectiveness' value
	)|>
	# Create a ggplot object
	ggplot(aes(x = Attacking, y = Defending, fill = Effectiveness-1))+
	geom_raster()+ # Add a raster layer
	geom_text(aes(label = text))+ # Add a text layer
	scale_fill_gradient2(low = "green", mid = "white", high = "red")+ # Set the fill gradient
	theme(legend.position = "none") # Remove the legend

# Load the 'catchRate' dataset from the ZekDex package
p = ZekDex::catchRate|>
	rename(ndex = Ndex)|> # Rename the 'Ndex' column to 'ndex'
	left_join(ZekDex::stats, by = c("ndex", "name"), relationship = "many-to-many")|> # Join with the 'stats' dataset
	left_join(ZekDex::nationalDex, by = c("name", "ndex"), relationship = "many-to-many")|> # Join with the 'nationalDex' dataset
	dplyr::filter(Average < 150)|> # Filter rows where 'Average' is less than 150
	mutate(
		Gen = factor(Gen, levels = c("I", "II-V", "VI", "VII", "VIII", "IX")),  # Convert 'Gen' to a factor with specified levels
		PokemonType = case_when(  # Create a new variable 'PokemonType' based on conditions
			isLegendary ~ "Legendary",
			isMythical ~ "Mythical",
			isUltraBeast ~ "UltraBeast",
			TRUE ~ "Regular"
		)
	)|>
	# Create a ggplot object
	ggplot(aes(x = catchRate, y = Average, color = PokemonType, frame = Gen, text = paste("name:", name)))+ # PokemonType
	geom_jitter() # Add a jitter layer

# Convert the ggplot object to a plotly object to make it interactive
plotly::ggplotly(p)

