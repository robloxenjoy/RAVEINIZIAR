//Hygiene stuff
/mob/living/carbon/human/Initialize(mapload)
	. = ..()
	//values are quite low due to the way dirty clothing dirtifies you
	set_germ_level(rand(GERM_LEVEL_START_MIN, GERM_LEVEL_START_MAX))
//	add_verb(src, /mob/living/carbon/human/proc/hide_furry_shit)
	//hehe horny
	set_arousal(rand(AROUSAL_LEVEL_START_MIN, AROUSAL_LEVEL_START_MAX))
	AddComponent(/datum/component/fixeye)
	AddComponent(/datum/component/interactable)
	AddComponent(/datum/component/babble)

/mob/living/carbon/human/set_stat(new_stat)
	if(new_stat == stat)
		return
	SEND_SIGNAL(src, COMSIG_MOB_STATCHANGE, new_stat)
	. = stat
	stat = new_stat
	if(isnull(.))
		return

	//Previous stat
	switch(.)
		if(CONSCIOUS)
			if(stat >= UNCONSCIOUS)
				ADD_TRAIT(src, TRAIT_IMMOBILIZED, TRAIT_KNOCKEDOUT)
			ADD_TRAIT(src, TRAIT_HANDS_BLOCKED, STAT_TRAIT)
			ADD_TRAIT(src, TRAIT_INCAPACITATED, STAT_TRAIT)
			ADD_TRAIT(src, TRAIT_FLOORED, STAT_TRAIT)
		if(SOFT_CRIT)
			if(stat >= UNCONSCIOUS)
				//adding trait sources should come before removing to avoid unnecessary updates
				ADD_TRAIT(src, TRAIT_IMMOBILIZED, TRAIT_KNOCKEDOUT)
		if(UNCONSCIOUS)
			if(stat < HARD_CRIT)
				cure_blind(UNCONSCIOUS_TRAIT)
		if(HARD_CRIT)
			if(stat < UNCONSCIOUS)
				cure_blind(UNCONSCIOUS_TRAIT)
		if(DEAD)
			remove_from_dead_mob_list()
			add_to_alive_mob_list()
	//Current stat
	switch(stat)
		if(CONSCIOUS)
			if(. >= UNCONSCIOUS)
				REMOVE_TRAIT(src, TRAIT_IMMOBILIZED, TRAIT_KNOCKEDOUT)
				cure_blind(UNCONSCIOUS_TRAIT)
			REMOVE_TRAIT(src, TRAIT_HANDS_BLOCKED, STAT_TRAIT)
			REMOVE_TRAIT(src, TRAIT_INCAPACITATED, STAT_TRAIT)
			REMOVE_TRAIT(src, TRAIT_FLOORED, STAT_TRAIT)
			REMOVE_TRAIT(src, TRAIT_CRITICAL_CONDITION, STAT_TRAIT)
		if(SOFT_CRIT)
			if(. >= UNCONSCIOUS)
				REMOVE_TRAIT(src, TRAIT_IMMOBILIZED, TRAIT_KNOCKEDOUT)
				cure_blind(UNCONSCIOUS_TRAIT)
		if(UNCONSCIOUS)
			if(. < UNCONSCIOUS)
				become_blind(UNCONSCIOUS_TRAIT)
		if(HARD_CRIT)
			if(. < UNCONSCIOUS)
				become_blind(UNCONSCIOUS_TRAIT)
			ADD_TRAIT(src, TRAIT_CRITICAL_CONDITION, STAT_TRAIT)
		if(DEAD)
			REMOVE_TRAIT(src, TRAIT_CRITICAL_CONDITION, STAT_TRAIT)
			remove_from_alive_mob_list()
			add_to_dead_mob_list()

/mob/living/carbon/human/set_health(new_value)
	. = health
	health = new_value
	if(CONFIG_GET(flag/near_death_experience))
		if(. > HEALTH_THRESHOLD_NEARDEATH)
			if(health <= HEALTH_THRESHOLD_NEARDEATH && !HAS_TRAIT(src, TRAIT_NODEATH))
				ADD_TRAIT(src, TRAIT_SIXTHSENSE, NEAR_DEATH_TRAIT)
		else if(health > HEALTH_THRESHOLD_NEARDEATH)
			REMOVE_TRAIT(src, TRAIT_SIXTHSENSE, NEAR_DEATH_TRAIT)

