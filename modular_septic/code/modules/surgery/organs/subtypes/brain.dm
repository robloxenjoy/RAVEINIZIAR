/obj/item/organ/brain
	name = "brain"
	desc = "A piece of juicy meat found in a person's head."
	icon_state = "brain"
	throw_speed = 3
	throw_range = 5
	layer = ABOVE_MOB_LAYER
	zone = BODY_ZONE_HEAD
	organ_efficiency = list(ORGAN_SLOT_BRAIN = 100)
	unique_slot = ORGAN_SLOT_BRAIN
	organ_flags = ORGAN_EDIBLE|ORGAN_VITAL|ORGAN_INDESTRUCTIBLE
	attack_verb_continuous = list("attacks", "slaps", "whacks")
	attack_verb_simple = list("attack", "slap", "whack")
	w_class = WEIGHT_CLASS_NORMAL

	// The brain's organ variables are significantly more different than the other organs, with half the decay rate for balance reasons, and twice the maxHealth
	maxHealth = BRAIN_DAMAGE_DEATH
	healing_factor = BRAIN_DAMAGE_DEATH/200
	low_threshold = BRAIN_DAMAGE_DEATH * 0.25
	high_threshold = BRAIN_DAMAGE_DEATH * 0.75
	pain_multiplier = 0 // We don't count towards bodypart pain for balance reasons
	internal_damage_modifier = 3.5 // Brains are easy to hurty

	// head cavity volume is 6
	organ_volume = 2
	max_blood_storage = 25
	current_blood = 25
	blood_req = 5
	oxygen_req = 10
	nutriment_req = 10
	hydration_req = 10

	/// This is stuff
	var/damage_threshold_value = BRAIN_DAMAGE_DEATH/10
	/// Suicide is fucking retarded
	var/suicided = FALSE
	/// The actual mob, if for some reason the brain got lobbed off
	var/mob/living/brain/brainmob
	/// If it's a fake brain with no brainmob assigned. Feedback messages will be faked as if it does have a brainmob. See changelings & dullahans.
	var/decoy_override = FALSE
	/// Brain traumas
	var/list/datum/brain_trauma/traumas = list()
	/// List of skillchip items, their location should be this brain.
	var/list/obj/item/skillchip/skillchips
	/// Maximum skillchip complexity we can support before they stop working. Do not reference this var directly and instead call get_max_skillchip_complexity()
	var/max_skillchip_complexity = 3
	/// Maximum skillchip slots available. Do not reference this var directly and instead call get_max_skillchip_slots()
	var/max_skillchip_slots = 5

/obj/item/organ/brain/Insert(mob/living/carbon/new_owner, special = FALSE, drop_if_replaced = TRUE, new_zone = null, no_id_transfer = FALSE)
	. = ..()
	name = initial(name)
	if(new_owner.mind?.has_antag_datum(/datum/antagonist/changeling) && !no_id_transfer) //congrats, you're trapped in a body you don't control
		if(brainmob && !(new_owner.stat == DEAD || (HAS_TRAIT(new_owner, TRAIT_DEATHCOMA))))
			to_chat(brainmob, span_danger("I can't feel my body! I'm still just a brain!"))
		forceMove(new_owner)
		return

	if(brainmob)
		if(new_owner.key)
			new_owner.ghostize()

		if(brainmob.mind)
			brainmob.mind.transfer_to(new_owner)
		else
			new_owner.key = brainmob.key

		QDEL_NULL(brainmob)

	for(var/datum/brain_trauma/trauma as anything in traumas)
		trauma.owner = owner
		trauma.on_gain()

/obj/item/organ/brain/Remove(mob/living/carbon/old_owner, special = FALSE, no_id_transfer = FALSE)
	// Delete skillchips first as parent proc sets owner to null, and skillchips need to know the brain's owner.
	if(!QDELETED(old_owner) && length(skillchips))
		to_chat(old_owner, span_notice("I feel my skillchips enable emergency power saving mode, deactivating as my brain leaves my body..."))
		for(var/chip in skillchips)
			var/obj/item/skillchip/skillchip = chip
			// Run the try_ proc with force = TRUE.
			skillchip.try_deactivate_skillchip(FALSE, TRUE)
	. = ..()
	for(var/X in traumas)
		var/datum/brain_trauma/trauma = X
		trauma.on_lose(TRUE)
		trauma.owner = null

	if(!QDELETED(src) && !QDELETED(old_owner) && !no_id_transfer)
		transfer_identity(old_owner)

