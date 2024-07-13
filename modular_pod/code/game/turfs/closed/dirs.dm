/turf/podpol
	name = "Стена"
	desc = "Стрёмно!"
	icon = 'icons/wall.dmi'
	icon_state = "wall"
	base_icon_state = "wall"
	var/wallis = TRUE
	var/state1 = "wall1"
	var/state2 = "wall2"
	baseturfs = /turf/open/floor/plating/polovich/codec/dirt/mud
	var/personal_turf = /turf/open/floor/plating/polovich/codec/dirt/mud

/turf/podpol/Initialize(mapload)
	. = ..()
	if(wallis)
		update_icon_pod()

/turf/podpol/proc/update_icon_pod()
	icon_state = state2
	var/list/surround = list(0, 0, 0, 0) //up, down, right, left
	if(istype(locate(x, y + 1, z), type))
		surround[1] = 1
	if(istype(locate(x, y - 1, z), type))
		surround[2] = 1
	if(istype(locate(x + 1, y, z), type))
		surround[3] = 1
	if(istype(locate(x - 1, y, z), type))
		surround[4] = 1
	switch(list2params(surround))
		if("1&0&0&0")
			dir = NORTH
		if("0&1&0&0")
			dir = SOUTH
		if("0&0&1&0")
			dir = EAST
		if("0&0&0&1")
			dir = WEST
		if("0&1&0&1")
			dir = NORTHWEST
		if("1&0&0&1")
			dir = SOUTHWEST
		if("0&1&1&0")
			dir = NORTHEAST
		if("1&0&1&0")
			dir = SOUTHEAST

		if("1&0&1&1")
			icon_state = state1
			dir = SOUTHEAST
		if("0&1&1&1")
			icon_state = state1
			dir = SOUTHWEST
		if("1&1&1&0")
			icon_state = state1
			dir = NORTHEAST
		if("1&1&0&1")
			icon_state = state1
			dir = NORTHWEST
		if("1&1&0&0")
			icon_state = state1
			dir = SOUTH
		if("0&0&1&1")
			icon_state = state1
			dir = NORTH
		if("1&1&1&1")
			icon_state = state1
			dir = EAST
		else
			icon_state = state1
			dir = WEST

/turf/podpol/wall/Destroy()
	if(cantbreak)
		return
//	ChangeTurf(personal_turf, null, CHANGETURF_IGNORE_AIR)
//	for(var/turf/podpol/wall/F in oview(1, personal_turf))
//		F.update_icon_pod()

/turf/podpol/wall
	plane = GAME_PLANE
	inspect_icon_state = "wall"
	max_integrity = 500
	blocks_air = TRUE
	pass_flags_self = PASSCLOSEDTURF
	density = TRUE
	layer = CLOSED_TURF_LAYER
	opacity = TRUE
	clingable = TRUE
	var/cantbreak = FALSE
	var/powerwall = 10
	var/hardness = 40
	var/mineable = TRUE
	var/mine_hp = 3
	var/ore_type = /obj/item/stone
	var/ore_amount = 1
	var/defer_change = TRUE

/turf/podpol/wall/on_rammed(mob/living/carbon/rammer)
	rammer.ram_stun()
	var/smash_sound = pick('modular_septic/sound/gore/smash1.ogg',
						'modular_septic/sound/gore/smash2.ogg',
						'modular_septic/sound/gore/smash3.ogg')
	playsound(src, smash_sound, 75)
	rammer.sound_hint()

/turf/podpol/wall/ex_act(severity, target)
	if(cantbreak)
		return
/*
	if(target == src)
//		qdel(src)
		ChangeTurf(/turf/open/floor/plating/polovich/codec/dirt/mud, null, CHANGETURF_IGNORE_AIR)
		return

	switch(severity)
		if(EXPLODE_DEVASTATE)
			//SN src = null
			ChangeTurf(/turf/open/floor/plating/polovich/codec/dirt/mud, null, CHANGETURF_IGNORE_AIR)
			var/turf/NT = ScrapeAway()
			NT.contents_explosion(severity, target)
			return
		if(EXPLODE_HEAVY)
			ChangeTurf(/turf/open/floor/plating/polovich/codec/dirt/mud, null, CHANGETURF_IGNORE_AIR)
		if(EXPLODE_LIGHT)
			if (prob(hardness))
				ChangeTurf(/turf/open/floor/plating/polovich/codec/dirt/mud, null, CHANGETURF_IGNORE_AIR)
*/
//	if(!density)
//		..()

