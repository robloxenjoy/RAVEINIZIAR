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

/obj/structure/stalag/Initialize(mapload)
	. = ..()
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
	var/smell_amount = 15

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
