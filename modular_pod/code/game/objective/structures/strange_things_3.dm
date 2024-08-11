/obj/structure/wayto/podpol
	name = "Underfloor"
	desc = "What's there?"
	icon = 'modular_pod/icons/obj/things/things_4.dmi'
	icon_state = "podpol"
	anchored = TRUE
	obj_flags = CAN_BE_HIT | BLOCK_Z_OUT_DOWN
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	pixel_x = -16
	pixel_y = -16
	var/up = FALSE
	var/down = TRUE
	light_range = 2
	light_power = 1
	light_color = "#e1dfe1"

/obj/structure/wayto/podpol/attack_hand(mob/living/carbon/human/user, list/modifiers)
	. = ..()
	if(.)
		return
	use(user, TRUE)

/obj/structure/wayto/podpol/attackby(obj/item/I, mob/living/user, params)
	use(user, TRUE)
	return TRUE

/obj/structure/wayto/podpol/proc/use(mob/living/carbon/human/user, going_up = TRUE, is_ghost = FALSE)
	if(user.truerole != "Ladax")
		to_chat(user, span_notice("The boys there won't accept me."))
		return
	if(!in_range(src, user) || user.incapacitated())
		return
//	if(user.loc != loc)
//		return
	if(!do_after(user, 4, target = src))
		to_chat(user, span_danger(xbox_rage_msg()))
		user.playsound_local(get_turf(user), 'modular_pod/sound/eff/difficult1.ogg', 15, FALSE)
		return
	if(up)
		var/turf/above_turf = SSmapping.get_turf_above(get_turf(src))
		var/atom/movable/AM
		if(user.pulling)
			AM = user.pulling
			AM.forceMove(above_turf)
		user.forceMove(above_turf)
		if(AM)
			user.start_pulling(AM)
	if(down)
		var/turf/below_turf = SSmapping.get_turf_below(get_turf(src))
		var/atom/movable/AM
		if(user.pulling)
			AM = user.pulling
			AM.forceMove(below_turf)
		user.forceMove(below_turf)
		if(AM)
			user.start_pulling(AM)

/obj/structure/wayto/podpol/up
	icon_state = "podpol2"
	up = TRUE
	down = FALSE

/obj/structure/table/goody
	name = "Table"
	desc = "Nice. Cute. Good."
	icon = 'modular_pod/icons/obj/things/things_3.dmi'
	icon_state = "tablera"
	smoothing_flags = NONE
	smoothing_groups = null
	canSmoothWith = null
	frame = null

/obj/structure/table/goody/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		if(!QDELETED(src))
			qdel(src)

/obj/structure/bed/mattress
	name = "Mattress"
	desc = "The main thing is to get enough sleep."
	icon = 'modular_pod/icons/obj/things/things_3.dmi'
	icon_state = "mattress"

/obj/structure/closet/crate/freezer/podozl
	name = "Fridge"
	desc = "In this state... Somehow it cools."
	icon = 'modular_pod/icons/obj/things/things_3.dmi'
	icon_state = "holodos"
	open_sound = 'modular_pod/sound/eff/open_holodos.ogg'
	close_sound = 'modular_pod/sound/eff/close_holodos.ogg'
	door_anim_time = 0

/particles/fire
	icon = 'icons/effects/particles/bonfire.dmi'
	icon_state = "bonfire"
	width = 64
	height = 128
	count = 100
	spawning = 7
	lifespan = 2 SECONDS
	fade = 1 SECONDS
	color = 0
	color_change = 0.1
	gradient = list("#FBDB28", "#FCE6B6", "#FF532B")
	position = generator("box", list(-16,-12,-32), list(16,32,32), NORMAL_RAND)
	drift = generator("vector", list(-0.1,0), list(0.1,0.2), UNIFORM_RAND)
	scale = generator("vector", list(0.5,0.5), list(2,2), NORMAL_RAND)
	spin = generator("num", list(-30,30), NORMAL_RAND)

/particles/fog
	icon = 'icons/effects/particles/smoke.dmi'
	icon_state = list("chill_1" = 2, "chill_2" = 2, "chill_3" = 1)

/particles/fog/breath
	count = 1
	spawning = 1
	lifespan = 1 SECONDS
	fade = 0.5 SECONDS
	grow = 0.05
	spin = 2
	color = "#fcffff77"

/obj/structure/lighterfire
	name = "Barrel"
	icon = 'modular_pod/icons/obj/things/things_3.dmi'
	icon_state = "barrel"
	desc = "Fascinating."
	density = 1
	anchored = 1
	light_range = 4
	light_power = 1
	light_color = "#e19644"
	var/datum/looping_sound/firee/soundloop
	var/proj_pass_rate = 100

/obj/structure/lighterfire/CanAllowThrough(atom/movable/mover, border_dir)//So bullets will fly over and stuff.
	. = ..()
	if(locate(/obj/structure/lighterfire) in get_turf(mover))
		return TRUE
	else if(istype(mover, /obj/projectile))
		if(!anchored)
			return TRUE
		var/obj/projectile/proj = mover
		if(proj.firer && Adjacent(proj.firer))
			return TRUE
		if(prob(proj_pass_rate))
			return TRUE
		return FALSE

/obj/structure/lighterfire/Initialize(mapload)
	. = ..()
	soundloop = new(src, FALSE)
	soundloop.start()

/obj/structure/lighterfire/Destroy()
	. = ..()
	QDEL_NULL(soundloop)

/obj/structure/lighterfire/New()
	..()
	add_particle_holder("embers", /atom/movable/particle_holder/fire)
	add_particle_holder("smoke", /atom/movable/particle_holder/fire_smoke)

/datum/looping_sound/musicloop
	mid_sounds = list('modular_pod/sound/mus/boombox.ogg' = 1)
	mid_length = 161 SECONDS
	volume = 70
	falloff_exponent = 10
	falloff_distance = 3

/obj/item/musicshit/boombox
	name = "Boombox"
	desc = "Fucking amazing."
	icon = 'modular_pod/icons/obj/items/otherobjects.dmi'
	icon_state = "boombox"
//	var/datum/looping_sound/musicloop/soundloop
	var/playc = FALSE
	var/list/rangers = list()

//obj/item/musicshit/boombox/Initialize(mapload)
//	. = ..()
//	soundloop = new(src,  FALSE)

//obj/item/musicshit/boombox/Destroy()
//	QDEL_NULL(soundloop)
//	. = ..()

/obj/item/musicshit/boombox/attack_self(mob/user)
	. = ..()
	if(.)
		return
	if(playc)
		playc = FALSE
		STOP_PROCESSING(SSobj, src)
		for(var/mob/living/L in rangers)
			if(!L || !L.client)
				continue
			L.stop_sound_channel(CHANNEL_JUKEBOX)
		rangers = list()
	else
		playc = TRUE
		START_PROCESSING(SSobj, src)
	user.changeNext_move(CLICK_CD_MELEE)

/obj/item/musicshit/boombox/process()
	if(playc)
		for(var/mob/M in range(10,src))
			if(!M.client)
				continue
			if(!(M in rangers))
				rangers[M] = TRUE
				M.playsound_local(get_turf(M), 'modular_pod/sound/mus/boombox.ogg', volume = 60, channel = CHANNEL_JUKEBOX, falloff_exponent = 11, falloff_distance = 3, use_reverb = TRUE)
		for(var/mob/L in rangers)
			if(get_dist(src,L) > 13)
				rangers -= L
				if(!L || !L.client)
					continue
				L.stop_sound_channel(CHANNEL_JUKEBOX)

