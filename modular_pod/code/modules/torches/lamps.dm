//Lamps
/obj/item/lamp
	icon = 'modular_pod/code/modules/torches/lamps.dmi'
	icon_state = "lamp0"
	inhand_icon_state = "lamp0"
	name = "Lamp"
	desc = "Thanks to this, the void will be filled with chaos."
	var/lit = FALSE
	var/self_lighting = 0

/obj/item/lamp/self_lit
	name = "Self-activating Lamp"
	desc = "Thanks to this, the void will be filled with chaos. This lamp provides its own."
	self_lighting = 1

/obj/item/lamp/work
	icon = 'modular_pod/code/modules/torches/lamps.dmi'
	icon_state = "lamp0"
	inhand_icon_state = "lamp0"
	name = "Lamp"
	desc = "Thanks to this, the void will be filled with chaos."
	lit = TRUE
/*
/obj/item/lamp/Initialize()
	..()

	if(prob(1)) //Needs playtesting. This seems a little high.
		if(istype(src.loc, /obj/structure/torchwall))
			return //Please don't put out torches that are on the walls.
		visible_message("The wind of Veva blows the fire from the torch.")
		snuff()
*/
/obj/item/lamp/update_icon()
	..()
	overlays = overlays.Cut()
	if(lit)
		icon_state = "lamp1"
		inhand_icon_state = "lamp1"
		set_light(3, 5, "#a340fe")
	else
		icon_state = "lamp0"
		inhand_icon_state = "lamp0"
		set_light(0,0)
		if(self_lighting == 1)
			icon_state = "lamp0_lighter"
//		update_appearance()
//	update_held_icon()

/obj/item/lamp/proc/light(var/mob/user, var/manually_lit = FALSE)//This doesn't seem to update the icon appropiately, not idea why.
	lit = TRUE
	if(manually_lit && self_lighting == 1)
		user.visible_message("<span class='notice'>\The [user] rips the vilir liquid-sheath off their [src].</span>")
	update_icon()
	START_PROCESSING(SSprocessing, src)
//	playsound(src, 'sound/items/torch_light.ogg', 50, TRUE)
	playsound(get_turf(src), 'modular_pod/sound/eff/potnpour.ogg', 80 , FALSE, FALSE)
/*
/obj/item/lamp/proc/snuff()
	lit = FALSE
	update_icon()
	STOP_PROCESSING(SSprocessing, src)
	playsound(src, 'sound/items/torch_snuff.ogg', 50, TRUE)
//	var/turf/vilired = get_turf(src)
//	vilired.add_liquid(/datum/reagent/consumable/vilir, 25)
*/
/obj/item/lamp/attack_self(mob/user)
	..()
	if(self_lighting == 1)
		light(user, TRUE)
		self_lighting = -1
		return
/*
	if(lit)
		snuff()
*/
/obj/item/lamp/attackby(obj/item/W, mob/user)
	..()
	if(istype(W, /obj/item/organ/spleen/vilir))
		var/obj/item/organ/spleen/vilir/V = W
		if(V.used)
			to_chat(user, span_notice("Vilir already used!"))
			return
		to_chat(user, span_notice("You fill the lamp with vilir."))
		V.used = TRUE
		light()

/obj/structure/lampwall
	name = "Lamp Holder"
	icon = 'modular_pod/code/modules/torches/lampslight.dmi'
	icon_state = "lampwall0"
	desc = "It's holding the lamp!"
	anchored = TRUE
	plane = ABOVE_GAME_PLANE
	layer = WALL_OBJ_LAYER
	var/putout = FALSE

	var/obj/item/lamp/lightlamp

/obj/structure/lampwall/New()
	..()
	if(prob(50))
		lightlamp = new(src)
		if(prob(50))
			lightlamp.lit = TRUE
	update_icon()

/obj/structure/lampwall/service/New()
	..()
	if(!locate(lightlamp) in src)
		lightlamp = new(src)
	lightlamp.lit = TRUE
	update_icon()

/obj/structure/lampwall/Destroy()
	QDEL_NULL(lightlamp)
	. = ..()

/obj/structure/lampwall/update_icon()
	..()
	if(lightlamp)
		if(lightlamp.lit)
			icon_state = "lampwall1"
			set_light(6, 3,"#a340fe")
		else
			icon_state = "lampwall0"
			set_light(0,0)
	else
		icon_state = "lampwall"
		set_light(0,0)

/obj/structure/lampwall/proc/insert_lamp(obj/item/lamp/T)
	T.forceMove(src)
	lightlamp = T
	update_icon()
	playsound(src, 'sound/items/torch_fixture.ogg', 50, TRUE)

/obj/structure/lampwall/attackby(obj/item/W, mob/user)
	// attempt to insert lamp
	return
/*
	if(lightlamp && !lightlamp.lit)
		if(istype(W, /obj/item/organ/spleen/vilir))
			var/obj/item/organ/spleen/vilir/V = W
			lightlamp.light()
			V.used = TRUE
			update_icon()
			return

		else if(lightlamp)
			return

*/

