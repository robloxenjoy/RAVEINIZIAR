/// How many tiles around the target the shooter can roam without losing their shot (mob must still be in view)
#define GUNPOINT_SHOOTER_STRAY_RANGE 14
/// How long it takes to reach stage 1 in case you unsteadied your aim so bad, it went to 0
#define GUNPOINT_DELAY_STAGE_1 1 SECONDS
/// How long it takes from stage 1 to reach stage 2
#define GUNPOINT_DELAY_STAGE_2 2 SECONDS
/// How long it takes from stage 2 to reach stage 3
#define GUNPOINT_DELAY_STAGE_3 6 SECONDS
/// How much we add to the modifier against target at stage 0
#define GUNPOINT_STAGE_0_MODIFIER 0
/// How much we add to the modifier against target at stage 1
#define GUNPOINT_STAGE_1_MODIFIER 2
/// How much we add to the modifier against target at stage 2
#define GUNPOINT_STAGE_2_MODIFIER 4
/// How much we add to the modifier against target at stage 3
#define GUNPOINT_STAGE_3_MODIFIER 6

/datum/component/gunpoint
	/// I want to stop this timer in case the guy unsteadies his aim while the aim is steadying
	var/steady_aim_timer
	/// This modifier is applied against whatever we are aiming at
	var/diceroll_modifier = 0
	/// Overlay we apply to the target while present
	var/mutable_appearance/target_overlay

/datum/component/gunpoint/Destroy(force, silent)
	remove_target_overlay()
	if(weapon)
		LAZYREMOVE(weapon.target_specific_diceroll, target)
	return ..()

/datum/component/gunpoint/Initialize(mob/living/target, obj/item/gun/weapon)
	if(!isliving(parent))
		return COMPONENT_INCOMPATIBLE

	var/mob/living/shooter = parent
	src.target = target
	src.weapon = weapon

	RegisterSignal(target, COMSIG_MOB_FIRED_GUN, .proc/trigger_reaction)

	LAZYSET(weapon.target_specific_diceroll, target, diceroll_modifier)
	RegisterSignal(weapon, list(COMSIG_ITEM_DROPPED, COMSIG_ITEM_EQUIPPED), .proc/cancel)

	shooter.visible_message(span_danger("<b>[shooter]</b> aims [weapon] at <b>[target]</b>!"), \
		span_danger("I aim [weapon]  at <b>[target]</b>!"), ignored_mobs = target)
	to_chat(target, span_userdanger("<b>[shooter]</b> aims [weapon] at me!"))
	apply_target_overlay()
	add_memory_in_range(target, 7, MEMORY_GUNPOINT, list(DETAIL_PROTAGONIST = target, DETAIL_DEUTERAGONIST = shooter, DETAIL_WHAT_BY = weapon), story_value = STORY_VALUE_OKAY, memory_flags = MEMORY_CHECK_BLINDNESS)

	shooter.apply_status_effect(STATUS_EFFECT_HOLDUP, shooter)
	target.apply_status_effect(STATUS_EFFECT_HELDUP, shooter)

	if(istype(weapon, /obj/item/gun/ballistic/rocketlauncher) && weapon.chambered)
		if(target.stat == CONSCIOUS && IS_NUKE_OP(shooter) && !IS_NUKE_OP(target) && (locate(/obj/item/disk/nuclear) in target.get_contents()) && shooter.client)
			shooter.client?.give_award(/datum/award/achievement/misc/rocket_holdup, shooter)
	else
		target.client?.give_award(/datum/award/achievement/misc/held_up)
	if(istype(weapon, /obj/item/gun/ballistic/automatic/remis/steyr))
		shooter.client?.give_award(/datum/award/achievement/misc/icanseeyou, shooter)

	if(weapon.aim_stress_sound)
		var/picked_sound = pick(weapon.aim_stress_sound)
		playsound(parent, picked_sound, weapon.aim_stress_sound_volume, weapon.aim_stress_sound_vary, -4)
		target.playsound_local(target, picked_sound, weapon.aim_stress_sound_volume, weapon.aim_stress_sound_vary)
		SEND_SIGNAL(weapon, COMSIG_GUNPOINT_GUN_AIM_STRESS_SOUNDED, picked_sound)

	SEND_SIGNAL(target, COMSIG_ADD_MOOD_EVENT, "gunpoint", /datum/mood_event/gunpoint)
	if(steady_aim_timer)
		deltimer(steady_aim_timer)
	steady_aim_timer = addtimer(CALLBACK(src, .proc/update_stage, 2), GUNPOINT_DELAY_STAGE_2, TIMER_STOPPABLE)

