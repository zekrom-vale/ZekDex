# Pokémon Type Effectiveness Dataset (`typeChartWide`)

This dataset provides a matrix of effectiveness multipliers for different types of Pokémon attacks.


Each Pokémon has a type, such as Fire, Water, Grass, etc., and each type has different effectiveness against other types.
This effectiveness is represented by a multiplier that is applied to the attack's damage.

The dataset is structured as a wide format, with each column representing a defending Pokémon's type and
each row representing an attacking Pokémon's type.


## Columns
  - Attacking: (`factor`) The type of the attacking Pokémon's move. There are 18 types in total.
  - Defending_Normal: (`numeric`) Effectiveness against Normal type.
  - Defending_Fighting: (`numeric`) Effectiveness against Fighting type.
  - Defending_Flying: (`numeric`) Effectiveness against Flying type.
  - Defending_Poison: (`numeric`) Effectiveness against Poison type.
  - Defending_Ground: (`numeric`) Effectiveness against Ground type.
  - Defending_Rock: (`numeric`) Effectiveness against Rock type.
  - Defending_Bug: (`numeric`) Effectiveness against Bug type.
  - Defending_Ghost: (`numeric`) Effectiveness against Ghost type.
  - Defending_Steel: (`numeric`) Effectiveness against Steel type.
  - Defending_Fire: (`numeric`) Effectiveness against Fire type.
  - Defending_Water: (`numeric`) Effectiveness against Water type.
  - Defending_Grass: (`numeric`) Effectiveness against Grass type.
  - Defending_Electric: (`numeric`) Effectiveness against Electric type.
  - Defending_Psychic: (`numeric`) Effectiveness against Psychic type.
  - Defending_Ice: (`numeric`) Effectiveness against Ice type.
  - Defending_Dragon: (`numeric`) Effectiveness against Dragon type.
  - Defending_Dark: (`numeric`) Effectiveness against Dark type.
  - Defending_Fairy: (`numeric`) Effectiveness against Fairy type.

## Sourced from
  - [Bulbapedia Type](https://bulbapedia.bulbagarden.net/wiki/Type)

## Reffers to
  - Nothing

## Examples
```
data(typeChartWide)
```
