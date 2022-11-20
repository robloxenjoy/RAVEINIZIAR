/**
 * Get a random organ object from the mob matching the passed in typepath
 *
 * Arguments:
 * * typepath The typepath of the organ to get
 */
/mob/proc/getorgan(typepath)
	return

/**
 * Get a list of organ objects from the mob matching the passed in typepath
 *
 * Arguments:
 * * typepath The typepath of the organ to get
 */
/mob/proc/getorganlist(typepath)
	return

/**
 * Get organ objects by zone
 *
 * This will return a list of all the organs that are relevant to the zone that is passedin
 *
 * Arguments:
 * * zone [a BODY_ZONE_X define](https://github.com/tgstation/tgstation/blob/master/code/__DEFINES/combat.dm#L187-L200)
 */
/mob/proc/getorganszone(zone)
	return

/**
 * Returns a random organ out of all organs in specified slot
 *
 * Arguments:
 * * slot Slot to get the organ from
 */
/mob/proc/getorganslot(slot)
	return

/**
 * Returns a list of all organs in the specified slot, if there are any
 *
 * Arguments:
 * * slot Slot to get the list
 */
/mob/proc/getorganslotlist(slot)
	return

/**
 * Returns a list of all organs in the specified slot, in the specified zone, if there are any
 *
 * Arguments:
 * * slot Slot to get the list
 */
/mob/proc/getorganslotlistzone(slot, zone)
	return

/**
 * Returns an integer referring to the efficiency of a certain organ slot
 *
 * Arguments:
 * * slot Slot to get the efficiency from
 */
/mob/proc/getorganslotefficiency(slot)
	return

/**
 * Returns an integer referring to the efficiency of a certain organ slot within a specific body zone
 *
 * Arguments:
 * * slot Slot to get the efficiency from
 * * zone Body zone that the organ needs to be from
 */
/mob/proc/getorganslotefficiencyzone(slot)
	return

/**
 * Updates organ blood, oxygen and nutriment requirements
 */
/mob/proc/update_organ_requirements()
	return

/mob/living/carbon/getorgan(typepath)
	var/list/organs = list()
	for(var/thing in internal_organs)
		if(istype(thing, typepath))
			organs |= thing
	if(length(organs))
		return pick(organs)

/mob/living/carbon/getorganlist(typepath)
	var/list/organs = list()
	for(var/thing in internal_organs)
		if(istype(thing, typepath))
			organs |= thing
	return organs

/mob/living/carbon/getorganszone(zone)
	return LAZYACCESS(organs_by_zone, zone)

/mob/living/carbon/getorganslot(slot)
	if(length(internal_organs_slot[slot]))
		return pick(internal_organs_slot[slot])

/mob/living/carbon/getorganslotlist(slot)
	. = list()
	if(length(internal_organs_slot[slot]))
		. |= internal_organs_slot[slot]

/mob/living/carbon/getorganslotlistzone(slot, zone)
	. = list()
	var/obj/item/organ/organ
	for(var/thing in internal_organs_slot[slot])
		organ = thing
		if(zone == check_zone(organ.current_zone))
			. |= organ

/mob/living/carbon/getorganslotefficiency(slot)
	. = 0
	var/obj/item/organ/organ
	for(var/thing in internal_organs_slot[slot])
		organ = thing
		. += organ.get_slot_efficiency(slot)

/mob/living/carbon/getorganslotefficiencyzone(slot, zone)
	. = 0
	var/obj/item/organ/organ
	for(var/thing in internal_organs_slot[slot])
		organ = thing
		if(zone == check_zone(organ.current_zone))
			. += organ.get_slot_efficiency(slot)

/mob/living/carbon/update_organ_requirements()
	if(status_flags & BUILDING_ORGANS)
		return
	total_blood_req = 0
	total_oxygen_req = 0
	total_nutriment_req = 0
	total_hydration_req = 0
	for(var/thing in internal_organs)
		var/obj/item/organ/organ = thing
		total_blood_req += (organ.blood_req/100 * BLOOD_VOLUME_NORMAL)
		total_oxygen_req += organ.oxygen_req
		total_nutriment_req += (organ.nutriment_req/1000)
		total_hydration_req += (organ.hydration_req/1000)