/obj/structure/chair/podpolsit
	name = "Throne"
	desc = "It's time to find out what power is."
	icon = 'modular_pod/icons/obj/things/things_5.dmi'
	icon_state = "sit"
	max_integrity = 10000
	light_range = 4
	light_power = 2
	light_color = "#ff7d00"

/obj/structure/chair/podpolsit/deconstruct()
	new /obj/item/podpol_weapon/sword/steel(get_turf(src))

/obj/structure/chair/podpolsit/post_buckle_mob(mob/living/M)
	. = ..()
	if(iscarbon(M))
		M.pixel_y += 5
		M.visible_message(span_notice("[M] sits down on [src]."),span_notice("I sit down on [src]."), span_hear("I hear something."))
		if(do_after(M, 3 SECONDS, target=src))
			if(!M.buckled)
				to_chat(M, span_meatymeat("We need to sit on the throne!"))
				return
			to_chat(M, span_meatymeat("I feel some kind of fucked up!"))
			M.fully_heal(TRUE)

/obj/structure/chair/podpolsit/post_unbuckle_mob(mob/living/M)
	if(iscarbon(M))
		M.pixel_y -= 5

/obj/structure/column/power
	name = "Statue"
	desc = "That which inspires fear."
	icon = 'modular_pod/icons/obj/things/things_3.dmi'
	icon_state = "power"
	plane = ABOVE_GAME_PLANE
	layer = FLY_LAYER
	anchored = 1
	density = 1
	obj_flags = NONE
	max_integrity = 1000

/obj/effect/decal/metalpodpol
	name = "Metal Tiles"
	icon = 'modular_pod/icons/obj/things/things_3.dmi'
	icon_state = "metal1"
	layer = TURF_PLATING_DECAL_LAYER
	alpha = 255
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/obj/effect/decal/metalpodpol/Initialize(mapload)
	. = ..()
	if(prob(50))
		icon_state = "metal2"

/obj/effect/decal/grassgood
	name = "Grass"
	icon = 'modular_pod/icons/obj/things/things_3.dmi'
	icon_state = "grass1"
	layer = TURF_PLATING_DECAL_LAYER
	alpha = 255
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/obj/effect/decal/grassgood/Initialize(mapload)
	. = ..()
	if(prob(50))
		icon_state = "grass2"

/obj/effect/decal/grassbad
	name = "Grass"
	icon = 'modular_pod/icons/obj/things/things_3.dmi'
	icon_state = "plant1"
	layer = TURF_PLATING_DECAL_LAYER
	alpha = 255
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/obj/effect/decal/grassbad/Initialize(mapload)
	. = ..()
	icon_state = pick("plant2", "plant1", "plant3")

/obj/effect/decal/grassnice
	name = "Grass"
	icon = 'modular_pod/icons/obj/things/things.dmi'
	icon_state = "planty_1"
	layer = TURF_PLATING_DECAL_LAYER
	alpha = 255
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/obj/effect/decal/grassnice/Initialize(mapload)
	. = ..()
	icon_state = pick("planty_1", "planty_2", "planty_3", "planty_4")

/obj/effect/decal/shroomworms
	name = "Shroomworms"
	icon = 'modular_pod/icons/obj/things/things_3.dmi'
	icon_state = "shroomworms"
	layer = TURF_PLATING_DECAL_LAYER
	alpha = 255
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/obj/structure/flora/ausbushes/cactus
	name = "Cactus"
	desc = "The bitch is prickly. I would like to get some water from it."
	icon = 'modular_pod/icons/obj/things/things_3.dmi'
	icon_state = "cactus1"
//	plane = ABOVE_GAME_PLANE
//	layer = FLY_LAYER
	resistance_flags = FLAMMABLE
	density = TRUE
	anchored = TRUE
	opacity = FALSE
	var/proj_pass_rate = 100

/obj/structure/flora/ausbushes/cactus/Initialize(mapload)
	. = ..()
	create_reagents(70, INJECTABLE | DRAINABLE)
	reagents.add_reagent(/datum/reagent/water, 70)
	icon_state = pick("cactus1", "cactus2", "cactus3")

/obj/structure/flora/ausbushes/cactus/on_density(mob/living/carbon/human/rammer)
	var/obj/item/bodypart/affecting = rammer.get_bodypart(ran_zone(BODY_ZONE_CHEST, 50))
	if(affecting)
		var/cloth_cover = LAZYLEN(rammer.clothingonpart(affecting))
		if(!cloth_cover)
/*
			M.apply_damage(10, BRUTE, affecting, wound_bonus = 2, sharpness = SHARP_POINTY)
			affecting.adjust_germ_level(100)
*/
			var/obj/item/cactus_needle
			cactus_needle = new /obj/item/cactus_needle(loc)
			var/embed_attempt = cactus_needle.tryEmbed(target = affecting, forced = TRUE, silent = TRUE)
			if(embed_attempt & COMPONENT_EMBED_SUCCESS)
				rammer.visible_message(span_pinkdang("The needle gets stuck in [rammer] [affecting]!"), \
									span_pinkdang("The needle gets stuck in [affecting]!"), \
									span_hear("I hear meat."))
			else
				qdel(cactus_needle)
				rammer.visible_message(span_meatymeat("[rammer] pricks himself on [src]!"),span_meatymeat("I prick myself on [src]!"), span_hear("I hear meat."))
				rammer.apply_damage(10, BRUTE, affecting, rammer.run_armor_check(affecting, MELEE), wound_bonus = 2, sharpness = SHARP_POINTY)
				affecting.adjust_germ_level(100)
			if(rammer.get_chem_effect(CE_PAINKILLER) < 30)
				to_chat(rammer, span_userdanger("FUCK CACTUSES!"))
				rammer.agony_scream()
		else
			to_chat(rammer, span_meatymeat("[src] almost pricked me!"))

/obj/structure/flora/ausbushes/cactus/examine(mob/user)
	. = ..()
	if(reagents.total_volume > 0)
		. += span_notice("The cactus is not dried.")
	else
		. += span_notice("Cactus is dried.")

/obj/structure/flora/ausbushes/cactus/attackby(obj/item/W, mob/living/carbon/user, params)
/*
	if(!W.sharpness)
		if(istype(W, /obj/item/reagent_containers))
			var/obj/item/reagent_containers/RG = W
			if(reagents.total_volume <= 0)
				to_chat(user, span_notice("[src] высушен."))
				return FALSE
			if(RG.is_refillable())
				if(!RG.reagents.holder_full())
					reagents.trans_to(RG, RG.amount_per_transfer_from_this, transfered_by = user)
					to_chat(user, span_notice("Я наполняю [RG] из [src]."))
					return TRUE
				to_chat(user, span_notice("[RG] полно."))
				return FALSE
*/
	if(user.a_intent == INTENT_HARM)
		if(W.sharpness)
			if(W.force >= 5)
				user.visible_message(span_notice("[user] cuts [src]."),span_notice("I cut [src]."), span_hear("I hear cutting."))
				user.changeNext_move(W.attack_delay)
				user.adjustFatigueLoss(5)
				sound_hint()
				W.damageItem("SOFT")
				deconstruct(FALSE)
