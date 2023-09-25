/turf/closed/wall
	icon = 'modular_septic/icons/turf/tall/walls/victorian.dmi'
	frill_icon = 'modular_septic/icons/turf/tall/walls/frills/victorian_frill.dmi'
	icon_state = "wall-0"
	base_icon_state = "wall"
	clingable = TRUE
	smoothing_groups = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_WALLS)
	canSmoothWith = list(SMOOTH_GROUP_WALLS, SMOOTH_GROUP_LOW_WALLS)
	decon_type = /turf/open/floor/plating/polovich/dirt/blueee
	girder_type = null
	var/mineable = TRUE
	var/mine_hp = 8
	var/ore_type = /obj/item/stone
	var/ore_amount = 1
	var/defer_change = TRUE
	sheet_type = null
	sheet_amount = null
//	turf_height = TURF_HEIGHT_BLOCK_THRESHOLD_TEST

/turf/closed/wall/get_projectile_hitsound(obj/projectile/projectile)
	return "modular_septic/sound/bullet/projectile_impact/ric_metal[rand(1,5)].ogg"

/turf/closed/wall/attackby(obj/item/W, mob/living/carbon/user, params)
	. = ..()
	if(.)
		return
	if(mineable)
		if(mine_hp > 0)
			if(user.a_intent == INTENT_HARM)
				if(W.can_dig)
					user.visible_message(span_notice("[user] strikes the [src] with [W]."),span_notice("You strike the [src] with [W]."), span_hear("You hear the sound of mining."))
					user.changeNext_move(W.attack_delay)
					user.adjustFatigueLoss(10)
					W.damageItem(10)
					playsound(get_turf(src), 'modular_pod/sound/eff/hitwallpick.ogg', 90 , FALSE, FALSE)
					user.sound_hint()
					mine_hp -= 1
					var/diceroll = user.diceroll(GET_MOB_SKILL_VALUE(user, SKILL_MASONRY), context = DICE_CONTEXT_PHYSICAL)
					if(diceroll >= DICE_SUCCESS)
						user.visible_message(span_notice("[user] mines the ore."),span_notice("You mine the ore with [W]."), span_hear("You hear the sound of mining."))
						new ore_type(get_turf(user), ore_amount)
					if(diceroll == DICE_CRIT_FAILURE)
						var/dicerolll = user.diceroll(GET_MOB_ATTRIBUTE_VALUE(user, STAT_PERCEPTION), context = DICE_CONTEXT_MENTAL)
						if(dicerolll == DICE_CRIT_FAILURE)
							user.visible_message(span_notice("[user] failed to strike the [src] with [W]!"),span_notice("You failed to strike the [src] with [W]!"), span_hear("You hear the sound of mining."))
							user.apply_damage(15, BRUTE, BODY_ZONE_HEAD, user.run_armor_check(BODY_ZONE_HEAD, MELEE), wound_bonus = 5, sharpness = NONE)
						else
							user.visible_message(span_notice("[user] stupidly strikes the [src] with [W]."),span_notice("You stupidly strike the [src] with [W]."), span_hear("You hear the sound of mining."))
		else
			if(user.a_intent == INTENT_HARM)
				if(W.can_dig)
					user.visible_message(span_notice("[user] ruins the [src] with [W]."),span_notice("You ruin the [src] with [W]."), span_hear("You hear the sound of mining."))
					user.changeNext_move(W.attack_delay)
					user.adjustFatigueLoss(10)
					W.damageItem(10)
					user.sound_hint()
					var/flags = NONE
					var/old_type = type
					if(defer_change)
						flags = CHANGETURF_DEFER_CHANGE
					var/turf/open/mined = ScrapeAway(null, flags)
					addtimer(CALLBACK(src, .proc/AfterChange, flags, old_type), 1, TIMER_UNIQUE)
					playsound(src, 'sound/effects/break_stone.ogg', 50, TRUE)
					mined.update_visuals()
					var/turf/mineturf = get_turf(src)
					mineturf.pollute_turf(/datum/pollutant/dust, 100)

/turf/closed/wall/r_wall
	icon = 'modular_septic/icons/turf/tall/walls/reinforced_victorian.dmi'
	desc = "Strong wall!"
	frill_icon = 'modular_septic/icons/turf/tall/walls/frills/reinforced_victorian_frill.dmi'
	icon_state = "reinforced_wall-0"
	base_icon_state = "reinforced_wall"
	mine_hp = 11
	sheet_type = null
	sheet_amount = null

/turf/closed/wall/r_wall/alt
	icon = 'modular_septic/icons/turf/tall/walls/reinforced_victorian_alt.dmi'
	frill_icon = 'modular_septic/icons/turf/tall/walls/frills/reinforced_victorian_alt_frill.dmi'
	icon_state = "reinforced_wall-0"
	base_icon_state = "reinforced_wall"

