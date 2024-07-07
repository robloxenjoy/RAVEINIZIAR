/obj/item/organ
	name = "organ"
	icon = 'modular_septic/icons/obj/items/surgery.dmi'
	force = 0
	throwforce = 0
	w_class = WEIGHT_CLASS_NORMAL
	drop_sound = "modular_pod/sound/eff/flesh_slap.ogg"

	/// Germ level is treated as the infection level of an organ, we start at 0 and only increase when appropriate
	germ_level = 0

	/// Robotic organs produce other fun reagents
	grind_results = list(
		/datum/reagent/consumable/nutriment/organ_tissue = 10,
		/datum/reagent/liquidgibs = 10,
	)
	juice_results = list(
		/datum/reagent/blood = 20,
	)

	/// Mob we are currently attached to
	var/mob/living/carbon/owner = null
	/// The first mob we ever got attached to
	var/datum/weakref/original_owner = null

	/// Organic or robotic
	var/status = ORGAN_ORGANIC

	/// Default body zone we occupy
	var/zone = BODY_ZONE_CHEST
	/// Body zone we are currently occupying
	var/current_zone = null
	/// Body zones we can be inserted on
	var/list/possible_zones = ALL_BODYPARTS

	/// Some organs have a side of the body they occupy - this should only be used for icon updates
	var/side = NO_SIDE

	/// General flags
	var/organ_flags = ORGAN_EDIBLE
	/// Efficiency attached to each slot
	var/list/organ_efficiency = list()
	/// Needs to get processed on next life() tick
	var/needs_processing = TRUE
	/// Used if the organ doesn't use organ processes and a mob can only have one
	var/unique_slot
	/// Organ will not show up on medical scanner
	var/scanner_hidden = FALSE
	/// If someone has written something stupid on us
	var/etching = ""

	/// The space we occupy inside a limb - unaffected by w_class for balance reasons
	var/organ_volume = 0
	/// How much blood an organ can store - Base is 5 * blood_req, so the organ can survive without blood for 10 seconds before taking damage (+ blood supply of arteries)
	var/max_blood_storage = 0
	/// How much blood is currently in the organ
	var/current_blood = 0
	/// How much blood (percent of BLOOD_VOLUME_NORMAL) an organ takes to funcion
	var/blood_req = 0
	/// If oxygen reqs are not satisfied, get debuffs and brain starts taking damage
	var/oxygen_req = 0
	/// Controls passive nutriment loss
	var/nutriment_req = 0
	/// Controls passive hydration loss
	var/hydration_req = 0

	/// Damage healed per second
	var/healing_factor = STANDARD_ORGAN_HEALING
	/// Minimum amount of germ_level we gain when rotting
	var/min_decay_factor = MIN_ORGAN_DECAY_INFECTION
	/// Maximum amount of germ_level we gain when rotting
	var/max_decay_factor = MAX_ORGAN_DECAY_INFECTION
	/// Maximum amount of damage we can suffer
	var/maxHealth = STANDARD_ORGAN_THRESHOLD
	/// Total damage this organ has sustained
	var/damage = 0
	/// How much pain this causes in relation to damage (pain_multiplier * damage)
	var/pain_multiplier = 0.75
	/// Modifier for when the parent limb gets damaged, and fucks up the organs inside
	var/internal_damage_modifier = 1
	/// Flat reduction of the damage when the limb gets damaged and fucks us up
	var/internal_damage_reduction = 0
	/// When severe organ damage (broken) occurs
	var/high_threshold = STANDARD_ORGAN_THRESHOLD * 0.8
	/// When medium organ damage occurs (only matters for bones at the moment)
	var/medium_threshold = STANDARD_ORGAN_THRESHOLD * 0.5
	/// When minor organ damage (bruising) occurs
	var/low_threshold = STANDARD_ORGAN_THRESHOLD * 0.2
	/// Cooldown for severe effects, used for synthetic organ emp effects.
	COOLDOWN_DECLARE(severe_cooldown)
	/// Time we have spent failing
	var/failure_time = 0
	/// Last amount of damage we were at
	var/prev_damage = 0

	/// Just passed bruise threshold
	var/low_threshold_passed
	/// Just passed medium threshold
	var/medium_threshold_passed
	/// Just passed the broken treshold
	var/high_threshold_passed
	/// Organ is failing
	var/now_failing
	/// Organ has been fixed from failing
	var/now_fixed
	/// Organ has been fixed below broken
	var/high_threshold_cleared
	/// Organ has been fixed below medium
	var/medium_threshold_cleared
	/// Organ has been fixed below bruised
	var/low_threshold_cleared

	// ~TOXIN DAMAGE VARIABLES
	/// Toxin damage holding
	var/toxins = 0
	/// How much toxin damage we can hold
	var/max_toxins = 0
	/// How much shock a point of toxins causes
	var/toxin_pain_factor = LIVER_TOXIN_PAIN_FACTOR

	/// Used to handle rejection from incompatible owner
	var/rejection_stage = 0
	/// Prevents running constantly failing code
	var/failed = FALSE
	/// When you take a bite, the organ stops working
	var/functional = TRUE

	/// Used to handle EMP effects
	var/emp_vulnerability = 0

	/// Reagents the edible component gets
	var/list/food_reagents = list(/datum/reagent/consumable/nutriment = 5, \
							/datum/reagent/consumable/nutriment/protein = 5, \
							/datum/reagent/consumable/nutriment/organ_tissue = 5)
	/// The size of the reagent container
	var/reagent_vol = 20

	/// Types of items that can stitch this organ when severed
	var/list/attaching_items = list(/obj/item/stack/medical/suture)
	/// If this is set, this organ can be healed with item types in this list
	var/list/healing_items = list(/obj/item/stack/medical/suture)
	/// The above, but for tool behaviors
	var/list/healing_tools

	///	With what DNA block do we mutate in mutate_feature() ? For genetics
	var/dna_block

	/// This is for associating an organ with a mutant bodypart - Look at tails for examples
	var/mutantpart_key
	/// Should this get colored by mutantpart_info?
	var/mutantpart_colored = FALSE
	/// Info about our sprite accessory, if we have a valid mutantpart_key
	var/list/list/mutantpart_info

