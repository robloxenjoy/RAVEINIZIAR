/*
	Wounds are specific medical complications that can arise and be applied to (currently) carbons, with a focus on humans. All of the code for and related to this is heavily WIP,
	and the documentation will be slanted towards explaining what each part/piece is leading up to, until such a time as I finish the core implementations. The original design doc
	can be found at https://hackmd.io/@Ryll/r1lb4SOwU

	Wounds are datums that operate like a mix of diseases, brain traumas, and components, and are applied to a /obj/item/bodypart (preferably attached to a carbon) when they take large spikes of damage
	or under other certain conditions (thrown hard against a wall, sustained exposure to plasma fire, etc). Wounds are categorized by the three following criteria:
		1. Severity: Either MODERATE, SEVERE, or CRITICAL. See the hackmd for more details
		2. Viable zones: What body parts the wound is applicable to. Generic wounds like broken bones and severe burns can apply to every zone, but you may want to add special wounds for certain limbs
			like a twisted ankle for legs only, or open air exposure of the organs for particularly gruesome chest wounds. Wounds should be able to function for every zone they are marked viable for.
		3. Damage type: Currently either BRUTE or BURN. Again, see the hackmd for a breakdown of my plans for each type.

	When a body part suffers enough damage to get a wound, the severity (determined by a roll or something, worse damage leading to worse wounds), affected limb, and damage type sustained are factored into
	deciding what specific wound will be applied. I'd like to have a few different types of wounds for at least some of the choices, but I'm just doing rough generals for now. Expect polishing
*/

/datum/wound
	/// What it's named
	var/name = "Wound"
	/// The description shown on the scanners
	var/desc = ""
	/// The basic treatment suggested by health analyzers
	var/treat_text = ""
	/// What the limb looks like on a cursory examine
	var/examine_desc = "is badly hurt"

	/// needed for "your arm has a compound fracture" vs "your arm has some third degree burns"
	var/a_or_from = "a"
	/// The visible message when this happens
	var/occur_text = ""
	/// This sound will be played upon the wound being applied
	var/sound_effect

	/// Either WOUND_SEVERITY_TRIVIAL (meme wounds like stubbed toe), WOUND_SEVERITY_MODERATE, WOUND_SEVERITY_SEVERE, or WOUND_SEVERITY_CRITICAL (or maybe WOUND_SEVERITY_LOSS)
	var/severity = WOUND_SEVERITY_MODERATE
	/// The type of wound (WOUND_BLUNT, WOUND_ARTERY, etc)
	var/wound_type

	/// What body zones can we affect
	var/list/viable_zones = ALL_BODYPARTS
	/// Who owns the body part that we're wounding
	var/mob/living/carbon/victim = null
	/// The bodypart we're parented to
	var/obj/item/bodypart/limb = null
	/// What kind of limb status we can apply on - set to null if there is no status requirement
	var/required_status = null

	/// Specific items such as bandages or sutures that can try directly treating this wound
	var/list/treatable_by
	/// Specific items such as bandages or sutures that can try directly treating this wound only if the user has the victim in an aggressive grab or higher
	var/list/treatable_by_grabbed
	/// Tools with the specified tool flag will also be able to try directly treating this wound
	var/treatable_tool
	/// How long it will take to treat this wound with a standard effective tool, assuming it doesn't need surgery
	var/base_treat_time = 5 SECONDS // Please remember that this is heavily affected by skills

	/// How much this reduces the limb's efficiency
	var/limb_efficiency_reduction = 0
	/// Using this limb in a do_after interaction will multiply the length by this duration (arms and hands)
	var/interaction_efficiency_penalty = 1
	/// Incoming damage on this limb will be multiplied by this, to simulate tenderness and vulnerability
	var/damage_multiplier_penalty = 1
	/// If set and this wound is applied to a leg/foot, we take this many deciseconds extra per step on this leg/foot
	var/limp_slowdown = 0
	/// How much we're contributing to this limb's bleed_rate
	var/blood_flow = 0

	/// Will apply this amount of damage to attached organs if set
	var/apply_organ_damage = 0
	/// How much this reduces an attached organ's efficiency, if it does it at all
	var/list/organ_efficiency_reduction

	/// The minimum we need to roll on [/obj/item/bodypart/proc/check_wounding] to begin suffering this wound, see check_wounding_mods() for more
	var/threshold_minimum
	/// How much having this wound will add to all future check_wounding() rolls on this limb, to allow progression to worse injuries with repeated damage
	var/threshold_penalty
	/// If we need to process each life tick
	var/processes = FALSE

	/// If having this wound makes currently makes the parent bodypart unusable
	var/disabling
	/// How much pain this wound causes
	var/pain_amount = 10
	/// How much this wound increases the damage on organ damage rolls
	var/organ_damage_increase = 0
	/// How much this wound reduces organ_damage_minimum in /obj/item/bodypart/damage_internal_organs()
	var/organ_minimum_reduction = 0
	/// How much this wound reduces organ_damaged_required in /obj/item/bodypart/damage_internal_organs()
	var/organ_required_reduction = 0

	/// What status effect we assign on application
	var/status_effect_type
	/// if you're a lazy git and just throw them in cryo, the wound will go away after accumulating severity * 25 power
	var/cryo_progress

	/// What we add to the carbon mob's descriptive wound string once acquired
	var/descriptive = ""
	/// What kind of scars this wound will create description wise once healed
	var/scar_keyword
	/// If we've already tried scarring while removing (since remove_wound calls qdel, and qdel calls remove wound, .....) TODO: make this cleaner
	var/already_scarred = FALSE
	/// If we forced this wound through badmin smite, we won't count it towards the round totals
	var/from_smite

	/// What flags apply to this wound
	var/wound_flags = (WOUND_SOUND_HINTS|WOUND_ACCEPTS_STUMP|WOUND_VISIBLE_THROUGH_CLOTHING)

