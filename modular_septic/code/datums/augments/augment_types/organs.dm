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