/obj/item/organ/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)
	current_zone = zone
	if(mutantpart_colored && mutantpart_key)
		color = LAZYACCESSASSOC(mutantpart_info, MUTANT_INDEX_COLOR, 1)
	if(status == ORGAN_ROBOTIC)
		grind_results = list(/datum/reagent/iron = 20)
		juice_results = list(/datum/reagent/toxin/acid = 20)
	if(organ_flags & ORGAN_EDIBLE)
		AddComponent(/datum/component/edible, \
			initial_reagents = food_reagents, \
			foodtypes = RAW|MEAT|GROSS, \
			volume = reagent_vol, \
			after_eat = CALLBACK(src, PROC_REF(on_eat_from)))
	update_appearance()

/obj/item/organ/Destroy()
	if(owner)
		// The special flag is important, because otherwise mobs can die while undergoing transformation into different mobs.
		Remove(owner, special = TRUE)
	return ..()

/obj/item/organ/proc/on_eat_from(eater, feeder)
	functional = FALSE //You can't use it anymore after eating it you spaztic
	applyOrganDamage(maxHealth/4)

/*
 * Previously, only bones affected wounding, but i have changed it for every organ
 * to be capable of doing so.
 * This returns a wounding modifier depending on wounding_type.
 *
 * arguments:
 * wounding_type - the wound type we are contributing to
 */
/obj/item/organ/proc/get_wound_weakness(wounding_type = WOUND_BLUNT)
	return 0

/*
 * Insert the organ into the select mob.
 *
 * receiver - the mob who will get our organ
 * special - "quick swapping" an organ out - when TRUE, the mob will be unaffected by not having that organ for the moment
 * drop_if_replaced - if there's an organ in the slot already, whether we drop it afterwards
 */
/obj/item/organ/proc/Insert(mob/living/carbon/new_owner, special = FALSE, drop_if_replaced = TRUE, new_zone = null)
	. = FALSE
	if(!istype(new_owner) || (owner == new_owner))
		return

	if(!isnull(new_zone))
		current_zone = new_zone
	else
		current_zone = zone

	if(unique_slot)
		var/obj/item/organ/replaced = new_owner.getorganslot(unique_slot)
		if(replaced)
			replaced.Remove(new_owner, special = TRUE)
			if(drop_if_replaced)
				replaced.forceMove(new_owner.drop_location())
			else
				qdel(replaced)

	SEND_SIGNAL(src, COMSIG_ORGAN_IMPLANTED, new_owner)
	SEND_SIGNAL(new_owner, COMSIG_CARBON_GAIN_ORGAN, src, special)
	STOP_PROCESSING(SSobj, src)

	moveToNullspace()
	owner = new_owner
	new_owner.internal_organs |= src
	for(var/slot in organ_efficiency)
		LAZYADD(new_owner.internal_organs_slot[slot], src)
	var/checked_zone = check_zone(current_zone)
	LAZYADD(new_owner.organs_by_zone[checked_zone], src)
	RegisterSignal(owner, COMSIG_PARENT_EXAMINE, PROC_REF(on_owner_examine))
	var/datum/action/action
	for(var/thing in actions)
		action = thing
		action.Grant(new_owner)
	handle_rejection()
	if(!(new_owner.status_flags & BUILDING_ORGANS))
		new_owner.update_organ_requirements()
		if(mutantpart_key && ishuman(new_owner))
			new_owner.dna.species.mutant_bodyparts[mutantpart_key] = mutantpart_info.Copy()
			new_owner.update_body()
		if(organ_flags & ORGAN_LIMB_SUPPORTER)
			var/obj/item/bodypart/affected = owner.get_bodypart(current_zone)
			affected?.update_limb_efficiency()
	return TRUE