/datum/wound/Destroy()
	if(limb?.wounds && (src in limb.wounds)) // destroy can call remove_wound() and remove_wound() calls qdel, so we check to make sure there's anything to remove first
		remove_wound()
	set_limb(null)
	victim = null
	return ..()

/**
 * Whether we should show an interactable topic in examines of the wound. href_list["wound_topic"]
 */
/datum/wound/proc/show_wound_topic(mob/user)
	return FALSE

/**
 * Gets the name of the wound with any interactable topic if possible
 */
/datum/wound/proc/get_topic_name(mob/user)
	return (show_wound_topic(user) ? "<a href='?src=[REF(src)];wound_topic=1'>[lowertext(name)]</a>" : lowertext(name))

/**
 * can_afflict() is used to check if a wound can even be applied on the victim and bodypart specified
 *
 * Arguments
 * L: The limb being wounded - We can get the owner via the limb itself.
 */
/datum/wound/proc/can_afflict(obj/item/bodypart/new_limb, datum/wound/old_wound = null)
	. = FALSE
	if(!istype(new_limb))
		return
	if(!(new_limb.owner))
		return
	if(!(new_limb.body_zone in viable_zones))
		return
	if(required_status && (new_limb.status != required_status))
		return
	if(new_limb.is_stump() && !(CHECK_BITFIELD(wound_flags, WOUND_ACCEPTS_STUMP)))
		return
	if(HAS_TRAIT(new_limb, TRAIT_NEVER_WOUNDED) || HAS_TRAIT(new_limb.owner, TRAIT_NEVER_WOUNDED))
		return
	var/epic_fail = TRUE
	switch(wound_type)
		if(WOUND_BLUNT)
			switch(severity)
				if(WOUND_SEVERITY_MODERATE)
					for(var/thing in new_limb.getorganslotlist(ORGAN_SLOT_BONE))
						var/obj/item/organ/bone/bone = thing
						if((bone.bone_flags & BONE_JOINTED) && (bone.damage < bone.low_threshold))
							epic_fail = FALSE
				if(WOUND_SEVERITY_SEVERE)
					for(var/thing in new_limb.getorganslotlist(ORGAN_SLOT_BONE))
						var/obj/item/organ/bone/bone = thing
						if(bone.damage < bone.medium_threshold)
							epic_fail = FALSE
				else
					for(var/thing in new_limb.getorganslotlist(ORGAN_SLOT_BONE))
						var/obj/item/organ/bone/bone = thing
						if(!(bone.damage < bone.high_threshold))
							epic_fail = FALSE
		if(WOUND_ARTERY)
			for(var/thing in new_limb.getorganslotlist(ORGAN_SLOT_ARTERY))
				var/obj/item/organ/artery/artery = thing
				if(artery.damage < artery.maxHealth)
					epic_fail = FALSE
		if(WOUND_TENDON)
			for(var/thing in new_limb.getorganslotlist(ORGAN_SLOT_TENDON))
				var/obj/item/organ/tendon/tendon = thing
				if(tendon.damage < tendon.maxHealth)
					epic_fail = FALSE
		if(WOUND_NERVE)
			for(var/thing in new_limb.getorganslotlist(ORGAN_SLOT_NERVE))
				var/obj/item/organ/nerve/nerve = thing
				if(nerve.damage < nerve.maxHealth)
					epic_fail = FALSE
		else
			epic_fail = FALSE
	if(epic_fail)
		return
	// we accept promotions and demotions, but no point in redundancy.
	// This should have already been checked wherever the wound was rolled and applied for (see: bodypart damage code), but we do an extra check
	// in case we ever directly add wounds.
	// This check is avoided if our wound type has WOUND_STACKING as a flag.
	if(!CHECK_BITFIELD(wound_flags, WOUND_STACKABLE))
		for(var/thing in new_limb.wounds)
			var/datum/wound/preexisting_wound = thing
			if((preexisting_wound.type == type) && (preexisting_wound != old_wound))
				return
	return TRUE

