# Pokemon Evolution Dataset (`family`)

This dataset contains information about Pokémon evolution and family groupings.


It provides a comprehensive view of the evolution tree of each Pokémon,
making it an excellent resource for understanding how different Pokémon are related to each other and how they evolve.
The dataset includes Pokémon from all generations and covers various forms and regional variants.


## Columns
  - family: (`character`) The family to which the Pokemon belongs. This refers to the group or lineage the Pokémon belongs to, often based on common themes or characteristics among the Pokémon.
  - base: (`character`) The prior form of the pokemon or the base form. This is the form from which the Pokémon evolves.
  - form: (`character`) The specific form of the Pokemon. This refers to the different physical forms that Pokémon can take. NA if the Pokemon does not have a special form.
  - method: (`character`) The method of evolution. This refers to the specific condition or trigger that causes the Pokémon to evolve. Examples include leveling up, exposure to an evolution stone, trading, and more.
  - evo: (`character`) The next stage of the Pokemon. This is the form that the Pokémon evolves into.
  - evoForm: (`character`) The form of next stage of the Pokemon. This refers to the specific form that the Pokémon takes after evolution. NA if the Pokemon does not change form upon evolution.
  - transition: (`character`) The transition stage of the Pokemon. This refers to any intermediate stages that occur during the Pokémon's evolution.
  - first: (`character`) The first form of the Pokemon. This is the initial form of the Pokémon before any evolutions.
  - firstForm: (`character`) The specific first form of the Pokemon. This refers to the specific form that the Pokémon takes in its initial stage. NA if the Pokemon does not have a special form at the initial stage.
  - regional: (`factor`) The regional form of the Pokemon. This refers to the variations of Pokémon that appear differently and have different attributes compared to their counterparts in other regions. NA if the Pokemon does not have a regional form.
  - evoRegional: (`factor`) The regional evolved form of the Pokemon. This refers to the regional form that the Pokémon takes after evolution. NA if the Pokemon does not change form upon evolution in a specific region.
  - firstRegional: (`factor`) The regional first form of the Pokemon. This refers to the regional form that the Pokémon takes in its initial stage. NA if the Pokemon does not have a regional form at the initial stage.

## Sourced from
  - [List of Pokémon by evolution family. In Bulbapedia.](https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_evolution_family)

## Reffers to
  - [Methods of evolution. In Bulbapedia.](https://bulbapedia.bulbagarden.net/wiki/Methods_of_evolution)

## Examples
```
data(family)
```
