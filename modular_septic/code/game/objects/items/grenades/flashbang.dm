/obj/item/grenade/flashbang
	icon = 'modular_septic/icons/obj/items/grenade.dmi'
	icon_state = "flashbang"
	base_icon_state = "flashbang"
	drop_sound = list('modular_septic/sound/weapons/flash1.wav', 'modular_septic/sound/weapons/flash2.wav')
	pin = /obj/item/pin/flashbang
	grenade_flags = GRENADE_PINNED|GRENADE_VISIBLE_PIN|GRENADE_VISIBLE_SPOON

/obj/item/grenade/flashbang/detonate(mob/living/lanced_by)
	. = ..()
	update_mob()
	var/flashbang_turf = get_turf(src)
	if(!flashbang_turf)
		return
	do_sparks(rand(5, 9), FALSE, src)
	playsound(flashbang_turf, 'modular_septic/sound/weapons/flashBANG.ogg', 100, TRUE, 8, 0.9)
	new /obj/effect/dummy/lighting_obj(flashbang_turf, flashbang_range + 2, 4, COLOR_WHITE, 2)
	new /obj/item/trash/flashbang(flashbang_turf)
	for(var/mob/living/M in get_hearers_in_view(flashbang_range, flashbang_turf))
		bang(get_turf(M), M)
	qdel(src)

/obj/item/grenade/flashbang/bang(turf/T , mob/living/M)
	if(M.stat == DEAD) //They're dead!
		return
	M.show_message(span_warning("BANG"), MSG_AUDIBLE)
	var/distance = max(0,get_dist(get_turf(src),T))

	//Flash
	if(M.flash_act(affect_silicon = 1))
		M.Paralyze(max(20/max(1,distance), 5))
		M.Knockdown(max(200/max(1,distance), 60))

	//Bang
	if(!distance || loc == M || loc == M.loc)
		//Stop allahu akbarring rooms with this.
		M.Paralyze(20)
		M.Knockdown(200)
		M.soundbang_act(1, 200, 10, 15)
	else
		// Adds more stun as to not prime n' pull (#45381)
		if(distance <= 1)
			M.Paralyze(5)
			M.Knockdown(30)
		M.soundbang_act(1, max(200/max(1,distance), 60), rand(0, 5))

/obj/item/grenade/stingbang
	icon = 'modular_septic/icons/obj/items/grenade.dmi'
	icon_state = "stinger"
	base_icon_state = "stinger"

/obj/item/pin/flashbang
	name = "flashbang grenade pin"
	icon = 'modular_septic/icons/obj/items/grenade.dmi'
	icon_state = "pin_flash"
	base_icon_state = "pin_flash"
