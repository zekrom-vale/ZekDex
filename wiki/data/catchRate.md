# Catch Rate Dataset (`catchRate`)

This dataset provides information about the catch rate of each Pokémon.


The catch rate is a statistic that determines the probability of capturing a Pokémon.
A higher catch rate means that the Pokémon is easier to catch.

In the context of Pokémon Legends: Arceus, many Pokémon were given heightened catch rates to facilitate catching them
outside of battle.


## Columns
  - ndex: (`integer`) The National Pokédex number of the Pokémon. This is the unique identifier for each Pokémon in the National Pokédex.
  - name: (`character`) The name of the Pokémon. This is the common name used to identify a particular Pokémon.
  - catchRate: (`integer`) The catch rate of the Pokémon. This is a value that represents the probability of capturing the Pokémon. Higher values indicate a higher probability of capture.
  - note: (`character`) Additional notes about the catch rate of the Pokémon. This may include information about specific conditions or factors that can influence the catch rate.
  - hdex: (`integer`) The Pokémon Legends: Arceus Pokédex number. This is the unique identifier for each Pokémon in the Pokémon Legends: Arceus Pokédex.

## Sourced from
  - [Bulbapedia Catch Rate](https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_catch_rate)

## Reffers to
  - Nothing

## Examples
```
data(catchRate)
```
