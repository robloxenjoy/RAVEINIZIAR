//KNOCKDOWN
/mob/living/proc/KnockToFloor(silent = TRUE, ignore_canknockdown = FALSE, knockdown_amt = 1)
	return

/mob/living/proc/CombatKnockdown(stamina_damage, knockdown_amount, paralyze_amount, disarm = FALSE, ignore_canknockdown = FALSE)
	if(!stamina_damage)
		return
	return Paralyze((paralyze_amount ? paralyze_amount : stamina_damage))

//DAZE
/mob/living/proc/IsDazed() //If we're Dazed
	return has_status_effect(STATUS_EFFECT_DAZED)

/mob/living/proc/AmountDazed() //How many deciseconds remain in our Dazed status effect
	var/datum/status_effect/incapacitating/dazed/I = IsDazed()
	if(I)
		return I.duration - world.time
	return 0

/mob/living/proc/Daze(amount, updating = TRUE, ignore_canstun = FALSE) //Can't go below remaining duration
	if(SEND_SIGNAL(src, COMSIG_LIVING_STATUS_DAZE, amount, updating, ignore_canstun) & COMPONENT_NO_STUN)
		return
	if(!ignore_canstun && (!(status_flags & CANSTUN) || HAS_TRAIT(src, TRAIT_STUNIMMUNE)))
		return
	if(absorb_stun(amount, ignore_canstun))
		return
	var/datum/status_effect/incapacitating/dazed/I = IsDazed()
	if(I)
		I.duration = max(world.time + amount, I.duration)
	else if(amount > 0)
		I = apply_status_effect(STATUS_EFFECT_DAZED, amount, updating)
	return I

/mob/living/proc/SetDazed(amount, updating = TRUE, ignore_canstun = FALSE) //Sets remaining duration
	if(SEND_SIGNAL(src, COMSIG_LIVING_STATUS_DAZE, amount, updating, ignore_canstun) & COMPONENT_NO_STUN)
		return
	if(!ignore_canstun && (!(status_flags & CANSTUN) || HAS_TRAIT(src, TRAIT_STUNIMMUNE)))
		return
	var/datum/status_effect/incapacitating/dazed/I = IsDazed()
	if(amount <= 0)
		if(I)
			qdel(I)
	else
		if(absorb_stun(amount, ignore_canstun))
			return
		if(I)
			I.duration = world.time + amount
		else
			I = apply_status_effect(STATUS_EFFECT_DAZED, amount, updating)
	return I

/mob/living/proc/AdjustDazed(amount, updating = TRUE, ignore_canstun = FALSE) //Adds to remaining duration
	if(SEND_SIGNAL(src, COMSIG_LIVING_STATUS_DAZE, amount, updating, ignore_canstun) & COMPONENT_NO_STUN)
		return
	if(!ignore_canstun && (!(status_flags & CANSTUN) || HAS_TRAIT(src, TRAIT_STUNIMMUNE)))
		return
	if(absorb_stun(amount, ignore_canstun))
		return
	var/datum/status_effect/incapacitating/dazed/I = IsDazed()
	if(I)
		I.duration += amount
	else if(amount > 0)
		I = apply_status_effect(STATUS_EFFECT_DAZED, amount, updating)
	return I

//STUMBLE
/mob/living/proc/IsStumble() //If we're stumbling
	return has_status_effect(STATUS_EFFECT_STUMBLE)

/mob/living/proc/AmountStumble() //How many deciseconds remain in our Dazed status effect
	var/datum/status_effect/incapacitating/stumble/I = IsStumble()
	if(I)
		return I.duration - world.time
	return 0

/mob/living/proc/Stumble(amount, updating = TRUE, ignore_canstun = FALSE) //Can't go below remaining duration
	if(SEND_SIGNAL(src, COMSIG_LIVING_STATUS_STUMBLE, amount, updating, ignore_canstun) & COMPONENT_NO_STUN)
		return
	if(!ignore_canstun && (!(status_flags & CANKNOCKDOWN) || HAS_TRAIT(src, TRAIT_STUNIMMUNE)))
		return
	if(absorb_stun(amount, ignore_canstun))
		return
	var/datum/status_effect/incapacitating/stumble/I = IsStumble()
	if(I)
		I.duration = max(world.time + amount, I.duration)
	else if(amount > 0)
		I = apply_status_effect(STATUS_EFFECT_STUMBLE, amount, updating)
	return I

