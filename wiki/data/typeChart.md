# Extended Pokémon Type Effectiveness Dataset (`typeChart`)

This dataset provides detailed effectiveness values for attacks between different Pokémon types.

It is structured in a long format, with each row representing an interaction between an attacking type and a defending type.
The 'Effectiveness' column provides the multiplier for the effectiveness of the attack.


## Columns
  - Attacking: (`factor`) The type of the attacking Pokémon's move. There are 18 types in total.
  - Defending: (`factor`) The type of the defending Pokémon. There are 18 types in total.
  - Effectiveness: (`numeric`) The multiplier for the effectiveness of the attack. It lists the effectiveness of an attacking type against a defending type, with numerical values indicating the level of effectiveness: 0 denotes immunity (no effect), 0.5 means the attack is not very effective (half damage), 1 means the attack is effective (regular damage), and 2 means the attack is very effective (double damage).

## Sourced from
  - [Bulbapedia Type](https://bulbapedia.bulbagarden.net/wiki/Type)

## Reffers to
  - Nothing

## Examples
```
data(typeChart)
```