/*
 * Remove the organ from the select mob.
 *
 * old_owner - the mob who owns our organ, that we're removing the organ from.
 * special - "quick swapping" an organ out - when TRUE, the mob will be unaffected by not having that organ for the moment
 */
/obj/item/organ/proc/Remove(mob/living/carbon/old_owner, special = FALSE)
	. = FALSE
	if(!old_owner)
		return
	UnregisterSignal(old_owner, COMSIG_PARENT_EXAMINE)
	var/initial_zone = current_zone
	owner = null
	current_zone = zone
	old_owner.internal_organs -= src
	for(var/slot in organ_efficiency)
		LAZYREMOVE(old_owner.internal_organs_slot[slot], src)
	var/checked_initial_zone = check_zone(initial_zone)
	LAZYREMOVE(old_owner.organs_by_zone[checked_initial_zone], src)
	if(!special && (organ_flags & ORGAN_VITAL) && !(old_owner.status_flags & GODMODE))
		old_owner.death()
	for(var/datum/action/action as anything in actions)
		action.Remove(old_owner)
	SEND_SIGNAL(src, COMSIG_ORGAN_REMOVED, old_owner)
	SEND_SIGNAL(old_owner, COMSIG_CARBON_LOSE_ORGAN, src, special)
	START_PROCESSING(SSobj, src)
	if(!(old_owner.status_flags & BUILDING_ORGANS))
		old_owner.update_organ_requirements()
		if(mutantpart_key && ishuman(old_owner))
			if(old_owner.dna.species.mutant_bodyparts[mutantpart_key])
				mutantpart_info = old_owner.dna.species.mutant_bodyparts[mutantpart_key].Copy() //Update the info in case it was changed on the person
			if(mutantpart_colored)
				color = sanitize_hexcolor(mutantpart_info[MUTANT_INDEX_COLOR][1], 6, TRUE)
			old_owner.dna.species.mutant_bodyparts -= mutantpart_key
			old_owner.update_body()
		if(organ_flags & ORGAN_LIMB_SUPPORTER)
			var/obj/item/bodypart/affected = old_owner.get_bodypart(initial_zone)
			affected?.update_limb_efficiency()
	return TRUE

/obj/item/organ/proc/on_owner_examine(datum/source, mob/user, list/examine_list)
	return

/obj/item/organ/proc/on_find(mob/living/finder)
	return

/obj/item/organ/proc/switch_side(new_side = RIGHT_SIDE)
	side = new_side
	update_appearance()

/// when a limb is dropped, the internal organs are removed from the mob and put into the limb
/obj/item/organ/proc/transfer_to_limb(obj/item/bodypart/new_limb, mob/living/carbon/was_owner)
	if(owner)
		Remove(owner)
	forceMove(new_limb)
	plane = initial(plane)
	layer = initial(layer)

/// Adding/removing germs
/obj/item/organ/adjust_germ_level(add_germs, minimum_germs = 0, maximum_germs = GERM_LEVEL_MAXIMUM)
	. = ..()
	if((germ_level >= INFECTION_LEVEL_THREE) && !CHECK_BITFIELD(organ_flags, ORGAN_DEAD))
		kill_organ()

/// Infection/rot checks
/obj/item/organ/proc/can_decay()
	check_cold()
	if(CHECK_BITFIELD(organ_flags, ORGAN_FROZEN|ORGAN_DEAD|ORGAN_SYNTHETIC|ORGAN_NOINFECTION))
		return FALSE
	else if(reagents?.has_reagent(/datum/reagent/toxin/formaldehyde, 0.5) || reagents?.has_reagent(/datum/reagent/cryostylane, 0.5))
		return FALSE
	else if((owner?.stat >= DEAD) && (owner?.reagents?.has_reagent(/datum/reagent/toxin/formaldehyde, 0.5) || owner?.reagents?.has_reagent(/datum/reagent/cryostylane, 0.5)))
		return FALSE
	return TRUE

/// Runs decay when outside of a person
/obj/item/organ/process(delta_time, times_fired)
	// Kinda hate doing it like this, but I really don't want to call process directly.
	return on_death(delta_time, times_fired)

/// Runs decay both inside and outside a person
/obj/item/organ/proc/on_death(delta_time, times_fired)
	check_cold()
	if(!owner && !isbodypart(loc))
		organ_flags |= ORGAN_CUT_AWAY
	if(can_decay())
		decay(delta_time)
	else
		STOP_PROCESSING(SSobj, src)

