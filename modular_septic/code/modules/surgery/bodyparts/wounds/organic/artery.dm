/datum/wound/artery
	name = "Torn Artery"
	sound_effect = list('modular_septic/sound/gore/artery1.ogg', \
						'modular_septic/sound/gore/artery2.ogg', \
						'modular_septic/sound/gore/artery3.ogg')
	base_treat_time = 3 SECONDS
	wound_type = WOUND_ARTERY
	severity = WOUND_SEVERITY_MODERATE
	desc = "Patient's artery has been violently torn, causing severe hemorrhage."
	treat_text = "Immediate incision of the limb followed by suturing of the torn artery."
	examine_desc = "is <span style='color: #D59998'><i>bleeding profusely</i></span>"
	occur_text = "is violently torn, severing an artery"

	threshold_minimum = 65
	treatable_by = list(/obj/item/stack/medical/suture, /obj/item/stack/medical/nervemend)
	wound_flags = (WOUND_SOUND_HINTS|WOUND_ACCEPTS_STUMP|WOUND_VISIBLE_THROUGH_CLOTHING)

/datum/wound/artery/apply_wound(obj/item/bodypart/new_limb, silent = FALSE, datum/wound/old_wound = null, smited = FALSE, add_descriptive = TRUE)
	. = ..()
	if(!.)
		return
	var/obj/item/organ/artery/artery
	var/obj/item/organ/possible_artery
	for(var/thing in shuffle(new_limb.getorganslotlist(ORGAN_SLOT_ARTERY)))
		possible_artery = thing
		if(possible_artery.damage >= possible_artery.maxHealth)
			continue
		artery = possible_artery
		break
	var/dissection = FALSE
	if((severity >= WOUND_SEVERITY_CRITICAL) || (artery?.damage >= (artery.maxHealth * 0.5)) )
		dissection = TRUE
	if(artery)
		if(dissection)
			artery.dissect()
		else
			artery.tear()
	var/final_descriptive = "An artery is [dissection ? "torn" : "damaged"]!"
	// Carotid and aorta are pretty significantly dangerous
	if(istype(artery, ARTERY_NECK) || istype(artery, ARTERY_CHEST) || istype(artery, ARTERY_VITALS))
		final_descriptive = "\The [artery] [artery.p_are()] [dissection ? "dissected" : "damaged"]!"
	if(victim)
		if(sound_effect)
			playsound(new_limb.owner, pick(sound_effect), 70 + 20 * severity, TRUE)
		if(add_descriptive)
			SEND_SIGNAL(victim, COMSIG_CARBON_ADD_TO_WOUND_MESSAGE, span_bolddanger(" [final_descriptive]"))
	qdel(src)

/datum/wound/artery/tear
	severity = WOUND_SEVERITY_SEVERE
	threshold_minimum = 70

/datum/wound/artery/dissect
	severity = WOUND_SEVERITY_CRITICAL
	threshold_minimum = 100
