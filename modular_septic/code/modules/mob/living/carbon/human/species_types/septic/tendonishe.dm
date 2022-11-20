/datum/species/tendonishe
	name = "Tendonishe"
	id = SPECIES_TENDONISHE
	default_color = "FFFFFF"
	species_traits = list(HAS_FLESH)
	inherent_traits = list(
//		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
//		TRAIT_CAN_USE_FLIGHT_POTION,
	)
	mutant_bodyparts = list()
	bodypart_overides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/tendonishe,
		BODY_ZONE_PRECISE_L_HAND = /obj/item/bodypart/l_hand/tendonishe,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/tendonishe,
		BODY_ZONE_PRECISE_R_HAND = /obj/item/bodypart/r_hand/tendonishe,
		BODY_ZONE_PRECISE_L_EYE = /obj/item/bodypart/l_eyelid/tendonishe,
		BODY_ZONE_PRECISE_R_EYE = /obj/item/bodypart/r_eyelid/tendonishe,
		BODY_ZONE_PRECISE_FACE = /obj/item/bodypart/face/tendonishe,
		BODY_ZONE_PRECISE_MOUTH = /obj/item/bodypart/mouth/tendonishe,
		BODY_ZONE_PRECISE_NECK = /obj/item/bodypart/neck/tendonishe,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/tendonishe,
		BODY_ZONE_L_LEG = /obj/item/bodypart/l_leg/tendonishe,
		BODY_ZONE_PRECISE_L_FOOT = /obj/item/bodypart/l_foot/tendonishe,
		BODY_ZONE_R_LEG = /obj/item/bodypart/r_leg/tendonishe,
		BODY_ZONE_PRECISE_R_FOOT = /obj/item/bodypart/r_foot/tendonishe,
		BODY_ZONE_PRECISE_GROIN = /obj/item/bodypart/groin/tendonishe,
		BODY_ZONE_PRECISE_VITALS = /obj/item/bodypart/vitals/tendonishe,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/tendonishe,
	)
	no_equip = list(ITEM_SLOT_LEAR,
					ITEM_SLOT_REAR,
					ITEM_SLOT_EYES,
					ITEM_SLOT_NECK,
					ITEM_SLOT_OCLOTHING,
					ITEM_SLOT_BELT,
					ITEM_SLOT_GLOVES,
					ITEM_SLOT_LWRIST,
					ITEM_SLOT_RWRIST,
					ITEM_SLOT_FEET,
					ITEM_SLOT_ICLOTHING,
					ITEM_SLOT_SUITSTORE)
	skinned_type = /obj/item/stack/sheet/animalhide/human
	liked_food = RAW | MEAT | GROSS
	disliked_food = NUTS | CLOTH
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | RACE_SWAP
	attribute_sheet = /datum/attribute_holder/sheet/job/tendonishe
	limbs_id = "tendonishe"
	examine_icon = 'modular_septic/icons/obj/items/deviouslick.dmi'
	examine_icon_state = "tendonishe"
	armor = 50

/datum/species/tendonishe/handle_hair(mob/living/carbon/human/H, forced_colour)
	H.remove_overlay(HAIR_LAYER)
