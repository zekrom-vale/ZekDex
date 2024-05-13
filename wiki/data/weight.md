# Pokemon Weight Dataset (`weight`)

This dataset contains information about the weight of various Pokémon.
Each Pokémon's weight is recorded in both pounds (lbs) and kilograms (kg), providing flexibility for different uses.
The dataset also includes details about the lightest and heaviest Pokémon, their regional forms, and whether they have a Mega or Primal form.
This can be useful for a variety of analyses, such as studying the distribution of Pokémon weights,
identifying trends and patterns, or informing game strategies.


## Columns
  - name: (`character`) The name of the Pokémon.
  - form: (`character`) The form of the Pokémon. This refers to the different physical forms that Pokémon can take. 'NA' if the Pokémon does not have another form.
  - lbs: (`numeric`) The weight of the Pokémon in pounds.
  - kg: (`numeric`) The weight of the Pokémon in kilograms.
  - lightest: (`integer`) The rank of the Pokémon from lightest (1) to heaviest (1181).
  - heaveiest: (`integer`) The rank of the Pokémon from heaviest (1) to lightest (1181).
  - regional: (`character`) The regional form of the Pokémon. This refers to the variations of Pokémon that appear differently and have different attributes compared to their counterparts in other regions. 'NA' if the Pokémon does not have a regional form.
  - MegaOrPrimal: (`character`) Indicates if the Pokémon is in a Mega or Primal form. These are special forms that certain Pokémon can take.

## Sourced from
  - [Bulbapedia Weight](https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_weight)

## Reffers to
  - Nothing

## Examples
```
data(weight)
```
