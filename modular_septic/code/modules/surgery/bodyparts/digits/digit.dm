/obj/item/digit
	name = "digit"
	desc = "FUCK THIS SHOULDNT BE HERE.;"
	icon = 'modular_septic/icons/obj/items/surgery/bodyparts.dmi'
	throwforce = 0
	force = 0
	w_class = WEIGHT_CLASS_TINY
	/// Icon when not in inventory
	var/world_icon = 'modular_septic/icons/obj/items/surgery/bodyparts_world.dmi'
	/// Color of the greyscale overlay
	var/skin_color = ""
	/// Thumb, index, middle, etc
	var/digit_type = "fuck you"

/obj/item/digit/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/world_icon, null, icon, world_icon)

/obj/item/digit/update_overlays()
	. = ..()
	if(skin_color)
		var/image/skin = image(icon, "[base_icon_state]_greyscale")
		skin.color = sanitize_hexcolor(skin_color, 6, TRUE)
		. += skin

/obj/item/digit/proc/do_knock_out_animation(shrink_time = 1 SECONDS)
	var/old_transform = transform
	transform = transform.Scale(2, 2)
	animate(src, transform = old_transform, time = shrink_time)
