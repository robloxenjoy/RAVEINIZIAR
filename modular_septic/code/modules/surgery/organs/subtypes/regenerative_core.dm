/obj/item/organ/regenerative_core
	icon_state = "roro_core"
	base_icon_state = "roro_core"

/obj/item/organ/regenerative_core/update_icon_state()
	. = ..()
	icon_state = (inert ? "[base_icon_state]-inert" : base_icon_state)

/obj/item/organ/regenerative_core/update_overlays()
	. = ..()
	if(!inert && !preserved)
		. += image(icon, src, "[base_icon_state]-crackle")

/obj/item/organ/regenerative_core/legion
	icon_state = "legion_core"
	base_icon_state = "legion_core"
