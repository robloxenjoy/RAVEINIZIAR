/obj/structure/wayto/podpol
	name = "Подпол"
	desc = "Что там?"
	icon = 'modular_pod/icons/obj/things/things_4.dmi'
	icon_state = "podpol"
	anchored = TRUE
	obj_flags = CAN_BE_HIT | BLOCK_Z_OUT_DOWN
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	pixel_x = -16
	pixel_y = -16
	var/up = FALSE
	var/down = TRUE

/obj/structure/wayto/podpol/attack_hand(mob/living/carbon/human/user, list/modifiers)
	. = ..()
	if(.)
		return
	use(user, TRUE)

/obj/structure/wayto/podpol/attackby(obj/item/I, mob/living/user, params)
	use(user, TRUE)
	return TRUE

/obj/structure/wayto/podpol/proc/use(mob/living/carbon/human/user, going_up = TRUE, is_ghost = FALSE)
	if(user.truerole != "Капнобатай")
		to_chat(user, span_notice("Меня там пацаны не примут."))
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
	light_range = 2
	light_power = 1
	light_color = "#e1dfe1"

/obj/structure/table/goody
	name = "Стол"
	desc = "Хорошо. Славно. Классно."
	icon = 'modular_pod/icons/obj/things/things_3.dmi'
	icon_state = "tablera"
	smoothing_flags = NONE
	smoothing_groups = null
	canSmoothWith = null
	frame = null

/obj/structure/bed/mattress
	name = "Матрас"
	desc = "Главное отоспаться."
	icon = 'modular_pod/icons/obj/things/things_3.dmi'
	icon_state = "mattress"

/obj/structure/closet/crate/freezer/podozl
	name = "Холодильник"
	desc = "В таком состоянии... Каким-то образом охлаждает."
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
	name = "Бочка"
	icon = 'modular_pod/icons/obj/things/things_3.dmi'
	icon_state = "barrel"
	desc = "Завораживающе."
	density = 1
	anchored = 1
	light_range = 4
	light_power = 1
	light_color = "#e19644"

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
	name = "Бумбокс"
	desc = "А это уже другое дело."
	icon = 'modular_pod/icons/obj/items/otherobjects.dmi'
	icon_state = "boombox"
	var/datum/looping_sound/musicloop/soundloop
	var/playc = FALSE

/obj/item/musicshit/boombox/Initialize(mapload)
	. = ..()
	soundloop = new(src,  FALSE)

/obj/item/musicshit/boombox/Destroy()
	QDEL_NULL(soundloop)
	. = ..()

/obj/item/musicshit/boombox/attack_self(mob/user)
	. = ..()
	if(.)
		return
	if(playc)
		playc = FALSE
		soundloop.stop()
//		STOP_PROCESSING(SSobj, src)
	else
		playc = TRUE
		soundloop.start()
	user.changeNext_move(CLICK_CD_MELEE)
//		START_PROCESSING(SSobj, src)

/*
/obj/item/musicshit/boombox/process()
	if(playc)
		for(var/mob/M in range(10, src))
			if(!M || !M.client)
				continue
			playsound(get_turf(src), 'modular_pod/sound/mus/boombox.ogg', volume = 60, falloff_exponent = 11, falloff_distance = 3, channel = CHANNEL_JUKEBOX, use_reverb = TRUE)
			playc = TRUE
	else
		for(var/mob/L in range(10, src))
			if(!L || !L.client)
				continue
			L.stop_sound_channel(CHANNEL_JUKEBOX)
*/

/obj/structure/chair/podpolsit
	name = "Трон"
	desc = "Пора узнать, что такое сила."
	icon = 'modular_pod/icons/obj/things/things_5.dmi'
	icon_state = "sit"
	max_integrity = 10000

/obj/structure/chair/podpolsit/deconstruct()
	new /obj/item/podpol_weapon/sword/steel(get_turf(src))

