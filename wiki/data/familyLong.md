# Extended Pokemon Evolution Dataset (`familyLong`)

This dataset contains detailed information about Pokémon evolution and family groupings.


It provides a comprehensive view of the evolution tree of each Pokémon, making
it an excellent resource for understanding how different Pokémon are related to each other and how they evolve.
The dataset includes Pokémon from all generations and covers various forms and regional variants.

While this dataset loses the hierarchical structure of the evolution tree, it is particularly useful for identifying which Pokémon belong to each family. It provides a flat structure that can be easily filtered and sorted to find specific Pokémon and their families.

Note: The `family.x` and `family.y` variables need to be reconciled to ensure consistency across the dataset.


## Columns
  - family.x: (`character`) The family of the Pokemon. This refers to the group or lineage the Pokémon belongs to, often based on common themes or characteristics among the Pokémon.
  - transition: (`character`) The transition stage of the Pokemon. This refers to any intermediate stages that occur during the Pokémon's evolution.
  - first: (`character`) The first form of the Pokemon. This is the initial form of the Pokémon before any evolutions.
  - firstForm: (`character`) The first form of the Pokemon if it has multiple forms. This refers to the specific form that the Pokémon takes in its initial stage. NA if the Pokemon does not have a special form at the initial stage.
  - firstRegional: (`factor`) The first regional form of the Pokemon. This refers to the regional form that the Pokémon takes in its initial stage. NA if the Pokemon does not have a regional form at the initial stage.
  - name: (`character`) The name of the Pokemon. This is the common name used to identify a particular Pokémon.
  - form: (`character`) The form of the Pokemon. This refers to the different physical forms that Pokémon can take. NA if the Pokemon does not have a special form.
  - regional: (`factor`) The regional form of the Pokemon. This refers to the variations of Pokémon that appear differently and have different attributes compared to their counterparts in other regions. NA if the Pokemon does not have a regional form.
  - stage: (`factor`) The stage of the Pokemon. This refers to the stage in the Pokémon's evolution process, such as 'base', 'stage 1', 'stage 2', etc.
  - family.y: (`factor`) Legendary / Mythical family group of the Pokemon. This refers to the group or lineage the Legendary or Mythical Pokémon belongs to. NA if the Pokemon does not belong to a family group.
  - size: (`factor`) Legendary / Mythical family size. This refers to the size of the Legendary or Mythical family group the Pokémon belongs to. NA if the Pokemon does not belong to a family group.

## Sourced from
  - [Methods of evolution. In Bulbapedia.](https://bulbapedia.bulbagarden.net/wiki/Methods_of_evolution)

## Reffers to
  - Nothing

## Examples
```
data(familyLong)
```
