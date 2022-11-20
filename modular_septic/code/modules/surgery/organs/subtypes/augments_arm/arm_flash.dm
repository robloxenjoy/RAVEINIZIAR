/obj/item/organ/cyberimp/arm/flash
	name = "integrated high-intensity photon projector" //Why not
	desc = "An integrated projector mounted onto a user's arm that is able to be used as a powerful flash."
	contents = newlist(/obj/item/assembly/flash/armimplant)

/obj/item/organ/cyberimp/arm/flash/Extend()
	. = ..()
	active_item.set_light_range(7)
	active_item.set_light_on(TRUE)

/obj/item/organ/cyberimp/arm/flash/Retract()
	active_item.set_light_on(FALSE)
	return ..()

/obj/item/organ/cyberimp/arm/flash/l
	zone = BODY_ZONE_L_ARM
