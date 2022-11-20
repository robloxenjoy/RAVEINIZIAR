/obj/item/organ/lungs/ethereal
	name = "aeration reticulum"
	desc = "These exotic lungs seem crunchier than most."
	icon_state = "lungs_ethereal"
	heat_level_1_threshold = FIRE_MINIMUM_TEMPERATURE_TO_SPREAD // 150C or 433k, in line with ethereal max safe body temperature
	heat_level_2_threshold = 473
	heat_level_3_threshold = 1073

/obj/item/organ/lungs/ethereal/handle_gas_override(mob/living/carbon/human/breather, list/breath_gases, gas_breathed)
	// H2O electrolysis
	gas_breathed = breath_gases[/datum/gas/water_vapor][MOLES]
	breath_gases[/datum/gas/oxygen][MOLES] += gas_breathed/2
	breath_gases[/datum/gas/hydrogen][MOLES] += gas_breathed
	breath_gases[/datum/gas/water_vapor][MOLES] -= gas_breathed