/*
#define cycle_pause 15 //min 1
#define viewrange 4 //min 2

#define TENDON_SLEEP 0
#define TENDON_ATTACK 1
#define TENDON_IDLE 2

var/michael_shepard = FALSE

/mob/living/carbon/human/species/tendonishe/bot/Move()
	..()
	if(stat != CONSCIOUS)
		return
	if(prob(6))
		say(pick(bumquotes))
	if(prob(0.5))
		emote(pick("cry","scream","laugh"))

var/list/bumquotes = list("Cold... So cold...","Did you know?","People are so stupid compared to me.","Are we there yet?","Not enough love.","This fortress is my substitute for love.","Everything is fake.","I can't keep it in my mind. Can you help me?","Well, as usual","Vampires drink blood.","But if these ravens disappear one of these nights, the sun will still shine forever.","We need to endure it a little.","Today is just like yesterday.","It would be fun, but no.","Will I die in a great way?","I make a mistake here.","You've changed!","Long ago, I was a lord.","Meat eaters, bone gnawlers, skin lickers...","Foe","HOW DOES IT FEEL?!","I was told I do.", "I'm not a bum, I'm sapient!", "Who am I? I'm a hard worker. I set high goals and I've been told that I'm persistent.", "I surrender!")

/mob/living/carbon/human/species/tendonishe/bot
//	name = "Tendonishe"
	a_intent = INTENT_GRAB
//	density = 1
	var/list/path = new/list()
	var/frustration = 0
	var/atom/object_target
	var/reach_unable
	var/mob/living/carbon/target
	var/list/path_target = new/list()
	bot = 1
	var/list/path_idle = new/list()
	var/list/objects
	armor = 40

	New()
		..()
		sleep(10)
		if(!mind)
			mind = new /datum/mind(src)
		// main loop
		spawn while(stat != DEAD && bot)
			sleep(cycle_pause)
			src.process()
		zone_selected == BODY_ZONE_PRECISE_NECK
		fully_replace_character_name(null, pick("Tendonishe", "Tight Grabber", "Grabber"))
//		job = "Bum"
		if(prob(30))
			say(pick(bumquotes))

	// this is called when the target is within one tile
	// of distance from the zombie
	proc/attack_target(var/mob/living/carbon/human/target)
		if(!target)
			return
		if(target?.stat != CONSCIOUS && prob(70))
			return
		var/direct = get_dir(src, target)
		if ( (direct - 1) & direct)
			var/turf/Step_1
			var/turf/Step_2
			switch(direct)
				if(EAST|NORTH)
					Step_1 = get_step(src, NORTH)
					Step_2 = get_step(src, EAST)

				if(EAST|SOUTH)
					Step_1 = get_step(src, SOUTH)
					Step_2 = get_step(src, EAST)

				if(NORTH|WEST)
					Step_1 = get_step(src, NORTH)
					Step_2 = get_step(src, WEST)

				if(SOUTH|WEST)
					Step_1 = get_step(src, SOUTH)
					Step_2 = get_step(src, WEST)

			if(Step_1 && Step_2)
				var/check_1 = 1
				var/check_2 = 1

				check_1 = Adjacent(get_turf(src), Step_1, target) && Adjacent(Step_1, get_turf(target), target)

				check_2 = Adjacent(get_turf(src), Step_2, target) && Adjacent(Step_2, get_turf(target), target)

				if(check_1 || check_2)
					target.grabbedby(src)
					//((grab_mode == GM_STRANGLE) && active)
					//target.active
					target.strangle()
//					target.grippedby(src)
					return
				else
					var/obj/structure/table/W = locate() in target.loc
					var/obj/structure/table/WW = locate() in src.loc
					if(W)
						W.do_climb(src)
						return 1
					else if(WW)
						WW.do_climb(src)
						return 1
/*					var/obj/structure/window/W = locate() in target.loc
					var/obj/structure/window/WW = locate() in src.loc
					if(W)
						if(src.r_hand || src.l_hand)
							if(r_hand)
								W.attackby(r_hand, src)
							else
								if(l_hand)
									W.attackby(l_hand, src)
						else
							W.attack_hand(src)
						return 1
					else if(WW)
						if(src.r_hand || src.l_hand)
							if(r_hand)
								WW.attackby(r_hand, src)
							else if(l_hand)
								WW.attackby(l_hand, src)
						else
							WW.attack_hand(src)
						return 1*/
		else if(Adjacent(src?.loc , target?.loc,target))
			if(src.r_hand || src.l_hand)
				if(r_hand && istype(r_hand, /obj/item))
					target.attackby(r_hand, src)
				else
					if(l_hand && istype(l_hand, /obj/item))
						target.attackby(l_hand, src)
			else
				target.grabbedby(src)
				target.strangle()
			//target.attack_hand(src)
			// sometimes push the enemy
			if(prob(80))
				if(prob(10))
					step(src,direct)
				else
					if(prob(80))
						say(pick(bumquotes))
					else
						if(prob(80))
							say(pick(bumquotes))
			return 1
		else
			var/obj/structure/window/W = locate() in target.loc
			var/obj/structure/window/WW = locate() in src.loc
			if(W)
				if(src.r_hand || src.l_hand)
					if(r_hand)
						W.attackby(r_hand, src)
					else
						if(l_hand)
							W.attackby(l_hand, src)
				else
					W.attack_hand(src)
				return 1
			else if(WW)
				if(r_hand)
					WW.attackby(r_hand, src)
				else if(l_hand)
					WW.attackby(l_hand, src)
				else
					WW.attack_hand(src)
				return 1

	// main loop
	proc/process()
		if (stat == DEAD)
			return 0
		if(weakened || paralysis || handcuffed || !canmove)
			return 1
		if(resting)
			mob_rest()
			return

		if(destroy_on_path())
			return 1

		combat_mode = 0
		if(target)
			// change the target if there is another human that is closer
			if(prob(30))
				target = null
			for (var/mob/living/carbon/C in orange(2,src.loc))
				if (C.stat == DEAD || !can_see(src,C,viewrange))
					continue
				if (istype(C, /mob/living/carbon/human/species/tendonishe/bot))
					continue
				if(get_dist(src, target) >= get_dist(src, C) && prob(30))
					target = C
					break

			if(target?.stat == DEAD)
				target = null

			var/distance = get_dist(src, target)

			if(target in orange(viewrange,src))
				if(distance <= 1)
					if(attack_target())
						var/turf/T = get_step(src, target.dir)
						for(var/atom/A in T.contents)
							if(A.density)
								return 1
						if(!T.density)
							Move(T)
						return 1
				if(step_towards_3d(src,target))
					return 1
			else
				target = null
				return 1
		if(prob(20))
			step_rand(src)
		for(var/mob/living/carbon/human/H in orange(1, src.loc))
			if (!istype(H, /mob/living/carbon/human/species/tendonishe/bot))
				combat_mode = 1
				if(prob(75))
					var/face = 0
					if(src.grabbedby(target))
						for(var/x = 1; x <= src.grabbedby(target); x++)
							if(grabbed_by[x])
								face = 1
								break

					if(face)
						resist()
					if(!face)
						dir = get_dir(src, H)
						attack_target(H)
					target = H
				return 1
		return

	// destroy items on the path
	proc/destroy_on_path()
		// if we already have a target, use that
		if(object_target)
			if(!object_target.density)
				object_target = null
				frustration = 0
			else
				// we know the target has attack_hand
				// since we only use such objects as the target
				object_target:attack_hand(src)
				return 1

		// first, try to destroy airlocks and walls that are in the way
		/*
		if(locate(/obj/machinery/door/airlock) in get_step(src,src.dir))
			var/obj/machinery/door/airlock/D = locate() in get_step(src,src.dir)
			if(D)
				if(D.density && !(locate(/turf/space) in range(1,D)) )
					D.attack_hand(src)
					object_target = D
					return 1
		// before clawing through walls, try to find a direct path first
		if(frustration > 8 )
			if(istype(get_step(src,src.dir),/turf/simulated/wall))
				var/turf/simulated/wall/W = get_step(src,src.dir)
				if(W)
					if(W.density && !(locate(/turf/space) in range(1,W)))
						W.attack_hand(src)
						object_target = W
						return 1
		return 0
		*/

	death()
		..()
		target = null
*/