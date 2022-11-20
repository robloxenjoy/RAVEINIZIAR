/datum/export/toolbox
	cost = 1 DOLLARS
	unit_name = "toolbox"
	export_types = list(/obj/item/storage/toolbox)

// mechanical toolbox: 22cr
// emergency toolbox: 17-20cr
// electrical toolbox: 36cr
// robust: priceless

// Basic tools
/datum/export/screwdriver
	cost = 1 DOLLARS
	unit_name = "screwdriver"
	export_types = list(/obj/item/screwdriver)
	include_subtypes = FALSE

/datum/export/wrench
	cost = 8 DOLLARS
	unit_name = "wrench"
	export_types = list(/obj/item/wrench)

/datum/export/crowbar
	cost = 6 DOLLARS
	unit_name = "crowbar"
	export_types = list(/obj/item/crowbar)

/datum/export/wirecutters
	cost = 3 DOLLARS
	unit_name = "pair"
	message = "of wirecutters"
	export_types = list(/obj/item/wirecutters)


/datum/export/weldingtool
	cost = 6 DOLLARS
	unit_name = "welding tool"
	export_types = list(/obj/item/weldingtool)
	include_subtypes = FALSE

/datum/export/weldingtool/emergency
	cost = 2.1 DOLLARS
	unit_name = "emergency welding tool"
	export_types = list(/obj/item/weldingtool/mini)

/datum/export/weldingtool/industrial
	cost = 10 DOLLARS
	unit_name = "industrial welding tool"
	export_types = list(/obj/item/weldingtool/largetank, /obj/item/weldingtool/hugetank)


/datum/export/extinguisher
	cost = 2 DOLLARS
	unit_name = "fire extinguisher"
	export_types = list(/obj/item/extinguisher)
	include_subtypes = FALSE

/datum/export/extinguisher/mini
	cost = 4 DOLLARS
	unit_name = "pocket fire extinguisher"
	export_types = list(/obj/item/extinguisher/mini)


/datum/export/flashlight
	cost = 4 DOLLARS
	unit_name = "flashlight"
	export_types = list(/obj/item/flashlight)
	include_subtypes = FALSE

/datum/export/flashlight/flare
	cost = 2 DOLLARS
	unit_name = "flare"
	export_types = list(/obj/item/flashlight/flare)

/datum/export/flashlight/seclite
	cost = 6.66 DOLLARS
	unit_name = "seclite"
	export_types = list(/obj/item/flashlight/seclite)


/datum/export/analyzer
	cost = 3 DOLLARS
	unit_name = "analyzer"
	export_types = list(/obj/item/analyzer)

/datum/export/analyzer/t_scanner
	cost = 2 DOLLARS
	unit_name = "t-ray scanner"
	export_types = list(/obj/item/t_scanner)


/datum/export/radio
	cost = 4 DOLLARS
	unit_name = "radio"
	export_types = list(/obj/item/radio)
	exclude_types = list(/obj/item/radio/mech)

//Advanced/Power Tools.
/datum/export/weldingtool/experimental
	cost = 15 DOLLARS
	unit_name = "experimental welding tool"
	export_types = list(/obj/item/weldingtool/experimental)

/datum/export/jawsoflife
	cost = 20 DOLLARS
	unit_name = "jaws of life"
	export_types = list(/obj/item/crowbar/power)

/datum/export/handdrill
	cost = 20 DOLLARS
	unit_name = "hand drill"
	export_types = list(/obj/item/screwdriver/power)

/datum/export/rld_mini
	cost = 6 DOLLARS
	unit_name = "mini rapid lighting device"
	export_types = list(/obj/item/construction/rld/mini)

/datum/export/rcd
	cost = 25 DOLLARS
	unit_name = "rapid construction device"
	export_types = list(/obj/item/construction/rcd)

/datum/export/rcd_ammo
	cost = 7.5 DOLLARS
	unit_name = "compressed matter cardridge"
	export_types = list(/obj/item/rcd_ammo)

/datum/export/rpd
	cost = 21 DOLLARS
	unit_name = "rapid pipe dispenser"
	export_types = list(/obj/item/pipe_dispenser)

//artisanal exports for the mom and pops
/datum/export/soap
	cost = 80 CENTS
	unit_name = "soap"
	export_types = list(/obj/item/soap)

/datum/export/soap/homemade
	cost = 40 CENTS
	unit_name = "artisanal soap"
	export_types = list(/obj/item/soap/homemade)

/datum/export/soap/omega
	cost = 1 DOLLARS
	unit_name = "omega soap"
	export_types = list(/obj/item/soap/omega)

/datum/export/candle
	cost = 30 CENTS
	unit_name = "candle"
	export_types = list(/obj/item/candle)