/obj/item/organ/brain/handle_blood(delta_time, times_fired)
	var/effective_blood_oxygenation = GET_EFFECTIVE_BLOOD_VOL(owner.get_blood_oxygenation(), owner.total_blood_req)
	var/arterial_efficiency = get_slot_efficiency(ORGAN_SLOT_ARTERY)
	var/in_bleedout = owner.in_bleedout()
	if(arterial_efficiency && !is_failing())
		// Arteries get an extra flat 5 blood regen
		current_blood = min(current_blood + 5 * (0.5 * delta_time) * (arterial_efficiency/ORGAN_OPTIMAL_EFFICIENCY), max_blood_storage)
		return
	if(!blood_req)
		return
	if(!in_bleedout && (effective_blood_oxygenation >= BLOOD_VOLUME_SAFE))
		current_blood = min(current_blood + (blood_req * (0.5 * delta_time)), max_blood_storage)
		return
	if(in_bleedout)
		current_blood = max(current_blood - (blood_req * (0.5 * delta_time)), 0)
	else
		current_blood = max(current_blood - (blood_req * ((BLOOD_VOLUME_NORMAL-effective_blood_oxygenation)/BLOOD_VOLUME_NORMAL) * (0.5 * delta_time)), 0)
	// When all blood is lost, take blood from blood vessels
	if(!current_blood)
		var/obj/item/organ/artery
		var/obj/item/bodypart/parent = owner.get_bodypart(current_zone)
		for(var/thing in shuffle(parent?.getorganslotlist(ORGAN_SLOT_ARTERY)))
			var/obj/item/organ/candidate = thing
			if(candidate.current_blood && (candidate.get_slot_efficiency(ORGAN_SLOT_ARTERY) >= ORGAN_FAILING_EFFICIENCY))
				artery = candidate
				break
		if(artery?.current_blood)
			var/prev_blood = artery.current_blood
			artery.current_blood = max(artery.current_blood - (blood_req * 0.5 * delta_time), 0)
			current_blood = max(prev_blood - artery.current_blood, 0)
		//Don't apply damage, this is handled by the organ process datum, if necessary

/obj/item/organ/brain/organ_failure(delta_time)
	if(HAS_TRAIT(owner, TRAIT_NOHARDCRIT))
		REMOVE_TRAIT(owner, TRAIT_KNOCKEDOUT, CRIT_HEALTH_TRAIT)
		return
	if(owner.stat < UNCONSCIOUS)
		owner.visible_message(span_danger("<b>[owner]</b> starts having a seizure!"), \
							span_userdanger("I'm having a seizure!"))
	ADD_TRAIT(owner, TRAIT_KNOCKEDOUT, CRIT_HEALTH_TRAIT)
	owner.Jitter(1000)
	owner.Unconscious(4 SECONDS)

/obj/item/organ/brain/on_owner_examine(datum/source, mob/user, list/examine_list)
	if(!ishuman(owner) || !is_failing())
		return
	if(owner.jitteriness >= 300)
		examine_list += span_flashingdanger(span_big("<b>[owner]</b> is having a seizure!"))

/obj/item/organ/brain/can_heal(delta_time, times_fired)
	. = TRUE
	if(!owner)
		return FALSE
	if(healing_factor <= 0)
		return FALSE
	if(is_dead())
		return FALSE
	if(current_blood <= 0)
		return FALSE
	if(owner.undergoing_cardiac_arrest())
		return FALSE
	var/effective_blood_oxygenation = GET_EFFECTIVE_BLOOD_VOL(owner.get_blood_oxygenation(), owner.total_blood_req)
	if(effective_blood_oxygenation < BLOOD_VOLUME_SAFE)
		return FALSE
	// if stable and not too damaged we can heal
	if(!past_damage_threshold(3) && owner.get_chem_effect(CE_STABLE))
		return TRUE
	// else, we only naturally regen to basically get rounded
	if(!(damage % damage_threshold_value) || owner.get_chem_effect(CE_BRAIN_REGEN))
		return FALSE