/*
	else
		if(!special_objj)
			special_objj = W
			qdel(W)
*/
/*
/obj/structure/flora/ausbushes/cactus/attack_hand(mob/living/carbon/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(user.a_intent == INTENT_GRAB)
		user.changeNext_move(CLICK_CD_MELEE)
		user.adjustFatigueLoss(5)
		sound_hint()
		new /obj/item/modular_computer/laptop/preset/civilian(get_turf(user))
		H.special_item = null
*/
/obj/structure/flora/ausbushes/cactus/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		chem_splash(loc, 3, list(reagents))
		playsound(loc,'modular_pod/sound/eff/hitcrazy.ogg', 30, TRUE)
	qdel(src)

/obj/structure/flora/ausbushes/cactus/CanAllowThrough(atom/movable/mover, border_dir)//So bullets will fly over and stuff.
	. = ..()
	if(locate(/obj/structure/flora/ausbushes/cactus) in get_turf(mover))
		return TRUE
	else if(istype(mover, /obj/projectile))
		if(!anchored)
			return TRUE
		var/obj/projectile/proj = mover
		if(proj.firer && Adjacent(proj.firer))
			return TRUE
		if(prob(proj_pass_rate))
			return TRUE
		return FALSE

/obj/item/cactus_needle
	name = "Cactus Needle"
	desc = "Probably, I can... Inject someone?"
	icon = 'modular_pod/icons/obj/items/otherobjects.dmi'
	icon_state = "needle"
	inhand_icon_state = null
	worn_icon_state = null
	hitsound = list('modular_pod/sound/eff/weapon/stab_hit.ogg')
	w_class = WEIGHT_CLASS_SMALL
	wound_bonus = 1
	bare_wound_bonus = 3
	min_force = 1
	force = 6
	throwforce = 5
	sharpness = SHARP_POINTY
	embedding = list("pain_mult" = 6, "rip_time" = 1, "embed_chance" = 70, "jostle_chance" = 3.5, "pain_stam_pct" = 0.5, "pain_jostle_mult" = 6, "fall_chance" = 0.5, "ignore_throwspeed_threshold" = TRUE)
	skill_melee = SKILL_KNIFE
	carry_weight = 0.5 KILOGRAMS
	attack_fatigue_cost = 4
	attack_delay = 10
	parrying_flags = null
	parrying_modifier = null
	havedurability = TRUE
	durability = 10
	tetris_width = 16
	tetris_height = 32
	canlockpick = TRUE
	slot_flags = ITEM_SLOT_BELT
	attack_verb_continuous = list("stabs", "needles")
	attack_verb_simple = list("stab", "needle")

/obj/structure/flora/ausbushes/granat
	name = "Pomegranate"
	desc = "A wonderful fruit that has miraculously retained its benefits."
	icon = 'modular_pod/icons/obj/things/things_3.dmi'
	icon_state = "granat"
//	plane = ABOVE_GAME_PLANE
//	layer = FLY_LAYER
	resistance_flags = FLAMMABLE
	density = FALSE
	anchored = TRUE
	opacity = FALSE
	var/granats = 3

/obj/structure/flora/ausbushes/granat/attack_hand(mob/living/carbon/human/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(!do_after(user, 2 SECONDS, target = src))
		to_chat(user, span_danger(xbox_rage_msg()))
		return
	user.visible_message(span_notice("[user] tears off a piece from [src]."),span_notice("I tear off a piece from [src]."), span_hear("I hear collecting."))
	playsound(loc,'modular_pod/sound/eff/tearthing.ogg', 30, TRUE)
	var/obj/item/granat = new /obj/item/food/grown/granat(loc)
	user.put_in_active_hand(granat)
	user.changeNext_move(5)
	granats--
	if(granats <= 0)
		qdel(src)

/obj/structure/flora/ausbushes/granat/attackby(obj/item/W, mob/living/carbon/user, params)
	return

/obj/structure/wiresa
	name = "Провода"
	desc = "ЛУЧШЕ не лезть."
	icon = 'modular_pod/icons/obj/things/things_3.dmi'
	icon_state = "wires"
//	plane = GAME_PLANE
	layer = 1
	density = FALSE
	anchored = TRUE
	opacity = FALSE

/obj/structure/kaotikmachine
	name = "Kaotik Machine"
	desc = "BUY EQUIPMENT!"
	icon = 'modular_pod/icons/obj/things/things_3.dmi'
	icon_state = "kaotik_machine"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	anchored = 1
	density = 1
	obj_flags = NONE
	light_range = 5
	light_power = 2
	light_color = "#8e0000"
	var/lockeda = FALSE

/obj/structure/kaotikmachine/attack_hand(mob/living/carbon/human/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(!user.client)
		return
	if(!lockeda)
		if(user.client?.prefs)
			var/thing = input(user, "What do I want?", "I want...") as null|anything in list("Melee", "Guns", "Armor", "Ammo", "Traps", "Tools", "Other")
			if(!thing)
				return
			playsound(get_turf(src), 'modular_pod/sound/eff/kaotika.ogg', 90 , FALSE, FALSE)
			if(thing == "Melee")
				melee_find(user)
			if(thing == "Guns")
				guns_find(user)
			if(thing == "Armor")
				armor_find(user)
			if(thing == "Ammo")
				ammo_find(user)
			if(thing == "Traps")
				traps_find(user)
			if(thing == "Tools")
				tools_find(user)
			if(thing == "Other")
				other_find(user)

/obj/structure/kaotikmachine/proc/melee_find(mob/living/carbon/human/user)
	var/list/meleelist = list("Sword (50)", "Spear (40)", "Buckler (20)", "Rebar (20)", "Flail (40)")
	var/thingy = input(user, "What kind of weapon I want?", "I want...") as null|anything in sort_list(meleelist)
	var/datum/preferences/pref_source = user.client?.prefs
	if(!thingy)
		return
	if(get_dist(src, user) >= 2)
		return
	if((!pref_source.bobux_amount) || (pref_source.bobux_amount <= 0))
		to_chat(user, span_meatymeat("Need kaotiks!"))
		return
	switch(thingy)
		if("Sword (50)")
			if(pref_source.bobux_amount < 50)
				to_chat(user, span_meatymeat("Need kaotiks!"))
				return
			new /obj/item/podpol_weapon/sword/steel(get_turf(user))
			pref_source.bobux_amount -= 50
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 90 , FALSE, FALSE)
			to_chat(user, span_meatymeat("Purchase done!"))
		if("Spear (40)")
			if(pref_source.bobux_amount < 40)
				to_chat(user, span_meatymeat("Need kaotiks!"))
				return
			new /obj/item/podpol_weapon/spear/wooden(get_turf(user))
			pref_source.bobux_amount -= 40
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 90 , FALSE, FALSE)
			to_chat(user, span_meatymeat("Purchase done!"))
		if("Buckler (20)")
			if(pref_source.bobux_amount < 20)
				to_chat(user, span_meatymeat("Need kaotiks!"))
				return
			new /obj/item/melee/shieldo/buckler/wooden(get_turf(user))
			pref_source.bobux_amount -= 20
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 90 , FALSE, FALSE)
			to_chat(user, span_meatymeat("Purchase done!"))
		if("Rebar (20)")
			if(pref_source.bobux_amount < 20)
				to_chat(user, span_meatymeat("Need kaotiks!"))
				return
			new /obj/item/melee/bita/rebar(get_turf(user))
			pref_source.bobux_amount -= 20
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 90 , FALSE, FALSE)
			to_chat(user, span_meatymeat("Purchase done!"))
		if("Flail (40)")
			if(pref_source.bobux_amount < 40)
				to_chat(user, span_meatymeat("Need kaotiks!"))
				return
			new /obj/item/melee/bita/cep/iron(get_turf(user))
			pref_source.bobux_amount -= 40
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 90 , FALSE, FALSE)
			to_chat(user, span_meatymeat("Purchase done!"))
		else
			return

