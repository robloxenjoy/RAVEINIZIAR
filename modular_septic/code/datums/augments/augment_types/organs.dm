/datum/augment_item/organ
	category = AUGMENT_CATEGORY_ORGANS

/datum/augment_item/organ/missing

/datum/augment_item/organ/missing/apply_to_human(mob/living/carbon/human/human, character_setup = FALSE, datum/preferences/prefs)
	if(character_setup)
		return
	var/list/kill_organs = human.getorganlist(path)
	for(var/obj/item/organ/organ in kill_organs)
		organ.Remove(human, FALSE)
		qdel(organ)
//RIGHT EYELID
/datum/augment_item/organ/heart
	slot = AUGMENT_SLOT_HEART

/datum/augment_item/organ/heart/robotic
	name = "Cybernetic Heart 1.0"
	description = "An electronic device designed to mimic the functions of an organic human heart."
	path = /obj/item/organ/heart/cybernetic
	value = 3

/datum/augment_item/organ/heart/robotic/two
	name = "Cybernetic Heart 2.0"
	description = "An electronic device designed to mimic the functions of an organic human heart. Also holds an emergency dose of epinephrine, used automatically after facing severe trauma."
	path = /obj/item/organ/heart/cybernetic/tier2
	value = 4