/**
 * Regenerates all standard organs of the body.
 */
/mob/living/proc/regenerate_organs()
	return FALSE

/mob/living/carbon/regenerate_organs()
	if(dna?.species)
		dna.species.regenerate_organs(src, replace_current = TRUE)
		return
	else
		var/list/lungs = getorganslotlist(ORGAN_SLOT_LUNGS)
		if(length(lungs) < 2)
			while(length(lungs) < 2)
				var/obj/item/organ/lungs/lung = new()
				lung.Insert(src)
		for(var/thing in lungs)
			var/obj/item/organ/lungs/lung = thing
			lung.setOrganDamage(0)

		var/obj/item/organ/heart/H = getorganslot(ORGAN_SLOT_HEART)
		if(!H)
			H = new()
			H.Insert(src)
		H.setOrganDamage(0)

		var/obj/item/organ/tongue/T = getorganslot(ORGAN_SLOT_TONGUE)
		if(!T)
			T = new()
			T.Insert(src)
		T.setOrganDamage(0)

		var/list/ears = getorganslotlist(ORGAN_SLOT_EARS)
		if(LAZYLEN(ears) < 2)
			while(LAZYLEN(ears) < 2)
				var/obj/item/organ/ears/ear = new()
				ear.Insert(src)
		for(var/thing in ears)
			var/obj/item/organ/ears/ear = thing
			ear.setOrganDamage(0)

/**
 * Get a random organ object from the bodypart matching the passed in typepath
 *
 * Arguments:
 * * typepath The typepath of the organ to get
 */
/obj/item/bodypart/proc/getorgan(typepath)
	if(owner)
		for(var/thing in shuffle(owner.getorganszone(body_zone)))
			if(istype(thing, typepath))
				return thing
	else
		var/list/organs = list()
		for(var/thing in src)
			if(istype(thing, typepath))
				organs |= thing
		if(length(organs))
			return pick(organs)

/**
 * Get a list of organ objects from the bodypart matching the passed in typepath
 *
 * Arguments:
 * * typepath The typepath of the organ to get
 */
/obj/item/bodypart/proc/getorganlist(typepath)
	var/list/organs = list()
	if(owner)
		for(var/thing in owner.getorganszone(body_zone))
			if(istype(thing, typepath))
				organs |= thing
	else
		for(var/thing in src)
			if(istype(thing, typepath))
				organs |= thing
	return organs

/**
 * Returns a random organ out of all organs in specified slot inside of the bodypart
 *
 * Arguments:
 * * slot Slot to get the organ from
 */
/obj/item/bodypart/proc/getorganslot(slot)
	if(owner)
		for(var/thing in shuffle(owner.getorganslotlist(slot)))
			var/obj/item/organ/organ = thing
			if(organ.current_zone == body_zone)
				return organ
	else
		var/list/organs = list()
		for(var/obj/item/organ/organ in src)
			if(slot in organ.organ_efficiency)
				organs |= organ
		if(length(organs))
			return pick(shuffle(organs))

/**
 * Returns a list of all organs in the specified slot inside this limb, if there are any
 *
 * Arguments:
 * * slot Slot to get the list
 */
/obj/item/bodypart/proc/getorganslotlist(slot)
	var/list/organs = list()
	if(owner)
		var/obj/item/organ/organ
		for(var/thing in owner.getorganslotlist(slot))
			organ = thing
			if(check_zone(organ.current_zone) == body_zone)
				organs |= organ
	else
		for(var/obj/item/organ/organ in src)
			if(slot in organ.organ_efficiency)
				organs |= organ
	return organs

/**
 * Returns the organ efficiency in a specific limb
 * Arguments:
 * * slot Slot to get the efficiency from
 */
/obj/item/bodypart/proc/getorganslotefficiency(slot)
	if(owner)
		return owner.getorganslotefficiencyzone(slot, body_zone)
	else
		. = null
		for(var/obj/item/organ/organ in src)
			. += organ.get_slot_efficiency(slot)
