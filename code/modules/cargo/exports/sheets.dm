/datum/export/stack
	unit_name = "sheet"

/datum/export/stack/get_amount(obj/O)
	var/obj/item/stack/S = O
	if(istype(S))
		return S.amount
	return 0

// Hides

/datum/export/stack/skin/monkey
	cost = 2 DOLLARS
	unit_name = "monkey hide"
	export_types = list(/obj/item/stack/sheet/animalhide/monkey)

/datum/export/stack/skin/human
	cost = 2.5 DOLLARS
	unit_name = "piece"
	message = "of human skin"
	export_types = list(/obj/item/stack/sheet/animalhide/human)

/datum/export/stack/skin/cat
	cost = 2.5 DOLLARS
	unit_name = "cat hide"
	export_types = list(/obj/item/stack/sheet/animalhide/cat)

/datum/export/stack/skin/corgi
	cost = 3 DOLLARS
	unit_name = "corgi hide"
	export_types = list(/obj/item/stack/sheet/animalhide/corgi)

/datum/export/stack/skin/lizard
	cost = 5 DOLLARS
	unit_name = "lizard hide"
	export_types = list(/obj/item/stack/sheet/animalhide/lizard)

// Common materials.
// For base materials, see materials.dm

/datum/export/stack/plasteel
	cost = 2.5 DOLLARS
	message = "of plasteel"
	export_types = list(/obj/item/stack/sheet/plasteel)

// 1 glass + 0.5 iron, cost is rounded up.
/datum/export/stack/rglass
	cost = 2 DOLLARS
	message = "of reinforced glass"
	export_types = list(/obj/item/stack/sheet/rglass)

/datum/export/stack/plastitanium
	cost = 4 DOLLARS
	message = "of plastitanium"
	export_types = list(/obj/item/stack/sheet/mineral/plastitanium)

/datum/export/stack/wood
	cost = 1 DOLLARS
	unit_name = "wood plank"
	export_types = list(/obj/item/stack/sheet/mineral/wood)

/datum/export/stack/cloth
	cost = 1 DOLLARS
	message = "rolls of cloth"
	export_types = list(/obj/item/stack/sheet/cloth)

/datum/export/stack/durathread
	cost = 1.5 DOLLARS
	message = "rolls of durathread"
	export_types = list(/obj/item/stack/sheet/durathread)

/datum/export/stack/cardboard
	cost = 10 CENTS
	message = "of cardboard"
	export_types = list(/obj/item/stack/sheet/cardboard)

/datum/export/stack/sandstone
	cost = 15 CENTS
	unit_name = "block"
	message = "of sandstone"
	export_types = list(/obj/item/stack/sheet/mineral/sandstone)

/datum/export/stack/cable
	cost = 25 CENTS
	unit_name = "cable piece"
	export_types = list(/obj/item/stack/cable_coil)
