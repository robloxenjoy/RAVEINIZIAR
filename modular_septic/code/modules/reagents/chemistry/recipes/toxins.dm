//do not swallow
/datum/chemical_reaction/armor_oil
	results = list(/datum/reagent/toxin/armor_oil = 3)
	required_reagents = list(/datum/reagent/fuel/oil = 1, \
							/datum/reagent/fuel/kerosene = 1, \
							/datum/reagent/fuel = 1)
	required_catalysts = list(/datum/reagent/space_cleaner = 10)
	required_temp = T0C
	optimal_temp = T0C
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_CHEMICAL
