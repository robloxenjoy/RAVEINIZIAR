//Use this one for things with pre-set default colors, I guess
/datum/body_marking/other
	icon = 'modular_septic/icons/mob/human/body_markings/other/other_markings.dmi'
	recommended_species = null

/datum/body_marking/other/drake_bone
	name = "Drake Bone"
	icon = 'modular_septic/icons/mob/human/body_markings/other/drakebone.dmi'
	icon_state = "drakebone"
	default_color = "CCCCCC"
	affected_bodyparts = CHEST|HAND_LEFT|HAND_RIGHT
	gendered = FALSE

/datum/body_marking/other/tonage
	name = "Body Tonage"
	icon = 'modular_septic/icons/mob/human/body_markings/other/tonage.dmi'
	icon_state = "tonage"
	default_color = "555555"
	affected_bodyparts = CHEST|GROIN
	gendered = FALSE

/datum/body_marking/other/pilot
	name = "Pilot"
	icon = 'modular_septic/icons/mob/human/body_markings/other/pilot.dmi'
	icon_state = "pilot"
	default_color = "CCCCCC"
	affected_bodyparts = HEAD|ARM_LEFT|ARM_RIGHT|HAND_LEFT|HAND_RIGHT
	gendered = FALSE

/datum/body_marking/other/pilot_jaw
	name = "Pilot Jaw"
	icon = 'modular_septic/icons/mob/human/body_markings/other/pilot_jaw.dmi'
	icon_state = "pilot_jaw"
	default_color = "CCCCCC"
	affected_bodyparts = HEAD
	gendered = FALSE

/datum/body_marking/other/drake_eyes
	name = "Drake Eyes"
	icon = 'modular_septic/icons/mob/human/body_markings/other/drakeeyes.dmi'
	icon_state = "drakeeyes"
	default_color = "FF0000"
	affected_bodyparts = HEAD
	always_color_customizable = TRUE
	gendered = FALSE

/datum/body_marking/other/bands
	name = "Color Bands"
	icon_state = "bands"
	affected_bodyparts = CHEST|GROIN|ARM_LEFT|ARM_RIGHT|HAND_LEFT|HAND_RIGHT|LEG_RIGHT|LEG_LEFT|FOOT_RIGHT|FOOT_LEFT
	gendered = FALSE

/datum/body_marking/other/anklet
	name = "Anklet"
	icon_state = "anklet"
	affected_bodyparts = LEG_RIGHT|LEG_LEFT
	gendered = FALSE