/turf/podpol/wall/attackby(obj/item/W, mob/living/carbon/user, params)
	. = ..()
	if(.)
		return

	if(user.a_intent == INTENT_GRAB)
		if(istype(W, /obj/item/grab))
			var/obj/item/grab/G = W
			if((G.grasped_part?.body_zone == BODY_ZONE_PRECISE_FACE) || (G.grasped_part?.body_zone == BODY_ZONE_HEAD) || (G.grasped_part?.body_zone == BODY_ZONE_PRECISE_NECK))
				var/mob/living/GR = user.pulling
				if(GR == null)
					return
				if(GR.body_position == STANDING_UP)
					var/obj/item/bodypart/head = GR.get_bodypart_nostump(BODY_ZONE_HEAD)
					if(head)
						var/damage = ((GET_MOB_ATTRIBUTE_VALUE(user, STAT_STRENGTH)/2) + src?.powerwall)
						GR.visible_message(span_pinkdang("[user] бьёт [GR] головой об [src]!"))
						head.receive_damage(brute = damage, wound_bonus = 2, sharpness = null)
						user.changeNext_move(CLICK_CD_GRABBING)
						user.adjustFatigueLoss(10)
						playsound(get_turf(GR), 'modular_pod/sound/eff/punch 1.ogg', 80, 0)
	if(mineable)
		if(mine_hp > 0)
			if(user.a_intent == INTENT_HARM)
				if(W.can_dig)
					user.visible_message(span_notice("[user] копает [src] с помощью [W]."),span_notice("Я копаю [src] с помощью [W]."), span_hear("Я слышу звуки раскопок."))
					user.changeNext_move(W.attack_delay)
					user.adjustFatigueLoss(8)
					W.damageItem(10)
					playsound(get_turf(src), 'modular_pod/sound/eff/hitwallpick.ogg', 90 , FALSE, FALSE)
					user.sound_hint()
					mine_hp -= 1
					var/diceroll = user.diceroll(GET_MOB_SKILL_VALUE(user, SKILL_MASONRY), context = DICE_CONTEXT_PHYSICAL)
					if(diceroll >= DICE_SUCCESS)
						user.visible_message(span_notice("[user] добывает руду."),span_notice("Я добываю руду."), span_hear("Я слышу звуки раскопок."))
						new ore_type(get_turf(user), ore_amount)
					if(diceroll == DICE_CRIT_FAILURE)
						var/dicerolll = user.diceroll(GET_MOB_ATTRIBUTE_VALUE(user, STAT_PERCEPTION), context = DICE_CONTEXT_MENTAL)
						if(dicerolll == DICE_CRIT_FAILURE)
							user.visible_message(span_notice("[user] провалился в попытке прокопать [src] с помощью [W]!"),span_notice("Я провалился в попытке прокопать [src] с помощью [W]!"), span_hear("Я слышу звуки раскопок."))
							user.apply_damage(15, BRUTE, BODY_ZONE_HEAD, user.run_armor_check(BODY_ZONE_HEAD, MELEE), wound_bonus = 5, sharpness = NONE)
						else
							user.visible_message(span_notice("[user] тупо копает [src] с помощью [W]."),span_notice("Я тупо копаю [src] с помощью [W]."), span_hear("Я слышу звуки раскопок"))
		else
			if(user.a_intent == INTENT_HARM)
				if(W.can_dig)
					user.visible_message(span_notice("[user] разрушает [src] с помощью [W]."),span_notice("Я разрушаю [src] с помощью [W]."), span_hear("Я слышу звуки раскопок."))
					user.changeNext_move(W.attack_delay)
					user.adjustFatigueLoss(8)
					W.damageItem(10)
					user.sound_hint()

					var/flags = NONE
					var/old_type = type
					if(defer_change)
						flags = CHANGETURF_DEFER_CHANGE
					var/turf/open/mined = ScrapeAway(null, flags)
					addtimer(CALLBACK(src, TYPE_PROC_REF(/turf, AfterChange), flags, old_type), 1, TIMER_UNIQUE)
					playsound(src, 'sound/effects/break_stone.ogg', 50, TRUE)
					mined.update_visuals()
					var/turf/mineturf = get_turf(src)
					mineturf.pollute_turf(/datum/pollutant/dust, 200)
//					if(!QDELETED(mineturf))
//						qdel(mineturf)

/turf/podpol/wall/get_projectile_hitsound(obj/projectile/projectile)
	return "modular_septic/sound/bullet/projectile_impact/ric_stone[rand(1,3)].ogg"

/turf/podpol/wall/darkyw
	icon = 'modular_pod/icons/turf/closed/europ.dmi'

/turf/podpol/wall/darkyw/get_projectile_hitsound(obj/projectile/projectile)
	return "modular_septic/sound/bullet/projectile_impact/ric_wood[rand(1,5)].ogg"

/turf/podpol/wall/grewich
	icon = 'modular_pod/icons/turf/closed/grewich.dmi'

/turf/podpol/wall/grewich/get_projectile_hitsound(obj/projectile/projectile)
	return "modular_septic/sound/bullet/projectile_impact/ric_metal[rand(1,5)].ogg"

