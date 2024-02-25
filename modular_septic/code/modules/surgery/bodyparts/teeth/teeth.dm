/// Teeth stack object, used by the jaw limb to do teeth stuff
/obj/item/stack/teeth
	name = "teeth"
	singular_name = "tooth"
	desc = "Something that british people don't have."
	icon = 'modular_septic/icons/obj/items/surgery/bodyparts.dmi'
	icon_state = "teeth"
	base_icon_state = "teeth"
	max_amount = HUMAN_TEETH_AMOUNT
	throwforce = 0
	force = 0
	w_class = WEIGHT_CLASS_TINY
	full_w_class = WEIGHT_CLASS_SMALL
	/// Icon when not in inventory
	var/world_icon = 'modular_septic/icons/obj/items/surgery/bodyparts_world.dmi'
	var/icon_state_variation = 4

/obj/item/stack/teeth/Initialize(mapload, new_amount, merge)
	. = ..()
	if(icon_state_variation)
		icon_state = "[base_icon_state][rand(1, icon_state_variation)]"
	AddElement(/datum/element/world_icon, null, icon, world_icon)

/obj/item/stack/teeth/proc/do_knock_out_animation(shrink_time = 1 SECONDS)
	var/old_transform = transform
	transform = transform.Scale(2, 2)
	animate(src, transform = old_transform, time = shrink_time)

//many teethe
/obj/item/stack/teeth/full
	amount = HUMAN_TEETH_AMOUNT