/obj/structure/kaotikmachine/proc/guns_find(mob/living/carbon/user)
	var/list/gunslist = list("Bobox (70)", "Revolver Nova (60)", "SMG Bolsa (100)", "SMG Cesno Thump (150)")
	var/thingy = input(user, "What kind of gun do I want?", "I want...") as null|anything in sort_list(gunslist)
	var/datum/preferences/pref_source = user.client?.prefs
	if(!thingy)
		return
	if(get_dist(src, user) >= 2)
		return
	if((!pref_source.bobux_amount) || (pref_source.bobux_amount <= 0))
		to_chat(user, span_meatymeat("Need kaotiks!"))
		return
	if(GLOB.world_deaths_crazy < 20)
		to_chat(user, span_meatymeat("Not enough deaths in the world! Need 20."))
		return
	switch(thingy)
		if("Bobox (70)")
			if(pref_source.bobux_amount < 70)
				to_chat(user, span_meatymeat("Need kaotiks!"))
				return
			new /obj/item/gun/ballistic/shotgun/doublebarrel/bobox(get_turf(user))
			pref_source.bobux_amount -= 70
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 90 , FALSE, FALSE)
			to_chat(user, span_meatymeat("Purchase done!"))
		if("Revolver Nova (60)")
			if(pref_source.bobux_amount < 60)
				to_chat(user, span_meatymeat("Need kaotiks!"))
				return
			new /obj/item/gun/ballistic/revolver/remis/nova(get_turf(user))
			pref_source.bobux_amount -= 60
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 90 , FALSE, FALSE)
			to_chat(user, span_meatymeat("Purchase done!"))
		if("SMG Bolsa (100)")
			if(pref_source.bobux_amount < 100)
				to_chat(user, span_meatymeat("Need kaotiks!"))
				return
			if(GLOB.phase_of_war != "Third")
				to_chat(user, span_meatymeat("We need Third War Phase!"))
				return
			new /obj/item/gun/ballistic/automatic/remis/smg/bolsa(get_turf(user))
			pref_source.bobux_amount -= 100
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 90 , FALSE, FALSE)
			to_chat(user, span_meatymeat("Purchase done!"))
		if("SMG Cesno Thump (150)")
			if(pref_source.bobux_amount < 150)
				to_chat(user, span_meatymeat("Need kaotiks!"))
				return
			if(GLOB.phase_of_war != "Third")
				to_chat(user, span_meatymeat("We need Third War Phase!"))
				return
			new /obj/item/gun/ballistic/automatic/remis/smg/thump(get_turf(user))
			pref_source.bobux_amount -= 150
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 90 , FALSE, FALSE)
			to_chat(user, span_meatymeat("Purchase done!"))
		else
			return

/obj/structure/kaotikmachine/proc/armor_find(mob/living/carbon/user)
	var/list/otherlist = list("Light Bulletproofer (50)", "Chainmail (50)", "Gloves (30)", "Ballistic Mask (40)")
	var/thingy = input(user, "What kind of armor do I want?", "I want...") as null|anything in sort_list(otherlist)
	var/datum/preferences/pref_source = user.client?.prefs
	if(!thingy)
		return
	if(get_dist(src, user) >= 2)
		return
	if((!pref_source.bobux_amount) || (pref_source.bobux_amount <= 0))
		to_chat(user, span_meatymeat("Need kaotiks!"))
		return
	if(GLOB.world_deaths_crazy < 10)
		to_chat(user, span_meatymeat("Not enough deaths in the world! Need 10."))
		return
	switch(thingy)
		if("Light Bulletproofer (50)")
			if(pref_source.bobux_amount < 50)
				to_chat(user, span_meatymeat("Need kaotiks!"))
				return
			new /obj/item/clothing/suit/armor/vest/bulletproofer(get_turf(user))
			pref_source.bobux_amount -= 50
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 90 , FALSE, FALSE)
			to_chat(user, span_meatymeat("Purchase done!"))
		if("Chainmail (50)")
			if(pref_source.bobux_amount < 50)
				to_chat(user, span_meatymeat("Need kaotiks!"))
				return
			new /obj/item/clothing/suit/armor/vest/chainmail/steel(get_turf(user))
			pref_source.bobux_amount -= 50
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 90 , FALSE, FALSE)
			to_chat(user, span_meatymeat("Purchase done!"))
		if("Gloves (30)")
			if(pref_source.bobux_amount < 30)
				to_chat(user, span_meatymeat("Need kaotiks!"))
				return
			new /obj/item/clothing/gloves/thickleather(get_turf(user))
			pref_source.bobux_amount -= 30
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 90 , FALSE, FALSE)
			to_chat(user, span_meatymeat("Purchase done!"))
		if("Ballistic Mask (40)")
			if(pref_source.bobux_amount < 40)
				to_chat(user, span_meatymeat("Need kaotiks!"))
				return
			new /obj/item/clothing/mask/gas/ballisticarmor(get_turf(user))
			pref_source.bobux_amount -= 40
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 90 , FALSE, FALSE)
			to_chat(user, span_meatymeat("Purchase done!"))
		else
			return

/obj/structure/kaotikmachine/proc/ammo_find(mob/living/carbon/user)
	var/list/otherlist = list("Buckshot (30)", ".38 Bullets (20)", "9mm Magazine (30)", ".45 Magazine (30)")
	var/thingy = input(user, "What kind of ammo do I want?", "I want...") as null|anything in sort_list(otherlist)
	var/datum/preferences/pref_source = user.client?.prefs
	if(!thingy)
		return
	if(get_dist(src, user) >= 2)
		return
	if((!pref_source.bobux_amount) || (pref_source.bobux_amount <= 0))
		to_chat(user, span_meatymeat("Need kaotiks!"))
		return
