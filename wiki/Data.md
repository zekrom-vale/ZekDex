## Datasets

The package includes the following datasets:

### nationalDex
Pokemon National dex information
- `ndex` (`integer`): National Pokedex number.
- `name` (`character`): Name of the Pokemon.
- `form` (`character`): Form of the Pokemon. NA if the Pokemon does not have a special form.
- `regional` (`character`): Regional form of the Pokemon. NA if the Pokemon does not have a regional form.
- `type` (`character`): Primary type of the Pokemon.
- `type2` (`character`): Secondary type of the Pokemon. NA if the Pokemon does not have a secondary type.
- `generation` (`integer`): The generation the Pokemon was introduced in.
- `isLegendary` (`logical`): Whether the Pokemon is Legendary.
- `isMythical` (`logical`): Whether the Pokemon is Mythical.
- `isUltraBeast` (`logical`): Whether the Pokemon is an Ultra Beast.
- `family` (`character`): Legendary / Mythical family group of the Pokemon. NA if the Pokemon does not belong to a family group.
- `size` (`character`): Legendary / Mythical family size. NA if the Pokemon does not belong to a family group.

### groups
A dataset containing Legendary and Mythical Pokémon categorized by their family groupings and sizes.
- `family` (`character`): The family grouping of the Pokémon. Examples include 'Tao trio', 'Super-ancient Pokémon', 'Paradox duo', etc.
- `name` (`character`): The name of the individual Pokémon within the family grouping.
- `size` (`character`): The size category of the family grouping. Categories include 'duos', 'trios', 'quartets', and 'quintets'.

### stats
Base stats of Pokémon including various forms / sizes of Pokémon.
- `ndex` (`integer`): National Pokédex number
- `name` (`character`): Pokémon name
- `HP` (`integer`): Hit Points
- `Attack` (`integer`): Attack strength
- `Defense` (`integer`): Defensive strength
- `Speed` (`integer`): Speed
- `Special` (`integer`): Special attack or special defense strength
- `Total` (`integer`): Total of all stats
- `Average` (`numeric`): Average of all stats
- `Gen` (`factor`): Generation
- `SpAttack` (`integer`): Special Attack strength (NA for Gen I)
- `SpDefense` (`integer`): Special Defense strength (NA for Gen I)

### family
Pokemon evolution and family information.
This dataset is good if you want to know the evolution tree.
- `family` (`character`): The family to which the Pokemon belongs.
- `base` (`character`): The prior form of the pokemon or the base form
- `form` (`character`): The specific form of the Pokemon. NA if not applicable.
- `method` (`character`): The method of evolution.
- `evo` (`character`): The next stage of the Pokemon.
- `evoForm` (`character`): The form of next stage of the Pokemon. NA if not applicable.
- `transition` (`character`): The transition stage of the Pokemon.
- `first` (`character`): The first form of the Pokemon.
- `firstForm` (`character`): The specific first form of the Pokemon. NA if not applicable.
- `regional` (`character`): The regional form of the Pokemon. NA if not applicable.
- `evoRegional` (`character`): The regional evolved form of the Pokemon. NA if not applicable.
- `firstRegional` (`character`): The regional first form of the Pokemon. NA if not applicable.

### familyLong
Extended Pokémon family information.
This dataset looses the evolution tree, but is good for finding what Pokémon is in each family.
TODO fixing the `family.x` and `family.y` issue
- `family.x` (`character`): The family of the Pokemon
- `transition` (`character`): The transition stage of the Pokemon
- `first` (`character`): The first form of the Pokemon
- `firstForm` (`character`): The first form of the Pokemon if it has multiple forms
- `firstRegional` (`character`): The first regional form of the Pokemon
- `name` (`character`): The name of the Pokemon
- `form` (`character`): The form of the Pokemon
- `regional` (`character`): The regional form of the Pokemon
- `stage` (`character`): The stage of the Pokemon
- `family.y` (`character`): The legendary family of the Pokemon
- `size` (`character`): The size of the legendary family

