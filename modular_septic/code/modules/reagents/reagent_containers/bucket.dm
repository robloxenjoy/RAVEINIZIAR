#define SQUEEZING_DISPERSAL_PERCENT 0.75

/obj/item/reagent_containers/glass/bucket/attackby_secondary(obj/item/weapon, mob/user, params)
	. = ..()
	if(!istype(weapon, /obj/item/mop))
		return
	if(weapon.reagents.total_volume == 0)
		to_chat(user, span_warning("[weapon] is dry, i can't squeeze anything out!"))
		return
	if(reagents.total_volume == reagents.maximum_volume)
		to_chat(user, span_warning("[src] is full!"))
		return
	weapon.reagents.remove_any(weapon.reagents.total_volume*SQUEEZING_DISPERSAL_PERCENT)
	weapon.reagents.trans_to(src, weapon.reagents.total_volume, transfered_by = user)
	to_chat(user, span_notice("I squeeze the liquids from [weapon] to [src]."))

#undef SQUEEZING_DISPERSAL_PERCENT
