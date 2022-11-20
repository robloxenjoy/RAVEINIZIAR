/datum/organ_process/lungs
	slot = ORGAN_SLOT_LUNGS

/datum/organ_process/lungs/needs_process(mob/living/carbon/owner)
	var/needlung = owner.needs_lungs()
	if(!needlung || (owner.stat >= DEAD))
		owner.failed_last_breath = FALSE
		return FALSE
	return ..()

/datum/organ_process/lungs/handle_process(mob/living/carbon/owner, delta_time, times_fired)
	var/next_breath = owner.get_breath_modulo() // Breathe per 4 ticks normally
	if( ((times_fired % next_breath) == 0) || owner.failed_last_breath)
		owner.breathe(delta_time, times_fired, src)
		if(owner.failed_last_breath)
			SEND_SIGNAL(owner, COMSIG_ADD_MOOD_EVENT, "suffocation", /datum/mood_event/suffocation)
		else
			SEND_SIGNAL(owner, COMSIG_CLEAR_MOOD_EVENT, "suffocation")
	else
		if(istype(owner.loc, /obj/))
			var/obj/location_as_object = owner.loc
			location_as_object.handle_internal_lifeform(owner, FALSE)
	handle_oxygenation(owner, delta_time, times_fired)
	return TRUE

/datum/organ_process/lungs/proc/handle_oxygenation(mob/living/carbon/owner, delta_time, times_fired)
	var/lung_efficiency = owner.getorganslotefficiency(ORGAN_SLOT_LUNGS)
	var/effective_oxygenation = ((100 - owner.getOxyLoss()) * (lung_efficiency/optimal_threshold))
	if(effective_oxygenation < owner.total_oxygen_req)
		if(DT_PROB(0.5, delta_time))
			if(owner.body_position != LYING_DOWN)
				owner.visible_message(span_danger("<b>[owner]</b> falls to the ground and hyperventilates!"), \
								span_userdanger("I need more air!"))
			else
				owner.visible_message(span_danger("<b>[owner]</b> hyperventilates!"), \
					span_userdanger("I need more air!"))
			owner.Knockdown(8 SECONDS)
			INVOKE_ASYNC(src, .proc/gasp_spam, owner)
		if(DT_PROB(2, delta_time))
			owner.blur_eyes(5)
			owner.set_confusion(owner.get_confusion() + 16)
		if(DT_PROB(2, delta_time))
			owner.agony_gasp()
			owner.losebreath = max(owner.losebreath, rand(8, 16))
		if(DT_PROB(4, delta_time))
			owner.emote("cough")
	if(effective_oxygenation < (owner.total_oxygen_req/5))
		if(DT_PROB(20, delta_time))
			ADJUSTBRAINLOSS(owner, BRAIN_DAMAGE_LOWEST_OXYGENATION)
		if(effective_oxygenation < (owner.total_oxygen_req/10))
			ADJUSTBRAINLOSS(owner, BRAIN_DAMAGE_LOWEST_OXYGENATION)

/datum/organ_process/lungs/proc/gasp_spam(mob/living/carbon/victim)
	for(var/i in 1 to 3)
		if(QDELETED(victim))
			return
		if(prob(80))
			victim.agony_gasp()
		else
			victim.agony_gargle()
		sleep(1 SECONDS)