/obj/item/organ/brain/transfer_to_limb(obj/item/bodypart/new_limb, mob/living/carbon/human/was_owner)
	. = ..()
	new_limb.brain = src
	if(brainmob)
		new_limb.brainmob = brainmob
		brainmob = null
		new_limb.brainmob.forceMove(new_limb)
		new_limb.brainmob.set_stat(DEAD)

/obj/item/organ/brain/handle_organ_attack(obj/item/tool, mob/living/user, params)
	if(owner && DOING_INTERACTION_WITH_TARGET(user, owner))
		return TRUE
	else if(DOING_INTERACTION_WITH_TARGET(user, src))
		return TRUE
	if(owner && CHECK_BITFIELD(organ_flags, ORGAN_CUT_AWAY))
		for(var/thing in attaching_items)
			if(istype(tool, thing))
				handle_attaching_item(tool, user, params)
				return TRUE
	for(var/thing in healing_items)
		if(istype(tool, thing))
			handle_healing_item(tool, user, params)
			return TRUE
	for(var/thing in healing_tools)
		if(tool.tool_behaviour == thing)
			handle_healing_item(tool, user, params)
			return TRUE
	// LOBOTOMITE
	if(owner && (tool.tool_behaviour == TOOL_HEMOSTAT))
		handle_lobotomy(tool, user, params)
		return TRUE
	if(owner && CHECK_BITFIELD(tool.get_sharpness(), SHARP_EDGED) && !CHECK_BITFIELD(organ_flags, ORGAN_CUT_AWAY))
		handle_cutting_away(tool, user, params)
		return TRUE
	// Attempt to heal the brain
	if(is_failing() && tool.is_drainable() && tool.reagents.has_reagent(/datum/reagent/medicine/mannitol))
		if(brainmob?.health <= HEALTH_THRESHOLD_DEAD) //if the brain is fucked anyway, do nothing
			to_chat(user, span_warning("[src] is far too damaged, there's nothing else i can do for it!"))
			return TRUE
		if(!tool.reagents.has_reagent(/datum/reagent/medicine/mannitol, 10))
			to_chat(user, span_warning("There's not enough mannitol in [tool] to restore [src]!"))
			return TRUE
		user.visible_message(span_notice("<b>[user]</b> starts to pour the contents of [tool] onto [src]."),
						span_notice("I start to slowly pour the contents of [tool] onto [src]."))
		if(!do_after(user, 5 SECONDS, src))
			to_chat(user, span_warning("I failed to pour [tool] onto [src]!"))
			return TRUE
		user.visible_message(span_notice("<b>[user]</b> pours the contents of [tool] onto [src], causing it to reform its original shape and turn a slightly brighter shade of pink."), \
						span_notice("I pour the contents of [tool] onto [src], causing it to reform its original shape and turn a slightly brighter shade of pink."))
		var/healby = tool.reagents.get_reagent_amount(/datum/reagent/medicine/mannitol)
		applyOrganDamage(-healby*2) //heals 2 damage per unit of mannitol
		tool.reagents.clear_reagents()
		return TRUE
	// Cutting out skill chips.
	if(length(skillchips) && (tool.get_sharpness() & SHARP_EDGED))
		to_chat(user,span_notice("I begin to excise skillchips from [src]."))
		if(do_after(user, 10 SECONDS, target = src))
			for(var/chip in skillchips)
				var/obj/item/skillchip/skillchip = chip
				if(!istype(skillchip))
					stack_trace("Item of type [skillchip.type] qdel'd from [src] skillchip list.")
					qdel(skillchip)
					continue
				remove_skillchip(skillchip)
				if(skillchip.removable)
					skillchip.forceMove(drop_location())
					continue
				qdel(skillchip)
			skillchips = null
		return TRUE

