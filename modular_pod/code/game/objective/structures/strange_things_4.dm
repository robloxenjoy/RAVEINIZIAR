/obj/structure/stalag
	name = "Сталагмит"
	desc = "Ой, мешает."
	icon = 'modular_pod/icons/obj/things/things_3.dmi'
	icon_state = "stalag1"
	density = TRUE
	anchored = TRUE
	opacity = FALSE
	pass_flags_self = LETPASSTHROW|PASSSTRUCTURE
	var/mine_hp = 1
	var/ore_type = /obj/item/stone
	var/ore_amount = 1
	var/proj_pass_rate = 100

/obj/structure/stalag/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/climbable)
	icon_state = "stalag[rand(1, 2)]"

/obj/structure/stalag/attackby(obj/item/W, mob/living/carbon/user, params)
	if(mine_hp > 0)
		if(W.can_dig)
			user.visible_message(span_notice("[user] копает [src] с помощью [W]."),span_notice("Я копаю [src] с помощью [W]."), span_hear("Я слышу звуки раскопок."))
			user.changeNext_move(W.attack_delay)
			user.adjustFatigueLoss(5)
			W.damageItem(5)
			playsound(get_turf(src), 'modular_pod/sound/eff/hitwallpick.ogg', 90 , FALSE, FALSE)
			user.sound_hint()
			mine_hp -= 1
			var/diceroll = user.diceroll(GET_MOB_SKILL_VALUE(user, SKILL_MASONRY), context = DICE_CONTEXT_PHYSICAL)
			if(diceroll >= DICE_SUCCESS)
				user.visible_message(span_notice("[user] добывает руду."),span_notice("Я добываю руду."), span_hear("Я слышу звуки раскопок."))
				new ore_type(get_turf(user), ore_amount)
				user.client.prefs.adjust_bobux(1, "<span class='bobux'>Я добыл руду! +1 Каотик!</span>")
				user.flash_kaosgain()
	else
		if(W.can_dig)
			user.visible_message(span_notice("[user] разрушает [src] с помощью [W]."),span_notice("Я разрушаю [src] с помощью [W]."), span_hear("Я слышу звуки раскопок."))
			user.changeNext_move(W.attack_delay)
			user.adjustFatigueLoss(5)
			W.damageItem(5)
			playsound(src, 'sound/effects/break_stone.ogg', 50, TRUE)
			user.sound_hint()
			deconstruct(FALSE)

/obj/structure/stalag/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		new ore_type(get_turf(src), ore_amount)
		playsound(get_turf(src), 'modular_pod/sound/eff/hitwallpick.ogg', 90 , FALSE, FALSE)
	qdel(src)

/obj/structure/stalag/CanAllowThrough(atom/movable/mover, border_dir)
	. = ..()
	if(locate(/obj/structure/stalag) in get_turf(mover))
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

/obj/structure/gelatine/smelly
	name = "Желе"
	desc = "Воняет."
	icon = 'modular_pod/icons/obj/things/things_3.dmi'
	icon_state = "jelly"
	density = TRUE
	anchored = TRUE
	opacity = FALSE
//	layer = FLY_LAYER
	pass_flags_self = LETPASSTHROW|PASSSTRUCTURE
	var/ready_smell = TRUE
	var/smell_type = /datum/pollutant/blues
	var/smell_amount = 30
	var/proj_pass_rate = 100

/obj/structure/gelatine/smelly/Initialize()
	. = ..()
	AddElement(/datum/element/climbable)
	if(prob(50))
		smell_type = /datum/pollutant/blues
	else
		smell_type = /datum/pollutant/redoz

/obj/structure/gelatine/smelly/on_density(mob/living/carbon/human/rammer)
	if(ready_smell)
		rammer.visible_message(span_notice("[rammer] прислоняется к [src]."),span_notice("Я прислоняюсь к [src]."), span_hear("Я слышу чё-то."))
		sound_hint()
		var/turf/my_turf = get_turf(src)
		my_turf.pollute_turf(smell_type, smell_amount)
		ready_smell = FALSE
		addtimer(CALLBACK(src, PROC_REF(readyagain), 15 SECONDS))
		playsound(loc,'modular_pod/sound/eff/incrementum.ogg', 30, TRUE)

/obj/structure/gelatine/smelly/proc/readyagain()
	if(QDELETED(src) || ready_smell)
		return
	ready_smell = TRUE