/// proper decaying
/obj/item/organ/proc/decay(delta_time)
	adjust_germ_level(rand(min_decay_factor,max_decay_factor) * delta_time)

/// healing checks
/obj/item/organ/proc/can_heal(delta_time, times_fired)
	. = TRUE
	if(!owner)
		return FALSE
	if(healing_factor <= 0)
		return FALSE
	if((damage > maxHealth/5) && !owner.get_chem_effect(CE_ORGAN_REGEN))
		return FALSE
	if(is_dead())
		return FALSE
	if(current_blood <= 0)
		return FALSE
	if(owner.undergoing_cardiac_arrest())
		return FALSE
	if(owner.get_chem_effect(CE_TOXIN))
		return FALSE

/// repair organ damage if the organ is not failing
/obj/item/organ/proc/on_life(delta_time, times_fired)
	SHOULD_CALL_PARENT(TRUE)
	if(!owner)
		return

	/// Handle germs before anything else!
	if(can_decay())
		if(rejection_stage)
			handle_rejection(delta_time, times_fired)
		handle_germ_effects(delta_time, times_fired)
		handle_antibiotics(delta_time, times_fired)
	else
		germ_level = 0

	/// Handle blood
	handle_blood(delta_time, times_fired)

	if(is_failing())
		handle_failing_organ(delta_time, times_fired)
		return

	// Synthetic organ has been emped, apply damage until it starts failing
	if(is_emped())
		applyOrganDamage(healing_factor * delta_time)
		return

	// Decrease failure time while healthy
	if(failure_time > 0)
		failure_time = max(0, failure_time - delta_time)

	// Damage decrements by a percent of maxhealth
	if(can_heal(delta_time, times_fired) && damage)
		handle_healing(delta_time, times_fired)

/obj/item/organ/proc/handle_blood(delta_time, times_fired)
	var/arterial_efficiency = get_slot_efficiency(ORGAN_SLOT_ARTERY)
	var/in_bleedout = owner.in_bleedout()
	if(arterial_efficiency && !is_failing())
		// Arteries get an extra flat 5 blood regen
		current_blood = min(current_blood + 5 * (0.5 * delta_time) * (arterial_efficiency/ORGAN_OPTIMAL_EFFICIENCY), max_blood_storage)
		return
	if(!blood_req)
		return
	var/obj/item/bodypart/parent = owner.get_bodypart(current_zone)
	var/bodypart_arterial_efficiency = parent?.getorganslotefficiency(ORGAN_SLOT_ARTERY)
	if(!in_bleedout)
		var/efficiency_multiplier = (bodypart_arterial_efficiency/ORGAN_OPTIMAL_EFFICIENCY)
		current_blood = min(current_blood + (blood_req * efficiency_multiplier * (0.5 * delta_time)), max_blood_storage)
		//No efficiency? That means gangrene
		if(bodypart_arterial_efficiency <= 0)
			adjust_germ_level(1 * (0.5 * delta_time))
		return
	current_blood = max(current_blood - (blood_req * (0.5 * delta_time)), 0)
	// When all blood is lost, take blood from arteries
	if(!current_blood)
		var/obj/item/organ/artery
		var/most_arterial_efficiency = ORGAN_FAILING_EFFICIENCY
		for(var/obj/item/organ/candidate as anything in shuffle(parent?.getorganslotlist(ORGAN_SLOT_ARTERY)))
			if(candidate.current_blood && (candidate.get_slot_efficiency(ORGAN_SLOT_ARTERY) >= most_arterial_efficiency))
				artery = candidate
				most_arterial_efficiency = candidate.get_slot_efficiency(ORGAN_SLOT_ARTERY)
				break
		if(artery?.current_blood)
			var/artery_prev_blood = artery.current_blood
			artery.current_blood = max(artery.current_blood - (blood_req * 0.5 * delta_time), 0)
			current_blood = max(artery_prev_blood - artery.current_blood, 0)
		if((current_blood <= 0) && !(organ_flags & ORGAN_LIMB_SUPPORTER))
			applyOrganDamage(2 * (0.5 * delta_time))
	//No efficiency? That means gangrene
	if(bodypart_arterial_efficiency <= 0)
		adjust_germ_level(1 * (0.5 * delta_time))

/obj/item/organ/proc/handle_healing(delta_time, times_fired)
	if(damage <= 0)
		return
	applyOrganDamage(-healing_factor * delta_time, damage)
	//this doesn't seem very right at all...
	owner.adjust_nutrition(-nutriment_req/100 * (0.5 * delta_time))
	owner.adjust_hydration(-hydration_req/100 * (0.5 * delta_time))

