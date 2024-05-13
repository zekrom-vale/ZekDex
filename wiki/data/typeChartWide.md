# Pokémon Type Effectiveness Dataset (`typeChartWide`)

This dataset provides a matrix of effectiveness multipliers for different types of Pokémon attacks.
Each Pokémon has a type, such as Fire, Water, Grass, etc., and each type has different effectiveness against other types.
This effectiveness is represented by a multiplier that is applied to the attack's damage.

The dataset is structured as a wide format, with each column representing a defending Pokémon's type and
each row representing an attacking Pokémon's type.


## Columns
  - Attacking: (`factor`) The type of the attacking Pokémon's move. There are 18 types in total.
  - Defending_*: (`numeric`) The effectiveness of the attacking type against the defending type. This is represented by a multiplier (0, 0.5, 1, 2) applied to the attack's damage. Each 'Defending_*' represents a different Pokémon type.

## Sourced from
  - [Bulbapedia Type](https://bulbapedia.bulbagarden.net/wiki/Type)

## Reffers to
  - Nothing

## Examples
```
data(typeChartWide)
```