/obj/structure/chair/podpolsit/post_buckle_mob(mob/living/M)
	. = ..()
	if(iscarbon(M))
		M.pixel_y += 5
		M.visible_message(span_notice("[M] усаживается на [src]."),span_notice("Я усаживаюсь на [src]."), span_hear("Я слышу чё-то."))
		if(do_after(M, 3 SECONDS, target=src))
			if(!M.buckled)
				to_chat(M, span_meatymeat("Надо на трон сесть!"))
				return
			to_chat(M, span_meatymeat("Я ощущаю какой-то пиздец!"))
			M.fully_heal(TRUE)

/obj/structure/chair/podpolsit/post_unbuckle_mob(mob/living/M)
	if(iscarbon(M))
		M.pixel_y -= 5

/obj/structure/column/power
	name = "Статуя"
	desc = "То, что внушает страх."
	icon = 'modular_pod/icons/obj/things/things_3.dmi'
	icon_state = "power"
	plane = ABOVE_GAME_PLANE
	layer = FLY_LAYER
	anchored = 1
	density = 1
	obj_flags = NONE
	max_integrity = 1000

/obj/effect/decal/metalpodpol
	name = "Плитка"
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
	name = "Травка"
	icon = 'modular_pod/icons/obj/things/things_3.dmi'
	icon_state = "grass1"
	layer = TURF_PLATING_DECAL_LAYER
	alpha = 255
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/obj/effect/decal/grassgood/Initialize(mapload)
	. = ..()
	if(prob(50))
		icon_state = "grass2"

/obj/structure/flora/ausbushes/cactus
	name = "Кактус"
	desc = "Сука колючий. Воды бы набрать с него."
	icon = 'modular_pod/icons/obj/things/things_3.dmi'
	icon_state = "cactus1"
	plane = ABOVE_GAME_PLANE
	layer = FLY_LAYER
	resistance_flags = FLAMMABLE
	density = TRUE
	anchored = TRUE
	opacity = FALSE
	var/proj_pass_rate = 100

/obj/structure/flora/ausbushes/cactus/Initialize(mapload)
	. = ..()
	create_reagents(50, INJECTABLE | DRAINABLE)
	reagents.add_reagent(/datum/reagent/water, 50)
	if(prob(50))
		icon_state = "cactus2"

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
				rammer.visible_message(span_pinkdang("Игла застревает в [rammer] [affecting]!"), \
									span_pinkdang("Игла застревает в [affecting]!"), \
									span_hear("Я слышу звук плоти."))
			else
				qdel(cactus_needle)
				rammer.visible_message(span_meatymeat("[rammer] укалывается об [src]!"),span_meatymeat("Я укалываюсь об [src]!"), span_hear("Я слышу чё-то."))
				rammer.apply_damage(10, BRUTE, affecting, rammer.run_armor_check(affecting, MELEE), wound_bonus = 2, sharpness = SHARP_POINTY)
				affecting.adjust_germ_level(100)
			if(rammer.get_chem_effect(CE_PAINKILLER) < 30)
				to_chat(rammer, span_userdanger("ЕБУЧИЕ КАКТУСЫ!"))
				rammer.agony_scream()
		else
			to_chat(rammer, span_meatymeat("[src] чуть не уколол меня!"))

/obj/structure/flora/ausbushes/cactus/examine(mob/user)
	. = ..()
	if(reagents.total_volume > 0)
		. += span_notice("Кактус не полностью высушен.")
	else
		. += span_notice("Кактус высушен.")

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
	if(W.sharpness)
		if(W.force >= 5)
			user.visible_message(span_notice("[user] срезает [src]."),span_notice("Я срезаю [src]."), span_hear("Я слышу рубку."))
			user.changeNext_move(W.attack_delay)
			user.adjustFatigueLoss(5)
			sound_hint()
			W.damageItem("SOFT")
			deconstruct(FALSE)

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
	name = "Игла Кактуса"
	desc = "Наверное, можно... Уколоть кого-нибудь?"
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
	attack_verb_continuous = list("тыкает", "иголит", "укалывает")
	attack_verb_simple = list("тыкать", "иголить", "укалывать")

