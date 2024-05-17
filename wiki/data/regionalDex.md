# Pokémon Information from the Regional Dex (`regionalDex`)

This dataset contains information about Pokémon as per the Regional Pokédex.
The regionalDex columns are in the format of `<Game>_<Region>_<DexName>`.
If the data is missing, it is represented as `NA`.


## Columns
  - ndex: (`integer`) The National Pokédex number of the Pokémon.
  - name: (`character`) The name of the Pokémon.
  - form: (`character`) The form of the Pokémon. This refers to the different physical forms that Pokémon can take.
  - regional: (`factor`) The regional form of the Pokémon. This refers to the variations of Pokémon that appear differently and have different attributes compared to their counterparts in other regions.
  - type: (`factor`) The primary type of the Pokémon. Each Pokémon has a primary type which determines the Pokémon's strengths and weaknesses.
  - type2: (`factor`) The secondary type of the Pokémon. Some Pokémon may have a secondary type, which further influences the Pokémon's strengths and weaknesses.
  - generation: (`integer`) The generation of the Pokémon. This refers to the generation of games in which the Pokémon was first introduced.
  - isLegendary: (`logical`) A boolean indicating if the Pokémon is Legendary. Legendary Pokémon are a group of incredibly rare and often very powerful Pokémon.
  - isMythical: (`logical`) A boolean indicating if the Pokémon is Mythical. Mythical Pokémon are a related but separate group of Pokémon, which are usually event-exclusive.
  - isUltraBeast: (`logical`) A boolean indicating if the Pokémon is an Ultra Beast. Ultra Beasts is a term introduced in Generation VII to classify seven known Pokémon.
  - family: (`factor`) Legendary / Mythical family group of the Pokemon. This refers to the group or lineage the Legendary or Mythical Pokémon belongs to. NA if the Pokemon does not belong to a family group.
  - size: (`factor`) Legendary / Mythical family size. This refers to the size of the Legendary or Mythical family group the Pokémon belongs to. NA if the Pokemon does not belong to a family group.
  - NA_Kanto_Kdex: (`integer`) The Kanto Pokédex number. This is the number assigned to the Pokémon in the Kanto Regional Pokédex.
  - NA_Johto_Jdex: (`integer`) The Johto Pokédex number. This is the number assigned to the Pokémon in the Johto Regional Pokédex.
  - GenerationIII_Hoenn_Hdex: (`integer`) The Hoenn Pokédex number in Generation III. This is the number assigned to the Pokémon in the Hoenn Regional Pokédex in Generation III games.
  - GenerationVI_Hoenn_Hdex: (`integer`) The Hoenn Pokédex number in Generation VI. This is the number assigned to the Pokémon in the Hoenn Regional Pokédex in Generation VI games.
  - NA_Sinnoh_Sdex: (`integer`) The Sinnoh Pokédex number. This is the number assigned to the Pokémon in the Sinnoh Regional Pokédex.
  - BlackandWhite_Unova_Udex: (`integer`) The Unova Pokédex number in Black and White. This is the number assigned to the Pokémon in the Unova Regional Pokédex in Pokémon Black and White.
  - Black2andWhite2_Unova_Udex: (`integer`) The Unova Pokédex number in Black 2 and White 2. This is the number assigned to the Pokémon in the Unova Regional Pokédex in Pokémon Black 2 and White 2.
  - NA_Blueberry_BBdex: (`integer`) The Blueberry Pokédex number. This is the number assigned to the Pokémon in the Blueberry Regional Pokédex.
  - NA_Kalos_CeKdex: (`integer`) The Central Kalos Pokédex number. This is the number assigned to the Pokémon in the Central Kalos Regional Pokédex.
  - NA_Kalos_CoKdex: (`integer`) The Coastal Kalos Pokédex number. This is the number assigned to the Pokémon in the Coastal Kalos Regional Pokédex.
  - NA_Kalos_MoKdex: (`integer`) The Mountain Kalos Pokédex number. This is the number assigned to the Pokémon in the Mountain Kalos Regional Pokédex.
  - SunandMoon_Alola_Adex: (`integer`) The Alola Pokédex number in Sun and Moon. This is the number assigned to the Pokémon in the Alola Regional Pokédex in Pokémon Sun and Moon.
  - SunandMoon_Alola_Melemele: (`integer`) The Melemele Pokédex number in Sun and Moon. This is the number assigned to the Pokémon in the Melemele Regional Pokédex in Pokémon Sun and Moon.
  - SunandMoon_Alola_Akala: (`integer`) The Akala Pokédex number in Sun and Moon. This is the number assigned to the Pokémon in the Akala Regional Pokédex in Pokémon Sun and Moon.
  - SunandMoon_Alola_Ulaula: (`integer`) The Ula'ula Pokédex number in Sun and Moon. This is the number assigned to the Pokémon in the Ula'ula Regional Pokédex in Pokémon Sun and Moon.
  - SunandMoon_Alola_Poni: (`integer`) The Poni Pokédex number in Sun and Moon. This is the number assigned to the Pokémon in the Poni Regional Pokédex in Pokémon Sun and Moon.
  - UltraSunandUltraMoon_Alola_Adex: (`integer`) The Alola Pokédex number in Ultra Sun and Ultra Moon. This is the number assigned to the Pokémon in the Alola Regional Pokédex in Pokémon Ultra Sun and Ultra Moon.
  - UltraSunandUltraMoon_Alola_Melemele: (`integer`) The Melemele Pokédex number in Ultra Sun and Ultra Moon. This is the number assigned to the Pokémon in the Melemele Regional Pokédex in Pokémon Ultra Sun and Ultra Moon.
  - UltraSunandUltraMoon_Alola_Akala: (`integer`) The Akala Pokédex number in Ultra Sun and Ultra Moon. This is the number assigned to the Pokémon in the Akala Regional Pokédex in Pokémon Ultra Sun and Ultra Moon.
  - UltraSunandUltraMoon_Alola_Ulaula: (`integer`) The Ula'ula Pokédex number in Ultra Sun and Ultra Moon. This is the number assigned to the Pokémon in the Ula'ula Regional Pokédex in Pokémon Ultra Sun and Ultra Moon.
  - UltraSunandUltraMoon_Alola_Poni: (`integer`) The Poni Pokédex number in Ultra Sun and Ultra Moon. This is the number assigned to the Pokémon in the Poni Regional Pokédex in Pokémon Ultra Sun and Ultra Moon.
  - NA_Galar_Gdex: (`integer`) The Galar Pokédex number. This is the number assigned to the Pokémon in the Galar Regional Pokédex.
  - NA_IsleofArmor_IoAdex: (`integer`) The Isle of Armor Pokédex number. This is the number assigned to the Pokémon in the Isle of Armor Regional Pokédex.
  - NA_CrownTundra_CTdex: (`integer`) The Crown Tundra Pokédex number. This is the number assigned to the Pokémon in the Crown Tundra Regional Pokédex.
  - NA_Hisui_LAdex: (`integer`) The Hisui Pokédex number. This is the number assigned to the Pokémon in the Hisui Regional Pokédex.
  - NA_Paldea_Pdex: (`integer`) The Paldea Pokédex number. This is the number assigned to the Pokémon in the Paldea Regional Pokédex.
  - NA_Kitakami_Kdex: (`integer`) The Kitakami Pokédex number. This is the number assigned to the Pokémon in the Kitakami Regional Pokédex.