/mob/living/carbon/human/update_stat()
	if(status_flags & GODMODE)
		return
	if(stat < DEAD)
		if(health <= HEALTH_THRESHOLD_DEAD && !HAS_TRAIT(src, TRAIT_NODEATH))
			death()
			return
		if(undergoing_nervous_system_failure() && !HAS_TRAIT(src, TRAIT_NOHARDCRIT))
			set_stat(HARD_CRIT)
		else if(HAS_TRAIT(src, TRAIT_KNOCKEDOUT))
			set_stat(UNCONSCIOUS)
		else if(HAS_TRAIT(src, TRAIT_SOFT_CRITICAL_CONDITION) && !HAS_TRAIT(src, TRAIT_NOSOFTCRIT))
			set_stat(SOFT_CRIT)
		else
			set_stat(CONSCIOUS)
	update_damage_hud()
	update_health_hud()
	update_sleeping_hud()
	med_hud_set_status()

//OVERRIDE IGNORING PARENT RETURN VALUE
/mob/living/carbon/human/updatehealth()
	if(status_flags & GODMODE)
		return
	var/total_brute = 0
	var/total_burn = 0
	var/total_stamina = 0
	for(var/X in bodyparts) //hardcoded to streamline things a bit
		var/obj/item/bodypart/bodypart = X
		total_brute += (bodypart.brute_dam * bodypart.body_damage_coeff)
		total_burn += (bodypart.burn_dam * bodypart.body_damage_coeff)
		total_stamina += (bodypart.stamina_dam * bodypart.stam_damage_coeff)
	bruteloss = round(total_brute, DAMAGE_PRECISION)
	fireloss = round(total_burn, DAMAGE_PRECISION)
	staminaloss = round(total_stamina, DAMAGE_PRECISION)
	set_health(maxHealth - GETBRAINLOSS(src))
	update_pain()
	update_shock()
	if((maxHealth - total_burn <= HEALTH_THRESHOLD_DEAD*2) && (stat == DEAD))
		become_husk(BURN)
	update_stat()
	med_hud_set_health()
	dna?.species?.spec_updatehealth(src)
	SEND_SIGNAL(src, COMSIG_CARBON_HEALTH_UPDATE)

/mob/living/carbon/human/genital_visible(genital_slot = ORGAN_SLOT_PENIS)
	var/list/genitals = getorganslotlist(genital_slot)
	if(!LAZYLEN(genitals))
		var/obj/item/bodypart/bp_required
		switch(genital_slot)
			if(ORGAN_SLOT_WOMB)
				return FALSE
			if(ORGAN_SLOT_PENIS, ORGAN_SLOT_VAGINA, ORGAN_SLOT_ANUS)
				bp_required = get_bodypart_nostump(BODY_ZONE_PRECISE_GROIN)
				return (bp_required && !LAZYLEN(clothingonpart(bp_required)))
			if(ORGAN_SLOT_BREASTS)
				bp_required = get_bodypart_nostump(BODY_ZONE_CHEST)
				return (bp_required && !LAZYLEN(clothingonpart(bp_required)))
	else
		for(var/obj/item/organ/genital/genital as anything in genitals)
			if(genital.is_visible())
				return TRUE

/mob/living/carbon/human/should_have_genital(genital_slot = ORGAN_SLOT_PENIS)
	. = FALSE
	if((genital_slot in GLOB.genital_sets[genitals]) && !(AGENDER in dna.species.species_traits))
		return TRUE

/mob/living/carbon/human/getMaxHealth()
	var/obj/item/organ/brain = getorganslot(ORGAN_SLOT_BRAIN)
	if(brain)
		return brain.maxHealth
	return BRAIN_DAMAGE_DEATH

/mob/living/carbon/human/update_lips(new_style, new_colour, apply_trait)
	lip_style = new_style
	lip_color = new_colour
	update_body()

	var/obj/item/bodypart/mouth/hopefully_a_jaw = get_bodypart(check_zone(BODY_ZONE_PRECISE_MOUTH))
	REMOVE_TRAITS_IN(src, LIPSTICK_TRAIT)
	hopefully_a_jaw?.stored_lipstick_trait = null

	if(new_style && apply_trait)
		ADD_TRAIT(src, apply_trait, LIPSTICK_TRAIT)
		hopefully_a_jaw?.stored_lipstick_trait = apply_trait