/**
 * apply_wound() is used once a wound type is instantiated to assign it to a bodypart, and actually come into play.
 *
 *
 * Arguments:
 * * L: The bodypart we're wounding, we don't care about the person, we can get them through the limb
 * * silent: Not actually necessary I don't think, was originally used for demoting wounds so they wouldn't make new messages, but I believe old_wound took over that, I may remove this shortly
 * * old_wound: If our new wound is a replacement for one of the same time (promotion or demotion), we can reference the old one just before it's removed to copy over necessary vars
 * * smited- If this is a smite, we don't care about this wound for stat tracking purposes (not yet implemented)
 */
/datum/wound/proc/apply_wound(obj/item/bodypart/new_limb, silent = FALSE, datum/wound/old_wound = null, smited = FALSE, add_descriptive = TRUE)
	if(!can_afflict(new_limb, old_wound))
		qdel(src)
		return

	victim = new_limb.owner
	RegisterSignal(victim, COMSIG_PARENT_QDELETING, .proc/null_victim)
	set_limb(new_limb)
	LAZYADD(victim.all_wounds, src)
	LAZYADD(limb.wounds, src)
	limb.update_wounds()
	if(status_effect_type)
		victim.apply_status_effect(status_effect_type, src)
	SEND_SIGNAL(victim, COMSIG_CARBON_GAIN_WOUND, src, limb)

	var/demoted
	if(old_wound)
		demoted = (severity <= old_wound.severity)

	if(!silent && !demoted)
		if(add_descriptive)
			if(descriptive)
				SEND_SIGNAL(victim, COMSIG_CARBON_ADD_TO_WOUND_MESSAGE, " [descriptive]")
			if(sound_effect)
				playsound(new_limb.owner, pick(sound_effect), 70 + 20 * severity, TRUE)
		else
			victim.visible_message(span_danger("<b>[victim]</b>'s [limb.name] [occur_text]!"), \
					span_userdanger("My [limb.name] [occur_text]!"), \
					vision_distance = COMBAT_MESSAGE_RANGE)
			if(sound_effect)
				playsound(new_limb.owner, pick(sound_effect), 70 + 20 * severity, TRUE)

	if(!demoted)
		wound_injury(old_wound)
		second_wind()

	return TRUE