/// Rejection caused by unmatching owner DNA
/obj/item/organ/proc/handle_rejection(delta_time, times_fired)
	if(CHECK_BITFIELD(organ_flags, ORGAN_SYNTHETIC))
		rejection_stage = 0
		return

	// Process unsuitable transplants. TODO: consider some kind of
	// immunosuppressant that changes transplant data to make it match.
	var/antibiotics = owner.get_antibiotics()
	//for now just having lots of antibiotics will cure rejection
	if(antibiotics >= 50)
		if(DT_PROB(antibiotics*0.2, delta_time))
			original_owner = WEAKREF(owner)
			rejection_stage = 0
		return

	var/mob/living/carbon/og_owner = original_owner?.resolve()
	if(og_owner?.dna?.blood_type)
		var/datum/dna/original_dna = og_owner.dna
		if(!rejection_stage)
			if(!(owner.dna.blood_type in get_safe_blood(original_dna.blood_type)))
				rejection_stage = REJECTION_LEVEL_1
		else
			//Rejection severity increases over time.
			rejection_stage += (0.5 * delta_time)
			//Only fire every ten rejection ticks.
			if(!(rejection_stage % 10))
				switch(rejection_stage)
					if(REJECTION_LEVEL_1 to REJECTION_LEVEL_2)
						adjust_germ_level(1 * (0.5 * delta_time))
					if(REJECTION_LEVEL_2 to REJECTION_LEVEL_3)
						adjust_germ_level(rand(1,2) * (0.5 * delta_time))
					if(REJECTION_LEVEL_3 to REJECTION_LEVEL_4)
						adjust_germ_level(rand(2,3) * (0.5 * delta_time))
					if(REJECTION_LEVEL_4 to INFINITY)
						adjust_germ_level(rand(3,5) * (0.5 * delta_time))
						owner.reagents.add_reagent(/datum/reagent/toxin, rand(1,2))
	else
		original_owner = WEAKREF(owner)
		rejection_stage = 0

/// Malus caused by germs
/obj/item/organ/proc/handle_germ_effects(delta_time, times_fired)
	var/virus_immunity = owner?.virus_immunity()
	var/antibiotics = owner?.get_antibiotics()

	if(germ_level > 0 && germ_level < INFECTION_LEVEL_ONE/2 && DT_PROB(virus_immunity*0.15, delta_time))
		adjust_germ_level(-1 * (0.5 * delta_time))
		return

	if(germ_level >= INFECTION_LEVEL_ONE/2)
		//Aiming for germ level to go from ambient to INFECTION_LEVEL_TWO in an average of 15 minutes, when immunity is full.
		if(antibiotics < 5 && DT_PROB(round(germ_level/6 * owner.immunity_weakness() * 0.005), delta_time))
			if(virus_immunity > 0)
				adjust_germ_level(clamp(round(1/virus_immunity), 1, 10) * (0.5 * delta_time)) // Immunity starts at 100. This doubles infection rate at 50% immunity. Rounded to nearest whole.
			else // Will only trigger if immunity has hit zero. Once it does, 10x infection rate.
				adjust_germ_level(10 * (0.5 * delta_time))

	if(germ_level >= INFECTION_LEVEL_ONE && antibiotics < 20)
		var/fever_temperature = (BODYTEMP_HEAT_DAMAGE_LIMIT - BODYTEMP_NORMAL - 5)* min(germ_level/INFECTION_LEVEL_TWO, 1) + BODYTEMP_NORMAL
		owner.adjust_bodytemperature(clamp((fever_temperature - T20C)/BODYTEMP_COLD_DIVISOR + 1, 0, fever_temperature - owner.bodytemperature), use_insulation = FALSE)

	if(germ_level >= INFECTION_LEVEL_TWO && antibiotics < 25)
		var/obj/item/bodypart/bodypart = owner.get_bodypart(current_zone)
		if(bodypart)
			//Spread germs
			if(antibiotics < 5 && bodypart.germ_level < germ_level && (bodypart.germ_level < INFECTION_LEVEL_ONE*2 || DT_PROB(owner.immunity_weakness() * 0.15, delta_time)))
				bodypart.adjust_germ_level(1 * (0.5 * delta_time))
		//Cause organ damage about once every ~30 seconds
		//The bodypart deals with dealing raw toxin damage, let's not stack onto the problem now
		if(DT_PROB(2, delta_time))
			applyOrganDamage(2)

	// Organ is just completely dead by this point
	if(germ_level >= INFECTION_LEVEL_THREE && antibiotics < 40)
		var/obj/item/bodypart/bodypart = owner.get_bodypart(current_zone)
		if(bodypart)
			// Spread germs really badly
			if(antibiotics < 10 && bodypart.germ_level < germ_level && (bodypart.germ_level < INFECTION_LEVEL_THREE))
				bodypart.adjust_germ_level(1 * (0.5 * delta_time))

