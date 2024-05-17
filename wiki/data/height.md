# Height Dataset (`height`)

This dataset contains information about the height of different Pokémon forms.
The height is represented in different units such as feet (ft), meters (m), and inches (inch),
providing flexibility for different uses.
It also includes the ranking of each Pokémon form from smallest to biggest, and information about regional forms and Mega or Primal forms.
This can be useful for a variety of analyses, such as studying the distribution of Pokémon heights,
identifying trends and patterns, or informing game strategies.


## Columns
  - name: (`character`) The name of the Pokémon.
  - form: (`character`) The specific form of the Pokémon. This refers to the different physical forms that Pokémon can take.
  - ft: (`numeric`) The height of the Pokémon in feet.
  - m: (`numeric`) The height of the Pokémon in meters.
  - inch: (`numeric`) The height of the Pokémon in inches.
  - smallest: (`integer`) The ranking of the Pokémon from smallest to biggest.
  - bigest: (`integer`) The ranking of the Pokémon from biggest to smallest.
  - regional: (`factor`) The regional form of the Pokémon. This refers to the variations of Pokémon that appear differently and have different attributes compared to their counterparts in other regions.
  - MegaOrPrimal: (`factor`) Indicates if the Pokémon is in a Mega or Primal form. These are special forms that certain Pokémon can take.

## Sourced from
  - [Bulbapedia Height](https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_height)

## Reffers to
  - Nothing

## Examples
```
data(height)
```
