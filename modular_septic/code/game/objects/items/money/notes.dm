/obj/item/money/note/value5
	name = "5 dollars note"
	icon_state = "5dollars"
	base_icon_state = "5dollars"
	worth = 5 DOLLARS

/obj/item/money/note/value10
	name = "10 dollars note"
	icon_state = "10dollars"
	base_icon_state = "10dollars"
	worth = 10 DOLLARS

/obj/item/money/note/value20
	name = "20 dollars note"
	icon_state = "20dollars"
	base_icon_state = "20dollars"
	worth = 20 DOLLARS

/obj/item/money/note/value20/fake
	name = "20 dollars note"
	icon_state = "20dollars"
	base_icon_state = "20dollars"
	worth = 0 DOLLARS

/obj/item/money/note/value20/fake/get_visible_value(mob/user)
	if(GET_MOB_ATTRIBUTE_VALUE(user, STAT_PERCEPTION) > ATTRIBUTE_MIDDLING)
		return 0
	return 20 DOLLARS

/obj/item/money/note/value20/fake/value_examine(mob/user)
	if(GET_MOB_ATTRIBUTE_VALUE(user, STAT_PERCEPTION) > ATTRIBUTE_MIDDLING)
		return "[p_they(TRUE)] [p_are()] worth absolutely nothing! <b>It's a fake bill!</b>"
	return ..()

/obj/item/money/note/value50
	name = "50 dollars note"
	icon_state = "50dollars"
	base_icon_state = "50dollars"
	worth = 50 DOLLARS

/obj/item/money/note/value100
	name = "100 dollars note"
	icon_state = "100dollars"
	base_icon_state = "100dollars"
	worth = 100 DOLLARS
