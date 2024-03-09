/mob/living/carbon/human/GetVoice(if_no_voice = get_aged_gender())
	if(istype(wear_mask, /obj/item/clothing/mask/chameleon))
		var/obj/item/clothing/mask/chameleon/chameleon_mask = wear_mask
		if(chameleon_mask.voice_change)
			var/obj/item/card/id/idcard = wear_id?.GetID()
			if(istype(idcard))
				return idcard.registered_name
			else
				return if_no_voice
	else if(istype(wear_mask, /obj/item/clothing/mask/infiltrator))
		var/obj/item/clothing/mask/infiltrator/infiltrator_mask = wear_mask
		if(infiltrator_mask.voice_unknown)
			return if_no_voice
	if(mind)
		var/datum/antagonist/changeling/changeling = mind.has_antag_datum(/datum/antagonist/changeling)
		if(changeling?.mimicing)
			return changeling.mimicing
	if(GetSpecialVoice())
		return GetSpecialVoice()
	return real_name

/mob/living/carbon/human/get_visible_name()
	var/face_name = get_face_name("")
	var/id_name = get_id_name("")
	if(name_override)
		return name_override
	if(face_name)
		if(id_name && (id_name != face_name))
			return "[face_name] (as [id_name])"
		return face_name
	if(id_name)
		return id_name
	return "Unknown [get_aged_gender()]"

/mob/living/carbon/human/get_face_name(if_no_face = "[get_aged_gender()][get_assignment("", "", FALSE) ? " [get_assignment()]" : null]")
	if(wear_mask)
		if(istype(wear_mask, /obj/item/bodypart/face))
			var/obj/item/bodypart/face/face_mask = wear_mask
			if(face_mask)
				return face_mask.real_name
		//Wearing a mask which hides our face, use id-name if possible
		else if(wear_mask.flags_inv & HIDEFACE)
			return if_no_face
	if( head && (head.flags_inv & HIDEFACE) )
		return if_no_face //Likewise for hats
	var/obj/item/bodypart/face = get_bodypart_nostump(BODY_ZONE_PRECISE_FACE)
	//Disfigured, use id-name if possible
	if( !face || HAS_TRAIT(src, TRAIT_DISFIGURED) || HAS_TRAIT(src, TRAIT_HUSK) || (cloneloss > 50) || !real_name )
		return if_no_face
	return real_name

/mob/living/carbon/human/get_alt_name()
	return

/mob/living/carbon/human/proc/get_gender()
	var/visible_gender = p_they()
	switch(visible_gender)
		if("he")
			visible_gender = "Мужчина"
		if("she")
			visible_gender = "Женщина"
		if("they")
			visible_gender = "Существо"
		else
			visible_gender = "Нечто"
	return visible_gender

/mob/living/carbon/human/proc/get_age()
	switch(age)
		if(80 to INFINITY)
			return "Древний"
		if(65 to 80)
			return "Дедовский"
		if(34 to 65)
			return "Старый"
		if(28 to 33)
			return "Взрослый"
		if(18 to 27)
			return "Молоднявый"
		else
			return ""

/mob/living/carbon/human/proc/get_aged_gender(prefixed = FALSE, lowercase = FALSE)
	var/visible_gender = get_gender()
	switch(age)
		if(80 to INFINITY)
			visible_gender = "Древний [visible_gender]"
		if(65 to 80)
			visible_gender = "Дедовский [visible_gender]"
		if(34 to 65)
			visible_gender = "Старый [visible_gender]"
		if(28 to 33)
			visible_gender = "Взрослый [visible_gender]"
		if(18 to 27)
			visible_gender = "Молоднявый [visible_gender]"
		else
			visible_gender = "[visible_gender]"
	return lowercase ? lowertext(visible_gender) : visible_gender