/*
	if(GLOB.world_deaths_crazy < 15)
		to_chat(user, span_meatymeat("Недостаточно смертей в мире!"))
		return
*/
	switch(thingy)
		if("Buckshot (30)")
			if(pref_source.bobux_amount < 30)
				to_chat(user, span_meatymeat("Need kaotiks!"))
				return
			new /obj/item/ammo_box/magazine/ammo_stack/shotgunbuckshot/loaded(get_turf(user))
			pref_source.bobux_amount -= 30
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 90 , FALSE, FALSE)
			to_chat(user, span_meatymeat("Purchase done!"))
		if(".38 Bullets (20)")
			if(pref_source.bobux_amount < 20)
				to_chat(user, span_meatymeat("Need kaotiks!"))
				return
			new /obj/item/ammo_box/magazine/ammo_stack/c38/loaded(get_turf(user))
			pref_source.bobux_amount -= 20
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 90 , FALSE, FALSE)
			to_chat(user, span_meatymeat("Purchase done!"))
		if("9mm Magazine (30)")
			if(pref_source.bobux_amount < 30)
				to_chat(user, span_meatymeat("Need kaotiks!"))
				return
			new /obj/item/ammo_box/magazine/uzi9mm(get_turf(user))
			pref_source.bobux_amount -= 30
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 90 , FALSE, FALSE)
			to_chat(user, span_meatymeat("Purchase done!"))
		if(".45 Magazine (30)")
			if(pref_source.bobux_amount < 30)
				to_chat(user, span_meatymeat("Need kaotiks!"))
				return
			new /obj/item/ammo_box/magazine/thump45(get_turf(user))
			pref_source.bobux_amount -= 30
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 90 , FALSE, FALSE)
			to_chat(user, span_meatymeat("Purchase done!"))
		else
			return

/obj/structure/kaotikmachine/proc/traps_find(mob/living/carbon/user)
	var/list/otherlist = list("Wire Installer (40)", "Mine Installer (80)", "Pressure Mine Installer (70)")
	var/thingy = input(user, "What kind of trap do I want?", "I want...") as null|anything in sort_list(otherlist)
	var/datum/preferences/pref_source = user.client?.prefs
	if(!thingy)
		return
	if(get_dist(src, user) >= 2)
		return
	if((!pref_source.bobux_amount) || (pref_source.bobux_amount <= 0))
		to_chat(user, span_meatymeat("Need kaotiks!"))
		return
//	if(GLOB.world_deaths_crazy < 15)
//		to_chat(user, span_meatymeat("Недостаточно смертей в мире!"))
//		return
	switch(thingy)
		if("Wire Installer (40)")
			if(pref_source.bobux_amount < 40)
				to_chat(user, span_meatymeat("Need kaotiks!"))
				return
			new /obj/item/barbsetup(get_turf(user))
			pref_source.bobux_amount -= 40
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 90 , FALSE, FALSE)
			to_chat(user, span_meatymeat("Purchase done!"))
		if("Mine Installer (80)")
			if(pref_source.bobux_amount < 80)
				to_chat(user, span_meatymeat("Need kaotiks!"))
				return
			new /obj/item/minesetup(get_turf(user))
			pref_source.bobux_amount -= 80
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 90 , FALSE, FALSE)
			to_chat(user, span_meatymeat("Purchase done!"))
		if("Pressure Mine Installer (70)")
			if(pref_source.bobux_amount < 70)
				to_chat(user, span_meatymeat("Need kaotiks!"))
				return
			new /obj/item/minesetuplita(get_turf(user))
			pref_source.bobux_amount -= 70
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 90 , FALSE, FALSE)
			to_chat(user, span_meatymeat("Purchase done!"))
		else
			return

/obj/structure/kaotikmachine/proc/tools_find(mob/living/carbon/user)
	var/list/otherlist = list("Pickaxe (50)", "Disarmer (30)", "Pomegranate Tea (30)")
	var/thingy = input(user, "What kind of tool do I want?", "I want...") as null|anything in sort_list(otherlist)
	var/datum/preferences/pref_source = user.client?.prefs
	if(!thingy)
		return
	if(get_dist(src, user) >= 2)
		return
	if((!pref_source.bobux_amount) || (pref_source.bobux_amount <= 0))
		to_chat(user, span_meatymeat("Need kaotiks!"))
		return
	switch(thingy)
		if("Disarmer (30)")
			if(pref_source.bobux_amount < 30)
				to_chat(user, span_meatymeat("Need kaotiks!"))
				return
			new /obj/item/minedisarmer(get_turf(user))
			pref_source.bobux_amount -= 30
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 90 , FALSE, FALSE)
			to_chat(user, span_meatymeat("Purchase done!"))
		if("Pickaxe (50)")
			if(pref_source.bobux_amount < 50)
				to_chat(user, span_meatymeat("Need kaotiks!"))
				return
			new /obj/item/melee/hehe/pickaxe/iron(get_turf(user))
			pref_source.bobux_amount -= 50
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 90 , FALSE, FALSE)
			to_chat(user, span_meatymeat("Purchase done!"))
		if("Pomegranate Tea (30)")
			if(pref_source.bobux_amount < 30)
				to_chat(user, span_meatymeat("Need kaotiks!"))
				return
			new /obj/item/reagent_containers/food/drinks/bottle/thermos(get_turf(user))
			pref_source.bobux_amount -= 30
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 90 , FALSE, FALSE)
			to_chat(user, span_meatymeat("Purchase done!"))
		else
			return

/obj/structure/kaotikmachine/proc/other_find(mob/living/carbon/user)
	var/list/otherlist = list("Frag Grenade (60)", "Gas Grenade (40)", "Flare (10)", "Night Eyes (70)", "Shoulder Satchel (50)")
	var/thingy = input(user, "What kind of thing do I want?", "I want...") as null|anything in sort_list(otherlist)
	var/datum/preferences/pref_source = user.client?.prefs
	if(!thingy)
		return
	if(get_dist(src, user) >= 2)
		return
	if((!pref_source.bobux_amount) || (pref_source.bobux_amount <= 0))
		to_chat(user, span_meatymeat("Need kaotiks!"))
		return
	if(GLOB.world_deaths_crazy < 10)
		to_chat(user, span_meatymeat("Not enough deaths in the world! Need 10."))
		return
	switch(thingy)
		if("Frag Grenade (60)")
			if(pref_source.bobux_amount < 60)
				to_chat(user, span_meatymeat("Need kaotiks!"))
				return
			new /obj/item/grenade/frag(get_turf(user))
			pref_source.bobux_amount -= 60
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 90 , FALSE, FALSE)
			to_chat(user, span_meatymeat("Purchase done!"))
		if("Gas Grenade (40)")
			if(pref_source.bobux_amount < 40)
				to_chat(user, span_meatymeat("Need kaotiks!"))
				return
			new /obj/item/grenade/gas/incredible_gas(get_turf(user))
			pref_source.bobux_amount -= 40
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 90 , FALSE, FALSE)
			to_chat(user, span_meatymeat("Purchase done!"))
		if("Flare (10)")
			if(pref_source.bobux_amount < 10)
				to_chat(user, span_meatymeat("Need kaotiks!"))
				return
			new /obj/item/flashlight/flare(get_turf(user))
			pref_source.bobux_amount -= 10
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 90 , FALSE, FALSE)
			to_chat(user, span_meatymeat("Purchase done!"))
		if("Night Eyes (70)")
			if(pref_source.bobux_amount < 70)
				to_chat(user, span_meatymeat("Need kaotiks!"))
				return
			new /obj/item/clothing/glasses/night(get_turf(user))
			pref_source.bobux_amount -= 70
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 90 , FALSE, FALSE)
			to_chat(user, span_meatymeat("Purchase done!"))
		if("Shoulder Satchel (50)")
			if(pref_source.bobux_amount < 50)
				to_chat(user, span_meatymeat("Need kaotiks!"))
				return
			new /obj/item/storage/belt/military/itobe(get_turf(user))
			pref_source.bobux_amount -= 50
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 90 , FALSE, FALSE)
			to_chat(user, span_meatymeat("Purchase done!"))
		else
			return

