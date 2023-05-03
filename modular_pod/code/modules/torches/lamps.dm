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
	playsound(src, 'sound/items/torch_light.ogg', 50, TRUE)
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
		to_chat(user, span_notice("You fill the lamp with vilir."))
		var/obj/item/organ/spleen/vilir/V = W
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
	var/putout = 1

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
	playsound(src, 'sound/items/torch_fixture1.ogg', 50, TRUE)

/obj/structure/lampwall/attackby(obj/item/W, mob/user)
	// attempt to insert lamp
	if(lightlamp && !lightlamp.lit)
		if(istype(W, /obj/item/organ/spleen/vilir))
			var/obj/item/organ/spleen/vilir/V = W
			lightlamp.light()
			V.used = TRUE
			update_icon()
			return

		else if(lightlamp)
			return

//		user.drop_item()
	insert_lamp(W)
	src.add_fingerprint(user)

	update_icon()

/obj/structure/lampwall/proc/remove_lamp()
	. = lightlamp
//	lighttorch.dropInto(loc)
	lightlamp.update_icon()
	lightlamp = null
	update_icon()
	playsound(src, 'sound/items/torch_fixture0.ogg', 50, TRUE)

// attack with hand - remove lamp
/obj/structure/lampwall/attack_hand(mob/user)

	add_fingerprint(user)

	if(!lightlamp)
		to_chat(user, span_notice("There is no lamp here."))
		return

	if(!putout)
		to_chat(user, span_notice("This lamp cannot be removed!"))
		return
	// create a torch item and put it in the user's hand
	user.put_in_active_hand(remove_lamp())  //puts it in our active hand