/datum/wound/proc/null_victim()
	SIGNAL_HANDLER
	victim = null

/datum/wound/proc/source_died()
	SIGNAL_HANDLER
	qdel(src)

/// Remove the wound from whatever it's afflicting, and cleans up whateverstatus effects it had or modifiers it had on interaction times. ignore_limb is used for detachments where we only want to forget the victim
/datum/wound/proc/remove_wound(ignore_limb, replaced = FALSE)
	//TODO: have better way to tell if we're getting removed without replacement (full heal) scar stuff
	set_disabling(FALSE)
	if(limb && !already_scarred && !replaced)
		already_scarred = TRUE
		if(scar_keyword)
			var/datum/scar/new_scar = new
			new_scar.generate(limb, src)
	if(victim)
		LAZYREMOVE(victim.all_wounds, src)
		if(!victim.all_wounds)
			victim.clear_alert("wound")
		SEND_SIGNAL(victim, COMSIG_CARBON_LOSE_WOUND, src, limb)
	if(limb && !ignore_limb)
		LAZYREMOVE(limb.wounds, src)
		limb.update_wounds(replaced)
		limb.update_limb_efficiency()

/**
 * replace_wound() is used when you want to replace the current wound with a new wound, presumably of the same category, just of a different severity (either up or down counts)
 *
 * This proc actually instantiates the new wound based off the specific type path passed, then returns the new instantiated wound datum.
 *
 * Arguments:
 * * new_type- The TYPE PATH of the wound you want to replace this, like /datum/wound/slash/severe
 * * smited- If this is a smite, we don't care about this wound for stat tracking purposes (not yet implemented)
 */
/datum/wound/proc/replace_wound(new_type, smited = FALSE)
	var/datum/wound/new_wound = new new_type
	already_scarred = TRUE
	remove_wound(replaced=TRUE)
	new_wound.apply_wound(limb, TRUE, old_wound = src, smited = smited)
	. = new_wound
	qdel(src)

/// The immediate negative effects faced as a result of the wound
/datum/wound/proc/wound_injury(datum/wound/old_wound = null)
	return

/// Proc called to change the variable `limb` and react to the event.
/datum/wound/proc/set_limb(new_value)
	if(limb == new_value)
		return FALSE //Limb can either be a reference to something or `null`. Returning the number variable makes it clear no change was made.
	. = limb
	if(limb)
		UnregisterSignal(limb, COMSIG_PARENT_QDELETING)
	limb = new_value
	RegisterSignal(new_value, COMSIG_PARENT_QDELETING, .proc/source_died)
	if(. && disabling)
		var/obj/item/bodypart/old_limb = .
		REMOVE_TRAIT(old_limb, TRAIT_PARALYSIS, src)
		REMOVE_TRAIT(old_limb, TRAIT_DISABLED_BY_WOUND, src)
	if(limb)
		if(disabling)
			ADD_TRAIT(limb, TRAIT_PARALYSIS, src)
			ADD_TRAIT(limb, TRAIT_DISABLED_BY_WOUND, src)

/// Proc called to change the variable `disabling` and react to the event.
/datum/wound/proc/set_disabling(new_value)
	if(disabling == new_value)
		return
	. = disabling
	disabling = new_value
	if(disabling)
		if(!. && limb) //Gained disabling.
			ADD_TRAIT(limb, TRAIT_PARALYSIS, src)
			ADD_TRAIT(limb, TRAIT_DISABLED_BY_WOUND, src)
	else if(. && limb) //Lost disabling.
		REMOVE_TRAIT(limb, TRAIT_PARALYSIS, src)
		REMOVE_TRAIT(limb, TRAIT_DISABLED_BY_WOUND, src)
	if(limb?.can_be_disabled)
		limb.update_disabled()

