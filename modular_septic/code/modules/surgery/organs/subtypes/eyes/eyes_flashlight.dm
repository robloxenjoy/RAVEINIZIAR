/obj/item/organ/eyes/robotic/flashlight
	name = "flashlight eye"
	desc = "It's a flashlight rigged together with some wire. Why would you put these in someone's head?"
	eye_color ="fee5a3"
	icon = 'icons/obj/lighting.dmi'
	icon_state = "flashlight_eyes"
	flash_protect = FLASH_PROTECTION_WELDER
	tint = INFINITY
	var/obj/item/flashlight/eyelight/eye

/obj/item/organ/eyes/robotic/flashlight/emp_act(severity)
	return

/obj/item/organ/eyes/robotic/flashlight/Insert(mob/living/carbon/new_owner, special = FALSE, drop_if_replaced = TRUE, new_zone = null)
	. = ..()
	if(!eye)
		eye = new /obj/item/flashlight/eyelight()
	eye.on = TRUE
	eye.forceMove(new_owner)
	eye.update_brightness(new_owner)
	new_owner.become_blind("flashlight_eyes")

/obj/item/organ/eyes/robotic/flashlight/Remove(mob/living/carbon/old_owner, special = 0)
	eye.on = FALSE
	eye.update_brightness(old_owner)
	eye.forceMove(src)
	old_owner.cure_blind("flashlight_eyes")
	return ..()
