# Pokémon Effort Value Yields (`evYield`)

A dataset about Pokémon effort value yields per generation.
When a Pokémon is defeated in battle, it will give effort values to the Pokémon that participated in the battle against it. The values shown below are the effort points that a Pokémon will give in.


This dataset provides information about Pokémon effort value yields as per each generation,
which includes Pokémon from the Kanto region first, followed by those from Johto,
Hoenn, Sinnoh, Unova, Kalos, Alola, Galar, Hisui, and Paldea.


## Columns
  - ndex: (`integer`) National Pokedex number. This is the unique identifier for each Pokémon in the National Pokédex.
  - name: (`character`) Name of the Pokemon. This is the common name used to identify a particular Pokémon.
  - form: (`character`) Form of the Pokemon. This refers to the different physical forms that Pokémon can take. NA if the Pokemon does not have a special form.
  - regional: (`factor`) Regional form of the Pokemon. This refers to the variations of Pokémon that appear differently and have different attributes compared to their counterparts in other regions. NA if the Pokemon does not have a regional form.
  - Gen: (`factor`) The generation the Pokemon was introduced in. This refers to the different stages of Pokémon games, each introducing new Pokémon, regions, and gameplay concepts.
  - Mega: (`character`) The Mega form. These are special forms that certain Pokémon can take.
  - MegaOrPrimal: (`factor`) Indicates if the Pokémon is in a Mega or Primal form. These are special forms that certain Pokémon can take.
  - Exp: (`integer`) The experience yield of the Pokemon.
  - note: (`character`) Any additional notes about the Pokemon. NA if there are no additional notes.
  - HP: (`integer`) The HP effort value yield of the Pokemon.
  - Attack: (`integer`) The Attack effort value yield of the Pokemon.
  - Defense: (`integer`) The Defense effort value yield of the Pokemon.
  - SpAttack: (`integer`) The Special Attack effort value yield of the Pokemon.
  - SpDefense: (`integer`) The Special Defense effort value yield of the Pokemon.
  - Speed: (`integer`) The Speed effort value yield of the Pokemon.
  - TotalEVs: (`integer`) The total effort value yield of the Pokemon.

## Sourced from
  - [List of Pokémon by effort value yield (Generation III). In Bulbapedia.](https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_effort_value_yield_(Generation_III))
  - [List of Pokémon by effort value yield (Generation IV). In Bulbapedia.](https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_effort_value_yield_(Generation_IV))
  - [List of Pokémon by effort value yield (Generation VII). In Bulbapedia.](https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_effort_value_yield_(Generation_VII))
  - [List of Pokémon by effort value yield (Generation VIII). In Bulbapedia.](https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_effort_value_yield_(Generation_VIII))
  - [List of Pokémon by effort value yield (Generation IX). In Bulbapedia.](https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_effort_value_yield_(Generation_IX))
  - [List of Pokémon by effort value yield (Generation V-VI). In Bulbapedia.](https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_effort_value_yield_(Generation_V-VI))

## Reffers to
  - [Effort Values. In Bulbapedia.](https://bulbapedia.bulbagarden.net/wiki/Effort_values)

## Examples
```
data(evYield)
```
