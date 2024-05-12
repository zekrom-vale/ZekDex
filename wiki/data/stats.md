# Pokemon Stats (`stats`)

This dataset contains the base stats of Pokémon, including various forms and sizes of Pokémon. Base stats are an important defining characteristic of each Pokémon species. They determine the potential of each Pokémon in terms of their HP (Hit Points), Attack, Defense, Speed, and Special abilities. These stats can be influenced by other factors such as level, nature, and effort values.


## Columns
  - ndex: (`integer`) National Pokédex number. This is the unique identifier for each Pokémon in the National Pokédex.
  - name: (`character`) Pokémon name. This is the common name used to identify a particular Pokémon.
  - HP: (`integer`) Hit Points. This determines how much damage a Pokémon can receive before fainting.
  - Attack: (`integer`) Attack strength. This determines how much damage a Pokémon can deal with physical moves.
  - Defense: (`integer`) Defensive strength. This determines how much damage a Pokémon can resist from physical moves.
  - Speed: (`integer`) Speed. This determines the order of Pokémon that can act in battle.
  - Special: (`integer`) Special attack or special defense strength. This determines how much damage a Pokémon can deal with special moves or resist from special moves. Note that this stat is combined into one in Generation I.
  - Total: (`integer`) Total of all stats. This is the sum of all the base stats of a Pokémon.
  - Average: (`numeric`) Average of all stats. This is the average value of all the base stats of a Pokémon.
  - Gen: (`factor`) Generation. This indicates the generation of games in which the Pokémon was introduced.
  - SpAttack: (`integer`) Special Attack strength. This determines how much damage a Pokémon can deal with special moves. This stat is not applicable for Generation I as 'Special' stat is used instead.
  - SpDefense: (`integer`) Special Defense strength. This determines how much damage a Pokémon can resist from special moves. This stat is not applicable for Generation I as 'Special' stat is used instead.

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
data(stats)
```
