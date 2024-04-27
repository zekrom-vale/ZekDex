rstudioapi::restartSession(clean = TRUE)

# Install package
rm(list = ls())
devtools::clean_dll()
devtools::document()
devtools::install()

gen_national(write = TRUE)


gen_evos(write = TRUE)
gen_lang(write = TRUE)
gen_reginal(write = TRUE)
gen_stats(write = TRUE)
gen_type(write = TRUE)
