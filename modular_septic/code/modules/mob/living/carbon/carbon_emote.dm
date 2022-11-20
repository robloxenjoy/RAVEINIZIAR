// Clap
/datum/emote/living/carbon/clap/get_sound(mob/living/user)
	return "modular_septic/sound/emotes/clap[rand(1,2)].ogg"

// Moan
/datum/emote/living/carbon/moan/get_sound(mob/living/user)
	if(ishuman(user))
		if(user.gender != FEMALE)
			return "modular_septic/sound/emotes/moan_male[rand(1, 7)].ogg"
		else
			return "modular_septic/sound/emotes/moan_female[rand(1, 8)].ogg"
	else
		return ..()