/// Antibiotics combating germs and stuff
/obj/item/organ/proc/handle_antibiotics(delta_time, times_fired)
	if(!owner || (germ_level <= 0))
		return

	var/antibiotics = owner.get_antibiotics()
	if(antibiotics <= 0)
		return

	if((germ_level < INFECTION_LEVEL_ONE) && (antibiotics >= 20))
		set_germ_level(GERM_LEVEL_STERILE)
	else
		adjust_germ_level(-antibiotics * SANITIZATION_ANTIBIOTIC * (0.5 * delta_time))	//at germ_level == 500 and 50 antibiotic, this should cure the infection in 5 minutes
		if(owner?.body_position == LYING_DOWN)
			adjust_germ_level(-SANITIZATION_LYING * (0.5 * delta_time))

/// So we don't grant the organ's action to mobs who pick up the organ.
/obj/item/organ/item_action_slot_check(slot,mob/user)
	return

/// Adjusts an organ's damage by the amount "d", up to a maximum amount, which is by default max damage
/obj/item/organ/proc/applyOrganDamage(amount, maximum = maxHealth, silent = FALSE) //use for damaging effects
	if(!amount) //Micro-optimization.
		return
	if(maximum < damage)
		damage = maximum
	if(damage < 0 && owner?.get_chem_effect(CE_ORGAN_REGEN))
		damage *= 2
	prev_damage = damage
	damage = clamp(damage + amount, 0, maximum)
	var/mess = check_damage_thresholds(owner)
	if(!mess && (damage - prev_damage >= ORGAN_DAMAGE_NOTIFY_PLAYER))
		mess = span_userdanger("Что-то внутри [parse_zone(current_zone)] болит!")
	if(owner)
		if(mess && !silent)
			to_chat(owner, mess)
		if(organ_flags & ORGAN_LIMB_SUPPORTER)
			var/obj/item/bodypart/affected = owner.get_bodypart(current_zone)
			affected?.update_limb_efficiency()

/// Sets an organ's damage to the amount "d", and in doing so clears or sets the failing flag, good for when you have an effect that should fix an organ if broken
/obj/item/organ/proc/setOrganDamage(d, silent = FALSE) // use mostly for admin heals
	return applyOrganDamage(d - damage)

/// This should only be used by arteries, tendons and nerves
/obj/item/organ/proc/tear()

/// This should only be used by arteries, tendons and nerves
/obj/item/organ/proc/dissect()

/// This should only be used by arteries, tendons and nerves
/obj/item/organ/proc/mend()

/** check_damage_thresholds
 * input: holder (a mob, the owner of the organ we call the proc on)
 * output: returns a message should get displayed.
 * description: By checking our current damage against our previous damage, we can decide whether we've passed an organ threshold.
 *  If we have, send the corresponding threshold message to the owner, if such a message exists.
 */
/obj/item/organ/proc/check_damage_thresholds(mob/living/carbon/holder)
	if(damage == prev_damage)
		return
	var/delta = damage - prev_damage
	if(delta > 0)
		if(damage >= maxHealth && prev_damage < maxHealth)
			organ_flags |= ORGAN_FAILING
			if(!(organ_flags & ORGAN_INDESTRUCTIBLE))
				organ_flags |= ORGAN_DESTROYED
			return now_failing
		if(damage >= high_threshold && prev_damage < high_threshold)
			organ_flags |= ORGAN_FAILING
			return high_threshold_passed
		if(damage >= medium_threshold && prev_damage < medium_threshold)
			return medium_threshold_passed
		if(damage >= low_threshold && prev_damage < low_threshold)
			return low_threshold_passed
	if(delta < 0)
		if(prev_damage >= low_threshold && damage < low_threshold)
			organ_flags &= ~ORGAN_FAILING
			return low_threshold_cleared
		if(prev_damage >= medium_threshold && damage < medium_threshold)
			organ_flags &= ~ORGAN_FAILING
			return medium_threshold_cleared
		if(prev_damage >= high_threshold && damage < high_threshold)
			organ_flags &= ~ORGAN_FAILING
			return high_threshold_cleared
		if(prev_damage >= maxHealth && damage < maxHealth)
			return now_fixed

/**
 * Robotic organs do not feel pain, simply for balancing reasons
 * Thus lowering the shock of IPCs and other synths is easier, as
 * they don't have many painkillers
 */
/obj/item/organ/proc/can_feel_pain()
	. = FALSE
	if(is_robotic_organ())
		return FALSE
	if(pain_multiplier <= 0)
		return FALSE
	if(CHECK_BITFIELD(organ_flags, ORGAN_CUT_AWAY | ORGAN_DEAD))
		return FALSE
	if(HAS_TRAIT(src, TRAIT_NOPAIN))
		return FALSE
	if(owner?.can_feel_pain())
		return TRUE

