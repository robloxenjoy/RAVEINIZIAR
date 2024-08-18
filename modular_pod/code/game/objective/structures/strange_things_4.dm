/obj/structure/stalag
	name = "Stalagmite"
	desc = "Oh, it's in the way."
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
			user.visible_message(span_notice("[user] digs [src] with [W]."),span_notice("I dig [src] with [W]."), span_hear("I hear digging."))
			user.changeNext_move(W.attack_delay)
			user.adjustFatigueLoss(5)
			W.damageItem(5)
			playsound(get_turf(src), 'modular_pod/sound/eff/hitwallpick.ogg', 90 , FALSE, FALSE)
			user.sound_hint()
			mine_hp -= 1
			var/diceroll = user.diceroll(GET_MOB_SKILL_VALUE(user, SKILL_MASONRY), context = DICE_CONTEXT_PHYSICAL)
			if(diceroll >= DICE_SUCCESS)
				user.visible_message(span_notice("[user] mines ore."),span_notice("Я добываю руду."), span_hear("I hear digging."))
				new ore_type(get_turf(user), ore_amount)
				user.client.prefs.adjust_bobux(1, "<span class='bobux'>I mine ore! +1 Kaotik!</span>")
				user.flash_kaosgain()
	else
		if(W.can_dig)
			user.visible_message(span_notice("[user] ruins [src] with [W]."),span_notice("I ruin [src] with [W]."), span_hear("I hear digging."))
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
	name = "Jelly"
	desc = "Smells."
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
		rammer.visible_message(span_notice("[rammer] leans against [src]."),span_notice("I lean against [src]."), span_hear("I hear something."))
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
	user.visible_message(span_notice("[user] hits [src]."),span_notice("I hit [src]."), span_hear("I hear something."))
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
	user.visible_message(span_notice("[user] hits [src]."),span_notice("I hit [src]."), span_hear("I hear something."))
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
	name = "Baby"
	desc = "Do not hurt!"
	icon = 'modular_pod/icons/obj/things/things_2.dmi'
	icon_state = "worm"
	density = TRUE
	anchored = TRUE
	var/hide = FALSE
	var/hpp = 5
	var/last_words = 0
	var/words_delay = 2000
	var/words_list = list("Do not hit me!", "I know how to hide from mom and dad.", "I can teach you how to hide from mom and dad!")

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
		user.visible_message(span_notice("[user] feeds [src] with [I]."),span_notice("I feed [src] with [I]."), span_hear("I hear strange things."))
		if(do_after(user, 5 SECONDS, target = src))
			to_chat(user, span_notice("I feed [src] with [I]."))
			sound_hint()
			playsound(get_turf(src), 'modular_pod/sound/eff/eat.ogg', 100 , FALSE, FALSE)
			user.alpha = 50
			var/thankyou_words = pick("So tasty. How do you know this is my favorite fruit?", "I love this fruit.")
			speak(thankyou_words)
			qdel(I)
	else
		if(hpp > 0)
			hpp--
			var/bad_words = pick("DO NOT HIT ME!", "NO PLEASE!")
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

/obj/structure/beast/goat
	name = "Goat"
	desc = "..."
	icon = 'modular_pod/icons/obj/things/things_2.dmi'
	icon_state = "goat"
	density = TRUE
	anchored = TRUE
	var/hpp = 5
	var/soon = 20
	var/soundss = list('modular_septic/sound/sexo/bj1.ogg', \
				'modular_septic/sound/sexo/bj2.ogg', \
				'modular_septic/sound/sexo/bj3.ogg', \
				'modular_septic/sound/sexo/bj4.ogg', \
				'modular_septic/sound/sexo/bj5.ogg', \
				'modular_septic/sound/sexo/bj6.ogg', \
				'modular_septic/sound/sexo/bj7.ogg', \
				'modular_septic/sound/sexo/bj8.ogg', \
				'modular_septic/sound/sexo/bj9.ogg', \
				'modular_septic/sound/sexo/bj10.ogg', \
				'modular_septic/sound/sexo/bj11.ogg', \
				'modular_septic/sound/sexo/bj12.ogg', \
				'modular_septic/sound/sexo/bj13.ogg')

/obj/structure/beast/goat/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	switch(damage_type)
		if(BRUTE)
			if(damage_amount)
				playsound(src, 'sound/effects/attackblob.ogg', 100, TRUE)
			else
				playsound(src, 'sound/weapons/tap.ogg', 50, TRUE)
		if(BURN)
			if(damage_amount)
				playsound(src, 'sound/items/welder.ogg', 100, TRUE)

/obj/structure/beast/goat/attackby(obj/item/I, mob/living/user, params)
	if(I.force > 8)
		user.changeNext_move(I.attack_delay)
		playsound(src, 'modular_pod/sound/mobs_yes/paingoat.ogg', 100, TRUE)
		user.client?.prefs?.adjust_bobux(-100, "<span class='bobux'>Don't touch him! -100 Kaotiks!</span>")
		user.adjustFatigueLoss(5)
		I.damageItem(5)
		sound_hint()

/obj/structure/beast/goat/attack_jaw(mob/living/carbon/human/user, list/modifiers)
	. = ..()
	if(.)
		return
	var/obj/item/bodypart/check_jaw = user.get_bodypart(BODY_ZONE_PRECISE_MOUTH)
	if(!check_jaw)
		to_chat(user, span_notice("I don't have a jaw..."))
		return
	if(check_jaw?.bodypart_disabled)
		to_chat(user, span_warning("My [check_jaw.name] unable to be used."))
		return
	if(user.zone_selected == BODY_ZONE_PRECISE_GROIN)
		if(soon <= 0)
			playsound(src, 'modular_pod/sound/voice/goat.ogg', 100, TRUE)
			src.visible_message(span_love("[src] puts something in [user]'s mouth!"))
			soon = rand(15, 29)
			user.AddComponent(/datum/component/creamed/cum)
			sound_hint()
		else
			playsound(src, pick(soundss), 80, TRUE)
			user.visible_message(span_love("[user] does something for [src]."),span_love("I do something for [src]."), span_hear("I hear strange things."))
			INVOKE_ASYNC(user, TYPE_PROC_REF(/mob/, do_fucking_animation), get_dir(user, src))
			sound_hint()
			soon--
		user.changeNext_move(8)
		if(!user.block_belief)
			if(user.belief_progress < 30)
				user.belief_progress += 1
			else
				user.block_belief = TRUE
				user.client?.prefs?.adjust_bobux(10, "<span class='bobux'>I have improved my relationship with God! +10 Kaotiks!</span>")
				var/gift = pick("Nothing", "Pistol")
				to_chat(user, span_notice("I got what I wanted... [gift]!"))
				switch(gift)
					if("Pistol")
						new /obj/item/gun/ballistic/automatic/pistol/remis/ppk(get_turf(user))

/obj/structure/flager/prison
	name = "Flag"
	desc = "Prison flag. The ribcage is shown here."
	icon = 'modular_pod/icons/obj/things/things_5.dmi'
	icon_state = "prison"
	max_integrity = 1000
	layer = FLY_LAYER
	density = TRUE
	anchored = TRUE
	opacity = FALSE
	var/proj_pass_rate = 100

/obj/structure/flager/prison/CanAllowThrough(atom/movable/mover, border_dir)
	. = ..()
	if(locate(/obj/structure/flager/prison) in get_turf(mover))
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