/obj/structure/kaos/blackwindow
	name = "Black Window"
	desc = "?"
	icon = 'modular_pod/icons/turf/floors_4.dmi'
	icon_state = "blackwindow"
	plane = ABOVE_GAME_PLANE
	layer = FLY_LAYER
	obj_flags = NONE
	anchored = TRUE
	density = TRUE
	var/lightchoose

/obj/structure/kaos/blackwindow/Initialize(mapload)
	. = ..()
	lightchoose = rand(1, 2)
	switch(lightchoose)
		if(1)
			set_light(8, 4, "#b90000")
		if(2)
			set_light(8, 4, "#b900b9")
//		if(3)
//			set_light(4, 3, "#b90000")

/obj/structure/blockrole
	name = "Oh"
	desc = "Can't go any further."
	icon = 'modular_pod/icons/obj/things/things_3.dmi'
	icon_state = "turboa"
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	anchored = 1
	obj_flags = NONE
	var/allow_role = null

/obj/structure/blockrole/CanAllowThrough(atom/movable/mover, border_dir)
	. = ..()
	if(ishuman(mover))
		var/mob/living/carbon/human/H = mover
		if(H.truerole == allow_role)
			return TRUE
	return FALSE

/obj/structure/blockrole/konch
	allow_role = "Kador"

/obj/structure/sign/poster/contraband/codec/lians
	name = "Karza"
	desc = "How many lives saved..."
	icon = 'modular_pod/icons/obj/things/things_3.dmi'
	icon_state = "wallight"
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	var/lightchoose

/obj/structure/sign/poster/contraband/codec/lians/Initialize(mapload)
	. = ..()
	lightchoose = rand(1, 3)
	switch(lightchoose)
		if(1)
			set_light(4, 2, "#0017ff")
		if(2)
			set_light(4, 2, "#008dff")
		if(2)
			set_light(4, 2, "#3c00ff")

/obj/structure/sign/poster/contraband/codec/purpella
	name = "Purplea"
	desc = "Coating."
	icon = 'modular_pod/icons/turf/closed/cavera.dmi'
	icon_state = "purpela"
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	var/lightchoose

/obj/structure/sign/poster/contraband/codec/purpella/Initialize(mapload)
	. = ..()
	lightchoose = rand(1, 4)
	switch(lightchoose)
		if(1)
			set_light(2, 2, "#d1a5a0")
		if(2)
			set_light(3, 2, "#c680c8")
		if(3)
			set_light(4, 2, "#a180ed")
		if(4)
			set_light(1, 3, "#894ab6")

/obj/structure/medica
	name = "Medika"
	desc = "All it takes for Medika to cure me is..."
	icon = 'modular_pod/icons/obj/things/things_3.dmi'
	icon_state = "medica"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	anchored = 1
	density = 0
	obj_flags = NONE
	light_range = 3
	light_power = 2
	light_color = "#75a743"
	verb_say = "cutes"
	verb_ask = "cutes"
	verb_exclaim = "cutes"
	var/datum/looping_sound/medika/soundloop
	var/words_list = list("I will heal you, and your soul!", "You are my only one!", "I'm always here, just come to me.", "I will never betray you.", "I've been waiting for you...")

/obj/structure/medica/proc/speak(message)
	if(!message)
		return
	say(message)

/obj/structure/medica/Initialize(mapload)
	. = ..()
	soundloop = new(src, FALSE)
	soundloop.start()

/obj/structure/medica/Destroy()
	. = ..()
	QDEL_NULL(soundloop)