### languages
As of now the language columns are in the format of `<Language>_<language subset>` if there is no subset it's `<Language>_<language>`.
- `ndex` (`integer`): National Pokedex number.
- `name` (`character`): Name of the Pokemon.
- `form` (`character`): Form of the Pokemon. NA if the Pokemon does not have a special form.
- `regional` (`character`): Regional form of the Pokemon. NA if the Pokemon does not have a regional form.
- `type` (`character`): Primary type of the Pokemon.
- `type2` (`character`): Secondary type of the Pokemon. NA if the Pokemon does not have a secondary type.
- `generation` (`integer`): The generation the Pokemon was introduced in.
- `isLegendary` (`logical`): Whether the Pokemon is Legendary.
- `isMythical` (`logical`): Whether the Pokemon is Mythical.
- `isUltraBeast` (`logical`): Whether the Pokemon is an Ultra Beast.
- `family` (`character`): Legendary / Mythical family group of the Pokemon. NA if the Pokemon does not belong to a family group.
- `size` (`character`): Legendary / Mythical family size. NA if the Pokemon does not belong to a family group.
- `Japanese_Kana` (`character`): Japanese Kana name of the Pokemon.
- `Japanese_Hepburn` (`character`): Japanese Hepburn name of the Pokemon.
- `Japanese_Trademarked` (`character`): Japanese Trademarked name of the Pokemon.
- `German` (`character`): German name of the Pokemon.
- `French` (`character`): French name of the Pokemon.
- `Spanish` (`character`): Spanish name of the Pokemon.
- `Italian` (`character`): Italian name of the Pokemon.
- `Korean_Hangul` (`character`): Korean Hangul name of the Pokemon.
- `Korean_Revised` (`character`): Korean Revised name of the Pokemon.
- `Korean_McCune-Reischauer` (`character`): Korean McCune-Reischauer name of the Pokemon.
- `Korean_Official` (`character`): Korean Official name of the Pokemon.
- `Chinese_Traditional` (`character`): Chinese Traditional name of the Pokemon.
- `Chinese_Simplified` (`character`): Chinese Simplified name of the Pokemon.
- `Chinese_Pinyin` (`character`): Chinese Pinyin name of the Pokemon.
- `Chinese_Yale` (`character`): Chinese Yale name of the Pokemon.
- `Chinese_Former names` (`character`): Chinese Former names of the Pokemon.
- `Brazilian_Portuguese_brazilian_portuguese` (`character`): Brazilian Portuguese name of the Pokemon.
- `Turkish` (`character`): Turkish name of the Pokemon.
- `Russian_Cyrillic` (`character`): Russian Cyrillic name of the Pokemon.
- `Russian_Romanization` (`character`): Russian Romanization name of the Pokemon.
- `Thai` (`character`): Thai name of the Pokemon.
- `Thai_RTGS` (`character`): Thai RTGS name of the Pokemon.
- `Hindi_Devanāgarī` (`character`): Hindi Devanāgarī name of the Pokemon.
- `Hindi_Transliteration` (`character`): Hindi Transliteration name of the Pokemon.
- `Hindi_Romanization` (`character`): Hindi Romanization name of the Pokemon.

