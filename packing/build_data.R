rstudioapi::restartSession(clean = TRUE)

# Install package
devtools::clean_dll()
rm(list = ls(all.names = TRUE))

# Generate docs
library(glue)
library(tidyverse)
library(yaml)
l = list()
l$ATTRIBUTION = read_file("ATTRIBUTION.md")
l$INSTALL = read_file("packing/INSTALL.md")

source("packing/util.R")

# DATA ROXOGEN
source("packing/gen_roxogen.R")

# README
l$DATASETS = shortDescription("packing/data.readme.template")
glue_data(l, renmoveComments(read_file("packing/README.src.md")))|>
	write_file("README.md")

# WIKI HOME
l$DATASETS = shortDescription("packing/data.home.template")
glue_data(l, renmoveComments(read_file("packing/home.src.md")))|>
	write_file("wiki/Home.md")

# WIKI DATA
genWikiData()

source("packing/sidebar.R")


devtools::document()
devtools::install() # Or clean and install in Build
# (Required if some data chaged, will cause data coruption issues on the compiled package)
# Rcmd.exe INSTALL --preclean --no-multiarch --with-keep.source ZekDex

dir.create("data", showWarnings = FALSE)


gen_type(write = TRUE) # Note may need to restart if this changes

# Depends on type
gen_groups(write = TRUE)
gen_type_chart(write = TRUE)
gen_catch(write = TRUE)

# Requires PokemonGroups
gen_national(write = TRUE)


# Requires PokemonGroups
gen_evos(write = TRUE)

# Requires PokemonNational
gen_stats(write = TRUE) # takes a bit
gen_lang(write = TRUE) # takes a bit
gen_reginal(write = TRUE)
gen_physicalAttr(write = TRUE)
gen_mega(write = TRUE)


library(utils)
# Get the list of csv files in the data directory
csv_files = list.files("data", pattern = "\\.csv$", full.names = TRUE)

# Create a zip file of all csv files
zip(zipfile = "data/data.zip", files = csv_files)

# Create a tar.gz file of all csv files
tar(tarfile = "data/data.tar.gz", files = csv_files)