/obj/structure/gelatine/smelly/attackby(obj/item/W, mob/living/carbon/user, params)
	user.visible_message(span_notice("[user] стукает [src]."),span_notice("Я стукаю [src]."), span_hear("Я слышу чё-то."))
	user.changeNext_move(W.attack_delay)
	user.adjustFatigueLoss(5)
	sound_hint()
	playsound(loc,'modular_pod/sound/eff/incrementum.ogg', 30, TRUE)
	if(ready_smell)
		var/turf/my_turf = get_turf(src)
		my_turf.pollute_turf(smell_type, smell_amount)
		ready_smell = FALSE
		addtimer(CALLBACK(src, PROC_REF(readyagain), 15 SECONDS))

/obj/structure/gelatine/smelly/attack_hand(mob/living/carbon/human/user, list/modifiers)
	. = ..()
	if(.)
		return
	user.visible_message(span_notice("[user] стукает [src]."),span_notice("Я стукаю [src]."), span_hear("Я слышу чё-то."))
	user.changeNext_move(10)
	user.adjustFatigueLoss(5)
	sound_hint()
	playsound(loc,'modular_pod/sound/eff/incrementum.ogg', 30, TRUE)
	if(ready_smell)
		var/turf/my_turf = get_turf(src)
		my_turf.pollute_turf(smell_type, smell_amount)
		ready_smell = FALSE
		addtimer(CALLBACK(src, PROC_REF(readyagain), 15 SECONDS))

/obj/structure/gelatine/smelly/CanAllowThrough(atom/movable/mover, border_dir)
	. = ..()
	if(locate(/obj/structure/gelatine/smelly) in get_turf(mover))
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

/obj/structure/beast/worm
	name = "Малыш"
	desc = "Не обижай!"
	icon = 'modular_pod/icons/obj/things/things_2.dmi'
	icon_state = "worm"
	density = TRUE
	anchored = TRUE
	var/hide = FALSE
	var/hpp = 5
	var/last_words = 0
	var/words_delay = 2000
	var/words_list = list("Не бей!", "Я умею прятаться от мамы и папы.", "Могу научить прятаться от папы и мамы!")

/obj/structure/beast/worm/proc/speak(message)
	say(message)

/obj/structure/beast/worm/Initialize()
	. = ..()
	if(last_words + words_delay <= world.time && prob(50))
		var/words = pick(words_list)
		speak(words)
		sound_hint()
		playsound(src, 'modular_pod/sound/eff/good_voice.ogg', 55, FALSE)
		last_words = world.time

/obj/structure/beast/worm/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/food/grown/granat))
		user.visible_message(span_notice("[user] кормит [src] с помощью [I]."),span_notice("Я кормлю [src] с помощью [I]."), span_hear("Я слышу странности."))
		if(do_after(user, 5 SECONDS, target = src))
			to_chat(user, span_notice("Я накормил [src] с помощью [I]."))
			sound_hint()
			playsound(get_turf(src), 'modular_pod/sound/eff/eat.ogg', 100 , FALSE, FALSE)
			user.alpha = 50
			var/thankyou_words = pick("Как вкусно. Откуда ты знаешь, что это мой любимый фрукт?", "Люблю этот гранат.")
			speak(thankyou_words)
			qdel(I)
	else
		if(hpp > 0)
			hpp--
			var/bad_words = pick("НЕ ОБИЖАЙ!", "НЕ БЕЙ!")
			speak(bad_words)
			playsound(get_turf(src), 'modular_pod/sound/eff/babycry.ogg', 100 , FALSE, FALSE)
//			user.overlay_fullscreen("childy", /atom/movable/screen/fullscreen/childy, 1)
//			addtimer(CALLBACK(user, TYPE_PROC_REF(/mob/, clear_fullscreen), "childy"), 3 SECONDS)
		else
			alpha = 0

/obj/structure/beast/worm/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	switch(damage_type)
		if(BRUTE)
			if(damage_amount)
				playsound(src, 'sound/effects/attackblob.ogg', 100, TRUE)
			else
				playsound(src, 'sound/weapons/tap.ogg', 50, TRUE)
		if(BURN)
			if(damage_amount)
				playsound(src, 'sound/items/welder.ogg', 100, TRUE)
/*
/obj/structure/beast/worm/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		new /obj/effect/decal/cleanable/spacespot(get_turf(src))
		playsound(src,'modular_pod/sound/eff/death.ogg', 50, TRUE)
	qdel(src)
*/
