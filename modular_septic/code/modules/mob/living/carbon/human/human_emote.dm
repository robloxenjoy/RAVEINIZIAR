/datum/emote/living/carbon/human/scream
	only_forced_audio = FALSE
	vary = FALSE

/datum/emote/living/sneeze/run_emote(mob/living/user)
	. = ..()
	if(ishuman(user) && GET_MOB_ATTRIBUTE_VALUE(user, STAT_STRENGTH) <= 3 && prob(8))
		var/obj/item/bodypart/neck/neck = user.get_bodypart(BODY_ZONE_PRECISE_NECK)
		var/obj/item/organ/bone/neck/spine = neck.getorganslot(ORGAN_SLOT_BONE)
		spine.applyOrganDamage(51)
		user.visible_message(span_red("[user] sneezes painfully and coughs blood immediately after whiplashing!"),\
			span_red("I break my fucking spine holy shit. SHIT. FUCK!"))
