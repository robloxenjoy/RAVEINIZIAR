/datum/augment_item
	/// Name obviously, make sure that NO NAME gets repeated in the same slot!
	var/name
	/// Description of the loadout augment, automatically set by New() if null
	var/description
	/// How many quirk points does it cost?
	var/value = 0
	/// Category in which the augment belongs to - check "_DEFINES/augment.dm"
	var/category = AUGMENT_CATEGORY_NONE
	/// Slot in which the augment belongs to, MAKE SURE THE SAME SLOT IS ONLY IN ONE CATEGORY
	var/slot = AUGMENT_SLOT_NONE
	/// Which biotypes are allowed to receive the augment
	var/allowed_biotypes = MOB_ORGANIC
	/// Hardcoded styles can be chosen from - SHOULD ONLY BE USED ON LIMBS1
	var/uses_robotic_styles = FALSE
	/// Typepath to the augment being used
	var/path

/datum/augment_item/New()
	. = ..()
	if(!description && path)
		var/atom/atom_path = path
		description = initial(atom_path.desc)

/datum/augment_item/proc/apply_to_human(mob/living/carbon/human/human, character_setup = FALSE, datum/preferences/prefs)
	return
