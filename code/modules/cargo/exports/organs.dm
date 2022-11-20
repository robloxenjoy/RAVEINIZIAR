/datum/export/organ
	include_subtypes = FALSE //CentCom doesn't need organs from non-humans.

/datum/export/organ/heart
	cost = 95.5 DOLLARS
	unit_name = "humanoid heart"
	export_types = list(/obj/item/organ/heart)

/datum/export/organ/eyes
	cost = 50 DOLLARS
	unit_name = "humanoid eyes"
	export_types = list(/obj/item/organ/eyes)

/datum/export/organ/ears
	cost = 20 DOLLARS
	unit_name = "humanoid ears"
	export_types = list(/obj/item/organ/ears)

/datum/export/organ/liver
	cost = 50 DOLLARS
	unit_name = "humanoid liver"
	export_types = list(/obj/item/organ/liver)

/datum/export/organ/lungs
	cost = 60.25 DOLLARS
	unit_name = "humanoid lungs"
	export_types = list(/obj/item/organ/lungs)

/datum/export/organ/stomach
	cost = 42 DOLLARS
	unit_name = "humanoid stomach"
	export_types = list(/obj/item/organ/stomach)

/datum/export/organ/tongue
	cost = 30 DOLLARS
	unit_name = "humanoid tounge"
	export_types = list(/obj/item/organ/tongue)

/datum/export/organ/tail/lizard
	cost = 10 DOLLARS
	unit_name = "lizard tail"
	export_types = list(/obj/item/organ/tail/lizard)


/datum/export/organ/tail/cat
	cost = 2 DOLLARS
	unit_name = "cat tail"
	export_types = list(/obj/item/organ/tail/cat)

/datum/export/organ/ears/cat
	cost = 5 DOLLARS
	unit_name = "cat ears"
	export_types = list(/obj/item/organ/ears/cat)