/obj/structure/flora/ausbushes/granat
	name = "Гранат"
	desc = "Прекрасный фрукт, чудом сохранивший свою пользу."
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
	user.visible_message(span_notice("[user] отрывает от [src] кусок."),span_notice("Я отрываю от [src] кусок."), span_hear("Я слышу собирание."))
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
	name = "Каотическая Машина"
	desc = "ПОКУПКА СНАРЯГИ!"
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
			var/thing = input(user, "Чего я хочу?", "Я хочу...") as null|anything in list("Холодное оружие", "Огнестрельное оружие", "Броня", "Другое")
			if(!thing)
				return
			if(thing == "Холодное оружие")
				melee_find(user)
			if(thing == "Огнестрельное оружие")
				guns_find(user)
			if(thing == "Броня")
				armor_find(user)
			if(thing == "Амуниция")
				ammo_find(user)
			if(thing == "Другое")
				other_find(user)

/obj/structure/kaotikmachine/proc/melee_find(mob/living/carbon/human/user)
	var/list/meleelist = list("Меч (40)", "Копьё (40)", "Баклер (20)", "Молоток (30)", "Цеп (40)")
	var/thingy = input(user, "Что за оружие я хочу?", "Я хочу...") as null|anything in sort_list(meleelist)
	var/datum/preferences/pref_source = user.client?.prefs
	if(!thingy)
		return
	if(get_dist(src, user) >= 2)
		return
	if((!pref_source.bobux_amount) || (pref_source.bobux_amount <= 0))
		to_chat(user, span_meatymeat("Нужны каотики!"))
		return
	switch(thingy)
		if("Меч (40)")
			if(pref_source.bobux_amount < 40)
				to_chat(user, span_meatymeat("Нужны каотики!"))
				return
			new /obj/item/podpol_weapon/sword/steel(get_turf(user))
			pref_source.bobux_amount -= 40
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 100 , FALSE, FALSE)
			to_chat(user, span_meatymeat("Покупка сделана!"))
		if("Копьё (40)")
			if(pref_source.bobux_amount < 40)
				to_chat(user, span_meatymeat("Нужны каотики!"))
				return
			new /obj/item/podpol_weapon/spear/wooden(get_turf(user))
			pref_source.bobux_amount -= 40
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 100 , FALSE, FALSE)
			to_chat(user, span_meatymeat("Покупка сделана!"))
		if("Баклер (20)")
			if(pref_source.bobux_amount < 20)
				to_chat(user, span_meatymeat("Нужны каотики!"))
				return
			new /obj/item/melee/shieldo/buckler/wooden(get_turf(user))
			pref_source.bobux_amount -= 20
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 100 , FALSE, FALSE)
			to_chat(user, span_meatymeat("Покупка сделана!"))
		if("Молоток (30)")
			if(pref_source.bobux_amount < 30)
				to_chat(user, span_meatymeat("Нужны каотики!"))
				return
			new /obj/item/melee/bita/hammer/heavy(get_turf(user))
			pref_source.bobux_amount -= 30
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 100 , FALSE, FALSE)
			to_chat(user, span_meatymeat("Покупка сделана!"))
		if("Цеп (40)")
			if(pref_source.bobux_amount < 40)
				to_chat(user, span_meatymeat("Нужны каотики!"))
				return
			new /obj/item/melee/bita/cep/iron(get_turf(user))
			pref_source.bobux_amount -= 40
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 100 , FALSE, FALSE)
			to_chat(user, span_meatymeat("Покупка сделана!"))
		else
			return

