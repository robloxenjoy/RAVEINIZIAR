/obj/item/organ/cyberimp/arm/toolset
	name = "integrated toolset implant"
	desc = "A stripped-down version of the engineering cyborg toolset, designed to be installed on subject's arm. Contain advanced versions of every tool."
	contents = newlist(/obj/item/screwdriver/cyborg, /obj/item/wrench/cyborg, /obj/item/weldingtool/largetank/cyborg,
		/obj/item/crowbar/cyborg, /obj/item/wirecutters/cyborg, /obj/item/multitool/cyborg)

/obj/item/organ/cyberimp/arm/toolset/emag_act(mob/user)
	. = ..()
	if(!(locate(/obj/item/knife/combat/cyborg) in items_list))
		to_chat(user, span_notice("I unlock [src]'s integrated knife!"))
		items_list += new /obj/item/knife/combat/cyborg(src)
		return TRUE
	return FALSE

/obj/item/organ/cyberimp/arm/toolset/l
	zone = BODY_ZONE_L_ARM
