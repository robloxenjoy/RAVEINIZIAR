/mob/living/carbon/human/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.) //to allow surgery to return properly.
		return
	if(ishuman(user))
		var/mob/living/carbon/human/human_user = user
		dna.species.spec_attack_hand(human_user, src, user.mind?.martial_art, modifiers)