/obj/structure/kaotikmachine/proc/guns_find(mob/living/carbon/user)
	var/list/gunslist = list("Бобокс (80)", "Револьвер Нова (70)", "Винтовка СВД (100)")
	var/thingy = input(user, "Что за оружие я хочу?", "Я хочу...") as null|anything in sort_list(gunslist)
	var/datum/preferences/pref_source = user.client?.prefs
	if(!thingy)
		return
	if(get_dist(src, user) >= 2)
		return
	if((!pref_source.bobux_amount) || (pref_source.bobux_amount <= 0))
		to_chat(user, span_meatymeat("Нужны каотики!"))
		return
	if(GLOB.world_deaths_crazy < 30)
		to_chat(user, span_meatymeat("Недостаточно смертей в мире!"))
		return
	switch(thingy)
		if("Бобокс (80)")
			if(pref_source.bobux_amount < 80)
				to_chat(user, span_meatymeat("Нужны каотики!"))
				return
			new /obj/item/gun/ballistic/shotgun/doublebarrel/bobox(get_turf(user))
			pref_source.bobux_amount -= 80
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 100 , FALSE, FALSE)
			to_chat(user, span_meatymeat("Покупка сделана!"))
		if("Револьвер Нова (70)")
			if(pref_source.bobux_amount < 70)
				to_chat(user, span_meatymeat("Нужны каотики!"))
				return
			new /obj/item/gun/ballistic/revolver/remis/nova(get_turf(user))
			pref_source.bobux_amount -= 70
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 100 , FALSE, FALSE)
			to_chat(user, span_meatymeat("Покупка сделана!"))
		if("Винтовка СВД (100)")
			if(pref_source.bobux_amount < 100)
				to_chat(user, span_meatymeat("Нужны каотики!"))
				return
			new /obj/item/gun/ballistic/automatic/remis/svd(get_turf(user))
			pref_source.bobux_amount -= 100
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 100 , FALSE, FALSE)
			to_chat(user, span_meatymeat("Покупка сделана!"))
		else
			return

/obj/structure/kaotikmachine/proc/armor_find(mob/living/carbon/user)
	var/list/otherlist = list("Лёгкий Бронежилет (50)", "Кольчуга (50)", "Перчатки (30)", "Баллистическая Маска (40)")
	var/thingy = input(user, "Что за броню я хочу?", "Я хочу...") as null|anything in sort_list(otherlist)
	var/datum/preferences/pref_source = user.client?.prefs
	if(!thingy)
		return
	if(get_dist(src, user) >= 2)
		return
	if((!pref_source.bobux_amount) || (pref_source.bobux_amount <= 0))
		to_chat(user, span_meatymeat("Нужны каотики!"))
		return
	if(GLOB.world_deaths_crazy < 20)
		to_chat(user, span_meatymeat("Недостаточно смертей в мире!"))
		return
	switch(thingy)
		if("Лёгкий Бронежилет (50)")
			if(pref_source.bobux_amount < 50)
				to_chat(user, span_meatymeat("Нужны каотики!"))
				return
			new /obj/item/clothing/suit/armor/vest/bulletproofer(get_turf(user))
			pref_source.bobux_amount -= 50
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 100 , FALSE, FALSE)
			to_chat(user, span_meatymeat("Покупка сделана!"))
		if("Кольчуга (50)")
			if(pref_source.bobux_amount < 50)
				to_chat(user, span_meatymeat("Нужны каотики!"))
				return
			new /obj/item/clothing/suit/armor/vest/chainmail/steel(get_turf(user))
			pref_source.bobux_amount -= 50
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 100 , FALSE, FALSE)
			to_chat(user, span_meatymeat("Покупка сделана!"))
		if("Перчатки (30)")
			if(pref_source.bobux_amount < 30)
				to_chat(user, span_meatymeat("Нужны каотики!"))
				return
			new /obj/item/clothing/gloves/thickleather(get_turf(user))
			pref_source.bobux_amount -= 30
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 100 , FALSE, FALSE)
			to_chat(user, span_meatymeat("Покупка сделана!"))
		if("Баллистическая Маска (40)")
			if(pref_source.bobux_amount < 40)
				to_chat(user, span_meatymeat("Нужны каотики!"))
				return
			new /obj/item/clothing/mask/gas/ballisticarmor(get_turf(user))
			pref_source.bobux_amount -= 40
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 100 , FALSE, FALSE)
			to_chat(user, span_meatymeat("Покупка сделана!"))
		else
			return

