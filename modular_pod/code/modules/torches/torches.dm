//Torches
/obj/item/torch
	icon = 'modular_pod/code/modules/torches/torches.dmi'
	icon_state = "torch0"
	inhand_icon_state = "torch0"
	name = "Torch"
	desc = "Thanks to this, the void will be filled with yellow-bright pus."
	var/lit = FALSE
	var/self_lighting = 0

/obj/item/torch/self_lit
	name = "Self-igniting Torch"
	desc = "Thanks to this, the void will be filled with yellow-bright pus. This torch provides its own."
	self_lighting = 1

/obj/item/torch/Initialize()
	..()

	if(prob(1)) //Needs playtesting. This seems a little high.
		if(istype(src.loc, /obj/structure/torchwall))
			return //Please don't put out torches that are on the walls.
		visible_message("The wind of Veva blows the fire from the torch.")
		snuff()

/obj/item/torch/update_icon()
	..()
	overlays = overlays.Cut()
	if(lit)
		icon_state = "torch1"
		inhand_icon_state = "torch1"
		set_light(3, 5, "#E38F46")
	else
		icon_state = "torch0"
		inhand_icon_state = "torch0"
		set_light(0,0)
		if(self_lighting == 1)
			icon_state = "torch0_lighter"
//		update_appearance()
//	update_held_icon()

/obj/item/torch/proc/light(var/mob/user, var/manually_lit = FALSE)//This doesn't seem to update the icon appropiately, not idea why.
	lit = TRUE
	if(manually_lit && self_lighting == 1)
		user.visible_message("<span class='notice'>\The [user] rips the lighting sheath off their [src].</span>")
	update_icon()
	START_PROCESSING(SSprocessing, src)
	playsound(src, 'sound/items/torch_light.ogg', 50, TRUE)

/obj/item/torch/proc/snuff()
	lit = FALSE
	update_icon()
	STOP_PROCESSING(SSprocessing, src)
	playsound(src, 'sound/items/torch_snuff.ogg', 50, TRUE)

/obj/item/torch/attack_self(mob/user)
	..()
	if(self_lighting == 1)
		light(user, TRUE)
		self_lighting = -1
		return
	if(lit)
		snuff()

/obj/item/torch/attackby(obj/item/W, mob/user)
	..()
	if(src.lit)
		if(istype(W, /obj/item/clothing/mask/cigarette))
			var/obj/item/clothing/mask/cigarette/C = W
			C.light()
			to_chat(user, "You light [C] with [src].")
			return
		if(istype(W, /obj/item/candle))
			var/obj/item/candle/C = W
			C.light()
			to_chat(user, "You light [C] with [src].")
			return
	if(W.get_temperature())
		light()

/obj/structure/torchwall
	name = "Torch Holder"
	icon = 'modular_pod/code/modules/torches/torchlight.dmi'
	icon_state = "torchwall0"
	desc = "It's holding the torch!."
	anchored = TRUE
	plane = ABOVE_GAME_PLANE
	layer = WALL_OBJ_LAYER

	var/obj/item/torch/lighttorch

/obj/structure/torchwall/New()
	..()
	if(prob(98))
		lighttorch = new(src)
		if(prob(75))
			lighttorch.lit = TRUE
	update_icon()

/obj/structure/torchwall/service/New()
	..()
	if(!locate(lighttorch) in src)
		lighttorch = new(src)
	lighttorch.lit = TRUE
	update_icon()


/obj/structure/torchwall/Destroy()
	QDEL_NULL(lighttorch)
	. = ..()

/obj/structure/torchwall/update_icon()
	..()
	if(lighttorch)
		if(lighttorch.lit)
			icon_state = "torchwall1"
			set_light(6, 3,"#E38F46")
			switch(dir)
				if(NORTH)
					plane = GAME_PLANE_UPPER_BLOOM
				if(SOUTH)
					plane = ABOVE_FRILL_PLANE_BLOOM
				if(EAST)
					plane = GAME_PLANE_UPPER_BLOOM
				if(WEST)
					plane = GAME_PLANE_UPPER_BLOOM
				else
					plane = ABOVE_FRILL_PLANE_BLOOM
		else
			icon_state = "torchwall0"
			set_light(0,0)
	else
		icon_state = "torchwall"
		set_light(0,0)

/obj/structure/torchwall/proc/insert_torch(obj/item/torch/T)
	T.forceMove(src)
	lighttorch = T
	update_icon()
	playsound(src, 'sound/items/torch_fixture1.ogg', 50, TRUE)

/obj/structure/torchwall/attackby(obj/item/W, mob/user)
	// attempt to insert torch
	if(lighttorch && !lighttorch.lit)
		if(W.get_temperature())
			lighttorch.light()
			update_icon()
			return

	if(istype(W, /obj/item/torch))
		if(lighttorch && lighttorch.lit)
			var/obj/item/torch/T = W
			if(!T.lit)
				T.light()
				update_icon()
			return

		else if(lighttorch)//To stop you from putting in a torch twice.
			return

//		user.drop_item()
		insert_torch(W)
		src.add_fingerprint(user)

	// attempt to light a cigarette or candle on the torch
	if(istype(W, /obj/item/clothing/mask/cigarette))
		var/obj/item/clothing/mask/cigarette/C = W
		C.light()
		to_chat(user, "You light [C] with [src].")
		return
	if(istype(W, /obj/item/candle))
		var/obj/item/candle/C = W
		C.light()
		to_chat(user, "You light [C] with [src].")
		return

	update_icon()

/obj/structure/torchwall/proc/remove_torch()
	. = lighttorch
//	lighttorch.dropInto(loc)
	lighttorch.update_icon()
	lighttorch = null
	update_icon()
	playsound(src, 'sound/items/torch_fixture0.ogg', 50, TRUE)

// attack with hand - remove torch
/obj/structure/torchwall/attack_hand(mob/user)

	add_fingerprint(user)

	if(!lighttorch)
		to_chat(user, "There is no torch here.")
		return
	// create a torch item and put it in the user's hand
	user.put_in_active_hand(remove_torch())  //puts it in our active hand
