//bicaridine
/datum/chemical_reaction/medicine/helbital
	results = list(/datum/reagent/medicine/c2/helbital = 3)
	required_reagents = list(/datum/reagent/medicine/inaprovaline = 1, \
							/datum/reagent/carbon = 1, \
							/datum/reagent/fluorine = 1)
	mix_message = "The mixture turns into a thick, purple powder."
	required_temp = 150
	optimal_temp = 300
	overheat_temp = 350
	purity_min = 0
	reaction_flags = REACTION_PH_VOL_CONSTANT
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_HEALING | REACTION_TAG_BRUTE

//kelotane
/datum/chemical_reaction/medicine/lenturi
	results = list(/datum/reagent/medicine/c2/aiuri = 3)
	required_reagents = list(/datum/reagent/silicon = 1, \
							/datum/reagent/carbon = 1, \
							/datum/reagent/hydrogen = 1)
	mix_message = "The mixture turns into a soft, light blue powder."
	required_temp = 150
	optimal_temp = 300
	overheat_temp = 350
	purity_min = 0
	reaction_flags = REACTION_PH_VOL_CONSTANT
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_HEALING | REACTION_TAG_BURN

//dicorderal
/datum/chemical_reaction/medicine/probital
	results = list(/datum/reagent/medicine/c2/probital = 2)
	required_reagents = list(/datum/reagent/medicine/c2/aiuri = 1, \
							/datum/reagent/medicine/c2/helbital = 1)
	mix_message = "The mixture turns into a soft, light purple powder."
	required_temp = 600
	optimal_temp = 750
	overheat_temp = 800
	purity_min = 0
	reaction_flags = REACTION_PH_VOL_CONSTANT
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_HEALING | REACTION_TAG_BRUTE | REACTION_TAG_BURN

//tirimol
/datum/chemical_reaction/medicine/tirimol
	results = list(/datum/reagent/medicine/c2/tirimol = 3)
	required_reagents = list(/datum/reagent/benzene = 2, \
							/datum/reagent/nitrous_oxide = 1)
	required_catalysts = null
	mix_message = "The mixture turns into a tired, reddish pink liquid."
	required_temp = 350
	optimal_temp = 350
	overheat_temp = 450
	purity_min = 0
	reaction_flags = REACTION_PH_VOL_CONSTANT
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_HEALING | REACTION_TAG_OXY

//prussian blue
/datum/chemical_reaction/medicine/seiver
	results = list(/datum/reagent/medicine/c2/seiver = 3)
	required_reagents = list(/datum/reagent/toxin/cyanide = 1, \
							/datum/reagent/iron = 1, \
							/datum/reagent/toxin/acid = 1)
	required_catalysts = null
	mix_message = "The mixture solidies into a deep dark blue pigment."
	is_cold_recipe = FALSE
	required_temp = T20C
	optimal_temp = T20C
	overheat_temp = T20C+50
	purity_min = 0
	reaction_flags = REACTION_PH_VOL_CONSTANT
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_HEALING | REACTION_TAG_TOXIN
