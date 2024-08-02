/datum/component/embedded
	var/datum/injury/injury

/datum/component/embedded/Initialize(obj/item/embedder,
									datum/thrownthing/throwingdatum,
									obj/item/bodypart/part,
									embed_chance = EMBED_CHANCE,
									fall_chance = EMBEDDED_ITEM_FALLOUT,
									pain_chance = EMBEDDED_PAIN_CHANCE,
									pain_mult = EMBEDDED_PAIN_MULTIPLIER,
									remove_pain_mult = EMBEDDED_UNSAFE_REMOVAL_PAIN_MULTIPLIER,
									impact_pain_mult = EMBEDDED_IMPACT_PAIN_MULTIPLIER,
									rip_time = EMBEDDED_UNSAFE_REMOVAL_TIME,
									ignore_throwspeed_threshold = FALSE,
									jostle_chance = EMBEDDED_JOSTLE_CHANCE,
									jostle_pain_mult = EMBEDDED_JOSTLE_PAIN_MULTIPLIER,
									pain_stam_pct = EMBEDDED_PAIN_STAM_PCT,
									datum/injury/supplied_injury = null,
									silence_message = FALSE,
									)
	if(!iscarbon(parent) || !isitem(embedder))
		return COMPONENT_INCOMPATIBLE

	if(part)
		src.limb = part
	src.embed_chance = embed_chance
	src.fall_chance = fall_chance
	src.pain_chance = pain_chance
	src.pain_mult = pain_mult
	src.remove_pain_mult = remove_pain_mult
	src.rip_time = rip_time
	src.impact_pain_mult = impact_pain_mult
	src.ignore_throwspeed_threshold = ignore_throwspeed_threshold
	src.jostle_chance = jostle_chance
	src.jostle_pain_mult = jostle_pain_mult
	src.pain_stam_pct = pain_stam_pct
	src.weapon = embedder
	src.injury = supplied_injury
	if(supplied_injury)
		LAZYADD(supplied_injury.embedded_objects, embedder)
		LAZYADD(supplied_injury.embedded_components, src)

	if(!weapon.isEmbedHarmless())
		harmful = TRUE

	weapon.embedded(parent, part)
	START_PROCESSING(SSdcs, src)
	var/mob/living/carbon/victim = parent
	LAZYADD(limb.embedded_objects, weapon)
	weapon.forceMove(victim)
	RegisterSignal(weapon, list(COMSIG_MOVABLE_MOVED, COMSIG_PARENT_QDELETING), PROC_REF(weaponDeleted))
	if(!silence_message)
		victim.visible_message(span_danger("[weapon] [harmful ? "embeds" : "embeds"] [harmful ? "in" : "on"] <b>[victim]</b> [limb.name]!"), \
					span_userdanger("[weapon] [harmful ? "embeds" : "embeds"] [harmful ? "in" : "on"] [limb.name]!"))

	var/damage = weapon.throwforce
	if(harmful)
		victim.throw_alert("embeddedobject", /atom/movable/screen/alert/embeddedobject)
		weapon.add_mob_blood(victim)//it embedded itself in you, of course it's bloody!
		damage += weapon.w_class * impact_pain_mult
		SEND_SIGNAL(victim, COMSIG_ADD_MOOD_EVENT, "embedded", /datum/mood_event/embedded)

	//we hopefully dealt the initial damage by creating the supplied injury, no need to make the situation worse
	if((damage > 0) && !injury)
		var/sharpness = embedder.get_sharpness()
		var/armor = victim.run_armor_check(limb.body_zone, \
								MELEE, \
								"", \
								"", \
								embedder.armour_penetration, \
								weak_against_armour = embedder.weak_against_armour, \
								sharpness = sharpness)
		var/subarmor = victim.run_subarmor_check(limb.body_zone, \
								MELEE, \
								"", \
								"", \
								embedder.subtractible_armour_penetration, \
								weak_against_armour = embedder.weak_against_subtractible_armour, \
								sharpness = sharpness)
		var/subarmor_flags = victim.get_subarmor_flags(limb.body_zone)
		var/edge_protection = victim.get_edge_protection(limb)
		edge_protection = max(0, edge_protection - weapon.edge_protection_penetration)
		limb.receive_damage(brute = (1 - pain_stam_pct) * damage, \
							stamina = pain_stam_pct * damage, \
							blocked = armor, \
							wound_bonus = weapon.wound_bonus, \
							bare_wound_bonus = weapon.bare_wound_bonus, \
							sharpness = sharpness, \
							organ_bonus = weapon.organ_bonus, \
							bare_organ_bonus = weapon.bare_organ_bonus, \
							reduced = subarmor, \
							edge_protection = edge_protection, \
							subarmor_flags = subarmor_flags)