/turf/closed/wall/r_wall/rusty
	icon = 'modular_septic/icons/turf/tall/walls/reinforced_rusty.dmi'
	frill_icon = 'modular_septic/icons/turf/tall/walls/frills/reinforced_rusty_frill.dmi'
	icon_state = "rusty_reinforced_wall-0"
	base_icon_state = "rusty_reinforced_wall"

/turf/closed/wall/pink_crazy
	icon = 'modular_septic/icons/turf/tall/walls/pink_crazy.dmi'
	frill_icon = 'modular_septic/icons/turf/tall/walls/frills/pink_crazy_frill.dmi'
	icon_state = "pink_crazy-0"
	base_icon_state = "pink_crazy"
	desc = "Strange wall."
	mine_hp = 6
	sheet_type = null
	sheet_amount = null

/turf/closed/wall/darkrock
	icon = 'modular_septic/icons/turf/tall/walls/rockcoolnew.dmi'
	frill_icon = 'modular_septic/icons/turf/tall/walls/frills/rockcoolnew_frill.dmi'
	icon_state = "wood_wall-0"
	base_icon_state = "wood_wall"
	desc = "So dark and evil!"
	mine_hp = 6
	sheet_type = null
	sheet_amount = null

/turf/closed/wall/darkrock/get_projectile_hitsound(obj/projectile/projectile)
	return "modular_septic/sound/bullet/projectile_impact/ric_stone[rand(1,3)].ogg"

/turf/closed/wall/mineral/wood
	icon = 'modular_septic/icons/turf/tall/walls/wood.dmi'
	frill_icon = 'modular_septic/icons/turf/tall/walls/frills/wood_frill.dmi'
	icon_state = "wood_wall-0"
	base_icon_state = "wood_wall"
	resistance_flags = FLAMMABLE
	desc = "Just wood wall."
	mine_hp = 4
	sheet_type = null
	sheet_amount = null

/turf/closed/wall/bluegreen
	icon = 'modular_septic/icons/turf/tall/walls/woodbluegreen.dmi'
	frill_icon = 'modular_septic/icons/turf/tall/walls/frills/woodbluegreen_frill.dmi'
	icon_state = "reinforced_wall-0"
	base_icon_state = "reinforced_wall"
	resistance_flags = FLAMMABLE
	desc = "Interesting wood wall."
	mine_hp = 4
	sheet_type = null
	sheet_amount = null

/turf/closed/wall/bluegreen/get_projectile_hitsound(obj/projectile/projectile)
	return "modular_septic/sound/bullet/projectile_impact/ric_wood[rand(1,4)].ogg"

/turf/closed/wall/mineral/wood/alt
	icon = 'modular_septic/icons/turf/tall/walls/wood_victorian.dmi'
	frill_icon = 'modular_septic/icons/turf/tall/walls/frills/wood_victorian_frill.dmi'
	icon_state = "wood_wall-0"
	base_icon_state = "wood_wall"
	resistance_flags = FLAMMABLE
	desc = "Just wood wall."

/turf/closed/wall/mineral/wood/get_projectile_hitsound(obj/projectile/projectile)
	return "modular_septic/sound/bullet/projectile_impact/ric_wood[rand(1,4)].ogg"

//Example smooth wall
/turf/closed/wall/smooth
	frill_icon = null

//NO   CLING!!!!!!!!!!!!!!!!!!!!!!!!!

/turf/closed/wall/pink_crazy/nocling
	desc = "Strange wall. Also you cant climb here."
	clingable = FALSE

/turf/closed/wall/r_wall/nocling
	desc = "Strong wall! Also you cant climb here."
	clingable = FALSE

/turf/closed/wall/r_wall/alt/nocling
	desc = "Strong wall! Also you cant climb here."
	clingable = FALSE

/turf/closed/wall/r_wall/rusty/nocling
	desc = "Rusty and strong wall! Also you cant climb here."
	clingable = FALSE

/turf/closed/wall/mineral/wood/nocling
	desc = "Just wood wall. Also you cant climb here."
	clingable = FALSE

/turf/closed/wall/mineral/wood/alt/nocling
	desc = "Just wood wall. Also you cant climb here."
	clingable = FALSE

/turf/closed/wall/bluegreen/nocling
	desc = "Interesting wood wall. Also you cant climb here."
	clingable = FALSE

/turf/closed/wall/darkrock/nocling
	desc = "So dark and evil! Also you cant climb here."
	clingable = FALSE

/turf/closed/wall/nocling
	desc = "Nice wall. Also you cant climb here."
	clingable = FALSE