/// Additional beneficial effects when the wound is gained, in case you want to give a temporary boost to allow the victim to try an escape or last stand
/datum/wound/proc/second_wind()
	switch(severity)
		if(WOUND_SEVERITY_MODERATE)
			victim.reagents.add_reagent(/datum/reagent/medicine/epinephrine, WOUND_DETERMINATION_MODERATE)
		if(WOUND_SEVERITY_SEVERE)
			victim.reagents.add_reagent(/datum/reagent/medicine/epinephrine, WOUND_DETERMINATION_SEVERE)
		if(WOUND_SEVERITY_CRITICAL)
			victim.reagents.add_reagent(/datum/reagent/medicine/epinephrine, WOUND_DETERMINATION_CRITICAL)
		if(WOUND_SEVERITY_LOSS)
			victim.reagents.add_reagent(/datum/reagent/medicine/epinephrine, WOUND_DETERMINATION_LOSS)

/**
 * try_treating() is an intercept run from [/mob/living/carbon/proc/attackby] right after surgeries but before anything else. Return TRUE here if the item is something that is relevant to treatment to take over the interaction.
 *
 * This proc leads into [/datum/wound/proc/treat] and probably shouldn't be added onto in children types. You can specify what items or tools you want to be intercepted
 * with var/list/treatable_by and var/treatable_tool, then if an item fulfills one of those requirements and our wound claims it first, it goes over to treat() and treat_self().
 *
 * Arguments:
 * * I: The item we're trying to use
 * * user: The mob trying to use it on us
 */
/datum/wound/proc/try_treating(obj/item/I, mob/user)
	// first we weed out if we're not dealing with our wound's bodypart, or if it might be an attack
	if(!I || limb.body_zone != user.zone_selected)
		return FALSE

	if(isliving(user))
		var/mob/living/tendee = user
		if(I.force && !IS_HELP_INTENT(tendee, null))
			return FALSE

	var/allowed = FALSE

	// check if we have a valid treatable tool
	if(I.tool_behaviour == treatable_tool)
		allowed = TRUE
	else if(treatable_tool == TOOL_CAUTERY && I.get_temperature() && user == victim) // allow improvised cauterization on yourself without an aggro grab
		allowed = TRUE
	// failing that, see if we're aggro grabbing them and if we have an item that works for aggro grabs only
	else if(user.pulling == victim && user.grab_state >= GRAB_AGGRESSIVE && check_grab_treatments(I, user))
		allowed = TRUE
	// failing THAT, we check if we have a generally allowed item
	else
		for(var/allowed_type in treatable_by)
			if(istype(I, allowed_type))
				allowed = TRUE
				break

	// if none of those apply, we return false to avoid interrupting
	if(!allowed)
		return FALSE

	// now that we've determined we have a valid attempt at treating, we can stomp on their dreams if we're already interacting with the patient or if their part is obscured
	if(DOING_INTERACTION_WITH_TARGET(user, victim))
		to_chat(user, span_warning("You're already interacting with <b>[victim]</b>!"))
		return TRUE

	// next we check if the bodypart in actually accessible (not under thick clothing). We skip the species trait check since skellies
	// & such may need to use bone gel but may be wearing a space suit for..... whatever reason a skeleton would wear a space suit for
	if(ishuman(victim))
		var/mob/living/carbon/human/victim_human = victim
		if(!victim_human.try_inject(user, injection_flags = INJECT_CHECK_IGNORE_SPECIES | INJECT_TRY_SHOW_ERROR_MESSAGE))
			return TRUE

	// lastly, treat them
	treat(I, user)
	return TRUE