/obj/structure/kaotikmachine/proc/ammo_find(mob/living/carbon/user)
	var/list/otherlist = list("2 Картечи (20)")
	var/thingy = input(user, "Что за амуницию я хочу?", "Я хочу...") as null|anything in sort_list(otherlist)
	var/datum/preferences/pref_source = user.client?.prefs
	if(!thingy)
		return
	if(get_dist(src, user) >= 2)
		return
	if((!pref_source.bobux_amount) || (pref_source.bobux_amount <= 0))
		to_chat(user, span_meatymeat("Нужны каотики!"))
		return
/*
	if(GLOB.world_deaths_crazy < 15)
		to_chat(user, span_meatymeat("Недостаточно смертей в мире!"))
		return
*/
	switch(thingy)
		if("2 Картечи (20)")
			if(pref_source.bobux_amount < 20)
				to_chat(user, span_meatymeat("Нужны каотики!"))
				return
			new /obj/item/ammo_box/magazine/ammo_stack/shotgun/buckshot/notfull/loaded(get_turf(user))
			pref_source.bobux_amount -= 20
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 100 , FALSE, FALSE)
			to_chat(user, span_meatymeat("Покупка сделана!"))
		else
			return

/obj/structure/kaotikmachine/proc/other_find(mob/living/carbon/user)
	var/list/otherlist = list("Осколочная Граната (70)", "Газовая Граната (50)", "Кирка (50)", "Установщик Проволоки (40)", "Установщик Мины (80)", "Установщик Нажимной Мины (70)")
	var/thingy = input(user, "Что за штуку я хочу?", "Я хочу...") as null|anything in sort_list(otherlist)
	var/datum/preferences/pref_source = user.client?.prefs
	if(!thingy)
		return
	if(get_dist(src, user) >= 2)
		return
	if((!pref_source.bobux_amount) || (pref_source.bobux_amount <= 0))
		to_chat(user, span_meatymeat("Нужны каотики!"))
		return
	if(GLOB.world_deaths_crazy < 15)
		to_chat(user, span_meatymeat("Недостаточно смертей в мире!"))
		return
	switch(thingy)
		if("Осколочная Граната (70)")
			if(pref_source.bobux_amount < 70)
				to_chat(user, span_meatymeat("Нужны каотики!"))
				return
			new /obj/item/grenade/frag(get_turf(user))
			pref_source.bobux_amount -= 70
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 100 , FALSE, FALSE)
			to_chat(user, span_meatymeat("Покупка сделана!"))
		if("Газовая Граната (50)")
			if(pref_source.bobux_amount < 50)
				to_chat(user, span_meatymeat("Нужны каотики!"))
				return
			new /obj/item/grenade/gas/incredible_gas(get_turf(user))
			pref_source.bobux_amount -= 50
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 100 , FALSE, FALSE)
			to_chat(user, span_meatymeat("Покупка сделана!"))
		if("Кирка (50)")
			if(pref_source.bobux_amount < 50)
				to_chat(user, span_meatymeat("Нужны каотики!"))
				return
			new /obj/item/melee/hehe/pickaxe/iron(get_turf(user))
			pref_source.bobux_amount -= 50
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 100 , FALSE, FALSE)
			to_chat(user, span_meatymeat("Покупка сделана!"))
		if("Установщик Проволоки (40)")
			if(pref_source.bobux_amount < 40)
				to_chat(user, span_meatymeat("Нужны каотики!"))
				return
			new /obj/item/barbsetup(get_turf(user))
			pref_source.bobux_amount -= 40
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 100 , FALSE, FALSE)
			to_chat(user, span_meatymeat("Покупка сделана!"))
		if("Установщик Мины (80)")
			if(pref_source.bobux_amount < 80)
				to_chat(user, span_meatymeat("Нужны каотики!"))
				return
			new /obj/item/minesetup(get_turf(user))
			pref_source.bobux_amount -= 80
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 100 , FALSE, FALSE)
			to_chat(user, span_meatymeat("Покупка сделана!"))
		if("Установщик Нажимной Мины (70)")
			if(pref_source.bobux_amount < 70)
				to_chat(user, span_meatymeat("Нужны каотики!"))
				return
			new /obj/item/minesetuplita(get_turf(user))
			pref_source.bobux_amount -= 70
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 100 , FALSE, FALSE)
			to_chat(user, span_meatymeat("Покупка сделана!"))
		else
			return