/datum/component/embedded/Destroy()
	var/obj/item/bodypart/old_limb =  limb
	if(injury)
		LAZYREMOVE(injury.embedded_components, src)
		LAZYREMOVE(injury.embedded_objects, weapon)
	injury = null
	. = ..()
	for(var/obj/item/grab/grabber as anything in old_limb.grasped_by)
		grabber.update_grab_mode()
//		grabber.stop_pulling

/datum/component/embedded/process(delta_time)
	var/mob/living/carbon/victim = parent

	if(!victim || !limb) // in case the victim and/or their limbs exploded (say, due to a sticky bomb)
		weapon.forceMove(get_turf(weapon))
		qdel(src)
		return

	if(victim.stat == DEAD)
		return

	if(harmful && pain_chance)
		var/damage = weapon.w_class * pain_mult
		var/pain_chance_current = DT_PROB_RATE(pain_chance / 100, delta_time) * 100
		if(victim.body_position == LYING_DOWN)
			pain_chance_current *= 0.2

		if(prob(pain_chance_current))
			if(injury)
				injury.open_injury((1-pain_stam_pct) * damage)
				limb.receive_damage(stamina = pain_stam_pct * damage)
			else
				limb.receive_damage(brute = (1-pain_stam_pct) * damage, stamina = pain_stam_pct * damage, wound_bonus = CANT_WOUND)
			to_chat(victim, span_userdanger("[weapon] inside [limb.name] does pain!"))

	if(fall_chance)
		var/fall_chance_current = DT_PROB_RATE(fall_chance / 100, delta_time) * 100
		if(victim.body_position == LYING_DOWN)
			fall_chance_current *= 0.2

		if(prob(fall_chance_current))
			fallOut()

/datum/component/embedded/jostleCheck()
	var/mob/living/carbon/victim = parent
	var/chance = jostle_chance
	if(victim.m_intent == MOVE_INTENT_WALK || victim.body_position == LYING_DOWN)
		chance *= 0.5

	if(harmful && prob(chance))
		var/damage = weapon.w_class * jostle_pain_mult
		if(injury)
			injury.open_injury((1-pain_stam_pct) * damage)
			limb.receive_damage(stamina=pain_stam_pct * damage)
			to_chat(victim, span_userdanger("[weapon] inside [limb.name] [injury.get_desc()] does pain!"))
		else
			limb.receive_damage(brute=(1-pain_stam_pct) * damage, stamina=pain_stam_pct * damage, wound_bonus = CANT_WOUND)
			to_chat(victim, span_userdanger("[weapon] inside [limb.name] does pain!"))

/datum/component/embedded/weaponDeleted()
//	var/mob/living/carbon/victim = parent
	LAZYREMOVE(limb.embedded_objects, weapon)
	if(injury)
		LAZYREMOVE(injury.embedded_objects, weapon)
		LAZYREMOVE(injury.embedded_components, src)

//	if(victim)
//		to_chat(victim, span_userdanger("\The [weapon] that was embedded in my [limb.name] disappears!"))

	qdel(src)

/datum/component/embedded/checkTweeze(mob/living/carbon/victim, obj/item/possible_tweezers, mob/user)
	if(!istype(victim) || possible_tweezers.tool_behaviour != TOOL_HEMOSTAT || user.zone_selected != limb.body_zone)
		return

	// just pluck the first one, since we can't easily coordinate with other embedded components affecting this limb who is highest priority
	if(weapon != LAZYACCESS(limb.embedded_objects, 1))
		return

	// check to see if the limb is actually exposed
	if(ishuman(victim))
		var/mob/living/carbon/human/victim_human = victim
		if(!victim_human.try_inject(user, limb.body_zone, INJECT_CHECK_IGNORE_SPECIES | INJECT_TRY_SHOW_ERROR_MESSAGE))
			return TRUE

	INVOKE_ASYNC(src, PROC_REF(tweezePluck), possible_tweezers, user)
	return COMPONENT_NO_AFTERATTACK

/datum/component/embedded/ripOut(datum/source, obj/item/ripped_out, obj/item/bodypart/limb, mob/living/user)
	if((ripped_out != weapon) || (src.limb != limb))
		return
	INVOKE_ASYNC(src, PROC_REF(complete_rip_out), source, ripped_out, limb, user)

