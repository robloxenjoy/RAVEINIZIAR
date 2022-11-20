//inaprovaline
/datum/chemical_reaction/medicine/inaprovaline
	results = list(/datum/reagent/medicine/inaprovaline = 3)
	required_reagents = list(/datum/reagent/acetone = 1, \
							/datum/reagent/carbon = 1, \
							/datum/reagent/consumable/sugar = 1)
	required_temp = 300
	optimal_temp = 400
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_CHEMICAL | REACTION_TAG_HEALING

//lisinopril
/datum/chemical_reaction/medicine/lisinopril
	results = list(/datum/reagent/medicine/lisinopril = 2)
	required_reagents = list(/datum/reagent/ammonia = 1, /datum/reagent/water = 1, /datum/reagent/benzene = 2)
	required_temp = 450
	optimal_temp = 450
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_CHEMICAL | REACTION_TAG_HEALING

//copium
/datum/chemical_reaction/medicine/copium
	results = list(/datum/reagent/medicine/copium = 1)
	required_reagents = list(/datum/reagent/medicine/morphine = 4, /datum/reagent/medicine/inaprovaline = 4, \
					/datum/reagent/medicine/c2/probital = 4, /datum/reagent/medicine/c2/libital = 4)
	mix_message = "The mixture seethes and dilates into a soft purple liquid."
	required_temp = 690 //needs to be SEETHED AND DILATED
	optimal_temp = 690
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_CHEMICAL | REACTION_TAG_HEALING
