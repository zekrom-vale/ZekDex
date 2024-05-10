rstudioapi::restartSession(clean = TRUE)

# Install package
devtools::clean_dll()
rm(list = ls(all.names = TRUE))
devtools::document()
devtools::install() # Or clean and install in Build
# (Required if some data chaged, will cause data coruption issues on the compiled package)
# Rcmd.exe INSTALL --preclean --no-multiarch --with-keep.source ZekDex

dir.create("data", showWarnings = FALSE)

gen_groups(write = TRUE)
gen_type_chart(write = TRUE)
gen_catch(write = TRUE)

# Requires PokemonGroups
gen_national(write = TRUE)


# Requires PokemonGroups
gen_evos(write = TRUE)

# Requires PokemonNational
gen_stats(write = TRUE)
gen_lang(write = TRUE)
gen_reginal(write = TRUE)
gen_type(write = TRUE)
gen_physicalAttr(write = TRUE)
