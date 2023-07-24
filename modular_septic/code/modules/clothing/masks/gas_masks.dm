/obj/item/clothing/mask/gas
	lowers_pitch = TRUE

///Check _masks.dm for this one
/obj/item/clothing/mask/gas/consume_filter_pollution(datum/pollution/pollution)
	if(LAZYLEN(gas_filters) <= 0 || max_filters == 0)
		return
	var/obj/item/gas_filter/gas_filter = pick(gas_filters)
	gas_filter.reduce_filter_status_pollution(pollution)
	if(gas_filter.filter_status <= 0)
		LAZYREMOVE(gas_filters, gas_filter)
		qdel(gas_filter)
	if(LAZYLEN(gas_filters) <= 0)
		has_filter = FALSE

/obj/item/clothing/mask/gas/idobe
	name = "IDOBE gas mask"
	desc = "A filtered gas-mask manufactured by IDOBE, can be connected to an oxygen supply and/or a filter at the same time. "
	icon = 'modular_septic/icons/obj/clothing/masks.dmi'
	icon_state = "idobe"
	base_icon_state = "idobe"
	worn_icon = 'modular_septic/icons/mob/clothing/mask.dmi'
	worn_icon_state = "idobe"
	inhand_icon_state = "gas_alt"
	permeability_coefficient = 0.01
	starting_filter_type = /obj/item/gas_filter/idobe

/obj/item/clothing/mask/gas/idobe/Initialize(mapload)
	. = ..()
	update_appearance(UPDATE_ICON)

/obj/item/clothing/mask/gas/idobe/update_overlays()
	. = ..()
	if(gas_filters)
		. += "[icon_state]_f"

/obj/item/clothing/mask/gas/idobe/attackby(obj/item/tool, mob/user)
	if(istype(tool, /obj/item/gas_filter))
		return ..()
	else if(!istype(tool, /obj/item/gas_filter/idobe))
		return ..()
	if(LAZYLEN(gas_filters) >= max_filters)
		return ..()
	if(user.transferItemToLoc(tool, src))
		playsound(user, 'modular_septic/sound/items/gas_screw0.ogg', 60, TRUE)
		to_chat(user, span_notice("I start screwing."))
		LAZYADD(gas_filters, tool)
		update_appearance()
		if(!do_after(user, 2 SECONDS, src))
			user.put_in_hands(tool)
			LAZYREMOVE(gas_filters, tool)
			update_appearance()
		to_chat(user, span_notice("I screw [tool] onto [src]'s filter-slot on the front."))
		playsound(user, 'modular_septic/sound/items/gas_screw1.ogg', 60, TRUE)
		has_filter = TRUE
		return TRUE
	else
		return ..()
