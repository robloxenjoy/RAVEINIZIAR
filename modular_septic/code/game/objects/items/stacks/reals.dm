/obj/item/stack/spacecash  //so good reals
	name = "Nevadian Reals"
	singular_name = "real"
	icon = 'icons/obj/economy.dmi'
	icon_state = null

/obj/item/stack/spacecash/suicide_act(mob/living/carbon/user)
	user.visible_message(span_suicide("[user] begins to realize the Brazilian Economic Crisis, it looks like [user.p_theyre()] trying to kill themselves!"))
	ADJUSTBRAINLOSS(user, BRAIN_DAMAGE_DEATH)
	return MANUAL_SUICIDE
