//TODO: Make these markings associated with their assigned bodyparts rather than mob dna.
/datum/body_marking/tattoo
	icon = 'modular_septic/icons/mob/human/body_markings/tattoo/tattoo_markings.dmi'
	recommended_species = null
	default_color = "122" //slightly faded ink.
	always_color_customizable = TRUE
	gendered = FALSE

/datum/body_marking/tattoo/heart
	name = "Tattoo - Heart"
	icon = 'modular_septic/icons/mob/human/body_markings/tattoo/heart.dmi'
	icon_state = "tat_heart"
	affected_bodyparts = CHEST|ARM_LEFT|ARM_RIGHT

/datum/body_marking/tattoo/hive
	name = "Tattoo - Hive"
	icon = 'modular_septic/icons/mob/human/body_markings/tattoo/hive.dmi'
	icon_state = "tat_hive"
	affected_bodyparts = CHEST
	gendered = TRUE

/datum/body_marking/tattoo/nightling
	name = "Tattoo - Nightling"
	icon = 'modular_septic/icons/mob/human/body_markings/tattoo/nightling.dmi'
	icon_state = "tat_nightling"
	affected_bodyparts = CHEST|GROIN

/datum/body_marking/tattoo/circuit
	name = "Tattoo - Circuit"
	icon = 'modular_septic/icons/mob/human/body_markings/tattoo/tattoo_markings.dmi'
	icon_state = "tat_campbell"
	affected_bodyparts = ARM_LEFT|ARM_RIGHT|LEG_RIGHT|LEG_LEFT

/datum/body_marking/tattoo/silverburgh //dunno what this is.
	name = "Tattoo - Silverburgh"
	icon = 'modular_septic/icons/mob/human/body_markings/tattoo/silverburgh.dmi'
	icon_state = "tat_silverburgh"
	affected_bodyparts = LEG_RIGHT|LEG_LEFT

/datum/body_marking/tattoo/tiger
	name = "Tattoo - Tiger"
	icon_state = "tat_tiger"
	affected_bodyparts = CHEST|GROIN|ARM_LEFT|ARM_RIGHT|HAND_LEFT|HAND_RIGHT|LEG_RIGHT|FOOT_RIGHT|LEG_LEFT|FOOT_LEFT
	gendered = TRUE
