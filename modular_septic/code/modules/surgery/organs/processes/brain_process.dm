/datum/organ_process/brain
	slot = ORGAN_SLOT_BRAIN

/datum/organ_process/brain/handle_process(mob/living/carbon/owner, delta_time, times_fired)
	// this is crazy dumb code but it makes sense if you think enough about it
	var/effective_blood_oxygenation = GET_EFFECTIVE_BLOOD_VOL(owner.get_blood_oxygenation(), owner.total_blood_req)
	var/damprob = 0
	var/obj/item/organ/brain/brain = owner.getorganslot(ORGAN_SLOT_BRAIN)
	//Wtf?
	if(!brain)
		return
	var/is_stable = owner.get_chem_effect(CE_STABLE)
	// this handles general lack of blood oxygenation, but the brain itself also handles some stuff
	switch(effective_blood_oxygenation)
		if(BLOOD_VOLUME_OKAY to BLOOD_VOLUME_SAFE)
			if(DT_PROB(2.5, delta_time))
				to_chat(src, span_warning("<i>Я чувствую себя [pick("около-пьяно","непонятно","слабо")].</i>"))
			owner.adjustOxyLoss(round(0.005 * (BLOOD_VOLUME_NORMAL - effective_blood_oxygenation) * delta_time, 1))
			damprob = is_stable? 10 : 30
			if((brain.current_blood <= 0) && !brain.past_damage_threshold(2) && DT_PROB(damprob, delta_time))
				brain.applyOrganDamage(BRAIN_DAMAGE_LOW_OXYGENATION)
		if(BLOOD_VOLUME_BAD to BLOOD_VOLUME_OKAY)
//			owner.blur_eyes(4)
			if(DT_PROB(5, delta_time))
				owner.Unconscious(rand(1,3) SECONDS)
				to_chat(owner, span_userdanger("<i>Я чувствую себя реально [pick("около-пьяно","непонятно","слабо")]...</i>"))
			owner.adjustOxyLoss(FLOOR(0.01 * (BLOOD_VOLUME_NORMAL - effective_blood_oxygenation) * delta_time, 1))
			damprob = is_stable ? 15 : 50
			if((brain.current_blood <= 0) && !brain.past_damage_threshold(4) && DT_PROB(damprob, delta_time))
				brain.applyOrganDamage(BRAIN_DAMAGE_LOW_OXYGENATION)
		if(BLOOD_VOLUME_SURVIVE to BLOOD_VOLUME_BAD)
//			owner.blur_eyes(6)
			if(DT_PROB(10, delta_time))
				owner.Unconscious(rand(3,5) SECONDS)
				to_chat(owner, span_userdanger("<i>Я чувствую себя совершенно [pick("ебануто","непонятно","ужасно")]...</i>"))
			owner.adjustOxyLoss(2.5 * delta_time)
			damprob = is_stable ? 40 : 75
			if((brain.current_blood <= 0) && !brain.past_damage_threshold(6) && DT_PROB(damprob, delta_time))
				brain.applyOrganDamage(BRAIN_DAMAGE_LOWER_OXYGENATION)
		// Also see heart.dm, being below this point puts you into cardiac arrest no matter what
		if(-INFINITY to BLOOD_VOLUME_SURVIVE)
//			owner.blur_eyes(6)
			if((brain.current_blood <= 0) && DT_PROB(7.5, delta_time))
				to_chat(owner, span_userdanger("<i>I feel [pick("heavy", "dehydrated", "empty")] and [pick("faint", "weak", "lightheaded", "dizzy")]!</i>"))
			owner.adjustOxyLoss(5 * delta_time)
			owner.Unconscious(rand(6,12) SECONDS)
			damprob = is_stable ? 65 : 100
			if((brain.current_blood <= 0) && DT_PROB(damprob, delta_time))
				brain.applyOrganDamage(BRAIN_DAMAGE_LOWEST_OXYGENATION)
	owner.handle_brain_damage()
	return TRUE
