/datum/reagent/consumable/ethanol
	//Alcohol evaporates rather fast - 20u every 10 seconds
	liquid_evaporation_rate = 10
	liquid_fire_power = 10
	liquid_fire_burnrate = 0.1
	accelerant_quality = 10

/datum/reagent/consumable/ethanol/on_mob_metabolize(mob/living/L)
	. = ..()
	L.increase_chem_effect(CE_PAINKILLER, boozepwr/5, "[type]")

/datum/reagent/consumable/ethanol/on_mob_end_metabolize(mob/living/L)
	. = ..()
	L.decrease_chem_effect(CE_PAINKILLER, boozepwr/5, "[type]")

/datum/reagent/consumable/ethanol/beer
	liquid_fire_power = 2

/datum/reagent/consumable/ethanol/beer/light
	liquid_fire_power = 0

/datum/reagent/consumable/ethanol/beer/maltliquor
	liquid_fire_power = 3

/datum/reagent/consumable/ethanol/beer/green
	liquid_fire_power = 1

/datum/reagent/consumable/ethanol/kahlua
	liquid_fire_power = 4

/datum/reagent/consumable/ethanol/whiskey
	liquid_fire_power = 8

/datum/reagent/consumable/ethanol/whiskey/kong
	liquid_fire_power = 10

/datum/reagent/consumable/ethanol/whiskey/candycorn
	liquid_fire_power = 7

/datum/reagent/consumable/ethanol/thirteenloko
	liquid_fire_power = 10

/datum/reagent/consumable/ethanol/vodka
	liquid_fire_power = 7

/datum/reagent/consumable/ethanol/bilk
	liquid_fire_power = 0

/datum/reagent/consumable/ethanol/threemileisland
	liquid_fire_power = 1

/datum/reagent/consumable/ethanol/gin
	liquid_fire_power = 5

/datum/reagent/consumable/ethanol/rum
	liquid_fire_power = 6

/datum/reagent/consumable/ethanol/tequila
	liquid_fire_power = 7

/datum/reagent/consumable/ethanol/vermouth
	liquid_fire_power = 5

/datum/reagent/consumable/ethanol/wine
	liquid_fire_power = 4

/datum/reagent/consumable/ethanol/lizardwine
	liquid_fire_power = 4

/datum/reagent/consumable/ethanol/grappa
	liquid_fire_power = 6

/datum/reagent/consumable/ethanol/amaretto
	liquid_fire_power = 3

/datum/reagent/consumable/ethanol/cognac
	liquid_fire_power = 8

/datum/reagent/consumable/ethanol/absinthe
	liquid_fire_power = 8

/datum/reagent/consumable/ethanol/hooch
	liquid_fire_power = 10

/datum/reagent/consumable/ethanol/ale
	liquid_fire_power = 7

/datum/reagent/consumable/ethanol/goldschlager
	liquid_fire_power = 3

/datum/reagent/consumable/ethanol/patron
	liquid_fire_power = 6

/datum/reagent/consumable/ethanol/gintonic
	liquid_fire_power = 3

/datum/reagent/consumable/ethanol/rum_coke
	liquid_fire_power = 4

/datum/reagent/consumable/ethanol/cuba_libre
	liquid_fire_power = 5

/datum/reagent/consumable/ethanol/whiskey_cola
	liquid_fire_power = 6

/datum/reagent/consumable/ethanol/martini
	liquid_fire_power = 6

/datum/reagent/consumable/ethanol/vodkamartini
	liquid_fire_power = 7

/datum/reagent/consumable/ethanol/white_russian
	liquid_fire_power = 5

/datum/reagent/consumable/ethanol/screwdrivercocktail
	liquid_fire_power = 6

/datum/reagent/consumable/ethanol/booger
	liquid_fire_power = 5

/datum/reagent/consumable/ethanol/bloody_mary
	liquid_fire_power = 5

/datum/reagent/consumable/ethanol/brave_bull
	liquid_fire_power = 6

/datum/reagent/consumable/ethanol/tequila_sunrise
	liquid_fire_power = 5

/datum/reagent/consumable/ethanol/toxins_special
	liquid_fire_power = 3

/datum/reagent/consumable/ethanol/beepsky_smash
	liquid_fire_power = 6

/datum/reagent/consumable/ethanol/irish_cream
	liquid_fire_power = 5