///Get all the clothing on a specific body part
/mob/living/carbon/human/clothingonpart(obj/item/bodypart/def_zone)
	//body zone
	if(istext(def_zone))
		def_zone = GLOB.bodyzone_to_bitflag[def_zone]
	//bodypart
	else if(istype(def_zone))
		def_zone = def_zone.body_part
	//invalid
	else
		return
	//hopefully already a bitflag otherwise
	var/list/covering_part = list()
	//Everything but pockets. Pockets are l_store and r_store.
	//(if pockets were allowed, putting something armored, gloves or hats for example, would double up on the armor)
	var/list/clothings = list(head,
							wear_mask,
							wear_suit,
							w_uniform,
							back,
							gloves,
							shoes,
							belt,
							s_store,
							glasses,
							wrists,
							pants,
							oversuit,
							ears,
							ears_extra,
							wear_id,
							wear_neck)
	for(var/obj/item/item in clothings)
		if(item.body_parts_covered & def_zone)
			covering_part += item
	return covering_part

///Adjust the arousal of a human
/mob/living/carbon/human/proc/adjust_arousal(change)
	arousal = max(0, arousal + change)
	var/genital_arousal = AROUSAL_NONE
	switch(arousal)
		if(AROUSAL_LEVEL_HORNY to INFINITY)
			genital_arousal = AROUSAL_FULL
		if(AROUSAL_LEVEL_AROUSED to AROUSAL_LEVEL_HORNY)
			genital_arousal = AROUSAL_PARTIAL
		else
			genital_arousal = AROUSAL_NONE
	for(var/obj/item/organ/genital/genital in internal_organs)
		if(genital.arousal_state == AROUSAL_CANT)
			continue
		genital.arousal_state = genital_arousal
	update_mutant_bodyparts()
///Illiterate and proud
/mob/living/carbon/human/is_literate()
	if(HAS_TRAIT(src, TRAIT_ILLITERATE))
		return FALSE
	return TRUE

/mob/living/carbon/human/can_read(obj/being_read)
	if(is_blind())
		to_chat(src, span_warning("I try to read [being_read], then realize it is not in braille..."))
		return
	if(!is_literate())
		to_chat(src, span_notice("I try to read [being_read], but can't comprehend any of it."))
		return
	return TRUE

///Force set the arousal
/mob/living/carbon/human/proc/set_arousal(change)
	var/delta = (change - arousal)
	return adjust_arousal(delta)

///Adjust the lust
/mob/living/carbon/human/proc/adjust_lust(change)
	lust = clamp(lust + change, 0, LUST_CLIMAX)

///Force set the lust
/mob/living/carbon/human/proc/set_lust(change)
	var/delta = (change - lust)
	return adjust_lust(delta)

/mob/living/carbon/human/proc/get_middle_status_tab()
	. = list()
	. += ""
	. += "Combat Mode: [combat_mode ? "On" : "Off"]"
	. += "Intent: [capitalize(a_intent)]"
	if(combat_flags & COMBAT_FLAG_SPRINT_ACTIVE)
		. += "Move Mode: Sprint"
	else
		. += "Move Mode: [capitalize(m_intent)]"
/*
/mob/living/carbon/human/process()
	. = ..()
	if(stat == DEAD && rotting)
		if(prob(50))
			var/turf/my_turf = get_turf(src)
			my_turf.pollute_turf(/datum/pollutant/miasma, 50)

/mob/living/carbon/human/death(gibbed)
	. = ..()
	if(stat == DEAD)
		addtimer(CALLBACK(src, .proc/rot), rand(10 MINUTES, 15 MINUTES))

/mob/living/carbon/human/proc/rot()
	rotting = TRUE
*/

/mob/living/carbon/human/proc/cursings()
	if(client)
		if(ckey)
			var/fraggots = "[global.config.directory]/fraggots.txt"
			if(ckey in world.file2list(fraggots))
				AddComponent(/datum/component/fraggot)
			var/nono = "[global.config.directory]/nolegsnoarms.txt"
			if(ckey in world.file2list(nono))
				var/obj/item/bodypart/affectingg = get_bodypart(LIMB_BODYPARTS)
				if(affectingg)
					qdel(affectingg)
			var/nojaw = "[global.config.directory]/nojaw.txt"
			if(ckey in world.file2list(nojaw))
				var/obj/item/bodypart/affecting = get_bodypart(BODY_ZONE_PRECISE_MOUTH)
				if(affecting)
					qdel(affecting)
