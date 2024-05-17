# Pokémon Mega Evolution and Primal Reversion (`mega`)

This dataset contains information about Pokémon that can undergo Mega Evolution and Primal Reversion,
which are special forms of evolution that Pokémon can undergo during battle to become more powerful.
These Pokémon are categorized by their National Pokédex number, name, type before and after evolution, ability before and after evolution, and the stone required for the evolution.

For example, ‘Rayquaza’ is a Dragon/Flying type Pokémon with the ability ‘Air Lock’ that can undergo
Mega Evolution to remain a Dragon/Flying type but with the ability ‘Delta Stream’. Unlike other Pokémon,
Rayquaza does not require a Mega Stone to undergo Mega Evolution. Instead, Rayquaza must swallow the
Meteorite and learn Dragon Ascent during the Delta Episode or must be taught Dragon Ascent via move tutor.

The 'Primal Reversion' refers to Kyogre and Groudon,
which are ancient Pokémon that revert to their primal forms with the Blue Orb and Red Orb respectively,
changing their abilities to 'Primordial Sea' and 'Desolate Land'.

Note that there exist Primal Dialga, hovever this appears to be different from Primal Reversion.


## Columns
  - ndex: (`integer`) The National Pokédex number of the Pokémon.
  - name: (`character`) The name of the Pokémon.
  - typeBefore: (`factor`) The primary type of the Pokémon before Mega Evolution or Primal Reversion.
  - type2Before: (`factor`) The secondary type of the Pokémon before Mega Evolution or Primal Reversion, if applicable.
  - abilityBefore: (`character`) The ability of the Pokémon before Mega Evolution or Primal Reversion.
  - typeAfter: (`factor`) The primary type of the Pokémon after Mega Evolution or Primal Reversion.
  - type2After: (`factor`) The secondary type of the Pokémon after Mega Evolution or Primal Reversion, if applicable.
  - abilityAfter: (`character`) The ability of the Pokémon after Mega Evolution or Primal Reversion.
  - stone: (`character`) The Mega Stone or Orb required for the Pokémon to undergo Mega Evolution or Primal Reversion.  Or a note in case of Rayquaza

## Sourced from
  - [Mega Evolution. In Bulbapedia.](https://bulbapedia.bulbagarden.net/wiki/Mega_Evolution)
  - [Primal Reversion. In Bulbapedia.](https://bulbapedia.bulbagarden.net/wiki/Primal_Reversion)

## Reffers to
  - Nothing

## Examples
```
data(mega)
```