/datum/reagent/consumable/ethanol/manly_dorf
	liquid_fire_power = 6

/datum/reagent/consumable/ethanol/longislandicedtea
	liquid_fire_power = 4

/datum/reagent/consumable/ethanol/moonshine
	liquid_fire_power = 10

/datum/reagent/consumable/ethanol/b52
	liquid_fire_power = 9

/datum/reagent/consumable/ethanol/irishcoffee
	liquid_fire_power = 4

/datum/reagent/consumable/ethanol/margarita
	liquid_fire_power = 4

/datum/reagent/consumable/ethanol/black_russian
	liquid_fire_power = 7

/datum/reagent/consumable/ethanol/manhattan
	liquid_fire_power = 3

/datum/reagent/consumable/ethanol/manhattan_proj
	liquid_fire_power = 5

/datum/reagent/consumable/ethanol/whiskeysoda
	liquid_fire_power = 7

/datum/reagent/consumable/ethanol/antifreeze
	liquid_fire_power = 4

/datum/reagent/consumable/ethanol/barefoot
	liquid_fire_power = 5

/datum/reagent/consumable/ethanol/snowwhite
	liquid_fire_power = 4

/datum/reagent/consumable/ethanol/demonsblood
	liquid_fire_power = 8

/datum/reagent/consumable/ethanol/devilskiss
	liquid_fire_power = 7

/datum/reagent/consumable/ethanol/vodkatonic
	liquid_fire_power = 7

/datum/reagent/consumable/ethanol/ginfizz
	liquid_fire_power = 5

/datum/reagent/consumable/ethanol/bahama_mama
	liquid_fire_power = 4

/datum/reagent/consumable/ethanol/singulo
	liquid_fire_power = 4

/datum/reagent/consumable/ethanol/sbiten
	liquid_fire_power = 7

/datum/reagent/consumable/ethanol/red_mead
	liquid_fire_power = 3

/datum/reagent/consumable/ethanol/mead
	liquid_fire_power = 3

/datum/reagent/consumable/ethanol/iced_beer
	liquid_fire_power = 1

/datum/reagent/consumable/ethanol/grog
	liquid_fire_power = 0

/datum/reagent/consumable/ethanol/aloe
	liquid_fire_burnrate = 4

/datum/reagent/consumable/ethanol/andalusia
	liquid_fire_power = 4

/datum/reagent/consumable/ethanol/alliescocktail
	liquid_fire_power = 5

/datum/reagent/consumable/ethanol/acid_spit
	liquid_fire_power = 7

/datum/reagent/consumable/ethanol/amasec
	liquid_fire_power = 4

/datum/reagent/consumable/ethanol/changelingsting
	liquid_fire_power = 5

/datum/reagent/consumable/ethanol/irishcarbomb
	liquid_fire_power = 3

/datum/reagent/consumable/ethanol/syndicatebomb
	liquid_fire_power = 9

/datum/reagent/consumable/ethanol/hiveminderaser
	liquid_fire_power = 4

/datum/reagent/consumable/ethanol/erikasurprise
	liquid_fire_power = 4

/datum/reagent/consumable/ethanol/driestmartini
	liquid_fire_power = 8

/datum/reagent/consumable/ethanol/bananahonk
	liquid_fire_power = 5

/datum/reagent/consumable/ethanol/silencer
	liquid_fire_power = 5

/datum/reagent/consumable/ethanol/drunkenblumpkin
	liquid_fire_power = 5

/datum/reagent/consumable/ethanol/whiskey_sour
	liquid_fire_power = 4

/datum/reagent/consumable/ethanol/hcider
	liquid_fire_power = 3

/datum/reagent/consumable/ethanol/fetching_fizz
	liquid_fire_power = 1

/datum/reagent/consumable/ethanol/hearty_punch
	liquid_fire_power = 9

/datum/reagent/consumable/ethanol/bacchus_blessing
	liquid_fire_power = 30

/datum/reagent/consumable/ethanol/atomicbomb
	liquid_fire_power = 2

/datum/reagent/consumable/ethanol/gargle_blaster
	liquid_fire_power = 2

/datum/reagent/consumable/ethanol/neurotoxin
	liquid_fire_power = 5

/datum/reagent/consumable/ethanol/hippies_delight
	liquid_fire_power = 2

/datum/reagent/consumable/ethanol/eggnog
	liquid_fire_power = 0