/datum/component/gunpoint/RegisterWithParent()
	RegisterSignal(parent, COMSIG_MOVABLE_MOVED, .proc/check_deescalate)
	RegisterSignal(parent, COMSIG_MOB_APPLY_DAMAGE, .proc/flinch)
	RegisterSignal(parent, COMSIG_MOB_ATTACK_HAND, .proc/check_shove)
	RegisterSignal(parent, COMSIG_MOB_FIRED_GUN, .proc/gun_fired)
	RegisterSignal(parent, list(COMSIG_LIVING_START_PULL, COMSIG_MOVABLE_BUMP), .proc/check_bump)

/datum/component/gunpoint/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_MOVABLE_MOVED)
	UnregisterSignal(parent, COMSIG_MOB_APPLY_DAMAGE)
	UnregisterSignal(parent, COMSIG_MOB_ATTACK_HAND)
	UnregisterSignal(parent, COMSIG_MOB_FIRED_GUN)
	UnregisterSignal(parent, list(COMSIG_LIVING_START_PULL, COMSIG_MOVABLE_BUMP))

/datum/component/gunpoint/update_stage(new_stage, silent = FALSE)
	var/last_stage = stage
	stage = new_stage
	switch(stage)
		if(0)
			diceroll_modifier = GUNPOINT_STAGE_0_MODIFIER
			if(weapon.stage_zero_aim_bonus)
				diceroll_modifier += weapon.stage_zero_aim_bonus
			LAZYSET(weapon.target_specific_diceroll, target, diceroll_modifier)
			if(steady_aim_timer)
				deltimer(steady_aim_timer)
				steady_aim_timer = null
			steady_aim_timer = addtimer(CALLBACK(src, .proc/update_stage, 1), GUNPOINT_DELAY_STAGE_1, TIMER_STOPPABLE)
		if(1)
			diceroll_modifier = GUNPOINT_STAGE_1_MODIFIER
			if(weapon.stage_one_aim_bonus)
				diceroll_modifier += weapon.stage_one_aim_bonus
			LAZYSET(weapon.target_specific_diceroll, target, diceroll_modifier)
			if(steady_aim_timer && (last_stage < stage))
				deltimer(steady_aim_timer)
				steady_aim_timer = null
			steady_aim_timer = addtimer(CALLBACK(src, .proc/update_stage, 2), GUNPOINT_DELAY_STAGE_2, TIMER_STOPPABLE)
		if(2)
			if(!silent && (last_stage < stage))
				to_chat(parent, span_danger("I steady [weapon] on <b>[target]</b>."))
				to_chat(target, span_userdanger("<b>[parent]</b> has steadied [weapon] on me!"))
			diceroll_modifier = GUNPOINT_STAGE_2_MODIFIER
			if(weapon.stage_two_aim_bonus)
				diceroll_modifier += weapon.stage_two_aim_bonus
			LAZYSET(weapon.target_specific_diceroll, target, diceroll_modifier)
			if(steady_aim_timer)
				deltimer(steady_aim_timer)
				steady_aim_timer = null
			steady_aim_timer = addtimer(CALLBACK(src, .proc/update_stage, 3), GUNPOINT_DELAY_STAGE_3, TIMER_STOPPABLE)
		if(3)
			if(!silent && (last_stage < stage))
				to_chat(parent, span_danger("I have fully steadied [weapon] on <b>[target]</b>."))
				to_chat(target, span_userdanger("<b>[parent]</b> has fully steadied [weapon] on me!"))
			diceroll_modifier = GUNPOINT_STAGE_3_MODIFIER
			if(weapon.stage_three_aim_bonus)
				diceroll_modifier += weapon.stage_three_aim_bonus
			LAZYSET(weapon.target_specific_diceroll, target, diceroll_modifier)
			if(steady_aim_timer)
				deltimer(steady_aim_timer)
				steady_aim_timer = null

/datum/component/gunpoint/async_trigger_reaction()
	var/mob/living/shooter = parent

	if(point_of_no_return)
		return
	point_of_no_return = TRUE
	unsteady_aim()
	if(!weapon.can_trigger_gun(shooter) || !weapon.can_shoot() || (weapon.weapon_weight == WEAPON_HEAVY && shooter.get_inactive_held_item()))
		shooter.visible_message(span_danger("<b>[shooter]</b> fumbles [weapon]!"), \
							span_danger("I fumble [weapon] and fail to fire at <b>[target]</b>!"), ignored_mobs = target)
		to_chat(target, span_userdanger("<b>[shooter]</b> fumbles [weapon] and fails to fire at me!"))
		qdel(src)
		return

	if(weapon.check_botched(shooter))
		qdel(src)
		return

	point_of_no_return = FALSE
	weapon.process_fire(target, shooter)

