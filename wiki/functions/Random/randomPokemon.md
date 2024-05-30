# Returns a random Pokemon (`randomPokemon`)



## Paramaters
 - `n` How many
 - `p` What column to return (ndex, name, form, regional, type, type2 can be used)
 - `replace` Should sampling be with replacement?


## Usage
```r
randomPokemon(n = 1, ..., p = name, replace = FALSE)
```

## Examples
```r
# Get a random Pokemon
randomPokemon()
# > "Koraidon"

# Get a random Dragon type
randomPokemon(type = "Dragon")
# > "Zekrom"

# Get 6 random Dragon Pokemon
randomPokemon(6, type = "Dragon")
# > c("Dragapult", "Jangmo-o", "Rayquaza", "Zekrom", "Garchomp", "Haxorus")

# Get a random Dragon-Electric Pokemon
randomPokemon(type = "Dragon", type2 = "Electric")
# > "Zekrom"

# Get a random Dragon-Electric or Electric-Dragon Pokemon
randomPokemon(type = "Dragon", type2 = "Electric", swap = TRUE)
# > "Miraidon"

# Get All random Dragon-\* or \*-Dragon Pokemon
randomPokemon(n = -1, type = "Dragon", swap = TRUE)
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
randomPokemon(n = -1, type = "Dragon", swap = TRUE, p = ndex)
# > 1011, 1019, 371, 633, 634, 841, 334, 691,
# > 644, 718, 782, 381, 445, 804, 840, 704,
# > 799, 886, 380, 330, 842, 880, 714, 147,
# > 895, 646, 635, 705, 884, 1018, 967, 384,
# > 372, 373, 621, 780, 696, 887, 483, 1008,
# > 882, 706, 697, 1005, 784, 610, 978, 998,
# > 890, 997, 148, 443, 715, 776, 230, 611,
# > 783, 996, 1020, 103, 643, 1009, 487, 329,
# > 885, 612, 444, 149, 1021, 1007, 484

```