/obj/item/organ/brain/handle_healing_item(obj/item/tool, mob/living/user, params)
	var/obj/item/stack/stack = tool
	if(organ_flags & (ORGAN_DESTROYED|ORGAN_DEAD))
		to_chat(user, span_warning("\The [src] is damaged beyond the point of no return."))
		return
	if(!damage && !length(traumas))
		to_chat(user, span_notice("\The [src] is in pristine quality already."))
		return
	user.visible_message(span_notice("<b>[user]</b> starts healing \the [src]..."), \
					span_notice("I start healing \the [src]..."), \
					vision_distance = COMBAT_MESSAGE_RANGE)
	if(owner)
		owner.custom_pain("OH GOD! There are needles inside my [src]!", 30, FALSE, owner.get_bodypart(current_zone))
		if(!do_mob(user, owner, 5 SECONDS))
			to_chat(user, span_warning("I must stand still!"))
			user.playsound_local(get_turf(user), 'modular_pod/sound/eff/difficult1.ogg', 15, FALSE)
			return
	else
		if(!do_after(user, 5 SECONDS, src))
			to_chat(user, span_warning("I must stand still!"))
			user.playsound_local(get_turf(user), 'modular_pod/sound/eff/difficult1.ogg', 15, FALSE)
			return
	if(istype(stack))
		if(!stack.use(2))
			to_chat(user, span_warning("I don't have enough to heal \the [src]!"))
			return
	user.visible_message(span_notice("<b>[user]</b> healing \the [src]."), \
						span_notice("I heal \the [src]."))
	applyOrganDamage(-min(maxHealth/2, 50))
	cure_all_traumas(TRAUMA_RESILIENCE_SURGERY)

/obj/item/organ/brain/surgical_examine(mob/user)
	. = ..()
	if(length(skillchips) >= 2)
		. += span_info("It has some skillchips embedded in it.")
	else if(length(skillchips))
		. += span_info("It has a skillchip embedded in it.")
	if((brainmob && (brainmob.client || brainmob.get_ghost())) || decoy_override)
		if(is_failing())
			. += span_info("It seems to still have a bit of energy within it, but it's rather damaged...")
		else if(damage >= BRAIN_DAMAGE_DEATH*0.5)
			. += span_info("I can feel the small spark of life still left in this one, but it's got some bruises.")
		else
			. += span_info("I can feel the small spark of life still left in this one.")
	else
		. += span_info("This one is completely devoid of life.")

/obj/item/organ/brain/Destroy(force)
	if(brainmob)
		QDEL_NULL(brainmob)
	QDEL_LIST(traumas)
	destroy_all_skillchips()
	if(owner)
		//You aren't allowed to return to brains that don't exist
		owner.mind?.set_current(null)
		var/obj/item/bodypart/parent_part = owner.get_bodypart(current_zone)
		//Delete the brain mob first, don't leave it stranded
		if(parent_part.brainmob)
			QDEL_NULL(parent_part.brainmob)
	return ..()

/obj/item/organ/brain/applyOrganDamage(amount, maximum = maxHealth, silent = FALSE)
	if(!amount) //Micro-optimization.
		return
	if(maximum < damage)
		damage = maximum
	if(damage < 0 && owner?.get_chem_effect(CE_BRAIN_REGEN))
		damage *= 2
	prev_damage = damage
	damage = clamp(damage + amount, 0, maximum)
	var/mess = check_damage_thresholds(owner)
	if(owner)
		if(mess && !silent)
			to_chat(owner, mess)
		if(organ_flags & ORGAN_LIMB_SUPPORTER)
			var/obj/item/bodypart/affected = owner.get_bodypart(current_zone)
			affected?.update_limb_efficiency()
		if(amount >= 10)
			var/damage_side_effect = CEILING(amount/2, 1)
			if(damage_side_effect >= 1)
				owner.flash_pain(damage_side_effect*4)
//				owner.blur_eyes(damage_side_effect)
				owner.add_confusion(damage_side_effect)
				switch(rand(0,3))
					if(1)
						owner.stuttering += damage_side_effect
					if(2)
						owner.slurring += damage_side_effect
					if(3)
						owner.cultslurring += damage_side_effect
				if(damage_side_effect >= 5)
					if(prob(50))
						owner.shit(FALSE)
					else
						owner.piss(FALSE)
				owner.CombatKnockdown(damage_side_effect*2, damage_side_effect, (damage_side_effect >= 5 ? damage_side_effect : null), damage_side_effect >= 5)
		if(!is_failing())
			REMOVE_TRAIT(owner, TRAIT_KNOCKEDOUT, CRIT_HEALTH_TRAIT)

