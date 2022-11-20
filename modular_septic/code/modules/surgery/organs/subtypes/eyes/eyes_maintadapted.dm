/obj/item/organ/eyes/night_vision/maintenance_adapted
	name = "adapted eye"
	desc = "This red eye looks like a foggy marble. It gives off a particularly worrying glow in the dark."
	flash_protect = FLASH_PROTECTION_SENSITIVE
	eye_color = "f00"
	icon_state = "adapted_eyes"
	eye_icon_state = "eyes_glow"
	overlay_ignore_lighting = TRUE
	var/obj/item/flashlight/eyelight/adapted/adapt_light

/obj/item/organ/eyes/night_vision/maintenance_adapted/l
	zone = BODY_ZONE_PRECISE_L_EYE

/obj/item/organ/eyes/night_vision/maintenance_adapted/Insert(mob/living/carbon/new_owner, special = FALSE, drop_if_replaced = TRUE, new_zone = null)
	. = ..()
	//add lighting
	if(!adapt_light)
		adapt_light = new /obj/item/flashlight/eyelight/adapted()
	adapt_light.on = TRUE
	adapt_light.forceMove(new_owner)
	adapt_light.update_brightness(new_owner)
	//traits
	ADD_TRAIT(new_owner, TRAIT_FLASH_SENSITIVE, ORGAN_TRAIT)
	ADD_TRAIT(new_owner, TRAIT_UNNATURAL_RED_GLOWY_EYES, ORGAN_TRAIT)

/obj/item/organ/eyes/night_vision/maintenance_adapted/on_life(delta_time, times_fired)
	var/turf/T = get_turf(owner)
	var/lums = T.get_lumcount()
	if(lums > 0.5) //we allow a little more than usual so we can produce light from the adapted eyes
		to_chat(owner, span_userdanger("My eyes! They burn in the light!"))
		applyOrganDamage(10) //blind quickly
		playsound(owner, 'sound/machines/grill/grillsizzle.ogg', 50)
	else
		applyOrganDamage(-10) //heal quickly
	. = ..()

/obj/item/organ/eyes/night_vision/maintenance_adapted/Remove(mob/living/carbon/old_owner, special = FALSE)
	//remove lighting
	adapt_light.on = FALSE
	adapt_light.update_brightness(old_owner)
	adapt_light.forceMove(src)
	//traits
	REMOVE_TRAIT(old_owner, TRAIT_FLASH_SENSITIVE, ORGAN_TRAIT)
	REMOVE_TRAIT(old_owner, TRAIT_UNNATURAL_RED_GLOWY_EYES, ORGAN_TRAIT)
	return ..()
