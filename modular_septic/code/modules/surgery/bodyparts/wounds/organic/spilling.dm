/// Spilling wounds
/datum/wound/spill
	name = "Spill"
	sound_effect = list('modular_septic/sound/gore/spill1.ogg', 'modular_septic/sound/gore/spill2.ogg')
	severity = WOUND_SEVERITY_CRITICAL

	wound_type = WOUND_SPILL
	wound_flags = WOUND_SOUND_HINTS

/// Brain spill
/datum/wound/spill/brain
	name = "Brain Spill"
	viable_zones = list(BODY_ZONE_HEAD)
	severity = WOUND_SEVERITY_CRITICAL
	threshold_minimum = 50

/datum/wound/spill/brain/can_afflict(obj/item/bodypart/new_limb, datum/wound/old_wound)
	. = ..()
	if(!.)
		return
	// Bro where the brain at
	if(!new_limb.getorganslot(ORGAN_SLOT_BRAIN))
		return FALSE
	// We need the bone to be just completely FUCKED
	if((new_limb.getorganslotefficiency(ORGAN_SLOT_BONE) > 0) || !new_limb.is_compound_fractured())
		return FALSE
	// Limb is already spilled
	if(new_limb.spilled)
		return FALSE
	// Limb not mangled
	if(new_limb.get_mangled_state() != BODYPART_MANGLED_BOTH)
		return FALSE
	var/gaping_wound = FALSE
	for(var/datum/injury/injury as anything in new_limb.injuries)
		if(injury.get_bleed_rate() && (injury.damage_per_injury() >= 25))
			gaping_wound = TRUE
			break
	// No sufficiently open wound
	if(!gaping_wound)
		return FALSE

/datum/wound/spill/brain/apply_wound(obj/item/bodypart/new_limb, silent, datum/wound/old_wound, smited, add_descriptive)
	. = ..()
	if(!.)
		return
	if(victim)
		if(sound_effect)
			playsound(new_limb.owner, pick(sound_effect), 100, TRUE)
		if(add_descriptive)
			SEND_SIGNAL(victim, COMSIG_CARBON_ADD_TO_WOUND_MESSAGE, span_dead(" [span_big(" The brain is spilled!")]"))
	new_limb.spilled = TRUE
	victim.bleed(20)
	INVOKE_ASYNC(src, .proc/debrain_animation, victim)
	qdel(src)

/datum/wound/spill/brain/proc/debrain_animation(mob/living/carbon/debrained)
	var/image/debraining_overlay = image('modular_septic/icons/mob/human/overlays/gore.dmi', "brain_bust")
	debrained.overlays += debraining_overlay
	sleep(0.8 SECONDS)
	if(QDELETED(debrained))
		return
	debrained.overlays -= debraining_overlay
	debrained.update_damage_overlays()
	var/obj/item/organ/brain/mushy_pea_brain = debrained.getorganslot(ORGAN_SLOT_BRAIN)
	if(!mushy_pea_brain)
		return
	mushy_pea_brain.Remove(mushy_pea_brain.owner, FALSE, FALSE)
	if(QDELETED(mushy_pea_brain))
		return
	mushy_pea_brain.organ_flags |= ORGAN_CUT_AWAY
	mushy_pea_brain.forceMove(debrained.drop_location())
	var/turf/open/spill_turf = get_step(mushy_pea_brain, pick(GLOB.alldirs))
	if(istype(spill_turf))
		mushy_pea_brain.forceMove(spill_turf)
	animate(mushy_pea_brain, transform = mushy_pea_brain.transform.Scale(1, 0.3), time = 1 SECONDS, easing = ELASTIC_EASING)
	sleep(1 SECONDS)
	if(QDELETED(mushy_pea_brain))
		return
	if(mushy_pea_brain.icon_state == "brain")
		mushy_pea_brain.icon_state = "brain-mushed"
		mushy_pea_brain.transform = mushy_pea_brain.transform.Scale(1, 1/0.3)
		mushy_pea_brain.name = "mushy [mushy_pea_brain.name]"
		mushy_pea_brain.desc += "\n"
		mushy_pea_brain.desc += span_dead("<u>[mushy_pea_brain] has seen better days...</u>")

/// Gut spill
/datum/wound/spill/gut
	name = "Gut Spill"
	viable_zones = list(BODY_ZONE_PRECISE_VITALS)
	severity = WOUND_SEVERITY_CRITICAL
	threshold_minimum = 25