## Sourced from
  - [List of Pokémon by Kanto Pokédex number. In Bulbapedia.](https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_Kanto_Pok%C3%A9dex_number)
  - [List of Pokémon by New Pokédex number. In Bulbapedia.](https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_New_Pok%C3%A9dex_number)
  - [List of Pokémon by Johto Pokédex number. In Bulbapedia.](https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_Johto_Pok%C3%A9dex_number)
  - [List of Pokémon by Hoenn Pokédex number (Generation III). In Bulbapedia.](https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_Hoenn_Pok%C3%A9dex_number_(Generation_III))
  - [List of Pokémon by Hoenn Pokédex number (Generation VI). In Bulbapedia.](https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_Hoenn_Pok%C3%A9dex_number_(Generation_VI))
  - [List of Pokémon by Sinnoh Pokédex number. In Bulbapedia.](https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_Sinnoh_Pok%C3%A9dex_number)
  - [List of Pokémon by Unova Pokédex number (Black and White). In Bulbapedia.](https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_Unova_Pok%C3%A9dex_number_(Black_and_White))
  - [List of Pokémon by Unova Pokédex number (Black 2 and White 2). In Bulbapedia.](https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_Unova_Pok%C3%A9dex_number_(Black_2_and_White_2))
  - [List of Pokémon by Blueberry Pokédex number. In Bulbapedia.](https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_Blueberry_Pok%C3%A9dex_number)
  - [List of Pokémon by Kalos Pokédex number. In Bulbapedia.](https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_Kalos_Pok%C3%A9dex_number)
  - [List of Pokémon by Alola Pokédex number (Sun and Moon). In Bulbapedia.](https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_Alola_Pok%C3%A9dex_number_(Sun_and_Moon))
  - [List of Pokémon by Alola Pokédex number (Ultra Sun and Ultra Moon). In Bulbapedia.](https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_Alola_Pok%C3%A9dex_number_(Ultra_Sun_and_Ultra_Moon))
  - [List of Pokémon by Galar Pokédex number. In Bulbapedia.](https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_Galar_Pok%C3%A9dex_number)
  - [List of Pokémon by Isle of Armor Pokédex number. In Bulbapedia.](https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_Isle_of_Armor_Pok%C3%A9dex_number)
  - [List of Pokémon by Crown Tundra Pokédex number. In Bulbapedia.](https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_Crown_Tundra_Pok%C3%A9dex_number)
  - [List of Pokémon by Hisui Pokédex number. In Bulbapedia.](https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_Hisui_Pok%C3%A9dex_number)
  - [List of Pokémon by Paldea Pokédex number. In Bulbapedia.](https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_Paldea_Pok%C3%A9dex_number)
  - [List of Pokémon by Kitakami Pokédex number. In Bulbapedia.](https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_Kitakami_Pok%C3%A9dex_number)

## Reffers to
  - Nothing

## Examples
```
data(regionalDex)
```