//		user.drop_item()
//	insert_lamp(W)
//	src.add_fingerprint(user)

//	update_icon()

/obj/structure/lampwall/proc/remove_lamp()
	. = lightlamp
//	lighttorch.dropInto(loc)
	lightlamp.update_icon()
	lightlamp = null
	update_icon()
	playsound(src, 'sound/items/torch_fixture.ogg', 50, TRUE)

// attack with hand - remove lamp
/obj/structure/lampwall/attack_hand(mob/user)

	add_fingerprint(user)

	if(!lightlamp)
		to_chat(user, span_notice("There is no lamp here."))
		return

	if(!putout)
		to_chat(user, span_notice("This lamp cannot be removed!"))
		return
	// create a lamp item and put it in the user's hand
	user.put_in_active_hand(remove_lamp())  //puts it in our active hand

/obj/structure/lampwall/directional/north
	dir = SOUTH
	pixel_y = 32

/obj/structure/lampwall/service/directional/north
	dir = SOUTH
	pixel_y = 32
/*
//Torches
/obj/item/torch
	icon = 'modular_pod/icons/obj/lighting.dmi'
	icon_state = "mtorch0"
	inhand_icon_state = "torch0"
	name = "Torch"
	desc = "LIGHT!"
	havedurability = TRUE
	durability = 160
	carry_weight = 1 KILOGRAMS
	skill_melee = SKILL_IMPACT_WEAPON
	min_force = 9
	force = 11
	throwforce = 13
	min_force_strength = 1
	force_strength = 1.5
	wound_bonus = 4
	bare_wound_bonus = 4
	throw_speed = 2
	throw_range = 9
	attack_verb_continuous = list("bashes", "batters", "bludgeons", "whacks")
	attack_verb_simple = list("bash", "batter", "bludgeon", "whack")
	tetris_width = 32
	tetris_height = 32
	var/lit = FALSE
	var/self_lighting = 0

/obj/item/torch/self_lit
	name = "Self-igniting Torch"
	desc = "Thanks to this, the void will be filled with yellow-bright pus. This torch provides its own."
	self_lighting = 1

/obj/item/torch/Initialize()
	..()

	if(lit)
		inhand_icon_state = "torch1"
		damtype = BURN
	else
		inhand_icon_state = "torch0"
		damtype = BRUTE

	if(prob(1)) //Needs playtesting. This seems a little high.
		if(istype(src.loc, /obj/structure/torchwall))
			return //Please don't put out torches that are on the walls.
		visible_message(span_notice("A rush of wind puts off my torch. Cursed be!"))
		snuff()

/obj/item/torch/update_icon()
	..()
	if(lit)
		icon_state = "mtorch1"
		inhand_icon_state = "torch1"
		set_light(3, 5, "#bf915c")
	else
		icon_state = "mtorch0"
		inhand_icon_state = "torch0"
		set_light(0,0)

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
			user.visible_message("<span class='notice'>[user] enlights [C] with [src].")
			return
		if(istype(W, /obj/item/candle))
			var/obj/item/candle/C = W
			C.light()
			user.visible_message("<span class='notice'>[user] enlights [C] with [src].")
			return
		if(istype(W, /obj/item/torch))
			var/obj/item/torch/C = W
			C.light()
			user.visible_message("<span class='notice'>[user] enlights [C] with [src].")
			return

	else if(W.get_temperature())
		user.visible_message("<span class='notice'>[user] enlights [src].")
		light()

	else if(!lit)
		if(istype(W, /obj/item/torch))
			var/obj/item/torch/C = W
			if(C.lit)
				light()
				update_icon()
				user.visible_message("<span class='notice'>[user] enlights [src] with [C].")
				return

/obj/structure/torchwall
	name = "Torch Holder"
	icon = 'modular_pod/icons/obj/lighting.dmi'
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
			set_light(6, 3,"#bf915c")
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
	playsound(src, 'sound/items/torch_fixture.ogg', 50, TRUE)

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
		user.visible_message("<span class='notice'>[user] enlights [C] with torch.")
		return
	if(istype(W, /obj/item/candle))
		var/obj/item/candle/C = W
		C.light()
		user.visible_message("<span class='notice'>[user] enlights [C] with torch.")
		return

	update_icon()

/obj/structure/torchwall/proc/remove_torch()
	. = lighttorch
//	lighttorch.dropInto(loc)
	lighttorch.update_icon()
	lighttorch = null
	update_icon()
	playsound(src, 'sound/items/torch_fixture.ogg', 50, TRUE)

// attack with hand - remove torch
/obj/structure/torchwall/attack_hand(mob/user)

	add_fingerprint(user)

	if(!lighttorch)
		to_chat(user, span_notice("There is no torch here."))
		return
	// create a torch item and put it in the user's hand
	user.put_in_active_hand(remove_torch())  //puts it in our active hand

/obj/structure/torchwall/directional/north
	dir = SOUTH
	pixel_y = 32

/obj/structure/torchwall/service/directional/north
	dir = SOUTH
	pixel_y = 32
*/