/datum/wound/spill/gut/can_afflict(obj/item/bodypart/new_limb, datum/wound/old_wound)
	. = ..()
	if(!.)
		return
	// Bro where the gut at
	if(!new_limb.getorganslot(ORGAN_SLOT_INTESTINES))
		return FALSE
	// Limb is already spilled
	if(new_limb.spilled)
		return FALSE
	// Limb not mangled
	if((new_limb.get_mangled_state() != BODYPART_MANGLED_FLESH) && (new_limb.get_mangled_state() != BODYPART_MANGLED_BOTH))
		return FALSE
/*
	var/gaping_wound = FALSE
	for(var/datum/injury/injury as anything in new_limb.injuries)
		if(injury.get_bleed_rate() && (injury.damage_per_injury() >= 20))
			gaping_wound = TRUE
			break
	// No sufficiently open wound
	if(!gaping_wound)
		return FALSE
*/

/datum/wound/spill/gut/apply_wound(obj/item/bodypart/new_limb, silent, datum/wound/old_wound, smited, add_descriptive)
	. = ..()
	if(!.)
		return
	if(victim)
		if(sound_effect)
			playsound(new_limb.owner, pick(sound_effect), 100, TRUE)
		if(add_descriptive)
			SEND_SIGNAL(victim, COMSIG_CARBON_ADD_TO_WOUND_MESSAGE, span_bolddanger(" [span_big("The guts are spilled!")]"))
	new_limb.spilled = TRUE
	victim.bleed(20)
	victim.update_damage_overlays()
	var/list/intestines = new_limb.getorganslotlist(ORGAN_SLOT_INTESTINES)
	for(var/obj/item/organ/gut in intestines)
		gut.Remove(gut.owner)
		if(QDELETED(gut))
			continue
		gut.organ_flags |= ORGAN_CUT_AWAY
		var/turf/drop_location = victim.drop_location()
		if(istype(drop_location))
			gut.forceMove(victim.drop_location())
			victim.AddComponent(/datum/component/rope, gut, 'modular_septic/icons/effects/beam.dmi', "gut_beam2", 3, TRUE, /obj/effect/ebeam/gut, CALLBACK(victim, /mob/living/carbon/proc/gut_cut))
		else
			qdel(gut)
	for(var/obj/item/grab/grabber as anything in new_limb.grasped_by)
		grabber.update_grab_mode()
	qdel(src)

/datum/wound/spill/eyes
	name = "Eye Departure"
	viable_zones = list(BODY_ZONE_PRECISE_FACE, BODY_ZONE_HEAD)
	severity = WOUND_SEVERITY_CRITICAL
	threshold_minimum = 50

/datum/wound/spill/eyes/can_afflict(obj/item/bodypart/new_limb, datum/wound/old_wound)
	. = ..()
	if(!.)
		return
	// Bro where the eyes at
	if(!new_limb.getorganslot(ORGAN_SLOT_EYES))
		return FALSE
	// Limb is already spilled
	if(new_limb.spilled)
		return FALSE
	var/gaping_wound = FALSE
	for(var/datum/injury/injury as anything in new_limb.injuries)
		if(injury.get_bleed_rate() && (injury.damage_per_injury() >= 30))
			gaping_wound = TRUE
			break
	// No sufficiently open wound
	if(!gaping_wound)
		return FALSE

/datum/wound/spill/eyes/apply_wound(obj/item/bodypart/new_limb, silent, datum/wound/old_wound, smited, add_descriptive)
	. = ..()
	if(!.)
		return
	if(victim)
		if(sound_effect)
			playsound(new_limb.owner, pick(sound_effect), 100, TRUE)
		if(add_descriptive)
			SEND_SIGNAL(victim, COMSIG_CARBON_ADD_TO_WOUND_MESSAGE, span_bolddanger(" [span_big("The eyes popped out!")]"))
	new_limb.spilled = TRUE
	victim.bleed(20)
	victim.update_damage_overlays()
	var/list/eyes = new_limb.getorganslotlist(ORGAN_SLOT_EYES)
	for(var/obj/item/organ/eyeb in eyes)
		eyeb.Remove(eyeb.owner)
		if(QDELETED(eyeb))
			continue
		eyeb.organ_flags |= ORGAN_CUT_AWAY
		var/turf/open/dep_turf = get_step(eyeb, pick(GLOB.alldirs))
		if(istype(dep_turf))
			eyeb.forceMove(dep_turf)
		else
			qdel(eyeb)