/turf/podpol/wall/steel
	icon = 'modular_pod/icons/turf/closed/steel.dmi'
	cantbreak = TRUE
	mineable = FALSE

/turf/podpol/wall/steel/get_projectile_hitsound(obj/projectile/projectile)
	return "modular_septic/sound/bullet/projectile_impact/ric_metal[rand(1,5)].ogg"

/turf/podpol/wall/stal
	icon = 'modular_pod/icons/turf/closed/stal.dmi'
	cantbreak = TRUE
	mineable = FALSE

/turf/podpol/wall/stal/get_projectile_hitsound(obj/projectile/projectile)
	return "modular_septic/sound/bullet/projectile_impact/ric_metal[rand(1,5)].ogg"

/turf/podpol/wall/shroom
	icon = 'modular_pod/icons/turf/closed/cavero.dmi'
	mine_hp = 1
	baseturfs = /turf/open/floor/plating/polovich/way/dirtyd
	personal_turf = /turf/open/floor/plating/polovich/way/dirtyd
	var/random = TRUE

/turf/podpol/wall/shroom/get_projectile_hitsound(obj/projectile/projectile)
	return "modular_septic/sound/bullet/projectile_impact/ric_wood[rand(1,5)].ogg"

/turf/podpol/wall/shroom/Initialize(mapload)
	. = ..()
	if(random)
		if(prob(30))
			new /obj/structure/sign/poster/contraband/codec/lians(get_turf(src))

/turf/podpol/wall/caver
	icon = 'modular_pod/icons/turf/closed/mount.dmi'
	var/random = TRUE

/turf/podpol/wall/caver/Initialize(mapload)
	. = ..()
	if(random)
		if(prob(30))
			new /obj/structure/sign/poster/contraband/codec/lians(get_turf(src))

/turf/podpol/wall/caver/get_projectile_hitsound(obj/projectile/projectile)
	return "modular_septic/sound/bullet/projectile_impact/ric_stone[rand(1,3)].ogg"

/turf/podpol/wall/caverak
	icon = 'modular_pod/icons/turf/closed/cavera.dmi'
	var/random = TRUE

/turf/podpol/wall/caverak/Initialize(mapload)
	. = ..()
	if(random)
		if(prob(30))
			new /obj/structure/sign/poster/contraband/codec/purpella(get_turf(src))

/turf/podpol/wall/caverak/get_projectile_hitsound(obj/projectile/projectile)
	return "modular_septic/sound/bullet/projectile_impact/ric_stone[rand(1,3)].ogg"

/*
/turf/open/floor/plating/polovich/way/evilcaver
	name = "Грязь"
	icon = 'modular_pod/icons/turf/closed/caverfloor'
	icon_state = "evilmud"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_SAND
	var/wallis = TRUE
	var/cantbreak = TRUE

/turf/open/floor/plating/polovich/way/evilcaver/Initialize(mapload)
	. = ..()
	if(wallis)
		update_icon_pod()

/turf/open/floor/plating/polovich/way/evilcaver/proc/update_icon_pod()
	icon_state = state2
	var/list/surround = list(0, 0, 0, 0) //up, down, right, left
	if(istype(locate(x, y + 1, z), type))
		surround[1] = 1
	if(istype(locate(x, y - 1, z), type))
		surround[2] = 1
	if(istype(locate(x + 1, y, z), type))
		surround[3] = 1
	if(istype(locate(x - 1, y, z), type))
		surround[4] = 1
	switch(list2params(surround))
		if("1&0&0&0")
			dir = NORTH
		if("0&1&0&0")
			dir = SOUTH
		if("0&0&1&0")
			dir = EAST
		if("0&0&0&1")
			dir = WEST
		if("0&1&0&1")
			dir = NORTHWEST
		if("1&0&0&1")
			dir = SOUTHWEST
		if("0&1&1&0")
			dir = NORTHEAST
		if("1&0&1&0")
			dir = SOUTHEAST

		if("1&0&1&1")
			icon_state = state1
			dir = SOUTHEAST
		if("0&1&1&1")
			icon_state = state1
			dir = SOUTHWEST
		if("1&1&1&0")
			icon_state = state1
			dir = NORTHEAST
		if("1&1&0&1")
			icon_state = state1
			dir = NORTHWEST
		if("1&1&0&0")
			icon_state = state1
			dir = SOUTH
		if("0&0&1&1")
			icon_state = state1
			dir = NORTH
		if("1&1&1&1")
			icon_state = state1
			dir = EAST
		else
			icon_state = state1
			dir = WEST

/turf/open/floor/plating/polovich/way/evilcaver/Destroy()
	if(cantbreak)
		return
	ChangeTurf(personal_turf, null, CHANGETURF_IGNORE_AIR)
	for(var/turf/open/floor/plating/polovich/way/evilcaver/F in oview(1, personal_turf))
		F.update_icon_pod()
	..()
*/