/obj/structure/kaos/blackwindow
	name = "Чёрное Зеркало"
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
	name = "Опа"
	desc = "Нельзя дальше."
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
	allow_role = "Конченный"

/obj/structure/sign/poster/contraband/codec/lians
	name = "Карза"
	desc = "Сколько жизней спасла..."
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

/obj/structure/medica
	name = "Медика"
	desc = "Чтобы Медика вылечила меня, достаточно всего лишь..."
	icon = 'modular_pod/icons/obj/things/things_3.dmi'
	icon_state = "medica"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	anchored = 1
	density = 0
	obj_flags = NONE
	light_range = 3
	light_power = 2
	light_color = "#75a743"

/obj/structure/medica/attackby(obj/item/W, mob/living/carbon/user, params)
	return

/obj/structure/medica/attack_hand(mob/living/carbon/human/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(do_after(user, 2 SECONDS, target=src))
		to_chat(user, span_meatymeat("Я ощущаю какой-то пиздец!"))
		user.fully_heal(TRUE)

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
	name = "Колючая Проволока"
	desc = "НЕ ЛЕЗЬ."
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
		C.visible_message(span_meatymeat("[C] ранится об [src]!"),span_meatymeat("Я ранюсь об [src]!"), span_hear("Я слышу звуки плоти."))
		C.apply_damage(10, BRUTE, affecting, C.run_armor_check(affecting, MELEE), wound_bonus = 5, sharpness = SHARP_EDGED)
		affecting.adjust_germ_level(50)
		playsound(get_turf(src), 'modular_septic/sound/weapons/melee/sharpy1.ogg', 100 , FALSE, FALSE)

/obj/structure/barbwire/proc/on_uncrossed(datum/source, atom/movable/gone, direction)
	SIGNAL_HANDLER
	if(ishuman(gone))
		var/mob/living/carbon/human/H = gone
		if(prob(50))
			H.visible_message(span_meatymeat("[H] пытается вырваться из [src]!"))
			var/obj/item/bodypart/affecting = H.get_bodypart_nostump(ran_zone(BODY_ZONE_CHEST, 50))
			H.apply_damage(10, BRUTE, affecting, H.run_armor_check(affecting, MELEE), wound_bonus = 5, sharpness = SHARP_EDGED)
			affecting.adjust_germ_level(50)
			return COMPONENT_ATOM_BLOCK_EXIT
		else
			H.visible_message(span_meatymeat("[H] вырывается из [src]!"))
			return

/obj/item/barbsetup
	name = "Установщик"
	desc = "Таким вот можно установить проволоку."
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
	attack_verb_continuous = list("бьёт")
	attack_verb_simple = list("бить")
	var/zaryad = 3

/obj/item/detonatormine
	name = "Детонатор"
	desc = "Для моей мины."
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
	attack_verb_continuous = list("бьёт")
	attack_verb_simple = list("бить")
	var/id_detonator = null

/obj/item/detonatormine/attack_self(mob/user)
	. = ..()
	if(.)
		return
	if(id_detonator)
		user.visible_message(span_meatymeat("[user] нажимает на [src]."))
		user.changeNext_move(CLICK_CD_MELEE)
		for(var/obj/structure/mineexplosive/M in world)
			if(M.mineid != src.id_detonator)
				continue
			INVOKE_ASYNC(M, TYPE_PROC_REF(/obj/structure/mineexplosive/, detonate))
//			INVOKE_ASYNC(M, /obj/structure/mineexplosive.proc/detonate)

/obj/item/minesetup
	name = "Установщик Мины"
	desc = "Ещё нужен детонатор. Он, вроде как, внутри."
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
	attack_verb_continuous = list("бьёт")
	attack_verb_simple = list("бить")
	var/install_mine = /obj/structure/mineexplosive/based
	var/detonator = 1
	var/id_mine = null

/obj/item/minesetup/attack_self(mob/user)
	. = ..()
	if(.)
		return
	if(!detonator)
		to_chat(user, span_danger("Нет детонатора внутри!"))
		user.playsound_local(get_turf(user), 'modular_pod/sound/eff/difficult1.ogg', 15, FALSE)
		return
	GLOB.minenew += 1
	var/obj/item/detonatormine/detonatorr = new /obj/item/detonatormine(get_turf(user))
	user.put_in_hands(detonatorr)
	detonator--
	var/idd = GLOB.minenew
	id_mine = idd
	detonatorr.id_detonator = id_mine
	to_chat(user, span_notice("Я достаю детонатор."))
	user.changeNext_move(CLICK_CD_MELEE)

/obj/item/minesetuplita
	name = "Установщик Мины"
	desc = "После установки, на такую будет достаточно наступить."
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
	attack_verb_continuous = list("бьёт")
	attack_verb_simple = list("бить")
	var/install_mine = /obj/structure/mineexplosive/mineplit

/obj/structure/mineexplosive
	name = "Установленная Мина"
	desc = "НЕ ЛЕЗЬ."
	icon = 'modular_pod/icons/obj/things/things_3.dmi'
	icon_state = "installed"
	density = FALSE
	anchored = TRUE
	opacity = FALSE
	istrap = TRUE
	var/mineid = null
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

/obj/structure/mineexplosive/attackby(obj/item/W, mob/living/carbon/user, params)
	return

/obj/structure/mineexplosive/proc/detonate(mob/living/lanced_by)
	if(shrapnel_type && shrapnel_radius && !shrapnel_initialized)
		shrapnel_initialized = TRUE
		AddComponent(/datum/component/pellet_cloud, projectile_type=shrapnel_type, magnitude=shrapnel_radius)
	SEND_SIGNAL(src, COMSIG_CRAZYMINE_TRIGGERED, lanced_by)
	if(ex_dev || ex_heavy || ex_light || ex_flame)
		var/turf/explosionturf = get_turf(src)
		explosionturf.pollute_turf(/datum/pollutant/dust, 350)
		explosion(src, ex_dev, ex_heavy, ex_light, ex_flame)
		if(!QDELETED(src))
			qdel(src)

/obj/structure/mineexplosive/based
	shrapnel_type = /obj/projectile/bullet/shrapnel/mine
	shrapnel_radius = 7
	ex_heavy = 3
	ex_light = 4
	ex_flame = 3

/obj/structure/mineexplosive/mineplit
	name = "Установленная Мина"
	desc = "НЕ ЛЕЗЬ."
	icon = 'modular_pod/icons/obj/things/things_3.dmi'
	icon_state = "mineplit"
	density = FALSE
	anchored = TRUE
	opacity = FALSE
	istrap = TRUE
	shrapnel_type = /obj/projectile/bullet/shrapnel/mine
	shrapnel_radius = 7
	ex_heavy = 4
	ex_light = 2
	ex_flame = 3

/obj/structure/mineexplosive/mineplit/ComponentInitialize()
	. = ..()
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(detonated),
	)
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/structure/mineexplosive/mineplit/attackby(obj/item/W, mob/living/carbon/user, params)
	return

/obj/structure/mineexplosive/mineplit/proc/detonated(mob/living/lanced_by)
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
