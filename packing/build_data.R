rstudioapi::restartSession(clean = TRUE)

# Install package
devtools::clean_dll()
rm(list = ls(all.names = TRUE))

# Generate docs
source("packing/gen_roxogen.R")
source("packing/gen_readme.R")
source("packing/gen_md.R")
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
