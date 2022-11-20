/datum/smite/fraggot
	name = "Fraggot"

/datum/smite/fraggot/effect(client/user, mob/living/target)
	. = ..()
	target.AddComponent(/datum/component/fraggot)
