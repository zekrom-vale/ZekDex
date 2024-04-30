rstudioapi::restartSession(clean = TRUE)

# Install package
devtools::clean_dll()
rm(list = ls())
devtools::document()
devtools::install() # Or clean and install in Build
# (Required if some data chaged, will cause data coruption issues on the compiled package)
# Rcmd.exe INSTALL --preclean --no-multiarch --with-keep.source ZekDex

gen_national(write = TRUE)


gen_evos(write = TRUE)
gen_lang(write = TRUE)
gen_reginal(write = TRUE)
gen_stats(write = TRUE)
gen_type(write = TRUE)
