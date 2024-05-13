# National PokeDex (`nationalDex`)

The National PokeDex is a comprehensive database that records information on all Pokémon known to exist,
instead of just ones native in a particular region.
This dataset provides information about Pokémon as per the National Pokédex,
which includes Pokémon from the Kanto region first, followed by those from Johto,
Hoenn, Sinnoh, Unova, Kalos, Alola, Galar, Hisui, and Paldea.


## Columns
  - ndex: (`integer`) National Pokedex number. This is the unique identifier for each Pokémon in the National Pokédex.
  - name: (`character`) Name of the Pokemon. This is the common name used to identify a particular Pokémon.
  - form: (`character`) Form of the Pokemon. This refers to the different physical forms that Pokémon can take. NA if the Pokemon does not have a special form.
  - regional: (`character`) Regional form of the Pokemon. This refers to the variations of Pokémon that appear differently and have different attributes compared to their counterparts in other regions. NA if the Pokemon does not have a regional form.
  - type: (`character`) Primary type of the Pokemon. This is the main elemental category the Pokémon belongs to, such as Water, Fire, Grass, etc.
  - type2: (`character`) Secondary type of the Pokemon. This is the secondary elemental category the Pokémon belongs to, if any. NA if the Pokemon does not have a secondary type.
  - generation: (`integer`) The generation the Pokemon was introduced in. This refers to the different stages of Pokémon games, each introducing new Pokémon, regions, and gameplay concepts.
  - isLegendary: (`logical`) Whether the Pokemon is Legendary. This indicates if the Pokémon is a Legendary Pokémon, which are a group of incredibly rare and often very powerful Pokémon.
  - isMythical: (`logical`) Whether the Pokemon is Mythical. This indicates if the Pokémon is a Mythical Pokémon, which are a group of Pokémon seen so rarely in the Pokémon world that some question their very existence.
  - isUltraBeast: (`logical`) Whether the Pokemon is an Ultra Beast. This indicates if the Pokémon is an Ultra Beast, which are a group of extradimensional Pokémon originating from Ultra Space.
  - family: (`character`) Legendary / Mythical family group of the Pokemon. This refers to the group or lineage the Legendary or Mythical Pokémon belongs to. NA if the Pokemon does not belong to a family group.
  - size: (`character`) Legendary / Mythical family size. This refers to the size of the Legendary or Mythical family group the Pokémon belongs to. NA if the Pokemon does not belong to a family group.

## Sourced from
  - [List of Pokémon by National Pokédex number. In Bulbapedia.](https://bulbapedia.bulbagarden.net/wiki/List_of_Pokémon_by_National_Pokédex_number)

## Reffers to
  - [National Pokédex. In Bulbapedia.](https://bulbapedia.bulbagarden.net/wiki/National_Pokédex)

## Examples
```
data(nationalDex)
```
