/turf/open/floor
	var/special_floor = FALSE

/turf/open/floor/proc/special_thing()
	return

/turf/open/floor/plating/polovich
	name = "Violet Floor"
	desc = "This is cool."
	icon_state = "leaner"
	icon = 'modular_pod/icons/turf/floors.dmi'
	attachment_holes = FALSE
	footstep = FOOTSTEP_METAL
	barefootstep = FOOTSTEP_METAL
	clawfootstep = FOOTSTEP_METAL
	heavyfootstep = FOOTSTEP_METAL
	baseturfs = /turf/open/floor/plating/polovich/dirt/blueee

/*
/turf/open/floor/plating/polovich/setup_broken_states()
	return list("damaged1", "damaged2", "damaged3", "damaged4", "damaged5")

/turf/open/floor/plating/polovich/setup_burnt_states()
	return list("floorscorched1", "floorscorched2")
*/

/turf/open/floor/plating/polovich/burn_tile()
	return

/turf/open/floor/plating/polovich/break_tile()
	return
/*
/turf/open/alt_click_secondary(mob/user)
	return look_into_distance(src, params)
*/
/turf/open/floor/attack_hand(mob/living/carbon/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(user.a_intent == INTENT_HELP)
		user.visible_message(span_notice("[user] трогает [src]."),span_notice("Я трогаю [src]."), span_hear("Я слышу чё-то."))
//		user.visible_message("<span class='notice'>\[user] трогает [src].</span>")
		user.changeNext_move(CLICK_CD_WRENCH)
	if(user.a_intent == INTENT_GRAB)
		if(!special_floor)
			user.visible_message(span_notice("[user] размахивает рукой."),span_notice("Я размахиваю рукой."), span_hear("Я слышу чё-то."))
//		user.visible_message("<span class='notice'>\[user] touches the [src].</span>")
			user.changeNext_move(CLICK_CD_WRENCH)
			playsound(get_turf(src), 'modular_pod/sound/eff/swing_small.ogg', 90 , FALSE, FALSE)
			user.adjustFatigueLoss(5)
			sound_hint()
		else
			special_thing(user)
	if((user.a_intent == INTENT_HARM) || (user.a_intent == INTENT_DISARM))
		user.visible_message(span_notice("[user] бьёт [src] рукой."),span_notice("Я бью [src] рукой."), span_hear("Я слышу стук."))
//		user.visible_message("<span class='notice'>\[user] beats the [src].</span>")
		user.changeNext_move(CLICK_CD_MELEE)
		user.adjustFatigueLoss(5)
		playsound(get_turf(src), 'sound/effects/beatfloorhand.ogg', 80 , FALSE, FALSE)
		sound_hint()

/turf/open/floor/attack_hand_secondary(mob/living/carbon/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(user.a_intent == INTENT_HELP)
		user.visible_message(span_notice("[user] трогает [src]."),span_notice("Я трогаю [src]."), span_hear("Я слышу чё-то."))
//		user.visible_message("<span class='notice'>\[user] touches the [src].</span>")
		user.changeNext_move(CLICK_CD_WRENCH)
	if(user.a_intent == INTENT_GRAB)
		user.visible_message(span_notice("[user] размахивает рукой."),span_notice("Я размахиваю рукой."), span_hear("Я слышу чё-то."))
//		user.visible_message("<span class='notice'>\[user] touches the [src].</span>")
		user.changeNext_move(CLICK_CD_WRENCH)
		playsound(get_turf(src), 'modular_pod/sound/eff/swing_small.ogg', 90 , FALSE, FALSE)
	if((user.a_intent == INTENT_HARM) || (user.a_intent == INTENT_DISARM))
		user.visible_message(span_notice("[user] бьёт [src] рукой."),span_notice("Я бью [src] рукой."), span_hear("Я слышу стук."))
//		user.visible_message("<span class='notice'>\[user] beats the [src].</span>")
		user.changeNext_move(CLICK_CD_MELEE)
		user.adjustFatigueLoss(5)
		playsound(get_turf(src), 'sound/effects/beatfloorhand.ogg', 80 , FALSE, FALSE)
		sound_hint()

/turf/open/floor/plating/polovich/attackby(obj/item/W, mob/living/carbon/user, params, list/modifiers)
	. = ..()
	if(.)
		return
	if(W.force)
		if(LAZYACCESS(modifiers, RIGHT_CLICK) && (user.combat_style == CS_GUARD))
			if(!do_after(user, 3 SECONDS, target=src))
				to_chat(user, span_danger(xbox_rage_msg()))
				user.playsound_local(get_turf(user), 'modular_pod/sound/eff/difficult1.ogg', 15, FALSE)
				return
	/*
			if(!combat_mode)
				to_chat(user, span_danger("Надо бы серьёзнее отнестись"))
				user.playsound_local(get_turf(user), 'modular_pod/sound/eff/difficult1.ogg', 15, FALSE)
				return
	*/
			var/datum/component/guard/existing_guard = user.GetComponent(/datum/component/guard)
			if(user.GetComponent(/datum/component/guard))
				existing_guard.cancel()

			user.AddComponent(/datum/component/guard, src, W)
			W.guard_ready = TRUE
		else
			if(W.get_sharpness())
				user.visible_message(span_notice("[user] размахивает с помощью [W]."),span_notice("Я размахиваю с помощью [W]."), span_hear("Я слышу взмах."))
				user.changeNext_move(W.attack_delay)
				user.adjustFatigueLoss(W.attack_fatigue_cost)
				sound_hint()
				if(W.force <= 16)
					playsound(get_turf(src), 'modular_pod/sound/eff/swing_small.ogg', 90 , FALSE, FALSE)
				else
					playsound(get_turf(src), 'modular_pod/sound/eff/swing_big.ogg', 90 , FALSE, FALSE)
			else
				user.visible_message(span_notice("[user] бьёт [src] с помощью [W]."),span_notice("Я бью [src] с помощью [W]."), span_hear("Я слышу стук."))
				user.changeNext_move(W.attack_delay)
				user.adjustFatigueLoss(W.attack_fatigue_cost)
				W.damageItem("SOFT")
				playsound(get_turf(src), 'sound/effects/slamflooritem.ogg', 90 , FALSE, FALSE)
				sound_hint()
/*
			if(istype(src, /turf/open/floor/plating/polovich/dirt/dark/bright))
				if(prob(W.force))
					var/turf/open/floor/plating/polovich/dirt/dark/bright/firefloor = src
					new /atom/movable/fire(firefloor, 21)
			if(istype(src, /turf/open/floor/plating/polovich/roots))
				if(do_after(user, 3 SECONDS, target=src))
					user.visible_message(span_notice("[user] sawed [src] with the [W]."),span_notice("You sawed [src] with the [W]."), span_hear("You hear the sound of a sawing."))
					user.changeNext_move(W.attack_delay)
					user.adjustFatigueLoss(W.attack_fatigue_cost)
					W.damageItem("HARD")
					sound_hint()
					playsound(get_turf(src), 'modular_septic/sound/effects/saw.ogg', 100 , FALSE, FALSE)
					var/turf/open/floor/plating/polovich/roots/noroots = src
					noroots.canstumble = FALSE

	if(istype(W, /obj/item/atrat))
		var/obj/item/atrat/atrat = W
		if(!atrat.usedy)
			new /atom/movable/fire(src, 21)
			atrat.usedy = TRUE
			addtimer(CALLBACK(atrat, .proc/restart_use), 50 SECONDS)
*/

/turf/open/floor/attack_jaw(mob/living/carbon/human/user, list/modifiers)
	. = ..()
	if(.)
		return
	var/turf/turf_loc = get_turf(src)
//	var/turf/turf_loc = loc
	if(get_dist(turf_loc?.liquids,user) <= 1)
		if(user.wear_mask && user.wear_mask.flags_cover & MASKCOVERSMOUTH)
			visible_message(user, span_warning("Что-то мешает мне пить!"))
			return
		var/datum/reagents/temporary_holder = turf_loc.liquids.take_reagents_flat(CHOKE_REAGENTS_INGEST_ON_BREATH_AMOUNT)
		temporary_holder.trans_to(src, temporary_holder.total_volume, methods = INGEST)
		qdel(temporary_holder)
		visible_message(span_notice("[user] пьёт жидкость."))
		playsound(user.loc, 'sound/items/drink.ogg', rand(10, 50), TRUE)
		return
	else
		user.visible_message(span_notice("[user] кусает [src]."),span_notice("Я кусаю [src]."), span_hear("Я слышу чё-то."))
		user.changeNext_move(CLICK_CD_BITE)
		user.adjustFatigueLoss(5)
		playsound(get_turf(src), 'sound/weapons/bite.ogg', 80 , FALSE, FALSE)
		sound_hint()

/turf/open/floor/attack_foot(mob/living/carbon/human/user, list/modifiers)
	. = ..()
	if(.)
		return
	user.visible_message(span_notice("[user] пинает [src]."),span_notice("Я пинаю [src]."), span_hear("Я слышу стук."))
	user.changeNext_move(CLICK_CD_MELEE)
	user.adjustFatigueLoss(10)
	playsound(get_turf(src), 'sound/effects/beatfloorhand.ogg', 80 , FALSE, FALSE)
	sound_hint()

/turf/open/floor/plating/polovich/get_projectile_hitsound(obj/projectile/projectile)
	return "modular_septic/sound/bullet/projectile_impact/ric_ground[rand(1,5)].ogg"

/turf/open/floor/plating/polovich/rotten_stones
	name = "Stone Floor"
	desc = "DARK!"
	icon_state = "STONINGHEHE"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/rotten_stones/sec
	icon_state = "stonealbino"

/turf/open/floor/plating/polovich/rotten_stones/sec/secc
	icon_state = "stonealbino1"

/turf/open/floor/plating/polovich/rotten_stones/sec/third
	icon_state = "ebanytiy"

/turf/open/floor/plating/polovich/rotten_stones/sec/third/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/rotten_stones/sec/four
	icon_state = "darkrockfloor"

/turf/open/floor/plating/polovich/rotten_stones/sec/five
	icon_state = "darkrockfloor2"
/*
/turf/open/floor/plating/polovich/rotten_stones/sec/six
	icon_state = "ebanytiy"
*/
/turf/open/floor/plating/polovich/rotten_stones/sec/sev
	icon_state = "chaoto"
	desc = "HMMM."

/turf/open/floor/plating/polovich/rotten_stones/sec/eight
	icon_state = "chaotot"
	desc = "HMMM."

/turf/open/floor/plating/polovich/rotten_stones/sec/nine
	icon_state = "hotstone"
	desc = "HMMM."

/turf/open/floor/plating/polovich/rotten_stones/sec/ten
	icon_state = "hotstone2"
	desc = "HMMM."

/turf/open/floor/plating/polovich/rotten_dirt
	name = "Rotten Dirt"
	desc = "This is sticky."
	icon_state = "rottendirt"
	icon = 'modular_pod/icons/turf/floors.dmi'
	slowdown = 1
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_SAND

/turf/open/floor/plating/polovich/rotten_dirt/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/cosmicdirt
	name = "Cosmic Dirt"
	desc = "This is sticky."
	icon_state = "dirtyish"
	icon = 'modular_pod/icons/turf/floors.dmi'
	slowdown = 1
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_SAND

/turf/open/floor/plating/polovich/cosmicdirt/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/otherdirts
	name = "Dirt"
	desc = "This is sticky."
	icon_state = "dirtydirty"
	icon = 'modular_pod/icons/turf/floors.dmi'
	slowdown = 1
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_SAND

/turf/open/floor/plating/polovich/otherdirts/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/otherdirts/sec
	icon_state = "dirtybluei"

/turf/open/floor/plating/polovich/otherdirts/sec/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/otherdirts/third
	icon_state = "dirtybluei2"

/turf/open/floor/plating/polovich/otherdirts/third/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/otherdirts/four
	icon_state = "devildirt"

/turf/open/floor/plating/polovich/otherdirts/four/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/otherdirts/five
	icon_state = "dirtymud"

/turf/open/floor/plating/polovich/otherdirts/five/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/otherdirts/six
	icon_state = "dirtymud2"

/turf/open/floor/plating/polovich/otherdirts/six/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/steelishh
	name = "Steel Floor"
	desc = "DARK!"
	icon_state = "steelishfloor"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_PLATING

/turf/open/floor/plating/polovich/steelishhh
	name = "Steel Floor"
	desc = "Depressed."
	icon_state = "depressed"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_PLATING

/turf/open/floor/plating/polovich/steeldark
	name = "Пол"
	desc = "Вот бы вырвать, и посмотреть что под этим."
	icon_state = "steeldark"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_PLATING

/turf/open/floor/plating/polovich/steeldarkk
	name = "Пол"
	desc = "Вот бы вырвать, и посмотреть что под этим."
	icon_state = "steeldark2"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_PLATING

/turf/open/floor/plating/polovich/woodendarkdark
	name = "Wooden Floor"
	desc = "DARK!"
	icon_state = "evilishwood"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_WOOD
	barefootstep = FOOTSTEP_WOOD_BAREFOOT
	clawfootstep = FOOTSTEP_WOOD_CLAW
	heavyfootstep = FOOTSTEP_WOOD
	resistance_flags = FLAMMABLE
	var/randommm = FALSE

/turf/open/floor/plating/polovich/woodendarkdark/Initialize(mapload)
	. = ..()
	if(randommm)
		dir = rand(0,4)

/turf/open/floor/plating/polovich/woodendarkdark/random
	randommm = TRUE

/turf/open/floor/plating/polovich/woodendarkdarkk
	name = "Wooden Floor"
	desc = "DARK!"
	icon_state = "wodacid"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_WOOD
	barefootstep = FOOTSTEP_WOOD_BAREFOOT
	clawfootstep = FOOTSTEP_WOOD_CLAW
	heavyfootstep = FOOTSTEP_WOOD
	resistance_flags = FLAMMABLE

/turf/open/floor/plating/polovich/woodendarkdarkk/dark
	icon_state = "wodacid2"

/turf/open/floor/plating/polovich/red
	name = "Red Floor"
	desc = "This is cool."
	icon_state = "racalka"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/yellow
	name = "Yellow Floor"
	desc = "This is cool."
	icon_state = "interesno"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/yelloww
	name = "Yellow Floor"
	desc = "This is cool."
	icon_state = "krutonavernoe"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/kruto
	name = "Purple Floor"
	desc = "This is cool."
	icon_state = "kruto"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/typaya
	name = "Greenish Floor"
	desc = "This is cool."
	icon_state = "typaya"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/durackaya
	name = "Greenish Floor"
	desc = "This is cool."
	icon_state = "durackaya"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE
/*
/turf/open/floor/plating/polovich/temno
	name = "Dark Floor"
	desc = "This is cool."
	icon_state = "temno"
	icon = 'modular_pod/icons/turf/floors.dmi'
*/
/turf/open/floor/plating/polovich/temnoo
	name = "Asphalt"
	desc = "This is cool."
	icon_state = "asfalt"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/temnoo/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/temnoo/two
	name = "Asphalt"
	desc = "This is cool."
	icon_state = "asfalt2"
	icon = 'modular_pod/icons/turf/floors.dmi'

/turf/open/floor/plating/polovich/temnoo/two/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/darkydarkn
	name = "Stone Floor"
	desc = "Hmm."
	icon_state = "darkorstone"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/darkydarkn/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/temnoo/three
	name = "Asphalt"
	desc = "This is cool."
	icon_state = "asfalt3"
	icon = 'modular_pod/icons/turf/floors.dmi'

/turf/open/floor/plating/polovich/temnoo/four
	name = "Asphalt"
	desc = "This is cool."
	icon_state = "asfalt4"
	icon = 'modular_pod/icons/turf/floors.dmi'

/turf/open/floor/plating/polovich/temnoo/five
	name = "Asphalt"
	desc = "This is cool."
	icon_state = "asfalt5"
	icon = 'modular_pod/icons/turf/floors.dmi'

/turf/open/floor/plating/polovich/temnoo/six
	name = "Asphalt"
	desc = "This is cool."
	icon_state = "asfalt6"
	icon = 'modular_pod/icons/turf/floors.dmi'

/turf/open/floor/plating/polovich/temnoo/seven
	name = "Asphalt"
	desc = "This is cool."
	icon_state = "asfalt7"
	icon = 'modular_pod/icons/turf/floors.dmi'

/turf/open/floor/plating/polovich/temnoo/eight
	name = "Asphalt"
	desc = "This is cool."
	icon_state = "asfalt8"
	icon = 'modular_pod/icons/turf/floors.dmi'

/turf/open/floor/plating/polovich/temnoo/nine
	name = "Asphalt"
	desc = "This is cool."
	icon_state = "asfalt9"
	icon = 'modular_pod/icons/turf/floors.dmi'

/turf/open/floor/plating/polovich/temnoo/ten
	name = "Asphalt"
	desc = "This is cool."
	icon_state = "asfalt10"
	icon = 'modular_pod/icons/turf/floors.dmi'

/turf/open/floor/plating/polovich/kapec
	name = "Strange Floor"
	desc = "This is cool."
	icon_state = "kapec"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/kapec/two
	name = "Strange Floor"
	desc = "This is cool."
	icon_state = "brickstrange"
	icon = 'modular_pod/icons/turf/floors.dmi'

/turf/open/floor/plating/polovich/kapec/three
	name = "Strange Floor"
	desc = "This is cool."
	icon_state = "brickstrange2"
	icon = 'modular_pod/icons/turf/floors.dmi'

/turf/open/floor/plating/polovich/kapec/four
	name = "Strange Floor"
	desc = "This is cool."
	icon_state = "brickstrange3"
	icon = 'modular_pod/icons/turf/floors.dmi'

/turf/open/floor/plating/polovich/kapec/five
	name = "Strange Floor"
	desc = "This is cool."
	icon_state = "brickstrange4"
	icon = 'modular_pod/icons/turf/floors.dmi'

/turf/open/floor/plating/polovich/kapec/siv
	name = "Strange Floor"
	desc = "This is cool."
	icon_state = "brickstrange5"
	icon = 'modular_pod/icons/turf/floors.dmi'

/turf/open/floor/plating/polovich/kapec/ss
	name = "Strange Floor"
	desc = "This is cool."
	icon_state = "brickstrange6"
	icon = 'modular_pod/icons/turf/floors.dmi'

/turf/open/floor/plating/polovich/kapec/vv
	name = "Strange Floor"
	desc = "This is cool."
	icon_state = "brickstrange7"
	icon = 'modular_pod/icons/turf/floors.dmi'

/turf/open/floor/plating/polovich/kapec/ba
	name = "Strange Floor"
	desc = "This is cool."
	icon_state = "brickstrange8"
	icon = 'modular_pod/icons/turf/floors.dmi'

/turf/open/floor/plating/polovich/kapec/xy
	name = "Strange Floor"
	desc = "This is cool."
	icon_state = "brickstrange9"
	icon = 'modular_pod/icons/turf/floors.dmi'

/turf/open/floor/plating/polovich/strangeflesh
	name = "Strange Flesh"
	desc = "This is bad."
	icon_state = "strangeflesh"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_MEAT
	mood_turf_mes = "<span class='bloody'>Is this floor alive?!</span>\n"
	mood_bonus_turf = -1
	slowdown = 2
	barefootstep = FOOTSTEP_MEAT
	clawfootstep = FOOTSTEP_MEAT
	heavyfootstep = FOOTSTEP_MEAT

/turf/open/floor/plating/polovich/strangeflesh/two
	name = "Strange Flesh"
	desc = "This is sticky and bad."
	icon_state = "redsticky"
	icon = 'modular_pod/icons/turf/floors.dmi'
	mood_turf_mes = "<span class='bloody'>Is this floor alive?!</span>\n"
	mood_bonus_turf = -1
	slowdown = 1

/turf/open/floor/plating/polovich/bluee
	name = "Blue Floor"
	desc = "This is cool."
	icon_state = "bluefloor"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_PLATING

/turf/open/floor/plating/polovich/cosmick
	name = "Cosmic Floor"
	desc = "This is cool."
	icon_state = "cosmicanomaly"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_PLATING

/turf/open/floor/light/colour_cycle/polovich
	name = "Dancefloor"
	desc = "This is funny."
	icon = 'modular_pod/icons/turf/floors.dmi'
	icon_state = "dancefloor_on-11"
	light_color = COLOR_RED
	can_modify_colour = FALSE
	cycle = TRUE

/turf/open/floor/plating/polovich/purplefantast
	name = "Purple Floor"
	desc = "This is amazing."
	icon_state = "purplefantast"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_PLATING

/turf/open/floor/plating/polovich/purplefantast/two
	name = "Purple Floor"
	desc = "This is amazing."
	icon_state = "purplefantast2"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_PLATING

/turf/open/floor/plating/polovich/dirt
	name = "White Dirt"
	desc = "This is sticky."
	icon_state = "gryazwhite"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_SAND
	slowdown = 1
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_SAND

/turf/open/floor/plating/polovich/dirt/soft
	name = "Soft Dirt"
	desc = "Annoying to stand on it"
	icon_state = "dirtvillage"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_SAND
	slowdown = 1
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_SAND

/turf/open/floor/plating/polovich/dirt/soft/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/dirtyddd
	name = "Spidery Dirt"
	desc = "This is STICKY."
	icon_state = "webbishdirt"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_SAND
	slowdown = 1
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_SAND

/turf/open/floor/plating/polovich/dirtyddd/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/dirt/blue
	name = "Blue Dirt"
	desc = "This is good!"
	icon_state = "gryazblue"
	icon = 'modular_pod/icons/turf/floors.dmi'
	slowdown = -1

/turf/open/floor/plating/polovich/dirt/dark/gryazka
	name = "Black Dirt"
	desc = "This is darkly."
	icon_state = "blackgryaz"
	icon = 'modular_pod/icons/turf/floors.dmi'
	slowdown = 1
//	var/cooldown = 80

/turf/open/floor/plating/polovich/dirt/dark/gryazka/Initialize(mapload)
	. = ..()
	dir = rand(0,4)
/*
	if(prob(65))
		if(istype(src.loc, /mob/living/carbon/human))
			try_eat()

/turf/open/floor/plating/polovich/dirt/dark/gryazka/Initialize()
	. = ..()
	if(prob(65))
		if(locate(/mob/living/carbon/human) in src)
			try_eat()

/turf/open/floor/plating/polovich/dirt/dark/gryazka/proc/try_eat()
//	var/open/floor/plating/polovich/dirt/dark/T = get_turf(src)
	var/mob/living/carbon/human/eat_human = locate() in src
	if(eat_human.stat != DEAD)
		return
	if(eat_human.body_position == LYING_DOWN)
		if(cooldown <= world.time)
			visible_message(span_notice("Dirt swallows the corpse."))
			eat_human.unequip_everything()
			qdel(eat_human)
			cooldown = world.time + 80 //.... 8800

*/

/turf/open/floor/plating/polovich/dirt/dark/bright
	name = "Funny Dirt"
	desc = "This is funny."
	icon_state = "blackgryaz2"
	icon = 'modular_pod/icons/turf/floors.dmi'
	slowdown = 1

/turf/open/floor/plating/polovich/dirt/dark/bright/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/dirt/dark/animated
	name = "Black Dirt"
	desc = "This is darkly."
	icon_state = "blackgryaz3"
	icon = 'modular_pod/icons/turf/floors.dmi'

/turf/open/floor/plating/polovich/dirt/dark/animated/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/dirt/blueee
	name = "Blue Dirt"
	desc = "This is sticky."
	icon_state = "dirtybluei"
	icon = 'modular_pod/icons/turf/floors.dmi'
	slowdown = 1
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_SAND

/turf/open/floor/plating/polovich/dirt/blueee/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/dirt/blueee/second
	name = "Blue Dirt"
	desc = "This is sticky."
	icon_state = "dirtybluei2"
	icon = 'modular_pod/icons/turf/floors.dmi'
	slowdown = 1
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_SAND

/turf/open/floor/plating/polovich/dirt/blueee/second/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/bonefloor
	name = "Bone Floor"
	desc = "This is brutal and interesting."
	icon_state = "bonefloor"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_CRUMBLE
	barefootstep = FOOTSTEP_CRUMBLE
	clawfootstep = FOOTSTEP_CRUMBLE
	heavyfootstep = FOOTSTEP_CRUMBLE

/turf/open/floor/plating/polovich/gristle
	name = "Gristle Floor"
	desc = "This is brutal and interesting. Throbbing Gristle."
	icon_state = "gristle"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_CRUMBLE
	barefootstep = FOOTSTEP_CRUMBLE
	clawfootstep = FOOTSTEP_CRUMBLE
	heavyfootstep = FOOTSTEP_CRUMBLE

/turf/open/floor/plating/polovich/krutoplitka
	name = "Strange Floor"
	desc = "This is interesting."
	icon_state = "krutoplitka"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_PLATING

/turf/open/floor/plating/polovich/krutoplitka/plitkabluered
	name = "Strange Floor"
	desc = "This is interesting."
	icon_state = "plitkabluered"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_PLATING

/turf/open/floor/plating/polovich/krutoplitka/plitkapinkred
	name = "Strange Floor"
	desc = "This is interesting."
	icon_state = "plitrapinkred"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_PLATING

/turf/open/floor/plating/polovich/stoneplitblue
	name = "Пол"
	desc = "Вот это вот... Уже интересно!"
	icon_state = "stonebluei"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/cosmickick
	name = "Пол"
	desc = "Вот это вот... Уже интересно!"
	icon_state = "cosmicanomaly2"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/cosmickickk
	name = "Пол"
	desc = "Вот это вот... Уже интересно!"
	icon_state = "cosmicbrick"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/stoneplitblue/second
	name = "Stone Floor"
	desc = "This is interesting."
	icon_state = "stonebluei2"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/krutoplitka/krutoplitka2
	name = "Strange Floor"
	desc = "This is interesting."
	icon_state = "krutoplitka2"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/greenstone
	name = "Evil Floor"
	desc = "This is interesting and vicious."
	icon_state = "greenstone"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/greengryaz
	name = "Evil Dirt"
	desc = "This is interesting and vicious."
	icon_state = "evilzemlya"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_GRASS
	barefootstep = FOOTSTEP_GRASS
	clawfootstep = FOOTSTEP_GRASS
	heavyfootstep = FOOTSTEP_GRASS
	slowdown = 1
	var/randomgenerate = TRUE
	var/randomcolor = TRUE

/turf/open/floor/plating/polovich/greengryaz/Initialize(mapload)
	. = ..()
	dir = rand(0,8)
/*
			var/canspawn = 1
			var/near_t = range(1, src)
			if((locate(/turf/simulated/wall) in near_t) || (locate(/turf/stalker/floor/asphalt) in near_t) || (locate(/turf/stalker/floor/road) in near_t))
				canspawn = 0													//Проверяем есть ли рядом стены или дороги
			if(canspawn)
				var/obj/structure/stalker/flora/trees/tree = pick(typesof(/obj/structure/stalker/flora/trees/alive))
				new tree(loc)
*/

	if(randomcolor)
//		color = pick("#ffb3bf", "#b7ffb9", "#c2c3ff", "")
		color = pick("#d4abd2", "#edbdf1", "#d39dff", "#dcc3ff", "#ffa5e0", "")

	if(randomgenerate)
		if(locate(/obj/structure/) in get_turf(src))
			return
		var/state = pick_weight(list("crystalbush" = 6, "shroom" = 4, "stump" = 5, "treelong" = 5, "goldishincrementum" = 3, "crystal" = 3, "ygro" = 2, "chaosbush" = 3, "statuekas" = 1, "water" = 1, "chungu" = 1, "nothing" = 40))
		switch(state)
			if("crystalbush")
				new /obj/structure/flora/ausbushes/crystal(get_turf(src))
			if("shroom")
				new /obj/item/food/grown/mushroom/blood(get_turf(src))
			if("nothing")
				return
			if("stump")
				new /obj/structure/flora/stump(get_turf(src))
			if("treelong")
				var/canspawn = TRUE
				var/near_t = range(2, src)
				if((locate(/turf/closed/wall) in near_t) || (locate(/obj/structure/flora/tree/evil) in near_t) || (locate(/obj/structure/barricade/flora/crystal) in near_t))
					canspawn = FALSE
				if(canspawn)
					new /obj/structure/flora/tree/evil/long(get_turf(src))
					new /turf/open/floor/plating/polovich/roots(get_turf(src))
/*
			if("groundcrystals")
				var/crystaltype = rand(1, 4)
				switch(crystaltype)
					if(1)
						new /obj/structure/crystals_ground/green(get_turf(src))
					if(2)
						new /obj/structure/crystals_ground/red(get_turf(src))
					if(3)
						new /obj/structure/crystals_ground/blue(get_turf(src))
					if(4)
						new /obj/structure/crystals_ground/pink(get_turf(src))
*/
			if("crystal")
				var/crystaltypee = rand(1, 4)
				switch(crystaltypee)
					if(1)
						new /obj/structure/barricade/flora/crystal/green(get_turf(src))
					if(2)
						new /obj/structure/barricade/flora/crystal/red(get_turf(src))
					if(3)
						new /obj/structure/barricade/flora/crystal/blue(get_turf(src))
					if(4)
						new /obj/structure/barricade/flora/crystal/purple(get_turf(src))
			if("goldishincrementum")
				new /obj/structure/flora/ausbushes/incrementum(get_turf(src))
			if("ygro")
				new /obj/structure/flora/ausbushes/incrementum/ygro(get_turf(src))
			if("chaosbush")
				new /turf/open/floor/plating/polovich/evilevil(get_turf(src))
				new /obj/structure/flora/ausbushes/crystal/dark(get_turf(src))
			if("statuekas")
				new /obj/structure/fluff/statuestone(get_turf(src))
			if("water")
				var/watertype = rand(1, 2)
				switch(watertype)
					if(1)
						new /turf/open/floor/plating/polovich/asteroid/snow/river/nevado_surface/shallow/ankle/coffee(get_turf(src))
					if(2)
						new /turf/open/floor/plating/polovich/asteroid/snow/river/nevado_surface/shallow/ankle/acid(get_turf(src))
//			if("beartrap")
//				new /obj/item/restraints/legcuffs/beartrap(get_turf(src))
			if("chungu")
				new /obj/structure/flora/tree/chungus(get_turf(src))

/turf/open/floor/plating/polovich/greengryaz/norandomgen
	randomgenerate = FALSE
	randomcolor = FALSE

/turf/open/floor/plating/polovich/greengryaz/norandomgen/super
	randomgenerate = FALSE
	randomcolor = TRUE

/turf/open/floor/plating/polovich/greengryaz/super

/turf/open/floor/plating/polovich/greengryaz/super/Initialize(mapload)
	. = ..()
	dir = rand(0,8)

	if(randomcolor)
		color = pick("#d4abd2", "#edbdf1", "#d39dff", "#dcc3ff", "#ffa5e0", "")

	if(locate(/obj/structure/) in get_turf(src))
		return
	var/state = pick_weight(list("crystalbush" = 6, "shroom" = 4, "stump" = 5, "treelong" = 5, "tree" = 6, "goldishincrementum" = 3, "crystal" = 3, "ygro" = 2, "chaosbush" = 3, "statuekas" = 1, "beartrap" = 2, "water" = 1, "nothing" = 20))
	switch(state)
		if("crystalbush")
			new /obj/structure/flora/ausbushes/crystal(get_turf(src))
		if("shroom")
			new /obj/item/food/grown/mushroom/blood(get_turf(src))
		if("nothing")
			return
		if("stump")
			new /obj/structure/flora/stump(get_turf(src))
		if("treelong")
			var/canspawn = TRUE
			var/near_t = range(2, src)
			if((locate(/turf/closed/wall) in near_t) || (locate(/obj/structure/flora/tree/evil) in near_t) || (locate(/obj/structure/barricade/flora/crystal) in near_t))
				canspawn = FALSE
			if(canspawn)
				new /obj/structure/flora/tree/evil/long(get_turf(src))
				new /turf/open/floor/plating/polovich/roots(get_turf(src))
		if("tree")
			var/canspawn = TRUE
			var/near_t = range(2, src)
			if((locate(/turf/closed/wall) in near_t) || (locate(/obj/structure/flora/tree/evil) in near_t) || (locate(/obj/structure/barricade/flora/crystal) in near_t))
				canspawn = FALSE
			if(canspawn)
				new /obj/structure/flora/tree/evil(get_turf(src))
				new /turf/open/floor/plating/polovich/roots(get_turf(src))
/*
		if("groundcrystals")
			var/crystaltype = rand(1, 4)
			switch(crystaltype)
				if(1)
					new /obj/structure/crystals_ground/green(get_turf(src))
				if(2)
					new /obj/structure/crystals_ground/red(get_turf(src))
				if(3)
					new /obj/structure/crystals_ground/blue(get_turf(src))
				if(4)
					new /obj/structure/crystals_ground/pink(get_turf(src))
*/
		if("crystal")
			var/crystaltypee = rand(1, 4)
			switch(crystaltypee)
				if(1)
					new /obj/structure/barricade/flora/crystal/green(get_turf(src))
				if(2)
					new /obj/structure/barricade/flora/crystal/red(get_turf(src))
				if(3)
					new /obj/structure/barricade/flora/crystal/blue(get_turf(src))
				if(4)
					new /obj/structure/barricade/flora/crystal/purple(get_turf(src))
		if("goldishincrementum")
			new /obj/structure/flora/ausbushes/incrementum(get_turf(src))
		if("ygro")
			new /obj/structure/flora/ausbushes/incrementum/ygro(get_turf(src))
		if("chaosbush")
			new /turf/open/floor/plating/polovich/evilevil(get_turf(src))
			new /obj/structure/flora/ausbushes/crystal/dark(get_turf(src))
		if("statuekas")
			new /obj/structure/fluff/statuestone(get_turf(src))
		if("beartrap")
			new /obj/item/restraints/legcuffs/beartrap(get_turf(src))
		if("water")
			var/watertype = rand(1, 2)
			switch(watertype)
				if(1)
					new /turf/open/floor/plating/polovich/asteroid/snow/river/nevado_surface/shallow/ankle/coffee(get_turf(src))
				if(2)
					new /turf/open/floor/plating/polovich/asteroid/snow/river/nevado_surface/shallow/ankle/acid(get_turf(src))

/turf/open/floor/plating/polovich/greengryaz/bigfire
	turf_fire = /atom/movable/fire/inferno/magical
//	air.temperature == T0C+10

//	new /atom/movable/fire(src, power)

/turf/open/floor/plating/polovich/bluedirty
	name = "Blue Dirt"
	desc = "This is interesting."
	icon_state = "bluedirt"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_GRASS
	barefootstep = FOOTSTEP_GRASS
	clawfootstep = FOOTSTEP_GRASS
	heavyfootstep = FOOTSTEP_GRASS
	slowdown = 1
	var/saturated = FALSE

/turf/open/floor/plating/polovich/bluedirty/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/bluedirty/attackby(obj/item/W, mob/living/carbon/user, params)
	. = ..()
	if(.)
		return
	if(user.a_intent == INTENT_DISARM)
		if(istype(W, /obj/item/seeding/midnightberryseeds))
			if(locate(/obj/structure/) in get_turf(src))
				return
			if(saturated)
				if(do_after(user, 3 SECONDS, target=src))
					var/diceroll = user.diceroll(GET_MOB_SKILL_VALUE(user, SKILL_AGRICULTURE), context = DICE_CONTEXT_PHYSICAL)
					if(diceroll >= DICE_SUCCESS)
						user.visible_message(span_notice("[user] seeded [src] with the [W]."),span_notice("You seeded [src] with the [W]."), span_hear("You hear the sound of a seeding."))
						user.changeNext_move(CLICK_CD_GRABBING)
						sound_hint()
						new /obj/structure/flora/ausbushes/zarosli/midnight/good(get_turf(src))
						saturated = FALSE
						playsound(get_turf(src), 'modular_pod/sound/eff/grow_up.ogg', 80 , FALSE, FALSE)
						qdel(W)
					else
						user.visible_message(span_notice("[user] faily seeded [src] with the [W]."),span_notice("You faily seeded [src] with the [W]."), span_hear("You hear the sound of a seeding."))
						user.changeNext_move(CLICK_CD_GRABBING)
						sound_hint()
						saturated = FALSE
						qdel(W)
			else
				if(do_after(user, 3 SECONDS, target=src))
					var/diceroll = user.diceroll(GET_MOB_SKILL_VALUE(user, SKILL_AGRICULTURE), context = DICE_CONTEXT_PHYSICAL)
					if(diceroll >= DICE_SUCCESS)
						user.visible_message(span_notice("[user] seeded [src] with the [W]."),span_notice("You seeded [src] with the [W]."), span_hear("You hear the sound of a seeding."))
						user.changeNext_move(CLICK_CD_GRABBING)
						sound_hint()
						new /obj/structure/flora/ausbushes/zarosli/midnight(get_turf(src))
						playsound(get_turf(src), 'modular_pod/sound/eff/grow_up.ogg', 80 , FALSE, FALSE)
						qdel(W)
					else
						user.visible_message(span_notice("[user] faily seeded [src] with the [W]."),span_notice("You faily seeded [src] with the [W]."), span_hear("You hear the sound of a seeding."))
						user.changeNext_move(CLICK_CD_GRABBING)
						sound_hint()
						qdel(W)
/*
		else if(istype(W, /obj/item/stupidbottles/bluebottle))
			if(!saturated)
				var/obj/item/stupidbottles/bluebottle/B = W
				if(B.empty)
					user.changeNext_move(CLICK_CD_GRABBING)
					sound_hint()
					to_chat(user, span_notice("Bottle is empty..."))
					return
				user.visible_message(span_notice("[user] saturates [src] with the [B]."),span_notice("You saturates [src] with the [B]."), span_hear("You hear the sound of a saturating."))
				user.changeNext_move(CLICK_CD_GRABBING)
				sound_hint()
				saturated = TRUE
				B.empty = TRUE
				playsound(get_turf(src), 'modular_pod/sound/eff/potnpour.ogg', 80 , FALSE, FALSE)
			else
				to_chat(user, span_notice("Dirt is saturated already."))
				return
*/
		else if(istype(W, /obj/item/seeding/aguoseeds))
			if(locate(/obj/structure/) in get_turf(src))
				return
			if(do_after(user, 3 SECONDS, target=src))
				var/diceroll = user.diceroll(GET_MOB_SKILL_VALUE(user, SKILL_AGRICULTURE), context = DICE_CONTEXT_PHYSICAL)
				if(diceroll >= DICE_SUCCESS)
					user.visible_message(span_notice("[user] seeded [src] with the [W]."),span_notice("You seeded [src] with the [W]."), span_hear("You hear the sound of a seeding."))
					user.changeNext_move(CLICK_CD_GRABBING)
					sound_hint()
					new /obj/structure/flora/ausbushes/zarosli/aguo(get_turf(src))
					playsound(get_turf(src), 'modular_pod/sound/eff/grow_up.ogg', 80 , FALSE, FALSE)
					qdel(W)
				else
					user.visible_message(span_notice("[user] faily seeded [src] with the [W]."),span_notice("You faily seeded [src] with the [W]."), span_hear("You hear the sound of a seeding."))
					user.changeNext_move(CLICK_CD_GRABBING)
					sound_hint()
					qdel(W)

/turf/open/floor/plating/polovich/bluedirty/examine(mob/user)
	. = ..()
	if(saturated)
		. += "<span class='warning'>This blue dirt is satured.</span>"

/turf/open/floor/plating/polovich/greendirtevil
	name = "Green Dirt"
	desc = "This is evil."
	icon_state = "zemlyay"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_GRASS
	barefootstep = FOOTSTEP_GRASS
	clawfootstep = FOOTSTEP_GRASS
	heavyfootstep = FOOTSTEP_GRASS
	slowdown = 1
	var/randomcolor = TRUE
	var/randomgenerate = TRUE

/turf/open/floor/plating/polovich/greendirtevil/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

	if(randomcolor)
		color = pick("#d4abd2", "#edbdf1", "#d39dff", "#dcc3ff", "#ffa5e0", "")

	if(randomgenerate)
		if(locate(/obj/structure/) in get_turf(src))
			return
		var/state = pick_weight(list("crystal" = 4, "thickets" = 2, "flametrap" = 2, "chungu" = 2, "nothing" = 40))
		switch(state)
			if("nothing")
				return
			if("thickets")
				new /obj/structure/flora/ausbushes/zarosli/midnight(get_turf(src))
			if("crystal")
				var/crystaltypee = rand(1, 4)
				switch(crystaltypee)
					if(1)
						new /obj/structure/barricade/flora/crystal/green(get_turf(src))
					if(2)
						new /obj/structure/barricade/flora/crystal/red(get_turf(src))
					if(3)
						new /obj/structure/barricade/flora/crystal/blue(get_turf(src))
					if(4)
						new /obj/structure/barricade/flora/crystal/purple(get_turf(src))
			if("flametrap")
				new /obj/structure/trap/fire(get_turf(src))
			if("chungu")
				new /obj/structure/flora/tree/chungus(get_turf(src))

/turf/open/floor/plating/polovich/lightblue
	name = "Blue Dirt"
	desc = "This is evil and interesting."
	icon_state = "evilzemlyaslight"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_GRASS
	barefootstep = FOOTSTEP_GRASS
	clawfootstep = FOOTSTEP_GRASS
	heavyfootstep = FOOTSTEP_GRASS
	slowdown = 1
	var/randomcolor = TRUE
	var/randomgenerate = TRUE

/turf/open/floor/plating/polovich/lightblue/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

	if(randomcolor)
		color = pick("#d4abd2", "#edbdf1", "#d39dff", "#dcc3ff", "#ffa5e0", "")

	if(randomgenerate)
		if(locate(/obj/structure/) in get_turf(src))
			return
		var/state = pick_weight(list("crystal" = 3, "thickets" = 2, "chungu" = 2, "nothing" = 60))
		switch(state)
			if("thickets")
				new /obj/structure/flora/ausbushes/zarosli/midnight(get_turf(src))
			if("crystal")
				var/crystaltypee = rand(1, 4)
				switch(crystaltypee)
					if(1)
						new /obj/structure/barricade/flora/crystal/green(get_turf(src))
					if(2)
						new /obj/structure/barricade/flora/crystal/red(get_turf(src))
					if(3)
						new /obj/structure/barricade/flora/crystal/blue(get_turf(src))
					if(4)
						new /obj/structure/barricade/flora/crystal/purple(get_turf(src))
			if("chungu")
				new /obj/structure/flora/tree/chungus(get_turf(src))

/turf/open/floor/plating/polovich/woodennewblue
	name = "Wooden Floor"
	desc = "This is neutral."
	icon_state = "doskiblue"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_WOOD
	barefootstep = FOOTSTEP_WOOD_BAREFOOT
	clawfootstep = FOOTSTEP_WOOD_CLAW
	heavyfootstep = FOOTSTEP_WOOD
	resistance_flags = FLAMMABLE

/turf/open/floor/plating/polovich/woodennewblue/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/woodennewdarr
	name = "Wooden Floor"
	desc = "This is neutral and dark."
	icon_state = "wooddark"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_WOOD
	barefootstep = FOOTSTEP_WOOD_BAREFOOT
	clawfootstep = FOOTSTEP_WOOD_CLAW
	heavyfootstep = FOOTSTEP_WOOD
	resistance_flags = FLAMMABLE

/turf/open/floor/plating/polovich/greenishe
	name = "Wooden Floor"
	desc = "This is green and dark."
	icon_state = "woodgreen"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_WOOD
	barefootstep = FOOTSTEP_WOOD_BAREFOOT
	clawfootstep = FOOTSTEP_WOOD_CLAW
	heavyfootstep = FOOTSTEP_WOOD
	resistance_flags = FLAMMABLE

/turf/open/floor/plating/polovich/roots
	name = "Roots"
	desc = "Don't stumble!"
	icon_state = "roots"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_WOOD
	barefootstep = FOOTSTEP_WOOD_BAREFOOT
	clawfootstep = FOOTSTEP_WOOD_CLAW
	heavyfootstep = FOOTSTEP_WOOD
	resistance_flags = FLAMMABLE
	var/canstumble = TRUE

/turf/open/floor/plating/polovich/roots/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/roots/Entered(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	. = ..()
	if(.)
		return
	if(isliving(arrived))
		if(canstumble)
			if(prob(50))
				var/mob/living/stumbleguy = arrived
				stumbleguy.visible_message(span_warning("[stumbleguy] stumbles on the root."), \
							span_warning("I stumble on the root."))
				sound_hint()
				var/diceroll = stumbleguy.diceroll(GET_MOB_ATTRIBUTE_VALUE(stumbleguy, STAT_DEXTERITY), context = DICE_CONTEXT_MENTAL)
				if(diceroll <= DICE_FAILURE)
					stumbleguy.Stumble(3 SECONDS)
					stumbleguy.visible_message(span_warning("The roots are grasping [stumbleguy]!"), \
											span_warning("The roots are grasping me!"))

/turf/open/floor/plating/polovich/roots/examine(mob/user)
	. = ..()
	if(canstumble)
		. += "<span class='warning'>You might trip over those roots!</span>"

/turf/open/floor/plating/polovich/logsgreen
	name = "Wooden Floor"
	desc = "This is green. Cursed."
	icon_state = "logsgreen"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_WOOD
	barefootstep = FOOTSTEP_WOOD_BAREFOOT
	clawfootstep = FOOTSTEP_WOOD_CLAW
	heavyfootstep = FOOTSTEP_WOOD
	resistance_flags = FLAMMABLE

/turf/open/openspace/attackby(obj/item/C, mob/user, params)
	. = ..()
/*
	if(!CanBuildHere())
		return
*/
	if(istype(C, /obj/item/stack/grown/log/tree/evil/logg))
		var/obj/item/stack/grown/log/tree/evil/logg/R = C
		if(R.amount == 4)
			to_chat(user, span_notice("You construct a floor."))
			playsound(src, 'sound/weapons/genhit.ogg', 50, TRUE)
			new /turf/open/floor/plating/polovich/logsgreen(get_turf(src))
		else
			to_chat(user, span_warning("You need four logs to build a floor!"))
		return

/turf/open/floor/plating/polovich/logsgreen/two
	name = "Wooden Floor"
	desc = "This is green. Cursed."
	icon_state = "logsgreen_2"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_WOOD
	barefootstep = FOOTSTEP_WOOD_BAREFOOT
	clawfootstep = FOOTSTEP_WOOD_CLAW
	heavyfootstep = FOOTSTEP_WOOD
	resistance_flags = FLAMMABLE

/turf/open/floor/plating/polovich/logsgreen/three
	name = "Wooden Floor"
	desc = "This is green. Cursed."
	icon_state = "logsgreen_3"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_WOOD
	barefootstep = FOOTSTEP_WOOD_BAREFOOT
	clawfootstep = FOOTSTEP_WOOD_CLAW
	heavyfootstep = FOOTSTEP_WOOD
	resistance_flags = FLAMMABLE

/turf/open/floor/plating/polovich/greenishe2
	name = "Wooden Floor"
	desc = "This is green and dark."
	icon_state = "woodgreen2"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_WOOD
	barefootstep = FOOTSTEP_WOOD_BAREFOOT
	clawfootstep = FOOTSTEP_WOOD_CLAW
	heavyfootstep = FOOTSTEP_WOOD
	resistance_flags = FLAMMABLE

/turf/open/floor/plating/polovich/woodennew
	name = "Wooden Floor"
	desc = "This is good."
	icon_state = "woodennew"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_WOOD
	barefootstep = FOOTSTEP_WOOD_BAREFOOT
	clawfootstep = FOOTSTEP_WOOD_CLAW
	heavyfootstep = FOOTSTEP_WOOD
	resistance_flags = FLAMMABLE

/turf/open/floor/plating/polovich/woodens
	name = "Wooden Planks"
	desc = "This is good."
	icon_state = "planks"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_WOOD
	barefootstep = FOOTSTEP_WOOD_BAREFOOT
	clawfootstep = FOOTSTEP_WOOD_CLAW
	heavyfootstep = FOOTSTEP_WOOD
	resistance_flags = FLAMMABLE

/turf/open/floor/plating/polovich/woodenss
	name = "Wooden Planks"
	desc = "This is good."
	icon_state = "woodenfloor"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_WOOD
	barefootstep = FOOTSTEP_WOOD_BAREFOOT
	clawfootstep = FOOTSTEP_WOOD_CLAW
	heavyfootstep = FOOTSTEP_WOOD
	resistance_flags = FLAMMABLE

/turf/open/floor/plating/polovich/newstoneawesome
	name = "Stone Floor"
	desc = "Helps to move."
	icon_state = "stonefloornew"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/newstoneawesome/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/newstoneawesome/dirty
	name = "Stone Floor"
	desc = "Helps to move."
	icon_state = "stonefloordirty"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/newstoneawesome/big
	name = "Stone Floor"
	desc = "Helps to move."
	icon_state = "stonefloorsecond"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/newstoneawesome/big/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/newstoneawesome/big/shining
	name = "Stone Floor"
	desc = "Helps to move. What is this red glow?"
	icon_state = "stonefloorsecond_light"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/newstoneawesome/big/shining/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/gre
	name = "Stone Floor"
	desc = "This is probably boring."
	icon_state = "stoneone"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/pinkbrick
	name = "Pink Floor"
	desc = "This is interesting and good."
	icon_state = "pinkbrick"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/metalfloor
	name = "Steel Floor"
	desc = "This is brutal."
	icon_state = "metalnew"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_METAL
	barefootstep = FOOTSTEP_METAL
	clawfootstep = FOOTSTEP_METAL
	heavyfootstep = FOOTSTEP_METAL

/turf/open/floor/plating/polovich/metallicfloor
	name = "Metallic Floor"
	desc = "This is brutal."
	icon_state = "metallicfloor"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_METAL
	barefootstep = FOOTSTEP_METAL
	clawfootstep = FOOTSTEP_METAL
	heavyfootstep = FOOTSTEP_METAL

/turf/open/floor/plating/polovich/metallicfloor/second
	name = "Metallic Floor"
	desc = "This is brutal."
	icon_state = "metallicfloor2"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_METAL
	barefootstep = FOOTSTEP_METAL
	clawfootstep = FOOTSTEP_METAL
	heavyfootstep = FOOTSTEP_METAL

/turf/open/floor/plating/polovich/magicsteel
	name = "Magic Floor"
	desc = "This is magically and steel."
	icon_state = "steelmagic"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_METAL
	barefootstep = FOOTSTEP_METAL
	clawfootstep = FOOTSTEP_METAL
	heavyfootstep = FOOTSTEP_METAL

/turf/open/floor/plating/polovich/kollo
	name = "Magic Floor"
	desc = "This is magically."
	icon_state = "kollo"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_METAL
	barefootstep = FOOTSTEP_METAL
	clawfootstep = FOOTSTEP_METAL
	heavyfootstep = FOOTSTEP_METAL

/turf/open/floor/plating/polovich/bronzefloor
	name = "Bronze Floor"
	desc = "This is expensive."
	icon_state = "bronzecool"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_METAL
	barefootstep = FOOTSTEP_METAL
	clawfootstep = FOOTSTEP_METAL
	heavyfootstep = FOOTSTEP_METAL

/turf/open/floor/plating/polovich/stonestone
	name = "Пол"
	desc = "Брутально и древне. А ведь, ещё давно кто-то сражался на нём."
	icon_state = "rockfloor"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/warlocksticky
	name = "Evil Floor"
	desc = "This is evil and sticky."
	icon_state = "warlocksticky"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_MEAT
	barefootstep = FOOTSTEP_MEAT
	clawfootstep = FOOTSTEP_MEAT
	heavyfootstep = FOOTSTEP_MEAT
	slowdown = 2

/turf/open/floor/plating/polovich/warlocksticky/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/albin_meat
	name = "Meat Floor"
	desc = "This is evil and sticky."
	icon_state = "albin_meat"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_MEAT
	barefootstep = FOOTSTEP_MEAT
	clawfootstep = FOOTSTEP_MEAT
	heavyfootstep = FOOTSTEP_MEAT
	slowdown = 2

/turf/open/floor/plating/polovich/albin_meat/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/muddmy
	name = "Evil Mud"
	desc = "This is evil and sticky."
	icon_state = "evilmud"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_MEAT
	barefootstep = FOOTSTEP_MEAT
	clawfootstep = FOOTSTEP_MEAT
	heavyfootstep = FOOTSTEP_MEAT
	slowdown = 2

/turf/open/floor/plating/polovich/muddmy/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/muddmy/second
	icon_state = "evilmud2"

/turf/open/floor/plating/polovich/muddmy/second/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/sea/gelatinea
	name = "Mesopelagic Gelatine"
	desc = "So pleasing to the eye."
	icon_state = "gelatinea"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_MEAT
	barefootstep = FOOTSTEP_MEAT
	clawfootstep = FOOTSTEP_MEAT
	heavyfootstep = FOOTSTEP_MEAT
	slowdown = 1

/turf/open/floor/plating/polovich/sea/gelatinea/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/slush
	name = "Слякоть"
	desc = "Так грустно."
	icon_state = "muddymud"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_MEAT
	barefootstep = FOOTSTEP_MEAT
	clawfootstep = FOOTSTEP_MEAT
	heavyfootstep = FOOTSTEP_MEAT
	slowdown = 3

/turf/open/floor/plating/polovich/slush/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/slushy
	name = "Слякоть"
	desc = "Так грустно."
	icon_state = "mudacid"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_MEAT
	barefootstep = FOOTSTEP_MEAT
	clawfootstep = FOOTSTEP_MEAT
	heavyfootstep = FOOTSTEP_MEAT
	slowdown = 3

/turf/open/floor/plating/polovich/slushy/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/slushyy
	name = "Slush Floor"
	desc = "This is so sad."
	icon_state = "mudacid2"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_MEAT
	barefootstep = FOOTSTEP_MEAT
	clawfootstep = FOOTSTEP_MEAT
	heavyfootstep = FOOTSTEP_MEAT
	slowdown = 3

/turf/open/floor/plating/polovich/slushyy/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/slush/mud
	name = "Slush Floor"
	desc = "This is so sad."
	icon_state = "muddymudd"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_MEAT
	barefootstep = FOOTSTEP_MEAT
	clawfootstep = FOOTSTEP_MEAT
	heavyfootstep = FOOTSTEP_MEAT
	slowdown = 3

/turf/open/floor/plating/polovich/slush/mud/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/slush/mudd
	name = "Slush Floor"
	desc = "This is so sad."
	icon_state = "muddymuddd"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_MEAT
	barefootstep = FOOTSTEP_MEAT
	clawfootstep = FOOTSTEP_MEAT
	heavyfootstep = FOOTSTEP_MEAT
	slowdown = 3

/turf/open/floor/plating/polovich/slush/mudd/Initialize(mapload)
	. = ..()
	dir = rand(0,8)

/turf/open/floor/plating/polovich/evilevil
	name = "Evil Floor"
	desc = "This is evil and sticky."
	icon_state = "hryaz"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_MEAT
	barefootstep = FOOTSTEP_MEAT
	clawfootstep = FOOTSTEP_MEAT
	heavyfootstep = FOOTSTEP_MEAT
	slowdown = 2

/turf/open/floor/plating/polovich/evilevil/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/rockydarkness
	name = "Stone Floor"
	desc = "This is interesting and neutral."
	icon_state = "rockydarkness"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/rockydarevil
	name = "Stone Floor"
	desc = "This is interesting and mortal."
	icon_state = "stoneydeatth"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/rockydarevil/second
	name = "Stone Floor"
	desc = "This is interesting and mortal."
	icon_state = "stoneydeath"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/rockyhorrr
	name = "Stone Floor"
	desc = "This is interesting and neutral."
	icon_state = "rockhorror"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/rockedar
	name = "Stone Floor"
	desc = "This is interesting and neutral."
	icon_state = "rockhorror2"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/rockedar/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/rockedarr
	name = "Stone Floor"
	desc = "This is interesting and neutral."
	icon_state = "rockydarkness2"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/rockedarr/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/rockedarrr
	name = "Stone Floor"
	desc = "This is interesting and neutral."
	icon_state = "rockydarkness3"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/rockedarrr/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/*
	mood_turf_mes = "<span class='bloody'>Is this floor - EVIL!</span>\n"
	mood_bonus_turf = -2
	slowdown = 1

/turf/open/floor/plating/polovich/stonestonestone
	name = "Stone Floor"
	desc = "This is interesting and good."
	icon_state = "pinkstonee"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE
*/
/turf/open/floor/plating/polovich/stonestonestone/two
	name = "Stone Floor"
	desc = "This is good."
	icon_state = "verycoolstone"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/stonestonestone/two/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/stonestonestone/three
	name = "Stone Floor"
	desc = "This is evil."
	icon_state = "evilstoneyy"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/stonestonestone/three/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/stoneekas
	name = "Stone Floor"
	desc = "This is evil."
	icon_state = "stoneeyyyas"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/stoneekasas
	name = "Stone Floor"
	desc = "This is depressed."
	icon_state = "stoneyyyy"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/stoneekasasdarkk
	name = "Wooden Floor"
	desc = "This is devasted."
	icon_state = "darknessdarkl"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_WOOD
	barefootstep = FOOTSTEP_WOOD_BAREFOOT
	clawfootstep = FOOTSTEP_WOOD_CLAW
	heavyfootstep = FOOTSTEP_WOOD
	resistance_flags = FLAMMABLE

/turf/open/floor/plating/polovich/tilefloor
	name = "Blue Floor"
	desc = "Interesting..."
	icon_state = "tilefloor"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/stonestonestone/evilstoney
	name = "Stone Floor"
	desc = "This is evil."
	icon_state = "evilstoney"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/stonestonestone/evilstoney/Initialize(mapload)
	. = ..()
	dir = rand(0,8)

/turf/open/floor/plating/polovich/metalnoble
	name = "Metallic Floor"
	desc = "This is expensive."
	icon_state = "metalnoble1"
	icon = 'modular_pod/icons/turf/floors.dmi'
	attachment_holes = FALSE
	footstep = FOOTSTEP_METAL
	barefootstep = FOOTSTEP_METAL
	clawfootstep = FOOTSTEP_METAL
	heavyfootstep = FOOTSTEP_METAL

/turf/open/floor/plating/polovich/metalnoble/second
	name = "Metallic Floor"
	desc = "This is expensive."
	icon_state = "metalnoble2"
	icon = 'modular_pod/icons/turf/floors.dmi'
	attachment_holes = FALSE
	footstep = FOOTSTEP_METAL
	barefootstep = FOOTSTEP_METAL
	clawfootstep = FOOTSTEP_METAL
	heavyfootstep = FOOTSTEP_METAL

/turf/open/floor/plating/polovich/temnoo/experimental
	name = "Tendance Stone"
	icon_state = "verycoolstone"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE
//	var/flickering_floor = 0
	var/min_r = 0
	var/min_g = 0
	var/min_b = 0
	var/max_r = 255
	var/max_g = 255
	var/max_b = 255

/turf/open/floor/plating/polovich/temnoo/experimental/Initialize(mapload)
	color = rgb(rand(min_r, max_r), rand(min_g, max_g), rand(min_b, max_b))
/*
/turf/open/floor/plating/polovich/experimental/New()
	if(flickering_floor)
		var/list/col_filter_twothird = list(1,0,0,0, 0,0.68,0,0, 0,0,1,0, 0,0,0,1, 0,0,0,0)
		var/list/col_filter_light = list(1,0,0,0, 0,1,0,0, 0,0,1,0, 0,0,0,1, 0.1,0.2,0.2,0)
		var/list/col_filter_lightt = list(1,0,0,0, 0,1,0,0, 0,0,1,0, 0,0,0,1, 0.3,0.1,0.1,0)
		var/list/col_filter_half = list(1,0,0,0, 0,0.42,0,0, 0,0,1,0, 0,0,0,1, 0,0,0,0)
		var/list/col_filter_empty = list(1,0,0,0, 0,0,0,0, 0,0,1,0, 0,0,0,1, 0,0,0,0)
		add_filter("turfcolor", 10, color_matrix_filter(col_filter_twothird, FILTER_COLOR_HCY))
		add_filter("turflightness", 10, color_matrix_lightness(col_filter_light, 0.3))

	for(var/filter in src.get_filters("turfcolor"))
		animate(filter, loop = -1, color = col_filter_twothird, time = 4 SECONDS, easing = QUAD_EASING | EASE_IN, flags = ANIMATION_PARALLEL)
		animate(color = col_filter_twothird, time = 6 SECONDS, easing = QUAD_EASING | EASE_IN)
		animate(color = col_filter_half, time = 3 SECONDS, easing = QUAD_EASING | EASE_IN)
		animate(color = col_filter_empty, time = 2 SECONDS, easing = QUAD_EASING | EASE_IN)
		animate(color = col_filter_half, time = 24 SECONDS, easing = QUAD_EASING | EASE_IN)
		animate(color = col_filter_twothird, time = 12 SECONDS, easing = QUAD_EASING | EASE_IN)
	for(var/filter in src.get_filters("turflightness"))
		animate(filter, loop = -1, color = col_filter_light, time = 4 SECONDS, easing = QUAD_EASING | EASE_IN, flags = ANIMATION_PARALLEL)
		animate(color = col_filter_light, time = 6 SECONDS, easing = QUAD_EASING | EASE_IN)
		animate(color = col_filter_lightt, time = 3 SECONDS, easing = QUAD_EASING | EASE_IN)
		animate(color = col_filter_light, time = 13 SECONDS, easing = QUAD_EASING | EASE_IN)
*/
/*
			spawn while(1)
				set_light(3)
				sleep(3)
				set_light(2)
				sleep(3)
				set_light(3)
				sleep(3)
				set_light(2)
				sleep(3)
				set_light(3)
				sleep(3)
				set_light(4)
				sleep(3)
				set_light(2)
				sleep(3)
				set_light(3)
				sleep(3)
*/