/obj/item/organ/proc/get_shock(painkiller_included = FALSE)
	if(!can_feel_pain())
		return 0
	// Failing organs always cause maxHealth pain if possible
	if(is_failing())
		return round(maxHealth * pain_multiplier, DAMAGE_PRECISION)
	var/constant_pain = damage
	if(painkiller_included)
		constant_pain -= (owner.get_chem_effect(CE_PAINKILLER)/PAINKILLER_DIVISOR)
	return max(FLOOR(constant_pain * pain_multiplier, DAMAGE_PRECISION), 0)

///Get mutant part info from a dna datum
/obj/item/organ/proc/build_from_dna(datum/dna/dna_datum, associated_key)
	if(!associated_key || !dna_datum.species.mutant_bodyparts[associated_key])
		return
	mutantpart_key = associated_key
	mutantpart_info = dna_datum.species.mutant_bodyparts[associated_key].Copy()

// this only matters for kidneys and liver
/obj/item/organ/proc/add_toxins(amount)
	if(!can_add_toxins(amount))
		return 0
	var/last_tox = toxins
	toxins = min(max_toxins, max(0, toxins + amount))
	return (toxins - last_tox)

/obj/item/organ/proc/remove_toxins(amount)
	if(!can_remove_toxins(amount))
		return 0
	var/last_tox = toxins
	toxins = min(max_toxins, max(0, toxins - amount))
	return (toxins - last_tox)

/obj/item/organ/proc/get_toxins()
	if(max_toxins <= 0)
		return 0
	if(is_failing())
		return max_toxins
	return toxins

/obj/item/organ/proc/can_add_toxins(amount = 0)
	return (toxins < max_toxins)

/obj/item/organ/proc/can_remove_toxins(amount = 0)
	return (toxins > 0)

// Checks to see if the organ is frozen from temperature and adds the ORGAN_FROZEN flag if so
/obj/item/organ/proc/check_cold()
	//Freezer of some kind, hopefully
	if(isobj(loc))
		if(is_type_in_typecache(loc, GLOB.freezing_objects))
			//Incase someone puts them in when cold, but they warm up inside of the thing. (i.e. they have the flag, the thing turns it off, this rights it.)
			organ_flags |= ORGAN_FROZEN
		return (organ_flags & ORGAN_FROZEN)

	var/local_temp
	if(!owner)
		//Only concern is adding an organ to a freezer when the area around it is cold.
		if(isturf(loc))
			var/turf/turf_loc = loc
			var/datum/gas_mixture/enviro = turf_loc.return_air()
			local_temp = enviro.temperature
		else if(ismob(loc))
			var/mob/holder = loc
			if(is_type_in_typecache(holder.loc, GLOB.freezing_objects))
				organ_flags |= ORGAN_FROZEN
				return (organ_flags & ORGAN_FROZEN)
			var/turf/turf_loc = holder.loc
			var/datum/gas_mixture/enviro = turf_loc.return_air()
			local_temp = enviro?.temperature
	else
		// Don't interfere with bodies frozen by structures.
		if(is_type_in_typecache(owner.loc, GLOB.freezing_objects))
			organ_flags |= ORGAN_FROZEN
			return (organ_flags & ORGAN_FROZEN)
		local_temp = owner.bodytemperature

	// Shouldn't happen but just in case
	if(isnull(local_temp))
		return (organ_flags & ORGAN_FROZEN)
	//I have a pretty shaky citation that states -120 allows indefinite cryostorage
	if(local_temp < 154)
		organ_flags |= ORGAN_FROZEN
		return (organ_flags & ORGAN_FROZEN)

	organ_flags &= ~ORGAN_FROZEN
	return (organ_flags & ORGAN_FROZEN)

///Organs don't die instantly, and neither should you when you get fucked up
/obj/item/organ/proc/handle_failing_organ(delta_time, times_fired)
	if(!owner || owner.stat >= DEAD)
		return

	failure_time += delta_time
	organ_failure(delta_time)

/** organ_failure
 * generic proc for handling dying organs
 *
 * Arguments:
 * delta_time - seconds since last tick
 */
/obj/item/organ/proc/organ_failure(delta_time)
	return

/** get_availability
 * returns whether the species should innately have this organ.
 *
 * regenerate organs works with generic organs, so we need to get whether it can accept certain organs just by what this returns.
 * This is set to return true or false, depending on if a species has a specific organless trait. stomach for example checks if the species has NOSTOMACH and return based on that.
 * Arguments:
 * S - species, needed to return whether the species has an organ specific trait
 */
/obj/item/organ/proc/get_availability(datum/species/S)
	return TRUE

/// Called before organs are replaced in regenerate_organs with new ones
/obj/item/organ/proc/before_organ_replacement(obj/item/organ/replacement)
	return FALSE

/**
 * returns the efficiency for a specific organ slot
 *
 * Arguments:
 * slot - Slot we want to get the efficiency from
 */
