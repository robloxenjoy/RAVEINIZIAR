// Mostly pain related stuff here
// Important note about painloss: Simplemobs don't feel pain, so instead they should receive 0.5 pain as brute damage

/mob/living/apply_damage(damage = 0, \
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
						atom/used_weapon)
	SEND_SIGNAL(src, COMSIG_MOB_APPLY_DAMAGE, damage, damagetype, def_zone)
	var/hit_percent = (100-blocked)/100
	if(!damage || (!forced && (hit_percent <= 0)) )
		return FALSE
	var/damage_amount =  forced ? damage : max(0, (damage * hit_percent) - reduced)
	if(!damage_amount)
		return FALSE
	switch(damagetype)
		if(BRUTE)
			adjustBruteLoss(damage_amount, forced = forced)
		if(BURN)
			adjustFireLoss(damage_amount, forced = forced)
		if(TOX)
			adjustToxLoss(damage_amount, forced = forced)
		if(OXY)
			adjustOxyLoss(damage_amount, forced = forced)
		if(CLONE)
			adjustCloneLoss(damage_amount, forced = forced)
		if(STAMINA)
			adjustStaminaLoss(damage_amount, forced = forced)
		if(PAIN, SHOCK_PAIN)
			adjustPainLoss(damage_amount, forced = forced)
		if(SHOCK_STAGE)
			adjustShockStage(damage_amount, forced = forced)
	return TRUE

/mob/living/apply_damage_type(damage = 0, damagetype = BRUTE)
	switch(damagetype)
		if(BRUTE)
			return adjustBruteLoss(damage)
		if(BURN)
			return adjustFireLoss(damage)
		if(TOX)
			return adjustToxLoss(damage)
		if(OXY)
			return adjustOxyLoss(damage)
		if(CLONE)
			return adjustCloneLoss(damage)
		if(STAMINA)
			return adjustStaminaLoss(damage)
		if(PAIN, SHOCK_PAIN)
			return adjustPainLoss(damage)
		if(SHOCK_STAGE)
			return adjustShockStage(damage)

/mob/living/get_damage_amount(damagetype = BRUTE)
	switch(damagetype)
		if(BRUTE)
			return getBruteLoss()
		if(BURN)
			return getFireLoss()
		if(TOX)
			return getToxLoss()
		if(OXY)
			return getOxyLoss()
		if(CLONE)
			return getCloneLoss()
		if(STAMINA)
			return getStaminaLoss()
		if(PAIN)
			return getPainLoss()
		if(SHOCK_PAIN)
			return getShock()
		if(SHOCK_STAGE)
			return getShockStage()

/// Get a sum of all physical damage, except pain and stamina
/mob/living/proc/get_physical_damage()
	return round(getBruteLoss() + getFireLoss() + getToxLoss() + getCloneLoss() + getOxyLoss(), DAMAGE_PRECISION)

/mob/living/proc/getPainLoss()
	return painloss

/mob/living/proc/adjustPainLoss(amount, updating_health = TRUE, forced = FALSE)
	if(!forced && (status_flags & GODMODE))
		return
	. = painloss
	painloss = clamp((painloss + (amount * CONFIG_GET(number/damage_multiplier))), 0, maxHealth * 2)
	if(updating_health)
		updatehealth()

/mob/living/proc/setPainLoss(amount, updating_health = TRUE, forced = FALSE)
	if(!forced && status_flags & GODMODE)
		return
	. = painloss
	painloss = amount
	if(updating_health)
		updatehealth()

/mob/living/proc/getShock(painkiller_included = TRUE)
	return traumatic_shock

/mob/living/proc/getShockStage()
	return shock_stage

/mob/living/proc/adjustShockStage(amount, updating_health = TRUE, forced = FALSE)
	if(!forced && (status_flags & GODMODE))
		return
	. = shock_stage
	shock_stage = clamp((shock_stage + (amount * CONFIG_GET(number/damage_multiplier))), 0, SHOCK_STAGE_MAX)
	if(updating_health)
		updatehealth()

/mob/living/proc/setShockStage(amount, updating_health = TRUE, forced = FALSE)
	if(!forced && status_flags & GODMODE)
		return
	. = painloss
	shock_stage = amount
	if(updating_health)
		updatehealth()