/obj/structure/medica/attack_jaw(mob/living/carbon/human/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(do_after(user, 4 SECONDS, target=src))
		user.visible_message(span_notice("[user] does something with [src]."),span_notice("I do something with [src]."), span_hear("I hear strange things."))
		user.changeNext_move(CLICK_CD_MELEE)
		user.adjustFatigueLoss(10)
		sound_hint()
		playsound(src, 'modular_pod/sound/eff/anime-wow-1.ogg', 55, FALSE)

/obj/structure/medica/attackby(obj/item/W, mob/living/carbon/user, params)
	if(istype(W, /obj/item/grab))
		var/mob/living/GR = user.pulling
		if(GR == null)
			return
		if(do_after(user, 3 SECONDS, target=src))
			to_chat(GR, span_meatymeat("I feel some kind of fucked up!"))
			GR.fully_heal(TRUE, FALSE)
			var/words = pick(words_list)
			speak(words)
			sound_hint()
			playsound(src, 'modular_pod/sound/voice/my.ogg', 55, FALSE)
	else
		return

/obj/structure/medica/attack_hand(mob/living/carbon/human/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(do_after(user, 2 SECONDS, target=src))
		to_chat(user, span_meatymeat("I feel some kind of fucked up!"))
		user.fully_heal(TRUE, FALSE)
		var/words = pick(words_list)
		speak(words)
		sound_hint()
		playsound(src, 'modular_pod/sound/voice/my.ogg', 55, FALSE)

/*
/obj/item/paperpodpol
	name = "Бумажка"
	desc = "Нужно ли мне подобное читать?"
	icon = 'modular_pod/icons/obj/things/things_3.dmi'
	icon_state = "paper"
	resistance_flags = FLAMMABLE
	drop_sound = 'sound/items/handling/paper_drop.ogg'
	pickup_sound = 'sound/items/handling/paper_pickup.ogg'
	throw_range = 1
	throw_speed = 1
	throwforce = 0
	w_class = WEIGHT_CLASS_TINY
	var/info

/obj/item/paperpodpol/attack_self(mob/user)
	. = ..()
	if(.)
		return
	readshit(user)

/obj/item/paperpodpol/proc/readshit(mob/user)
//	user << browse_rsc('html/book.png')
	if(!user.client)
		return
//	if(!user.hud_used.reads)
//		return
	if(!user.can_read(src))
		return
	if(in_range(user, src) || isobserver(user))
//		var/obj/screen/read/R = user.hud_used.reads
//		user.hud_used.reads.icon_state = "scrap"
//		user.hud_used.reads.show()
		var/dat = list()
		dat += "[info]<br>"
//		dat += "<a href='?src=[REF(src)];close=1' style='position:absolute;right:50px'>Close</a>"
		dat += "</body></html>"
		user << browse(dat, "window=reading;size=600x400;can_close=1;can_minimize=0;can_maximize=0;can_resize=1;titlebar=1")
		onclose(user, "reading", src)
	else
		return "<span class='warning'>Слишком далеко.</span>"

/obj/item/paperpodpol/first
	info = "Я потерялся в этой хуйне. Свет дурманит меня, лучше бы оказался во тьме. Я насчитал уже 30 узоров на этом... На этой... Не знаю что это. Кажись, я понял, что они недооценивают меня, я осознал это. Пора спать."
*/
/obj/structure/barbwire
	name = "Barbed Wire"
	desc = "DO NOT TOUCH ME."
	icon = 'modular_pod/icons/obj/things/things_3.dmi'
	icon_state = "barbwire"
	density = FALSE
	anchored = TRUE
	opacity = FALSE
	istrap = TRUE

/obj/structure/barbwire/ComponentInitialize()
	. = ..()
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(dont_step),
		COMSIG_ATOM_EXIT = PROC_REF(on_uncrossed),
	)
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/structure/barbwire/proc/dont_step(datum/source, atom/movable/AM, thrown_at = FALSE)
	SIGNAL_HANDLER
	if(!isturf(loc) || !isliving(AM))
		return
	var/mob/living/L = AM
	if(!thrown_at && L.movement_type & (FLYING|FLOATING))
		return
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		var/obj/item/bodypart/affecting = C.get_bodypart_nostump(ran_zone(BODY_ZONE_CHEST, 50))
		var/armor_block = C.run_armor_check(affecting, MELEE, sharpness = SHARP_EDGED)
		var/armor_reduce = C.run_subarmor_check(affecting, MELEE, sharpness = SHARP_EDGED)
		C.visible_message(span_meatymeat("[C] gets hurt by [src]!"),span_meatymeat("I get hurt by [src]!"), span_hear("I hear hurting."))
		C.apply_damage(10, BRUTE, affecting, armor_block, wound_bonus = 5, sharpness = SHARP_EDGED, reduced = armor_reduce)
		affecting.adjust_germ_level(50)
		playsound(get_turf(src), 'modular_septic/sound/weapons/melee/sharpy1.ogg', 100 , FALSE, FALSE)

/obj/structure/barbwire/proc/on_uncrossed(datum/source, atom/movable/gone, direction)
	SIGNAL_HANDLER
	if(ishuman(gone))
		var/mob/living/carbon/human/H = gone
		if(prob(60))
			H.visible_message(span_meatymeat("[H] tries to get out of the [src]!"))
			var/obj/item/bodypart/affecting = H.get_bodypart_nostump(ran_zone(BODY_ZONE_CHEST, 50))
			var/armor_block = H.run_armor_check(affecting, MELEE, sharpness = SHARP_EDGED)
			var/armor_reduce = H.run_subarmor_check(affecting, MELEE, sharpness = SHARP_EDGED)
			H.apply_damage(10, BRUTE, affecting, armor_block, wound_bonus = 5, sharpness = SHARP_EDGED, reduced = armor_reduce)
			affecting.adjust_germ_level(50)
			return COMPONENT_ATOM_BLOCK_EXIT
		else
			H.visible_message(span_meatymeat("[H] gets out of the [src]!"))
			return

/obj/item/barbsetup
	name = "Installer"
	desc = "This is how you can install the wire."
	icon = 'modular_pod/icons/obj/items/otherobjects.dmi'
	icon_state = "setupper"
	inhand_icon_state = null
	worn_icon = null
	worn_icon_state = null
	w_class = WEIGHT_CLASS_BULKY
	wound_bonus = 1
	bare_wound_bonus = 3
	min_force = 1
	force = 8
	throwforce = 5
	carry_weight = 4 KILOGRAMS
	slot_flags = ITEM_SLOT_BELT
	attack_verb_continuous = list("hits")
	attack_verb_simple = list("hit")
	var/zaryad = 3

/obj/item/detonatormine
	name = "Detonator"
	desc = "For my mine."
	icon = 'modular_pod/icons/obj/things/things_3.dmi'
	icon_state = "detonator"
	inhand_icon_state = "flashbang"
	worn_icon_state = "grenade"
	lefthand_file = 'icons/mob/inhands/equipment/security_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/security_righthand.dmi'
	inhand_icon_state = null
	worn_icon = null
	worn_icon_state = null
	w_class = WEIGHT_CLASS_SMALL
	wound_bonus = 1
	bare_wound_bonus = 1
	min_force = 1
	force = 2
	throwforce = 1
	carry_weight = 0.5 KILOGRAMS
	slot_flags = ITEM_SLOT_BELT
	attack_verb_continuous = list("hits")
	attack_verb_simple = list("hit")
	var/id_detonator = null

/obj/item/detonatormine/attack_self(mob/user)
	. = ..()
	if(.)
		return
	if(id_detonator)
		user.visible_message(span_meatymeat("[user] clicks on [src]."))
		user.changeNext_move(CLICK_CD_MELEE)
		for(var/obj/structure/mineexplosive/M in world)
			if(M.mineid != src.id_detonator)
				continue
			INVOKE_ASYNC(M, TYPE_PROC_REF(/obj/structure/mineexplosive/, detonate))
//			INVOKE_ASYNC(M, /obj/structure/mineexplosive.proc/detonate)

/obj/item/minesetup
	name = "Mine Installer"
	desc = "Model Bajas, 3. You also need a detonator. It's like it's inside."
	icon = 'modular_pod/icons/obj/things/things_3.dmi'
	icon_state = "mine"
	inhand_icon_state = null
	worn_icon = null
	worn_icon_state = "shard"
	w_class = WEIGHT_CLASS_BULKY
	wound_bonus = 1
	bare_wound_bonus = 3
	min_force = 1
	force = 8
	throwforce = 5
	carry_weight = 3 KILOGRAMS
	slot_flags = ITEM_SLOT_BELT
	attack_verb_continuous = list("bits")
	attack_verb_simple = list("hit")
	var/install_mine = /obj/structure/mineexplosive/based
	var/detonator = 1
	var/id_mine = null

/obj/item/minesetup/attack_self(mob/user)
	. = ..()
	if(.)
		return
	if(!detonator)
		to_chat(user, span_danger("No detonator inside!"))
		user.playsound_local(get_turf(user), 'modular_pod/sound/eff/difficult1.ogg', 15, FALSE)
		return
	GLOB.minenew += 1
	var/obj/item/detonatormine/detonatorr = new /obj/item/detonatormine(get_turf(user))
	user.put_in_hands(detonatorr)
	detonator--
	var/idd = GLOB.minenew
	id_mine = idd
	detonatorr.id_detonator = id_mine
	to_chat(user, span_notice("I'm getting the detonator."))
	user.changeNext_move(CLICK_CD_MELEE)

/obj/item/minesetuplita
	name = "Mine Installer"
	desc = "Model Repeater. After installation, it will be enough to step on this."
	icon = 'modular_pod/icons/obj/things/things_3.dmi'
	icon_state = "mineplit_thing"
	inhand_icon_state = null
	worn_icon = null
	worn_icon_state = null
	w_class = WEIGHT_CLASS_BULKY
	wound_bonus = 1
	bare_wound_bonus = 3
	min_force = 1
	force = 8
	throwforce = 5
	carry_weight = 3 KILOGRAMS
	slot_flags = ITEM_SLOT_BELT
	attack_verb_continuous = list("hits")
	attack_verb_simple = list("hit")
	var/install_mine = /obj/structure/mineexplosive/mineplit

/obj/structure/mineexplosive
	name = "Installed Mine"
	desc = "DON'T CLIMB."
	icon = 'modular_pod/icons/obj/things/things_3.dmi'
	icon_state = "installed"
	density = FALSE
	anchored = TRUE
	opacity = FALSE
	istrap = TRUE
	var/mineid = null
	var/work = TRUE
	var/normal_way = TRUE
	var/ex_dev = 0
	///how big of a heavy explosion radius on prime
	var/ex_heavy = 0
	///how big of a light explosion radius on prime
	var/ex_light = 0
	///how big of a flame explosion radius on prime
	var/ex_flame = 0
	// dealing with creating a [/datum/component/pellet_cloud] on detonate
	/// if set, will spew out projectiles of this type
	var/shrapnel_type
	/// the higher this number, the more projectiles are created as shrapnel
	var/shrapnel_radius
	/// Did we add the component responsible for spawning sharpnel to this?
	var/shrapnel_initialized

/obj/structure/mineexplosive/examine(mob/user)
	. = ..()
	if(!work)
		. += span_notice("Mine doesn't work, eh.")

/obj/structure/mineexplosive/attackby(obj/item/W, mob/living/carbon/user, params)
	if(istype(W, /obj/item/minedisarmer))
		if(!work)
			return
		user.visible_message(span_meatymeat("[user] tries to disarm [src]!"))
		sound_hint()
		if(!do_after(user, 4 SECONDS, target = src))
			to_chat(user, span_danger(xbox_rage_msg()))
			user.playsound_local(get_turf(user), 'modular_pod/sound/eff/difficult1.ogg', 15, FALSE)
		var/epic_success = user.diceroll(GET_MOB_SKILL_VALUE(user, SKILL_ELECTRONICS), context = DICE_CONTEXT_PHYSICAL)
		if(epic_success >= DICE_SUCCESS)
			user.visible_message(span_meatymeat("[user] disarms [src]!"))
			work = FALSE
		else
			user.visible_message(span_meatymeat("[user] failed to disarm [src]!"))
			return
		user.changeNext_move(CLICK_CD_MELEE)
		sound_hint()
//			normal_way = FALSE
//			INVOKE_ASYNC(src, TYPE_PROC_REF(/obj/structure/mineexplosive, detonate))
	return

/obj/structure/mineexplosive/proc/detonate(mob/living/lanced_by)
	SIGNAL_HANDLER
	if(normal_way)
		if(!work)
			return
		if(shrapnel_type && shrapnel_radius && !shrapnel_initialized)
			shrapnel_initialized = TRUE
			AddComponent(/datum/component/pellet_cloud, projectile_type=shrapnel_type, magnitude=shrapnel_radius)
		SEND_SIGNAL(src, COMSIG_CRAZYMINE_TRIGGERED, lanced_by)
		if(ex_dev || ex_heavy || ex_light || ex_flame)
			var/turf/explosionturf = get_turf(src)
			if(explosionturf)
				explosionturf.pollute_turf(/datum/pollutant/dust, 350)
				explosion(src, ex_dev, ex_heavy, ex_light, ex_flame)
				if(!QDELETED(src))
					qdel(src)
	else
		if(shrapnel_type && shrapnel_radius && !shrapnel_initialized)
			shrapnel_initialized = TRUE
			AddComponent(/datum/component/pellet_cloud, projectile_type=shrapnel_type, magnitude=shrapnel_radius)
		SEND_SIGNAL(src, COMSIG_CRAZYMINE_TRIGGERED, lanced_by)
		if(ex_dev || ex_heavy || ex_light || ex_flame)
			var/turf/explosionturf = get_turf(src)
			if(explosionturf)
				explosionturf.pollute_turf(/datum/pollutant/dust, 350)
				explosion(src, ex_dev, ex_heavy, ex_light, ex_flame)
				if(!QDELETED(src))
					qdel(src)

/obj/structure/mineexplosive/based
	shrapnel_type = /obj/projectile/bullet/shrapnel/mine
	shrapnel_radius = 4
	ex_heavy = 3
	ex_light = 4
	ex_flame = 3

/obj/structure/mineexplosive/mineplit
	name = "Installed Mine"
	desc = "DON'T CLIMB."
	icon = 'modular_pod/icons/obj/things/things_3.dmi'
	icon_state = "mineplit"
	density = FALSE
	anchored = TRUE
	opacity = FALSE
	istrap = TRUE
	shrapnel_type = /obj/projectile/bullet/shrapnel/mine
	shrapnel_radius = 4
	ex_heavy = 4
	ex_light = 2
	ex_flame = 3
	var/friendo = null

/obj/structure/mineexplosive/mineplit/ComponentInitialize()
	. = ..()
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(detonated),
	)
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/structure/mineexplosive/mineplit/attackby(obj/item/W, mob/living/carbon/user, params)
	if(istype(W, /obj/item/minedisarmer))
		if(!work)
			return
		user.visible_message(span_meatymeat("[user] tries to disarm [src]!"))
		sound_hint()
		if(!do_after(user, 4 SECONDS, target = src))
			to_chat(user, span_danger(xbox_rage_msg()))
			user.playsound_local(get_turf(user), 'modular_pod/sound/eff/difficult1.ogg', 15, FALSE)
		var/epic_success = user.diceroll(GET_MOB_SKILL_VALUE(user, SKILL_ELECTRONICS), context = DICE_CONTEXT_PHYSICAL)
		if(epic_success >= DICE_SUCCESS)
			user.visible_message(span_meatymeat("[user] disarms [src]!"))
			work = FALSE
		else
			user.visible_message(span_meatymeat("[user] failed to disarm [src]!"))
			return
		user.changeNext_move(CLICK_CD_MELEE)
		sound_hint()
	return