/obj/item/organ/brain/check_damage_thresholds(mob/M)
	. = ..()
	// if we're not more injured than before, return without gambling for a trauma
	if(damage <= prev_damage)
		return
	var/damage_delta = damage - prev_damage
	// Safeguard to prevent traumas from low damage
	if((damage_delta >= TRAUMA_ROLL_THRESHOLD) && (damage >= BRAIN_DAMAGE_MILD))
		var/is_boosted = (owner && HAS_TRAIT(owner, TRAIT_SPECIAL_TRAUMA_BOOST))
		var/intelligence_modifier = (owner ? -(GET_MOB_ATTRIBUTE_VALUE(owner, STAT_INTELLIGENCE)-ATTRIBUTE_MIDDLING) : 0)
		if(damage >= BRAIN_DAMAGE_SEVERE)
			// Base chance is the hit damage, plus intelligence mod; for every point of damage past the threshold the chance is increased by 1%
			if(prob((damage_delta+intelligence_modifier) * (1 + max(0, (damage - BRAIN_DAMAGE_SEVERE)/100))))
				if(prob(20 + (is_boosted * 30) - (intelligence_modifier * 2)))
					gain_trauma_type(BRAIN_TRAUMA_SPECIAL, is_boosted ? TRAUMA_RESILIENCE_SURGERY : null, natural_gain = TRUE)
				else
					gain_trauma_type(BRAIN_TRAUMA_SEVERE, natural_gain = TRUE)
		else
			// Base chance is the hit damage, plus intelligence mod; for every point of damage past the threshold the chance is increased by 1%
			if(prob((damage_delta+intelligence_modifier) * (1 + max(0, (damage - BRAIN_DAMAGE_MILD)/100))))
				gain_trauma_type(BRAIN_TRAUMA_MILD, natural_gain = TRUE)
	if(owner)
		if(damage >= BRAIN_DAMAGE_DEATH && prev_damage < BRAIN_DAMAGE_DEATH && (organ_flags & ORGAN_VITAL))
			owner.death()
			return
		var/brain_message
		if(prev_damage < BRAIN_DAMAGE_MILD && damage >= BRAIN_DAMAGE_MILD)
			brain_message = span_warning("I feel lightheaded.")
		else if(prev_damage < BRAIN_DAMAGE_SEVERE && damage >= BRAIN_DAMAGE_SEVERE)
			brain_message = span_warning("I feel less in control of my thoughts.")
		else if(prev_damage < (BRAIN_DAMAGE_DEATH - 20) && damage >= (BRAIN_DAMAGE_DEATH - 20) && damage < BRAIN_DAMAGE_DEATH)
			brain_message = span_warning("I can feel my mind flickering on and off...")
		if(.)
			. += "\n[brain_message]"
		else
			return brain_message

/obj/item/organ/brain/before_organ_replacement(obj/item/organ/replacement)
	. = ..()
	var/obj/item/organ/brain/replacement_brain = replacement
	if(!istype(replacement_brain))
		return

	// If we have some sort of brain type or subtype change and have skillchips, engage the failsafe procedure!
	if(owner && length(skillchips) && (replacement_brain.type != type))
		activate_skillchip_failsafe(FALSE)

	// Check through all our skillchips, remove them from this brain, add them to the replacement brain.
	for(var/chip in skillchips)
		var/obj/item/skillchip/skillchip = chip

		// We're technically doing a little hackery here by bypassing the procs, but I'm the one who wrote them
		// and when you know the rules, you can break the rules.

		// Technically the owning mob is the same. We don't need to activate or deactivate the skillchips.
		// All the skillchips themselves care about is what brain they're in.
		// Because the new brain will ultimately be owned by the same body, we can safely leave skillchip logic alone.

		// Directly change the new holding_brain.
		skillchip.holding_brain = replacement_brain
		//And move the actual obj into the new brain (contents)
		skillchip.forceMove(replacement_brain)

		// Directly add them to the skillchip list in the new brain.
		LAZYADD(replacement_brain.skillchips, skillchip)

	// Any skillchips has been transferred over, time to empty the list.
	LAZYCLEARLIST(skillchips)

