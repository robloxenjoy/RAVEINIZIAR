/// depending on the species, it will run the corresponding apply_damage code there
/mob/living/carbon/human/apply_damage(damage, \
									damagetype = BRUTE, \
									def_zone = null, \
									blocked = FALSE, \
									forced = FALSE, \
									spread_damage = FALSE, \
									wound_bonus = 0, \
									bare_wound_bonus = 0, \
									sharpness = NONE, \
									organ_bonus = 0, \
									bare_organ_bonus = 0, \
									reduced = 0, \
									edge_protection = 0, \
									subarmor_flags = NONE, \
									attack_direction = null, \
									wound_messages = TRUE)
	return dna.species.apply_damage(src, \
									damage, \
									damagetype, \
									def_zone, \
									blocked, \
									forced, \
									spread_damage, \
									wound_bonus, \
									bare_wound_bonus, \
									sharpness, \
									organ_bonus, \
									bare_organ_bonus, \
									reduced, \
									edge_protection, \
									subarmor_flags, \
									attack_direction, \
									wound_messages)

/datum/species/apply_damage(mob/living/carbon/human/victim, \
							damage = 0, \
							damagetype = BRUTE, \
							def_zone = null, \
							blocked = 0, \
							forced = FALSE, \
							spread_damage = FALSE, \
							wound_bonus = 0, \
							bare_wound_bonus = 0, \
							sharpness = NONE, \
							organ_bonus = 0, \
							bare_organ_bonus = 0, \
							reduced = 0, \
							edge_protection = 0, \
							subarmor_flags = NONE, \
							attack_direction = null, \
							wound_messages = TRUE)
	// make sure putting wound_bonus here doesn't screw up other signals or uses for this signal
	SEND_SIGNAL(victim, COMSIG_MOB_APPLY_DAMAGE, damage, \
											damagetype, \
											def_zone, \
											wound_bonus, \
											bare_wound_bonus, \
											sharpness, \
											organ_bonus, \
											bare_organ_bonus, \
											reduced, \
											edge_protection, \
											subarmor_flags, \
											attack_direction, \
											wound_messages)
	var/hit_percent = (100-(blocked+armor))/100
	hit_percent = (hit_percent * (100-victim.physiology.damage_resistance))/100
	if(!damage || (!forced && hit_percent <= 0))
		return FALSE

	var/obj/item/bodypart/BP = null
	if(!spread_damage)
		if(isbodypart(def_zone))
			BP = def_zone
		else
			if(!def_zone)
				def_zone = ran_zone(def_zone)
			BP = victim.get_bodypart(check_zone(def_zone))
			if(!BP)
				BP = victim.bodyparts[1]

	switch(damagetype)
		if(BRUTE)
			victim.damageoverlaytemp = 20
			if(BP)
				if(BP.receive_damage(brute = (damage * brutemod * victim.physiology.brute_mod), \
								wound_bonus = wound_bonus, \
								bare_wound_bonus = bare_wound_bonus, \
								sharpness = sharpness, \
								organ_bonus = organ_bonus, \
								bare_organ_bonus = bare_organ_bonus, \
								blocked = blocked, \
								reduced = reduced, \
								edge_protection = edge_protection, \
								subarmor_flags = subarmor_flags, \
								attack_direction = attack_direction, \
								wound_messages = wound_messages))
					victim.update_damage_overlays()
			else//no bodypart, we deal damage with a more general method.
				var/damage_amount = forced ? damage : max(0, (damage * hit_percent * brutemod * victim.physiology.brute_mod) - reduced)
				victim.adjustBruteLoss(damage_amount)
		if(BURN)
			victim.damageoverlaytemp = 20
			if(BP)
				if(BP.receive_damage(burn = (damage * burnmod * victim.physiology.burn_mod), \
								wound_bonus = wound_bonus, \
								bare_wound_bonus = bare_wound_bonus, \
								sharpness = sharpness, \
								organ_bonus = organ_bonus, \
								bare_organ_bonus = bare_organ_bonus, \
								blocked = blocked, \
								reduced = reduced, \
								edge_protection = edge_protection, \
								subarmor_flags = subarmor_flags, \
								attack_direction = attack_direction, \
								wound_messages = wound_messages))
					victim.update_damage_overlays()
			else
				var/damage_amount = forced ? damage : max(0, (damage * hit_percent * burnmod * victim.physiology.burn_mod) - reduced)
				victim.adjustFireLoss(damage_amount)
		if(TOX)
			var/damage_amount = forced ? damage : max(0, (damage * hit_percent * victim.physiology.tox_mod) - reduced)
			victim.adjustToxLoss(damage_amount)
		if(OXY)
			var/damage_amount = forced ? damage : max(0, (damage * hit_percent * victim.physiology.oxy_mod) - reduced)
			victim.adjustOxyLoss(damage_amount)
		if(CLONE)
			var/damage_amount = forced ? damage : max(0, (damage * hit_percent * victim.physiology.clone_mod) - reduced)
			victim.adjustCloneLoss(damage_amount)
		if(STAMINA)
			var/damage_amount = forced ? damage : max(0, (damage * hit_percent * victim.physiology.stamina_mod) - reduced)
			if(BP)
				BP.receive_damage(stamina = damage_amount)
			else
				victim.adjustStaminaLoss(damage_amount)
		if(BRAIN)
			var/damage_amount = forced ? damage : max(0, damage * hit_percent * victim.physiology.brain_mod)
			victim.adjustOrganLoss(ORGAN_SLOT_BRAIN, damage_amount)
		if(PAIN, SHOCK_PAIN)
			var/damage_amount = forced ? damage : max(0, (damage * hit_percent) - reduced)
			if(BP)
				BP.add_pain(damage_amount)
			else
				victim.adjustPainLoss(damage_amount, forced = forced)
	return TRUE