/datum/reagent/consumable/ethanol/narsour
	liquid_fire_power = 1

/datum/reagent/consumable/ethanol/triple_sec
	liquid_fire_power = 3

/datum/reagent/consumable/ethanol/creme_de_menthe
	liquid_fire_power = 2

/datum/reagent/consumable/ethanol/creme_de_cacao
	liquid_fire_power = 2

/datum/reagent/consumable/ethanol/creme_de_coconut
	liquid_fire_power = 2

/datum/reagent/consumable/ethanol/quadruple_sec
	liquid_fire_power = 4

/datum/reagent/consumable/ethanol/quintuple_sec
	liquid_fire_power = 6

/datum/reagent/consumable/ethanol/grasshopper
	liquid_fire_power = 3

/datum/reagent/consumable/ethanol/stinger
	liquid_fire_power = 3

/datum/reagent/consumable/ethanol/bastion_bourbon
	liquid_fire_power = 3

/datum/reagent/consumable/ethanol/squirt_cider
	liquid_fire_power = 4

/datum/reagent/consumable/ethanol/fringe_weaver
	liquid_fire_power = 9

/datum/reagent/consumable/ethanol/sugar_rush
	liquid_fire_power = 1

/datum/reagent/consumable/ethanol/crevice_spike
	liquid_fire_power = -1

/datum/reagent/consumable/ethanol/sake
	liquid_fire_power = 7

/datum/reagent/consumable/ethanol/peppermint_patty
	liquid_fire_power = 3

/datum/reagent/consumable/ethanol/alexander
	liquid_fire_power = 5

/datum/reagent/consumable/ethanol/amaretto_alexander
	liquid_fire_power = 4

/datum/reagent/consumable/ethanol/sidecar
	liquid_fire_power = 5

/datum/reagent/consumable/ethanol/between_the_sheets
	liquid_fire_power = 6

/datum/reagent/consumable/ethanol/kamikaze
	liquid_fire_power = 6

/datum/reagent/consumable/ethanol/mojito
	liquid_fire_power = 3

/datum/reagent/consumable/ethanol/moscow_mule
	liquid_fire_power = 3

/datum/reagent/consumable/ethanol/fernet
	liquid_fire_power = 10

/datum/reagent/consumable/ethanol/fernet_cola
	liquid_fire_power = 3

/datum/reagent/consumable/ethanol/fanciulli
	liquid_fire_power = -1

/datum/reagent/consumable/ethanol/branca_menta
	liquid_fire_power = 4

/datum/reagent/consumable/ethanol/blank_paper
	liquid_fire_power = 2

/datum/reagent/consumable/ethanol/fruit_wine
	liquid_fire_power = 4

/datum/reagent/consumable/ethanol/champagne
	liquid_fire_power = 4

/datum/reagent/consumable/ethanol/wizz_fizz
	liquid_fire_power = 6

/datum/reagent/consumable/ethanol/bug_spray
	liquid_fire_power = 6

/datum/reagent/consumable/ethanol/applejack
	liquid_fire_power = 2

/datum/reagent/consumable/ethanol/jack_rose
	liquid_fire_power = 2

/datum/reagent/consumable/ethanol/turbo
	liquid_fire_power = 9

/datum/reagent/consumable/ethanol/old_timer
	liquid_fire_power = 4

/datum/reagent/consumable/ethanol/rubberneck
	liquid_fire_power = 6

/datum/reagent/consumable/ethanol/duplex
	liquid_fire_power = 3

/datum/reagent/consumable/ethanol/trappist
	liquid_fire_power = 4

/datum/reagent/consumable/ethanol/blazaam
	liquid_fire_power = 7

/datum/reagent/consumable/ethanol/planet_cracker
	liquid_fire_power = 5

/datum/reagent/consumable/ethanol/mauna_loa
	liquid_fire_power = 4

/datum/reagent/consumable/ethanol/painkiller
	liquid_fire_power = 2

/datum/reagent/consumable/ethanol/pina_colada
	liquid_fire_power = 3

/datum/reagent/consumable/ethanol/pruno
	liquid_fire_power = 9

/datum/reagent/consumable/ethanol/ginger_amaretto
	liquid_fire_power = 3

/datum/reagent/consumable/ethanol/godfather
	liquid_fire_power = 5

/datum/reagent/consumable/ethanol/godmother
	liquid_fire_power = 5