/// Return TRUE if we have an item that can only be used while aggro grabbed (unhanded aggro grab treatments go in [/datum/wound/proc/try_handling]). Treatment is still is handled in [/datum/wound/proc/treat]
/datum/wound/proc/check_grab_treatments(obj/item/I, mob/user)
	return FALSE

/// Like try_treating() but for unhanded interactions from humans, used by joint dislocations for manual bodypart chiropractice for example. Ignores thick material checks since you can pop an arm into place through a thick suit unlike using sutures
/datum/wound/proc/try_handling(mob/living/carbon/human/user)
	return FALSE

/// Someone is using something that might be used for treating the wound on this limb
/datum/wound/proc/treat(obj/item/I, mob/user)
	return

/// If var/processing is TRUE, this is run on each life tick
/datum/wound/proc/handle_process(delta_time, times_fired)
	return

/// For use in do_after callback checks
/datum/wound/proc/still_exists()
	return (!QDELETED(src) && limb)

/// When our parent bodypart is hurt
/datum/wound/proc/receive_damage(wounding_type, wounding_dmg, wound_bonus)
	return

/// Called from cryoxadone and pyroxadone when they're proc'ing. Wounds will slowly be fixed separately from other methods when these are in effect. crappy name but eh
/datum/wound/proc/on_xadone(power)
	cryo_progress += power
	if(cryo_progress > 33 * severity)
		qdel(src)

/// When synthflesh is applied to the victim, we call this. No sense in setting up an entire chem reaction system for wounds when we only care for a few chems. Probably will change in the future
/datum/wound/proc/on_synthflesh(power)
	return

/// Called when the patient is undergoing stasis, so that having fully treated a wound doesn't make you sit there helplessly until you think to unbuckle them
/datum/wound/proc/on_stasis(delta_time, times_fired)
	return

/// Used when we're being dragged while bleeding, the value we return is how much bloodloss this wound causes from being dragged. Since it's a proc, you can let bandages soak some of the blood
/datum/wound/proc/drag_bleed_amount()
	return

/**
 * get_bleed_rate_of_change() is used in [/mob/living/carbon/proc/bleed_warn] to gauge whether this wound (if bleeding) is becoming worse, better, or staying the same over time
 *
 * Returns BLOOD_FLOW_STEADY if we're not bleeding or there's no change (like piercing), BLOOD_FLOW_DECREASING if we're clotting (non-critical slashes, gauzed, coagulant, etc), BLOOD_FLOW_INCREASING if we're opening up (crit slashes/heparin)
 */
/datum/wound/proc/get_bleed_rate_of_change()
	if(blood_flow && HAS_TRAIT(victim, TRAIT_BLOODY_MESS))
		return BLOOD_FLOW_INCREASING
	return BLOOD_FLOW_STEADY

/**
 * get_examine_description() is used in carbon/examine and human/examine to show the status of this wound. Useful if you need to show some status like the wound being splinted or bandaged.
 *
 * Return the full string line you want to show, note that we're already dealing with the 'warning' span at this point, and that \n is already appended for you in the place this is called from
 *
 * Arguments:
 * * mob/user: The user examining the wound's owner, if that matters
 */
/datum/wound/proc/get_examine_description(mob/user)
	if(!examine_desc)
		return
	. = "[victim.p_their(TRUE)] [limb.name] [examine_desc]"
	. = severity <= WOUND_SEVERITY_MODERATE ? "[.]." : "<B>[.]!</B>"
	. = span_danger("[.]")

/datum/wound/proc/get_scanner_description(mob/user)
	return "Type: [name]\nSeverity: [severity_text()]\nDescription: [desc]\nRecommended Treatment: [treat_text]"

/datum/wound/proc/severity_text()
	switch(severity)
		if(WOUND_SEVERITY_TRIVIAL)
			return "Trivial"
		if(WOUND_SEVERITY_MODERATE)
			return "Moderate"
		if(WOUND_SEVERITY_SEVERE)
			return "Severe"
		if(WOUND_SEVERITY_CRITICAL)
			return "Critical"