/datum/component/gunpoint/check_bump(atom/source, atom/bumper)
	var/mob/living/shooter = parent
	if(shooter.combat_mode)
		return
	shooter.visible_message(span_danger("<b>[shooter]</b> bumps into <b>[bumper]</b> and fumbles [shooter.p_their()] aim!"), \
		span_danger("I bump into <b>[bumper]</b> and fumble my aim!"), ignored_mobs = bumper)
	to_chat(bumper, span_userdanger("<b>[shooter]</b> bumps into me and fumbles [shooter.p_their()] aim!"))
	qdel(src)

/datum/component/gunpoint/check_shove(mob/living/carbon/shooter, mob/shooter_again, mob/living/shover, datum/martial_art/attacker_style, modifiers)
	if(shooter.combat_mode)
		return
	shooter.visible_message(span_danger("<b>[shooter]</b> bumps into <b>[shover]</b> and fumbles [shooter.p_their()] aim!"), \
						span_danger("I bump into <b>[shover]</b> and fumble my aim!"), ignored_mobs = shover)
	to_chat(shover, span_userdanger("<b>[shooter]</b> bumps into me and fumbles [shooter.p_their()] aim!"))
	qdel(src)

/datum/component/gunpoint/check_deescalate()
	if(get_dist(parent, target) >= GUNPOINT_SHOOTER_STRAY_RANGE)
		cancel()
		return
	//Unsteady the aim if possible
	var/mob/living/shooter = parent
	var/unsteady_chance = 10
	if(shooter.movement_type == MOVE_INTENT_RUN)
		unsteady_chance = 30
	if(prob(unsteady_chance))
		unsteady_aim()

/datum/component/gunpoint/flinch(mob/living/source, damage, damagetype, def_zone)
	if(damage <= 0)
		return

	var/mob/living/shooter = parent
	var/flinch_chance = 50
	var/gun_hand = LEFT_HANDS
	if(shooter.held_items[RIGHT_HANDS] == weapon)
		gun_hand = RIGHT_HANDS

	if((def_zone == BODY_ZONE_PRECISE_L_HAND && gun_hand == LEFT_HANDS) \
		|| (def_zone == BODY_ZONE_PRECISE_R_HAND && gun_hand == RIGHT_HANDS))
		flinch_chance = 80

	if(shooter.combat_mode)
		flinch_chance /= 2
	if(prob(flinch_chance))
		shooter.visible_message(span_danger("<b>[shooter]</b> flinches!"), \
			span_danger("I flinch!"))
		INVOKE_ASYNC(src, .proc/async_trigger_reaction)

/datum/component/gunpoint/cancel()
	var/mob/living/shooter = parent
	shooter.visible_message(span_danger("<b>[shooter]</b> breaks [shooter.p_their()] aim on <b>[target]</b>!"), \
		span_danger("I stop aiming [weapon] at <b>[target]</b>."), ignored_mobs = target)
	to_chat(target, span_userdanger("<b>[shooter]</b> breaks [shooter.p_their()] aim on me!"))

	if(weapon.aim_spare_sound)
		var/picked_sound = pick(weapon.aim_spare_sound)
		playsound(parent, picked_sound, weapon.aim_spare_sound_volume, weapon.aim_spare_sound_vary, -4)
		target.playsound_local(target, picked_sound, weapon.aim_spare_sound_volume, weapon.aim_spare_sound_vary)
		SEND_SIGNAL(weapon, COMSIG_GUNPOINT_GUN_AIM_STRESS_UNSOUNDED, picked_sound)

	qdel(src)

/datum/component/gunpoint/proc/gun_fired(mob/living/source)
	if(prob(20))
		unsteady_aim()
	else
		update_stage(stage)

/datum/component/gunpoint/proc/unsteady_aim()
	update_stage(max(0, stage-1))
	var/final_message = span_warning("My aim unsteadies a bit.")
	switch(stage)
		if(0)
			final_message = span_warning("My aim unsteadies. It is <b>awful</b> now.")
		if(1)
			final_message = span_warning("My aim unsteadies. It is poor now.")
		if(2)
			final_message = span_notice("My aim unsteadies. It is decent now.")
		if(3)
			final_message = span_notice("My aim unsteadies. It is still <b>great</b>.")
	to_chat(parent, final_message)

/datum/component/gunpoint/proc/apply_target_overlay()
	if(target_overlay)
		target.cut_overlay(target_overlay)
	target_overlay = mutable_appearance('modular_septic/icons/effects/aiming.dmi', "aiming")
	target.add_overlay(target_overlay)

/datum/component/gunpoint/proc/remove_target_overlay()
	if(!target_overlay)
		return
	target.cut_overlay(target_overlay)
	target_overlay = null

#undef GUNPOINT_SHOOTER_STRAY_RANGE
#undef GUNPOINT_DELAY_STAGE_2
#undef GUNPOINT_DELAY_STAGE_3
#undef GUNPOINT_STAGE_1_MODIFIER
#undef GUNPOINT_STAGE_2_MODIFIER
#undef GUNPOINT_STAGE_3_MODIFIER
