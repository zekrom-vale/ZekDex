# Pokemon Stats (Wide Format) (`statsWide`)

This dataset is a wide format version of the `stats` dataset. It contains the base stats of Pokémon, including various forms and sizes of Pokémon, across different generations. Base stats are an important defining characteristic of each Pokémon species. They determine the potential of each Pokémon in terms of their HP (Hit Points), Attack, Defense, Speed, and Special abilities. These stats can be influenced by other factors such as level, nature, and effort values.


## Columns
  - ndex: (`integer`) National Pokédex number. This is the unique identifier for each Pokémon in the National Pokédex.
  - name: (`character`) Pokémon name. This is the common name used to identify a particular Pokémon.
  - Mega: (`character`) The Mega form. These are special forms that certain Pokémon can take.
  - MegaOrPrimal: (`character`) Indicates if the Pokémon is in a Mega or Primal form. These are special forms that certain Pokémon can take.
  - regional: (`character`) The regional form of the Pokémon. This refers to the variations of Pokémon that appear differently and have different attributes compared to their counterparts in other regions.
  - HP_I: (`integer`) Hit Points for Generation I. This determines how much damage a Pokémon can receive before fainting.
  - HP_VI: (`integer`) Hit Points for Generation VI. This determines how much damage a Pokémon can receive before fainting.
  - HP_VII: (`integer`) Hit Points for Generation VII. This determines how much damage a Pokémon can receive before fainting.
  - HP_VIII: (`integer`) Hit Points for Generation VIII. This determines how much damage a Pokémon can receive before fainting.
  - HP_IX: (`integer`) Hit Points for Generation IX. This determines how much damage a Pokémon can receive before fainting.
  - HP_II-V: (`integer`) Hit Points for Generations II to V. This determines how much damage a Pokémon can receive before fainting.
  - Attack_I: (`integer`) Attack strength for Generation I. This determines how much damage a Pokémon can deal with physical moves.
  - Attack_VI: (`integer`) Attack strength for Generation VI. This determines how much damage a Pokémon can deal with physical moves.
  - Attack_VII: (`integer`) Attack strength for Generation VII. This determines how much damage a Pokémon can deal with physical moves.
  - Attack_VIII: (`integer`) Attack strength for Generation VIII. This determines how much damage a Pokémon can deal with physical moves.
  - Attack_IX: (`integer`) Attack strength for Generation IX. This determines how much damage a Pokémon can deal with physical moves.
  - Attack_II-V: (`integer`) Attack strength for Generations II to V. This determines how much damage a Pokémon can deal with physical moves.
  - Defense_I: (`integer`) Defensive strength for Generation I. This determines how much damage a Pokémon can resist from physical moves.
  - Defense_VI: (`integer`) Defensive strength for Generation VI. This determines how much damage a Pokémon can resist from physical moves.
  - Defense_VII: (`integer`) Defensive strength for Generation VII. This determines how much damage a Pokémon can resist from physical moves.
  - Defense_VIII: (`integer`) Defensive strength for Generation VIII. This determines how much damage a Pokémon can resist from physical moves.
  - Defense_IX: (`integer`) Defensive strength for Generation IX. This determines how much damage a Pokémon can resist from physical moves.
  - Defense_II-V: (`integer`) Defensive strength for Generations II to V. This determines how much damage a Pokémon can resist from physical moves.
  - Speed_I: (`integer`) Speed for Generation I. This determines the order of Pokémon that can act in battle.
  - Speed_VI: (`integer`) Speed for Generation VI. This determines the order of Pokémon that can act in battle.
  - Speed_VII: (`integer`) Speed for Generation VII. This determines the order of Pokémon that can act in battle.
  - Speed_VIII: (`integer`) Speed for Generation VIII. This determines the order of Pokémon that can act in battle.
  - Speed_IX: (`integer`) Speed for Generation IX. This determines the order of Pokémon that can act in battle.
  - Speed_II-V: (`integer`) Speed for Generations II to V. This determines the order of Pokémon that can act in battle.
  - Special_I: (`integer`) Special attack or special defense strength for Generation I. This determines how much damage a Pokémon can deal with special moves or resist from special moves. Note that this stat is combined into one in Generation I.
  - Special_VI: (`integer`) Special attack or special defense strength for Generation VI. This determines how much damage a Pokémon can deal with special moves or resist from special moves.
  - Special_VII: (`integer`) Special attack or special defense strength for Generation VII. This determines how much damage a Pokémon can deal with special moves or resist from special moves.
  - Special_VIII: (`integer`) Special attack or special defense strength for Generation VIII. This determines how much damage a Pokémon can deal with special moves or resist from special moves.
  - Special_IX: (`integer`) Special attack or special defense strength for Generation IX. This determines how much damage a Pokémon can deal with special moves or resist from special moves.
  - Special_II-V: (`integer`) Special attack or special defense strength for Generations II to V. This determines how much damage a Pokémon can deal with special moves or resist from special moves.
  - Total_I: (`integer`) Total of all stats for Generation I. This is the sum of all the base stats of a Pokémon.
  - Total_VI: (`integer`) Total of all stats for Generation VI. This is the sum of all the base stats of a Pokémon.
  - Total_VII: (`integer`) Total of all stats for Generation VII. This is the sum of all the base stats of a Pokémon.
  - Total_VIII: (`integer`) Total of all stats for Generation VIII. This is the sum of all the base stats of a Pokémon.
  - Total_IX: (`integer`) Total of all stats for Generation IX. This is the sum of all the base stats of a Pokémon.
  - Total_II-V: (`integer`) Total of all stats for Generations II to V. This is the sum of all the base stats of a Pokémon.
  - Average_I: (`numeric`) Average of all stats for Generation I. This is the average value of all the base stats of a Pokémon.
  - Average_VI: (`numeric`) Average of all stats for Generation VI. This is the average value of all the base stats of a Pokémon.
  - Average_VII: (`numeric`) Average of all stats for Generation VII. This is the average value of all the base stats of a Pokémon.
  - Average_VIII: (`numeric`) Average of all stats for Generation VIII. This is the average value of all the base stats of a Pokémon.
  - Average_IX: (`numeric`) Average of all stats for Generation IX. This is the average value of all the base stats of a Pokémon.
  - Average_II-V: (`numeric`) Average of all stats for Generations II to V. This is the average value of all the base stats of a Pokémon.
  - SpAttack_I: (`integer`) Special Attack strength for Generation I. This determines how much damage a Pokémon can deal with special moves. This stat is not applicable for Generation I as 'Special' stat is used instead.
  - SpAttack_VI: (`integer`) Special Attack strength for Generation VI. This determines how much damage a Pokémon can deal with special moves.
  - SpAttack_VII: (`integer`) Special Attack strength for Generation VII. This determines how much damage a Pokémon can deal with special moves.
  - SpAttack_VIII: (`integer`) Special Attack strength for Generation VIII. This determines how much damage a Pokémon can deal with special moves.
  - SpAttack_IX: (`integer`) Special Attack strength for Generation IX. This determines how much damage a Pokémon can deal with special moves.
  - SpAttack_II-V: (`integer`) Special Attack strength for Generations II to V. This determines how much damage a Pokémon can deal with special moves.
  - SpDefense_I: (`integer`) Special Defense strength for Generation I. This determines how much damage a Pokémon can resist from special moves. This stat is not applicable for Generation I as 'Special' stat is used instead.
  - SpDefense_VI: (`integer`) Special Defense strength for Generation VI. This determines how much damage a Pokémon can resist from special moves.
  - SpDefense_VII: (`integer`) Special Defense strength for Generation VII. This determines how much damage a Pokémon can resist from special moves.
  - SpDefense_VIII: (`integer`) Special Defense strength for Generation VIII. This determines how much damage a Pokémon can resist from special moves.
  - SpDefense_IX: (`integer`) Special Defense strength for Generation IX. This determines how much damage a Pokémon can resist from special moves.
  - SpDefense_II-V: (`integer`) Special Defense strength for Generations II to V. This determines how much damage a Pokémon can resist from special moves.

## Sourced from
  - [List of Pokémon by base stats (Generation I). In Bulbapedia.](https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_base_stats_(Generation_I))
  - [List of Pokémon by base stats (Generation II-V). In Bulbapedia.](https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_base_stats_(Generation_II-V))
  - [List of Pokémon by base stats (Generation VI). In Bulbapedia.](https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_base_stats_(Generation_VI))
  - [List of Pokémon by base stats (Generation VII). In Bulbapedia.](https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_base_stats_(Generation_VII))
  - [List of Pokémon by base stats (Generation VIII). In Bulbapedia.](https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_base_stats_(Generation_VIII))
  - [List of Pokémon by base stats (Generation IX). In Bulbapedia.](https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_base_stats_(Generation_IX))

## Reffers to
  - Nothing

## Examples
```
data(statsWide)
```