/obj/item/organ/proc/get_slot_efficiency(slot)
	var/effective_efficiency = LAZYACCESS(organ_efficiency, slot)
	if(isnull(effective_efficiency))
		return effective_efficiency
	var/static/list/no_bleedout_organs = list(ORGAN_SLOT_ARTERY, ORGAN_SLOT_BONE)
	if(slot in no_bleedout_organs)
		if(is_failing_without_bleedout())
			return 0
	else
		if(is_failing())
			return 0
	effective_efficiency = max(0, CEILING(effective_efficiency - (effective_efficiency * (damage/maxHealth)), 1))
	return effective_efficiency

/obj/item/organ/proc/is_failing()
	return (CHECK_BITFIELD(organ_flags, ORGAN_FAILING|ORGAN_DESTROYED|ORGAN_DEAD|ORGAN_CUT_AWAY) || (damage >= high_threshold) || !functional || (!current_blood && max_blood_storage && !LAZYACCESS(organ_efficiency, ORGAN_SLOT_ARTERY)))

/obj/item/organ/proc/is_failing_without_bleedout()
	return (CHECK_BITFIELD(organ_flags, ORGAN_FAILING|ORGAN_DESTROYED|ORGAN_DEAD|ORGAN_CUT_AWAY) || (damage >= high_threshold) || !functional)

/obj/item/organ/proc/is_working()
	return !is_failing()

/obj/item/organ/proc/is_working_without_bleedout()
	return !is_failing_without_bleedout()

/obj/item/organ/proc/is_emped()
	return (CHECK_MULTIPLE_BITFIELDS(organ_flags, ORGAN_SYNTHETIC|ORGAN_SYNTHETIC_EMP))

/obj/item/organ/proc/is_bruised()
	return (damage >= low_threshold)

/obj/item/organ/proc/is_broken()
	return (CHECK_BITFIELD(organ_flags, ORGAN_FAILING) || (damage >= high_threshold))

/obj/item/organ/proc/is_destroyed()
	return (CHECK_BITFIELD(organ_flags, ORGAN_DESTROYED))

/obj/item/organ/proc/is_necrotic()
	return (CHECK_BITFIELD(organ_flags, ORGAN_DEAD) || (germ_level >= INFECTION_LEVEL_THREE))

/obj/item/organ/proc/is_dead()
	return (CHECK_BITFIELD(organ_flags, ORGAN_DESTROYED|ORGAN_DEAD) || (germ_level >= INFECTION_LEVEL_THREE) || (damage >= maxHealth) || !functional)

/obj/item/organ/proc/is_organic_organ()
	return ((status == ORGAN_ORGANIC) && !CHECK_BITFIELD(organ_flags, ORGAN_SYNTHETIC))

/obj/item/organ/proc/is_robotic_organ()
	return ((status == ORGAN_ROBOTIC) && CHECK_BITFIELD(organ_flags, ORGAN_SYNTHETIC))

/obj/item/organ/proc/bruise_organ()
	. = FALSE
	if(damage < low_threshold)
		setOrganDamage(low_threshold)
		return TRUE

/obj/item/organ/proc/break_organ()
	. = FALSE
	if(damage < high_threshold)
		setOrganDamage(high_threshold)
		return TRUE

/obj/item/organ/proc/kill_organ()
	. = FALSE
	if(damage < maxHealth && !CHECK_BITFIELD(organ_flags, ORGAN_DESTROYED))
		setOrganDamage(maxHealth)
		return TRUE

/obj/item/organ/proc/revive_organ()
	. = FALSE
	if(CHECK_BITFIELD(organ_flags, ORGAN_DESTROYED|ORGAN_FAILING|ORGAN_DEAD))
		setOrganDamage(0)
		organ_flags &= ~ORGAN_DESTROYED|ORGAN_FAILING|ORGAN_DEAD
		return TRUE

/obj/item/organ/proc/necrose_organ()
	. = FALSE
	if(!CHECK_BITFIELD(organ_flags, ORGAN_DEAD))
		set_germ_level(INFECTION_LEVEL_THREE)
		return TRUE

/obj/item/organ/proc/unnecrose_organ()
	. = FALSE
	if(CHECK_BITFIELD(organ_flags, ORGAN_DEAD))
		set_germ_level(GERM_LEVEL_STERILE)
		organ_flags &= ~ORGAN_DEAD
		return TRUE

/obj/item/organ/proc/cut_away_organ()
	. = FALSE
	if(!CHECK_BITFIELD(organ_flags, ORGAN_CUT_AWAY))
		organ_flags |= ORGAN_CUT_AWAY
		return TRUE

/obj/item/organ/proc/sew_organ()
	. = FALSE
	if(CHECK_BITFIELD(organ_flags, ORGAN_CUT_AWAY))
		organ_flags &= ~ORGAN_CUT_AWAY
		return TRUE
