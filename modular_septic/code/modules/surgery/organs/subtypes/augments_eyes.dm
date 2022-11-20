/obj/item/organ/cyberimp/eyes
	name = "cybernetic eye implant"
	desc = "Implants for your eyes."
	icon_state = "eye_implant"
	implant_overlay = "eye_implant_overlay"
	organ_efficiency = list(ORGAN_SLOT_EYES = 50)
	zone = BODY_ZONE_PRECISE_R_EYE
	w_class = WEIGHT_CLASS_TINY

/obj/item/organ/cyberimp/eyes/screwdriver_act(mob/living/user, obj/item/I)
	. = ..()
	zone = (zone == BODY_ZONE_PRECISE_R_EYE ? BODY_ZONE_PRECISE_L_EYE : BODY_ZONE_PRECISE_R_EYE)
	to_chat(user, span_notice("I modify [src] to be installed on the [parse_zone(zone)]."))
