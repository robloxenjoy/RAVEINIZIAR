/datum/wound/nerve
	name = "Torn Nerve"
	sound_effect = 'modular_septic/sound/gore/tendon.ogg'
	base_treat_time = 3 SECONDS
	wound_type = WOUND_NERVE
	severity = WOUND_SEVERITY_MODERATE
	desc = "Patient's tendon has been violently slashed apart, severely hindering the affected limb."
	treat_text = "Incision of the limb followed by suturing of the nerve."
	examine_desc = null
	occur_text = "is violently torn, severing a nerve"

	threshold_minimum = 120
	treatable_by = list(/obj/item/stack/medical/suture, /obj/item/stack/medical/nervemend)
	base_treat_time = 2 SECONDS
	wound_flags = (WOUND_SOUND_HINTS|WOUND_ACCEPTS_STUMP|WOUND_VISIBLE_THROUGH_CLOTHING)

/datum/wound/nerve/apply_wound(obj/item/bodypart/new_limb, silent = FALSE, datum/wound/old_wound = null, smited = FALSE, add_descriptive = TRUE)
	. = ..()
	if(!.)
		return
	var/obj/item/organ/nerve/nerve
	for(var/thing in shuffle(new_limb.getorganslotlist(ORGAN_SLOT_NERVE)))
		var/obj/item/organ/possible_nerve = thing
		if(possible_nerve.damage >= possible_nerve.maxHealth)
			continue
		nerve = possible_nerve
		break
	var/dissection = FALSE
	if((severity >= WOUND_SEVERITY_CRITICAL) || (nerve?.damage >= (nerve.maxHealth * 0.5)) )
		dissection = TRUE
	if(nerve)
		if(dissection)
			nerve.dissect()
		else
			nerve.tear()
	var/final_descriptive = "A nerve is [dissection ? "torn" : "damaged"]!"
	// Sciatic is pretty significant
	if(istype(nerve, NERVE_R_LEG) || istype(nerve, NERVE_L_LEG))
		final_descriptive = "\The [nerve] [nerve.p_are()] [dissection ? "torn" : "damaged"]!"
	if(victim)
		if(sound_effect)
			playsound(new_limb.owner, pick(sound_effect), 70 + 20 * severity, TRUE)
		if(add_descriptive)
			SEND_SIGNAL(victim, COMSIG_CARBON_ADD_TO_WOUND_MESSAGE, span_bolddanger(" [final_descriptive]"))
	qdel(src)

/datum/wound/nerve/tear
	severity = WOUND_SEVERITY_SEVERE
	threshold_minimum = 120

/datum/wound/nerve/dissect
	severity = WOUND_SEVERITY_CRITICAL
	threshold_minimum = 150
