/obj/structure/closet/secure_closet/dorms
	name = "dorm wardrobe"
	icon_state = "cabinet"
	resistance_flags = FLAMMABLE
	max_integrity = 50
	open_sound = 'sound/machines/wooden_closet_open.ogg'
	close_sound = 'sound/machines/wooden_closet_close.ogg'
	open_sound_volume = 25
	close_sound_volume = 50
	door_anim_time = 0 // no animation

/obj/structure/closet/secure_closet/dorms/PopulateContents()
	. = ..()
