/datum/wound/tendon
	name = "Torn Tendon"
	sound_effect = 'modular_septic/sound/gore/tendon.ogg'
	base_treat_time = 3 SECONDS
	wound_type = WOUND_TENDON
	severity = WOUND_SEVERITY_MODERATE
	desc = "Patient's tendon has been violently slashed apart, severely hindering the affected limb."
	treat_text = "Incision of the limb followed by suturing of the tendon."
	examine_desc = null
	occur_text = "is violently torn, severing a tendon"

	treatable_by = list(/obj/item/stack/medical/suture, /obj/item/stack/medical/nervemend)
	wound_flags = (WOUND_SOUND_HINTS|WOUND_ACCEPTS_STUMP|WOUND_VISIBLE_THROUGH_CLOTHING)

/datum/wound/tendon/apply_wound(obj/item/bodypart/new_limb, silent = FALSE, datum/wound/old_wound = null, smited = FALSE, add_descriptive = TRUE)
	. = ..()
	if(!.)
		return
	var/obj/item/organ/tendon/tendon
	var/obj/item/organ/possible_tendon
	for(var/thing in shuffle(new_limb.getorganslotlist(ORGAN_SLOT_TENDON)))
		possible_tendon = thing
		if(possible_tendon.damage >= possible_tendon.maxHealth)
			continue
		tendon = possible_tendon
		break
	var/dissection = FALSE
	if((severity >= WOUND_SEVERITY_CRITICAL) || (tendon?.damage >= (tendon.maxHealth * 0.5)) )
		dissection = TRUE
	if(tendon)
		if(dissection)
			tendon.dissect()
		else
			tendon.tear()
	var/final_descriptive = "A tendon is [dissection ? "torn" : "damaged"]!"
	// Achilles tendon is pretty significant
	if(istype(tendon, TENDON_R_FOOT) || istype(tendon, TENDON_L_FOOT) || istype(tendon, TENDON_NECK))
		final_descriptive = "\The [tendon] [tendon.p_are()] [dissection ? "torn" : "damaged"]!"
	if(victim)
		if(sound_effect)
			playsound(new_limb.owner, pick(sound_effect), 70 + 20 * severity, TRUE)
		if(add_descriptive)
			SEND_SIGNAL(victim, COMSIG_CARBON_ADD_TO_WOUND_MESSAGE, span_bolddanger(" [final_descriptive]"))
	qdel(src)

/datum/wound/tendon/tear
	severity = WOUND_SEVERITY_SEVERE
	threshold_minimum = 70

/datum/wound/tendon/dissect
	severity = WOUND_SEVERITY_CRITICAL
	threshold_minimum = 100