/datum/component/embedded/complete_rip_out(mob/living/carbon/victim, obj/item/I, obj/item/bodypart/limb, mob/living/remover)
	var/time_taken = rip_time * weapon.w_class * (victim == remover ? 2 : 1)
	if(remover == victim)
		remover.visible_message(span_warning("<b>[remover]</b> tries to rip [weapon] out from [limb.name]."), \
				span_userdanger("I'm trying to rip [weapon] out from [limb.name]..."))
	else
		victim.visible_message(span_warning("<b>[remover]</b> tries to rip [weapon] out from <b>[victim]'s</b> [limb.name]."), \
				span_userdanger("<b>[remover]</b> tries to rip [weapon] out from [limb.name]!"), \
				ignored_mobs = remover)
		to_chat(remover, span_userdanger("I'm trying to rip [weapon] out from <b>[victim]'s</b> [limb.name]..."))
	if(!do_mob(user = remover, target = victim, time = time_taken))
		return
	if(!weapon || !limb || (weapon.loc != victim) || !(weapon in limb.embedded_objects))
		qdel(src)
		return
	if(harmful)
		// It hurts to rip it out, get surgery you dingus
		var/damage = weapon.w_class * remove_pain_mult
		if(injury)
			injury.open_injury(damage)
			limb.receive_damage(stamina = pain_stam_pct * damage)
		else
			limb.receive_damage(brute = (1-pain_stam_pct) * damage, \
								stamina = pain_stam_pct * damage,\
								sharpness = SHARP_EDGED)
		victim.agony_scream()
	if(remover == victim)
		victim.visible_message(span_notice("<b>[remover]</b> rips [weapon] out from [limb.name]!"), \
				span_userdanger("I rip [weapon] out from [limb.name]."))
	else
		victim.visible_message(span_notice("<b>[remover]</b> rips [weapon] out from <b>[limb.owner]'s</b> [limb.name]!"), \
				span_userdanger("<b>[remover]</b> rips [weapon] out from [limb.name]."), \
				ignored_mobs = remover)
		to_chat(remover, span_notice("I rip [weapon] out from <b>[victim]'s</b> [limb.name]!"))
	playsound(victim, 'modular_septic/sound/gore/pullout.ogg', 83, 0)
	remover.changeNext_move(CLICK_CD_CLING)
	remover.adjustFatigueLoss(5)
	victim.visible_message(span_notice("[victim] rips [weapon] out from [limb.name]!"), span_notice("I rip [weapon] out from [limb.name]."))
	safeRemove(remover)

/datum/component/embedded/fallOut()
	var/mob/living/carbon/victim = parent

	if(harmful)
		var/damage = weapon.w_class * remove_pain_mult
		if(injury)
			injury.open_injury((1-pain_stam_pct) * damage)
			limb.receive_damage(stamina = pain_stam_pct * damage)
		else
			limb.receive_damage(brute = (1-pain_stam_pct) * damage, stamina=pain_stam_pct * damage, wound_bonus = CANT_WOUND)
	victim.visible_message(span_danger("[weapon] falls out from [victim.name]'s [limb.name]!"), span_userdanger("[weapon] falls out from [limb.name]!"))
	safeRemove()

/datum/component/embedded/safeRemove(mob/to_hands)
	var/mob/living/carbon/victim = parent
	LAZYREMOVE(limb.embedded_objects, weapon)
	if(injury)
		LAZYREMOVE(injury.embedded_objects, weapon)
		LAZYREMOVE(injury.embedded_components, src)
	UnregisterSignal(weapon, list(COMSIG_MOVABLE_MOVED, COMSIG_PARENT_QDELETING)) // have to do it here otherwise we trigger weaponDeleted()
	if(!weapon.unembedded(victim, limb))
		weapon.forceMove(victim.loc)
		if(to_hands)
			to_hands.put_in_hands(weapon)
//			INVOKE_ASYNC(to_hands, TYPE_PROC_REF(/mob, put_in_hands), weapon)
//			INVOKE_ASYNC(to_hands, /mob.proc/put_in_active_hand, weapon)
//			INVOKE_ASYNC(to_hands, /mob.proc/put_in_hand, weapon, active_hand)
//		var/obj/item/bodypart/part_will_get_nulled = grasped_part
//		if(QDELETED(part_will_get_nulled))
//			return TRUE
//		owner_will_get_nulled.put_in_hands(part_will_get_nulled)
	qdel(src)
