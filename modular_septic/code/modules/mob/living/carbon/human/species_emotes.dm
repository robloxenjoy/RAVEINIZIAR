/datum/species/get_scream_sound(mob/living/carbon/human/human)
	if(human.gender != FEMALE)
		return "modular_septic/sound/emotes/terror_scream_male[rand(1,6)].ogg"
	else
		return "modular_septic/sound/emotes/terror_scream_female[rand(1,7)].ogg"

/datum/species/proc/agony_scream(mob/living/carbon/human/H)
	if(!istype(H))
		return FALSE
	H.emote("agonyscream")

/datum/species/proc/fall_scream(mob/living/carbon/human/H)
	if(!istype(H))
		return FALSE
	H.emote("fallscream")

/datum/species/proc/death_scream(mob/living/carbon/human/H)
	if(!istype(H))
		return FALSE
	H.emote("deathscream")

/datum/species/proc/agony_gargle(mob/living/carbon/human/H)
	if(!istype(H))
		return FALSE
	H.emote("gargle")

/datum/species/proc/agony_gasp(mob/living/carbon/human/H)
	if(!istype(H))
		return FALSE
	H.emote("gasp")

/datum/species/proc/death_rattle(mob/living/carbon/human/H)
	if(!istype(H))
		return FALSE
	H.emote("deathrattle")

/datum/species/proc/sexy_moan(mob/living/carbon/human/H)
	if(!istype(H))
		return FALSE
	H.emote("sexymoan")

/datum/species/proc/jump_grunt(mob/living/carbon/human/H)
	if(!istype(H))
		return FALSE
	H.emote("jumpgrunt")

/datum/species/proc/fatigue_grunt(mob/living/carbon/human/H)
	if(!istype(H))
		return FALSE
	H.emote("fatiguegrunt")

/datum/species/proc/crack_addict(mob/living/carbon/human/H)
	if(!istype(H))
		return FALSE
	H.emote("crackaddict")