/obj/item/organ/brain/proc/handle_lobotomy(obj/item/tool, mob/living/user, params)
	user.visible_message(span_notice("<b>[user]</b> starts lobotomizing \the [src]..."), \
					span_notice("I start lobotomizing \the [src]..."), \
					vision_distance = COMBAT_MESSAGE_RANGE)
	owner.custom_pain("OH GOD! My [src] is being SLASHED IN TWAIN!", 30, FALSE, owner.get_bodypart(current_zone))
	if(!do_mob(user, owner, 10 SECONDS))
		to_chat(user, span_warning("I must stand still!"))
		return TRUE
	user.visible_message(span_notice("<b>[user]</b> lobotomizes \the [src]."), \
					span_notice("I lobotomize \the [src]."), \
					vision_distance = COMBAT_MESSAGE_RANGE)
	switch(owner.diceroll(GET_MOB_ATTRIBUTE_VALUE(owner, STAT_ENDURANCE), context = DICE_CONTEXT_MENTAL))
		// Cure all traumas, no penalties
		if(DICE_CRIT_SUCCESS)
			cure_all_traumas(TRAUMA_RESILIENCE_LOBOTOMY)
		// Cure all traumas, but gain a mild one
		if(DICE_SUCCESS)
			cure_all_traumas(TRAUMA_RESILIENCE_LOBOTOMY)
			gain_trauma_type(BRAIN_TRAUMA_MILD, TRAUMA_RESILIENCE_SURGERY)
		// Cure nothing, lose intelligence, go fuck yourself
		if(DICE_FAILURE)
			owner.attributes.add_attribute_modifier(/datum/attribute_modifier/lobotomy, TRUE)
		// Cure nothing, lose intelligence, gain another brain trauma, go fuck yourself
		if(DICE_CRIT_FAILURE)
			owner.attributes.add_attribute_modifier(/datum/attribute_modifier/lobotomite, TRUE)
			gain_trauma_type(BRAIN_TRAUMA_SEVERE, TRAUMA_RESILIENCE_LOBOTOMY)
	//no matter how shitty the lobotomy, always cure brainwashing
	if(owner.mind?.has_antag_datum(/datum/antagonist/brainwashed))
		owner.mind.remove_antag_datum(/datum/antagonist/brainwashed)
	return TRUE

/obj/item/organ/brain/proc/get_current_damage_threshold()
	return FLOOR(damage / damage_threshold_value, 1)

/obj/item/organ/brain/proc/past_damage_threshold(threshold)
	return (get_current_damage_threshold() > threshold)

/obj/item/organ/brain/proc/transfer_identity(mob/living/transferer)
	if(brainmob || decoy_override)
		return
	if(!transferer.mind)
		return
	brainmob = new(src)
	brainmob.name = transferer.real_name
	brainmob.real_name = transferer.real_name
	brainmob.timeofhostdeath = transferer.timeofdeath
	brainmob.suiciding = suicided
	if(transferer.has_dna())
		var/mob/living/carbon/carbon_transferer = transferer
		if(!brainmob.stored_dna)
			brainmob.stored_dna = new /datum/dna/stored(brainmob)
		carbon_transferer.dna.copy_dna(brainmob.stored_dna)
		if(HAS_TRAIT(carbon_transferer, TRAIT_BADDNA))
			LAZYSET(brainmob.status_traits, TRAIT_BADDNA, carbon_transferer.status_traits[TRAIT_BADDNA])
	if(transferer.mind && transferer.mind.current)
		transferer.mind.transfer_to(brainmob)
	to_chat(brainmob, span_notice("I feel slightly disoriented. That's normal since i'm just a brain."))

////////////////////////////////////TRAUMAS////////////////////////////////////////
/obj/item/organ/brain/proc/has_trauma_type(brain_trauma_type = /datum/brain_trauma, resilience = TRAUMA_RESILIENCE_ABSOLUTE)
	for(var/X in traumas)
		var/datum/brain_trauma/BT = X
		if(istype(BT, brain_trauma_type) && (BT.resilience <= resilience))
			return BT

/obj/item/organ/brain/proc/get_traumas_type(brain_trauma_type = /datum/brain_trauma, resilience = TRAUMA_RESILIENCE_ABSOLUTE)
	. = list()
	for(var/trauma_type in traumas)
		var/datum/brain_trauma/brain_trauma = trauma_type
		if(istype(brain_trauma, brain_trauma_type) && (brain_trauma.resilience <= resilience))
			. += brain_trauma