### regionalDex
As of now the regionalDex columns are in the format of `<Game>_<Region>_<DexName>`, `NA` if that data is missing.
- `ndex` (`integer`): National Pokedex number.
- `name` (`character`): Name of the Pokemon.
- `form` (`character`): Form of the Pokemon.
- `regional` (`character`): Regional form of the Pokemon.
- `type` (`character`): Primary type of the Pokemon.
- `type2` (`character`): Secondary type of the Pokemon.
- `generation` (`integer`): Generation of the Pokemon.
- `isLegendary` (`logical`): Boolean indicating if the Pokemon is Legendary.
- `isMythical` (`logical`): Boolean indicating if the Pokemon is Mythical.
- `isUltraBeast` (`logical`): Boolean indicating if the Pokemon is an Ultra Beast.
- `family` (`character`): Family of the Pokemon.
- `size` (`character`): Size of the Pokemon.
- `NA_Kanto_Kdex` (`integer`): Kanto Pokedex number.
- `NA_Johto_Jdex` (`integer`): Johto Pokedex number.
- `GenerationIII_Hoenn_Hdex` (`integer`): Hoenn Pokedex number in Generation III.
- `GenerationVI_Hoenn_Hdex` (`integer`): Hoenn Pokedex number in Generation VI.
- `NA_Sinnoh_Sdex` (`integer`): Sinnoh Pokedex number.
- `BlackandWhite_Unova_Udex` (`integer`): Unova Pokedex number in Black and White.
- `Black2andWhite2_Unova_Udex` (`integer`): Unova Pokedex number in Black 2 and White 2.
- `NA_Blueberry_BBdex` (`integer`): Blueberry Pokedex number.
- `NA_Kalos_CeKdex` (`integer`): Central Kalos Pokedex number.
- `NA_Kalos_CoKdex` (`integer`): Coastal Kalos Pokedex number.
- `NA_Kalos_MoKdex` (`integer`): Mountain Kalos Pokedex number.
- `SunandMoon_Alola_Adex` (`integer`): Alola Pokedex number in Sun and Moon.
- `SunandMoon_Alola_Melemele` (`integer`): Melemele Pokedex number in Sun and Moon.
- `SunandMoon_Alola_Akala` (`integer`): Akala Pokedex number in Sun and Moon.
- `SunandMoon_Alola_Ula'ula` (`integer`): Ula'ula Pokedex number in Sun and Moon.
- `SunandMoon_Alola_Poni` (`integer`): Poni Pokedex number in Sun and Moon.
- `UltraSunandUltraMoon_Alola_Adex` (`integer`): Alola Pokedex number in Ultra Sun and Ultra Moon.
- `UltraSunandUltraMoon_Alola_Melemele` (`integer`): Melemele Pokedex number in Ultra Sun and Ultra Moon.
- `UltraSunandUltraMoon_Alola_Akala` (`integer`): Akala Pokedex number in Ultra Sun and Ultra Moon.
- `UltraSunandUltraMoon_Alola_Ula'ula` (`integer`): Ula'ula Pokedex number in Ultra Sun and Ultra Moon.
- `UltraSunandUltraMoon_Alola_Poni` (`integer`): Poni Pokedex number in Ultra Sun and Ultra Moon.
- `NA_Galar_Gdex` (`integer`): Galar Pokedex number.
- `NA_IsleofArmor_IoAdex` (`integer`): Isle of Armor Pokedex number.
- `NA_CrownTundra_CTdex` (`integer`): Crown Tundra Pokedex number.
- `NA_Hisui_LAdex` (`integer`): Hisui Pokedex number.
- `NA_Paldea_Pdex` (`integer`): Paldea Pokedex number.
- `NA_Kitakami_Kdex` (`integer`): Kitakami Pokedex number.

### types
This dataset contains information about various Pokemon types.
- `types` (`character`): The types of Pokemon. Possible types include "Grass", "Fire", "Water", "Bug", "Normal", "Dark", "Poison", "Electric", "Ground", "Ice", "Fairy", "Steel", "Fighting", "Psychic", "Rock", "Ghost", "Dragon", "Flying".

### typeChartWide
This dataset outlines the effectiveness of various attacking Pokémon types against defending types.
Each cell in the dataset represents the effectiveness multiplier when a Pokémon type attacks another.
The effectiveness is represented by numerical values:
- **0** denotes immunity (the attack has no effect)
- **0.5** means the attack is not very effective (half damage)
- **1** means the attack is effective (causes regular damage)
- **2** means the attack is very effective (causes double damage)
- `Attacking` (`factor`): The Pokémon type of the attacking move.
- `Defending_Normal` (`numeric`): Effectiveness against Normal type.
- `Defending_Fighting` (`numeric`): Effectiveness against Fighting type.
- `Defending_Flying` (`numeric`): Effectiveness against Flying type.
- `Defending_Poison` (`numeric`): Effectiveness against Poison type.
- `Defending_Ground` (`numeric`): Effectiveness against Ground type.
- `Defending_Rock` (`numeric`): Effectiveness against Rock type.
- `Defending_Bug` (`numeric`): Effectiveness against Bug type.
- `Defending_Ghost` (`numeric`): Effectiveness against Ghost type.
- `Defending_Steel` (`numeric`): Effectiveness against Steel type.
- `Defending_Fire` (`numeric`): Effectiveness against Fire type.
- `Defending_Water` (`numeric`): Effectiveness against Water type.
- `Defending_Grass` (`numeric`): Effectiveness against Grass type.
- `Defending_Electric` (`numeric`): Effectiveness against Electric type.
- `Defending_Psychic` (`numeric`): Effectiveness against Psychic type.
- `Defending_Ice` (`numeric`): Effectiveness against Ice type.
- `Defending_Dragon` (`numeric`): Effectiveness against Dragon type.
- `Defending_Dark` (`numeric`): Effectiveness against Dark type.
- `Defending_Fairy` (`numeric`): Effectiveness against Fairy type.

