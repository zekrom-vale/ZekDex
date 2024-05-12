# Pokémon National Dex information in multiple languages (`languages`)

This dataset contains the names of Pokémon in various languages.
Each Pokémon has a unique name in each language, and these names often reflect the culture and
language patterns of their respective regions. The dataset includes names in multiple languages,
including but not limited to English, Japanese, German, French, Spanish, Italian, Korean, Chinese,
Brazilian Portuguese, Turkish, Russian, Thai, and Hindi. The language columns are in the format of
`<Language>_<language subset>`. If there is no subset, it's `<Language>`.


## Columns
  - ndex: (`integer`) The National Pokédex number of the Pokémon. This is the unique identifier for each Pokémon in the National Pokédex.
  - name: (`character`) The English name of the Pokémon.
  - form: (`character`) The form of the Pokémon. This refers to the different physical forms that Pokémon can take. 'NA' if the Pokémon does not have a special form.
  - regional: (`character`) The regional form of the Pokémon. This refers to the variations of Pokémon that appear differently and have different attributes compared to their counterparts in other regions. 'NA' if the Pokémon does not have a regional form.
  - type: (`character`) The primary type of the Pokémon. Each Pokémon has a primary type which determines the Pokémon's strengths and weaknesses.
  - type2: (`character`) The secondary type of the Pokémon. Some Pokémon may have a secondary type, which further influences the Pokémon's strengths and weaknesses. 'NA' if the Pokémon does not have a secondary type.
  - generation: (`integer`) The generation of the Pokémon. This refers to the generation of games in which the Pokémon was first introduced.
  - isLegendary: (`logical`) A boolean indicating if the Pokémon is Legendary. Legendary Pokémon are a group of incredibly rare and often very powerful Pokémon.
  - isMythical: (`logical`) A boolean indicating if the Pokémon is Mythical. Mythical Pokémon are a related but separate group of Pokémon, which are usually event-exclusive.
  - isUltraBeast: (`logical`) A boolean indicating if the Pokémon is an Ultra Beast. Ultra Beasts is a term introduced in Generation VII to classify seven known Pokémon.
  - family: (`character`) The family of the Pokémon. This refers to the group or lineage the Pokémon belongs to, often based on common themes or characteristics among the Pokémon.
  - size: (`character`) The size of the Pokémon. This refers to the height and weight of the Pokémon.
  - Japanese_Kana: (`character`) The Japanese Kana name of the Pokémon.
  - Japanese_Hepburn: (`character`) The Japanese Hepburn name of the Pokémon.
  - Japanese_Trademarked: (`character`) The Japanese Trademarked name of the Pokémon.
  - German: (`character`) The German name of the Pokémon.
  - French: (`character`) The French name of the Pokémon.
  - Spanish: (`character`) The Spanish name of the Pokémon.
  - Italian: (`character`) The Italian name of the Pokémon.
  - Korean_Hangul: (`character`) The Korean Hangul name of the Pokémon.
  - Korean_Revised: (`character`) The Korean Revised name of the Pokémon.
  - Korean_McCune-Reischauer: (`character`) The Korean McCune-Reischauer name of the Pokémon.
  - Korean_Official: (`character`) The Korean Official name of the Pokémon.
  - Chinese_Traditional: (`character`) The Chinese Traditional name of the Pokémon.
  - Chinese_Simplified: (`character`) The Chinese Simplified name of the Pokémon.
  - Chinese_Pinyin: (`character`) The Chinese Pinyin name of the Pokémon.
  - Chinese_Yale: (`character`) The Chinese Yale name of the Pokémon.
  - Chinese_Former names: (`character`) The Chinese Former names of the Pokémon.
  - Brazilian_Portuguese_brazilian_portuguese: (`character`) The Brazilian Portuguese name of the Pokémon.
  - Turkish: (`character`) The Turkish name of the Pokémon.
  - Russian_Cyrillic: (`character`) The Russian Cyrillic name of the Pokémon.
  - Russian_Romanization: (`character`) The Russian Romanization name of the Pokémon.
  - Thai: (`character`) The Thai name of the Pokémon.
  - Thai_RTGS: (`character`) The Thai RTGS name of the Pokémon.
  - Hindi_Devanāgarī: (`character`) The Hindi Devanāgarī name of the Pokémon.
  - Hindi_Transliteration: (`character`) The Hindi Transliteration name of the Pokémon.
  - Hindi_Romanization: (`character`) The Hindi Romanization name of the Pokémon.

## Sourced from
  - [List of Pokémon by National Pokédex number. In Bulbapedia.](https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_National_Pok%C3%A9dex_number)
  - [List of Japanese Pokémon names. In Bulbapedia.](https://bulbapedia.bulbagarden.net/wiki/List_of_Japanese_Pok%C3%A9mon_names)
  - [List of German Pokémon names. In Bulbapedia.](https://bulbapedia.bulbagarden.net/wiki/List_of_German_Pok%C3%A9mon_names)
  - [List of French Pokémon names. In Bulbapedia.](https://bulbapedia.bulbagarden.net/wiki/List_of_French_Pok%C3%A9mon_names)
  - [List of Spanish Pokémon names. In Bulbapedia.](https://bulbapedia.bulbagarden.net/wiki/List_of_Spanish_Pok%C3%A9mon_names)
  - [List of Italian Pokémon names. In Bulbapedia.](https://bulbapedia.bulbagarden.net/wiki/List_of_Italian_Pok%C3%A9mon_names)
  - [List of Korean Pokémon names. In Bulbapedia.](https://bulbapedia.bulbagarden.net/wiki/List_of_Korean_Pok%C3%A9mon_names)
  - [List of Chinese Pokémon names. In Bulbapedia.](https://bulbapedia.bulbagarden.net/wiki/List_of_Chinese_Pok%C3%A9mon_names)
  - [List of Brazilian Portuguese Pokémon names. In Bulbapedia.](https://bulbapedia.bulbagarden.net/wiki/List_of_Brazilian_Portuguese_Pok%C3%A9mon_names)
  - [List of Turkish Pokémon names. In Bulbapedia.](https://bulbapedia.bulbagarden.net/wiki/List_of_Turkish_Pok%C3%A9mon_names)
  - [List of Russian Pokémon names. In Bulbapedia.](https://bulbapedia.bulbagarden.net/wiki/List_of_Russian_Pok%C3%A9mon_names)
  - [List of Thai Pokémon names. In Bulbapedia.](https://bulbapedia.bulbagarden.net/wiki/List_of_Thai_Pok%C3%A9mon_names)
  - [List of Hindi Pokémon names. In Bulbapedia.](https://bulbapedia.bulbagarden.net/wiki/List_of_Hindi_Pok%C3%A9mon_names)

## Reffers to
  - Nothing

## Examples
```
data(languages)
```