/obj/item/organ/brain/proc/can_gain_trauma(datum/brain_trauma/trauma, resilience, natural_gain = FALSE)
	if(!ispath(trauma))
		trauma = trauma.type
	if(!initial(trauma.can_gain))
		return FALSE
	if(!resilience)
		resilience = initial(trauma.resilience)

	var/resilience_tier_count = 0
	for(var/X in traumas)
		if(istype(X, trauma))
			return FALSE
		var/datum/brain_trauma/existing_trauma = X
		if(resilience == existing_trauma.resilience)
			resilience_tier_count++

	var/max_traumas
	switch(resilience)
		if(TRAUMA_RESILIENCE_BASIC)
			max_traumas = TRAUMA_LIMIT_BASIC
		if(TRAUMA_RESILIENCE_SURGERY)
			max_traumas = TRAUMA_LIMIT_SURGERY
		if(TRAUMA_RESILIENCE_WOUND)
			max_traumas = TRAUMA_LIMIT_WOUND
		if(TRAUMA_RESILIENCE_LOBOTOMY)
			max_traumas = TRAUMA_LIMIT_LOBOTOMY
		if(TRAUMA_RESILIENCE_MAGIC)
			max_traumas = TRAUMA_LIMIT_MAGIC
		if(TRAUMA_RESILIENCE_ABSOLUTE)
			max_traumas = TRAUMA_LIMIT_ABSOLUTE

	if(natural_gain && resilience_tier_count >= max_traumas)
		return FALSE
	return TRUE

//Proc to use when directly adding a trauma to the brain, so extra args can be given
/obj/item/organ/brain/proc/gain_trauma(datum/brain_trauma/trauma, resilience, ...)
	var/list/arguments = list()
	if(args.len > 2)
		arguments = args.Copy(3)
	. = brain_gain_trauma(trauma, resilience, arguments)

//Direct trauma gaining proc. Necessary to assign a trauma to its brain. Avoid using directly.
/obj/item/organ/brain/proc/brain_gain_trauma(datum/brain_trauma/trauma, resilience, list/arguments)
	if(!can_gain_trauma(trauma, resilience))
		return FALSE

	var/datum/brain_trauma/actual_trauma
	if(ispath(trauma))
		if(!LAZYLEN(arguments))
			actual_trauma = new trauma() //arglist with an empty list runtimes for some reason
		else
			actual_trauma = new trauma(arglist(arguments))
	else
		actual_trauma = trauma

	if(actual_trauma.brain) //we don't accept used traumas here
		WARNING("gain_trauma was given an already active trauma.")
		return FALSE

	traumas += actual_trauma
	actual_trauma.brain = src
	if(owner)
		actual_trauma.owner = owner
		SEND_SIGNAL(owner, COMSIG_CARBON_GAIN_TRAUMA, trauma)
		actual_trauma.on_gain()
	if(resilience)
		actual_trauma.resilience = resilience
	SSblackbox.record_feedback("tally", "traumas", 1, actual_trauma.type)
	return actual_trauma

/// Add a random trauma of a certain subtype
/obj/item/organ/brain/proc/gain_trauma_type(brain_trauma_type = /datum/brain_trauma, resilience, natural_gain = FALSE)
	var/list/datum/brain_trauma/possible_traumas = list()
	for(var/trauma_type in subtypesof(brain_trauma_type))
		var/datum/brain_trauma/brain_trauma = trauma_type
		if(can_gain_trauma(brain_trauma, resilience, natural_gain) && initial(brain_trauma.random_gain))
			possible_traumas += brain_trauma

	if(!LAZYLEN(possible_traumas))
		return

	var/trauma_type = pick(possible_traumas)
	return gain_trauma(trauma_type, resilience)

/// Cure a random trauma of a certain resilience level
/obj/item/organ/brain/proc/cure_trauma_type(brain_trauma_type = /datum/brain_trauma, resilience = TRAUMA_RESILIENCE_BASIC)
	var/list/traumas = get_traumas_type(brain_trauma_type, resilience)
	if(LAZYLEN(traumas))
		qdel(pick(traumas))

/obj/item/organ/brain/proc/cure_all_traumas(resilience = TRAUMA_RESILIENCE_BASIC)
	var/amount_cured = 0
	var/list/traumas = get_traumas_type(resilience = resilience)
	for(var/X in traumas)
		qdel(X)
		amount_cured++
	return amount_cured

/obj/item/organ/brain/halber
	maxHealth = 200
	high_threshold = 150
	low_threshold = 140
	internal_damage_modifier = 0.5