/obj/structure/mineexplosive/mineplit/proc/detonated(datum/source, mob/living/lanced_by)
	SIGNAL_HANDLER
	if(normal_way)
		if(!work)
			return
		if(lanced_by.throwing || lanced_by.movement_type & (FLYING|FLOATING))
			return
		if(lanced_by.truerole == friendo)
			return
		if(shrapnel_type && shrapnel_radius && !shrapnel_initialized)
			shrapnel_initialized = TRUE
			AddComponent(/datum/component/pellet_cloud, projectile_type=shrapnel_type, magnitude=shrapnel_radius)
		SEND_SIGNAL(src, COMSIG_CRAZYMINE_TRIGGERED, lanced_by)
		if(ex_dev || ex_heavy || ex_light || ex_flame)
			var/turf/explosionturf = get_turf(src)
			if(explosionturf)
				explosionturf.pollute_turf(/datum/pollutant/dust, 350)
				explosion(src, ex_dev, ex_heavy, ex_light, ex_flame)
				if(!QDELETED(src))
					qdel(src)
	else
		if(shrapnel_type && shrapnel_radius && !shrapnel_initialized)
			shrapnel_initialized = TRUE
			AddComponent(/datum/component/pellet_cloud, projectile_type=shrapnel_type, magnitude=shrapnel_radius)
		SEND_SIGNAL(src, COMSIG_CRAZYMINE_TRIGGERED, lanced_by)
		if(ex_dev || ex_heavy || ex_light || ex_flame)
			var/turf/explosionturf = get_turf(src)
			if(explosionturf)
				explosionturf.pollute_turf(/datum/pollutant/dust, 350)
				explosion(src, ex_dev, ex_heavy, ex_light, ex_flame)
				if(!QDELETED(src))
					qdel(src)

/obj/item/minedisarmer
	name = "Disarmer"
	desc = "Mines are not a hindrance!"
	icon = 'modular_pod/icons/obj/things/things_3.dmi'
	icon_state = "disarmer"
	inhand_icon_state = null
	worn_icon = null
	worn_icon_state = null
	w_class = WEIGHT_CLASS_SMALL
	wound_bonus = 1
	bare_wound_bonus = 3
	min_force = 1
	force = 4
	throwforce = 3
	carry_weight = 1 KILOGRAMS
	slot_flags = ITEM_SLOT_BELT
	attack_verb_continuous = list("hits")
	attack_verb_simple = list("hit")