### typeChart
This dataset provides detailed effectiveness values for attacks between different Pokémon types.
It lists the effectiveness of an attacking type against a defending type, with numerical values indicating the level of effectiveness:
- **0** denotes immunity (no effect)
- **0.5** means the attack is not very effective (half damage)
- **1** means the attack is effective (regular damage)
- **2** means the attack is very effective (double damage)
- `Attacking` (`factor`): The Pokémon type of the attacking move.
- `Defending` (`factor`): The Pokémon type of the defending Pokémon.
- `Effectiveness` (`numeric`): The multiplier for the effectiveness of the attack.

### weight
This dataset contains information about the weight of various Pokemon in both pounds (lbs) and kilograms (kg).
It also includes details about the lightest and heaviest Pokemon, their regional forms, and whether they have a Mega or Primal form.
- `name` (`character`): Name of the Pokemon
- `form` (`character`): The form of the Pokemon, NA if it does not have another form
- `lbs` (`numeric`): Weight of the Pokemon in pounds
- `kg` (`numeric`): Weight of the Pokemon in kilograms
- `lightest` (`integer`): Rank of the Pokemon from lightest (1) to heaviest (1181)
- `heaviest` (`integer`): Rank of the Pokemon from heaviest (1) to lightest (1181)
- `regional` (`character`): The regional form of the Pokemon, NA if it does not have a regional form
- `MegaOrPrimal` (`character`): Is the Pokémon in a Mega or Primal form

### height
This dataset contains information about the height of different Pokémon forms.
The height is represented in different units such as feet (ft), meters (m), and inches (inch).
It also includes the ranking of each Pokémon form from smallest to biggest,
and information about regional forms and Mega or Primal forms.
- `name` (`character`): Name of the Pokémon
- `form` (`character`): Specific form of the Pokémon
- `ft` (`numeric`): Height of the Pokémon in feet
- `m` (`numeric`): Height of the Pokémon in meters
- `inch` (`numeric`): Height of the Pokémon in inches
- `smallest` (`integer`): Ranking of the Pokémon from smallest to biggest
- `bigest` (`integer`): Ranking of the Pokémon from biggest to smallest
- `regional` (`character`): Regional form of the Pokémon, if any
- `MegaOrPrimal` (`character`): Is the Pokémon in a Mega or Primal form

### physicalAttr
This dataset contains information about the physical attributes of Pokémon, including their type, generation, weight, height, and other characteristics.
- `ndex` (`integer`): National Pokédex number
- `name` (`character`): Name of the Pokémon
- `regional` (`character`): Regional variant, if any
- `type` (`character`): Primary type of the Pokémon
- `type2` (`character`): Secondary type of the Pokémon, if any
- `generation` (`integer`): Generation of the Pokémon
- `isLegendary` (`logical`): Indicates if the Pokémon is Legendary
- `isMythical` (`logical`): Indicates if the Pokémon is Mythical
- `isUltraBeast` (`logical`): Indicates if the Pokémon is an Ultra Beast
- `family` (`character`): Family of the Pokémon, if any
- `size` (`character`): Size of the Pokémon, if any
- `form` (`character`): Form of the Pokémon, if any
- `lbs` (`numeric`): Weight of the Pokémon in pounds
- `kg` (`numeric`): Weight of the Pokémon in kilograms
- `lightest` (`integer`): Lightest weight of the Pokémon in the Pokédex
- `heaveiest` (`integer`): Heaviest weight of the Pokémon in the Pokédex
- `MegaOrPrimal` (`character`): Is the Pokémon in a Mega or Primal form
- `ft` (`character`): Height of the Pokémon in feet
- `m` (`numeric`): Height of the Pokémon in meters
- `inch` (`integer`): Height of the Pokémon in inches
- `smallest` (`integer`): Smallest height of the Pokémon in the Pokédex
- `bigest` (`integer`): Biggest height of the Pokémon in the Pokédex

### catchRate
This dataset provides the catch rate for each Pokémon. The catch rate is a
statistic that determines how easy it is to catch a Pokémon. The higher the
catch rate, the easier it is to catch the Pokémon. In the context of Pokémon Legends: Arceus,
many Pokémon were given heightened catch rates to make catching them outside of battle much easier.
- `Ndex` (`integer`): National Pokédex number
- `name` (`character`): Name of the Pokémon
- `catchRate` (`integer`): Catch rate of the Pokémon
- `note` (`character`): Additional notes about the catch rate
- `Hdex` (`integer`): Pokémon Legends: Arceus Pokédex number

You can load any dataset with the `data()` function. For example, `data(nationalDex)`.