/mob/living/proc/SetStumble(amount, updating = TRUE, ignore_canstun = FALSE) //Sets remaining duration
	if(SEND_SIGNAL(src, COMSIG_LIVING_STATUS_STUMBLE, amount, updating, ignore_canstun) & COMPONENT_NO_STUN)
		return
	if(!ignore_canstun && (!(status_flags & CANKNOCKDOWN) || HAS_TRAIT(src, TRAIT_STUNIMMUNE)))
		return
	var/datum/status_effect/incapacitating/stumble/I = IsStumble()
	if(amount <= 0)
		if(I)
			qdel(I)
	else
		if(absorb_stun(amount, ignore_canstun))
			return
		if(I)
			I.duration = world.time + amount
		else
			I = apply_status_effect(STATUS_EFFECT_STUMBLE, amount, updating)
	return I

/mob/living/proc/AdjustStumble(amount, updating = TRUE, ignore_canstun = FALSE) //Adds to remaining duration
	if(SEND_SIGNAL(src, COMSIG_LIVING_STATUS_STUMBLE, amount, updating, ignore_canstun) & COMPONENT_NO_STUN)
		return
	if(!ignore_canstun && (!(status_flags & CANKNOCKDOWN) || HAS_TRAIT(src, TRAIT_STUNIMMUNE)))
		return
	if(absorb_stun(amount, ignore_canstun))
		return
	var/datum/status_effect/incapacitating/stumble/I = IsStumble()
	if(I)
		I.duration += amount
	else if(amount > 0)
		I = apply_status_effect(STATUS_EFFECT_STUMBLE, amount, updating)
	return I

//HEAD RAPE
/mob/living/proc/IsHeadRape()
	return has_status_effect(STATUS_EFFECT_HEADRAPE)

/mob/living/proc/AmountHeadRape()
	var/datum/status_effect/incapacitating/headrape/I = IsHeadRape()
	if(I)
		return I.duration - world.time
	return 0

/mob/living/proc/HeadRape(amount, updating = TRUE, ignore_canstun = FALSE) //Can't go below remaining duration
	if(SEND_SIGNAL(src, COMSIG_LIVING_STATUS_HEADRAPE, amount, updating, ignore_canstun) & COMPONENT_NO_STUN)
		return
	if(!ignore_canstun && (!(status_flags & CANSTUN) || HAS_TRAIT(src, TRAIT_STUNIMMUNE)))
		return
	if(absorb_stun(amount, ignore_canstun))
		return
	var/datum/status_effect/incapacitating/headrape/I = IsHeadRape()
	if(I)
		I.duration = max(world.time + CEILING(amount, 4 SECONDS), I.duration)
	else if(amount > 0)
		I = apply_status_effect(STATUS_EFFECT_HEADRAPE, CEILING(amount, 4), updating)
	return I

/mob/living/proc/SetHeadRape(amount, updating = TRUE, ignore_canstun = FALSE) //Sets remaining duration
	if(SEND_SIGNAL(src, COMSIG_LIVING_STATUS_HEADRAPE, amount, updating, ignore_canstun) & COMPONENT_NO_STUN)
		return
	if(!ignore_canstun && (!(status_flags & CANSTUN) || HAS_TRAIT(src, TRAIT_STUNIMMUNE)))
		return
	var/datum/status_effect/incapacitating/headrape/I = IsHeadRape()
	if(amount <= 0)
		if(I)
			qdel(I)
	else
		if(absorb_stun(amount, ignore_canstun))
			return
		if(I)
			I.duration = world.time + amount
		else
			I = apply_status_effect(STATUS_EFFECT_HEADRAPE, CEILING(amount, 4 SECONDS), updating)
	return I

/mob/living/proc/AdjustHeadRape(amount, updating = TRUE, ignore_canstun = FALSE) //Adds to remaining duration
	if(SEND_SIGNAL(src, COMSIG_LIVING_STATUS_HEADRAPE, amount, updating, ignore_canstun) & COMPONENT_NO_STUN)
		return
	if(!ignore_canstun && (!(status_flags & CANSTUN) || HAS_TRAIT(src, TRAIT_STUNIMMUNE)))
		return
	if(absorb_stun(amount, ignore_canstun))
		return
	var/datum/status_effect/incapacitating/headrape/I = IsHeadRape()
	if(I)
		I.duration += amount
	else if(amount > 0)
		I = apply_status_effect(STATUS_EFFECT_HEADRAPE, CEILING(amount, 4 SECONDS), updating)
	return I
