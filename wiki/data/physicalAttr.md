# Physical Attributes of Pokémon (`physicalAttr`)

This dataset provides a comprehensive overview of the physical attributes of Pokémon, including their type,
generation, weight, height, and other characteristics.
It includes information about each Pokémon's National Pokédex number, name, regional variant,
primary and secondary types, generation, legendary status, mythical status, ultra beast status,
family, size, form, weight in pounds and kilograms, lightest and heaviest weight rankings in the Pokédex,
Mega or Primal form status, height in feet, meters, and inches, and smallest and
biggest height rankings in the Pokédex.

This dataset can be useful for a variety of analyses, such as studying the distribution of Pokémon
weights and heights, identifying trends and patterns, or informing game strategies.


## Columns
  - ndex: (`integer`) The National Pokédex number of the Pokémon. This is the official numbering scheme that is used in every Pokémon game and media.
  - name: (`character`) The name of the Pokémon. This is the common name used to identify a particular Pokémon.
  - regional: (`factor`) The regional variant of the Pokémon, if any. This refers to the variations of Pokémon that appear differently and have different attributes compared to their counterparts in other regions.
  - type: (`factor`) The primary type of the Pokémon. Each Pokémon has a primary type which determines the Pokémon's strengths and weaknesses.
  - type2: (`factor`) The secondary type of the Pokémon, if any. Some Pokémon may have a secondary type, which further influences the Pokémon's strengths and weaknesses.
  - generation: (`factor`) The generation of the Pokémon. This refers to the generation of games in which the Pokémon was first introduced.
  - isLegendary: (`logical`) A boolean indicating if the Pokémon is Legendary. Legendary Pokémon are a group of incredibly rare and often very powerful Pokémon.
  - isMythical: (`logical`) A boolean indicating if the Pokémon is Mythical. Mythical Pokémon are a related but separate group of Pokémon, which are usually event-exclusive.
  - isUltraBeast: (`logical`) A boolean indicating if the Pokémon is an Ultra Beast. Ultra Beasts is a term introduced in Generation VII to classify seven known Pokémon.
  - family: (`factor`) Legendary / Mythical family group of the Pokemon. This refers to the group or lineage the Legendary or Mythical Pokémon belongs to. NA if the Pokemon does not belong to a family group.
  - size: (`factor`) Legendary / Mythical family size. This refers to the size of the Legendary or Mythical family group the Pokémon belongs to. NA if the Pokemon does not belong to a family group.
  - form: (`character`) The form of the Pokémon. This refers to the different physical forms that Pokémon can take.
  - lbs: (`numeric`) The weight of the Pokémon in pounds.
  - kg: (`numeric`) The weight of the Pokémon in kilograms.
  - lightest: (`integer`) The rank of the Pokémon from lightest (1) to heaviest (1181).
  - heaveiest: (`integer`) The rank of the Pokémon from heaviest (1) to lightest (1181).
  - MegaOrPrimal: (`factor`) Indicates if the Pokémon is in a Mega or Primal form. These are special forms that certain Pokémon can take.
  - ft: (`character`) The height of the Pokémon in feet.
  - m: (`numeric`) The height of the Pokémon in meters.
  - inch: (`integer`) The height of the Pokémon in inches.
  - smallest: (`integer`) The ranking of the Pokémon from smallest to biggest.
  - bigest: (`integer`) The ranking of the Pokémon from biggest to smallest.

## Sourced from
  - [Bulbapedia Weight](https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_weight)
  - [Bulbapedia Height](https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_height)

## Reffers to
  - Nothing

## Examples
```
data(physicalAttr)
```
