# Returns a random Pokemon Generator (`randomPokemonGen`)



## Paramaters
 - `p` What column to return (ndex, name, form, regional, type, type2 can be used)
 - `replace` Should sampling be with replacement?
 - `size` The number of random Pokemon to generate on each call


## Usage
```r
randomPokemonGen(..., p = name, replace = FALSE, size = 1)
```

## Examples
```r
\dontrun{
# Create a random Pokemon generator for any type of Pokemon
gen_any <- randomPokemonGen()
# Generate a random Pokemon
gen_any()
# > "Rayquaza"

# Create a random Pokemon generator for Fire type Pokemon
gen_fire <- randomPokemonGen(type = "Fire")
# Generate a random Fire type Pokemon
gen_fire()
# > "Reshiram"

# Create a random Pokemon generator for Fire and Flying type Pokemon
gen_fire_flying <- randomPokemonGen(type = "Fire", type2 = "Flying")
# Generate a random Fire and Flying type Pokemon
gen_fire_flying()
# > "Charizard"

# Create a random Pokemon generator for Fire or Flying type Pokemon
gen_dragon_or_electric <- randomPokemonGen(type = "Dragon", type2 = "Electric", swap = TRUE)
# Generate a random Fire or Flying type Pokemon
gen_dragon_or_electric()
# > "Zekrom"
gen_dragon_or_electric()
# > "Rayquaza"

# Create a random Pokemon generator for all Dragon type Pokemon
gen_all_dragon <- randomPokemonGen(type = "Dragon", swap = TRUE)
# Generate all Dragon type Pokemon
while(!coro::exhausted(gen_all_dragon)) {
  pokemon <- gen_all_dragon()
  print(pokemon)
}
# > "Zekrom", "Dreepy", "Guzzlord", "Archaludon", "Dragonite", "Raging Bolt",
# > "Frigibax", "Zweilous", "Goodra", "Rayquaza", "Regidrago", "Garchomp",
# > "Kingdra", "Roaring Moon", "Drakloak", "Jangmo-o", "Bagon", "Eternatus",
# > "Turtonator", "Altaria", "Goomy", "Baxcalibur", "Hydreigon", "Druddigon",
# > "Hydrapple", "Miraidon", "Dragapult", "Salamence", "Drampa", "Fraxure",
# > "Duraludon", "Zygarde", "Cyclizar", "Haxorus", "Dipplin", "Dratini",
# > "Dracovish", "Noibat", "Gouging Fire", "Latios", "Kyurem", "Latias",
# > "Palkia", "Walking Wake", "Kommo-o", "Sliggoo", "Vibrava", "Giratina",
# > "Dracozolt", "Flygon", "Tyrunt", "Shelgon", "Tatsugiri", "Dragalge",
# > "Axew", "Zygarde50", "Arctibax", "Tyrantrum", "Flapple", "Gible",
# > "Deino", "Applin", "Exeggutor", "Hakamo-o", "Noivern", "Koraidon",
# > "Dragonair", "Dialga", "Gabite", "Appletun", "Reshiram", "Naganadel",
# > "Zygarde10"

# Return the dex number instead
gen_dex <- randomPokemonGen(type = "Dragon", swap = TRUE, p = ndex)
# Generate all Dragon type Pokemon dex numbers
while(!coro::exhausted(gen_dex)) {
  pokemon = gen_dex()
  print(pokemon)
}
# > 1011, 1019, 371, 633, 634, 841, 334, 691,
# > 644, 718, 782, 381, 445, 804, 840, 704,
# > 799, 886, 380, 330, 842, 880, 714, 147,
# > 895, 646, 635, 705, 884, 1018, 967, 384,
# > 372, 373, 621, 780, 696, 887, 483, 1008,
# > 882, 706, 697, 1005, 784, 610, 978, 998,
# > 890, 997, 148, 443, 715, 776, 230, 611,
# > 783, 996, 1020, 103, 643, 1009, 487, 329,
# > 885, 612, 444, 149, 1021, 1007, 484

# Create a random Pokemon generator for Dragon type Pokemon with replacement
gen_dragon_replace <- randomPokemonGen(type = "Dragon", replace = TRUE)
# Generate 5 random Dragon type Pokemon with replacement
replicate(5, gen_dragon_replace())
# > "Zekrom" "Rayquaza" "Garchomp" "Zekrom" "Haxorus"
}
```