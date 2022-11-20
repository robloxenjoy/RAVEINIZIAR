/datum/export/large/crate
	cost = 5 DOLLARS
	k_elasticity = 0
	unit_name = "crate"
	export_types = list(/obj/structure/closet/crate)
	exclude_types = list(/obj/structure/closet/crate/large, /obj/structure/closet/crate/wooden, /obj/structure/closet/crate/mail)

/datum/export/large/crate/total_printout(datum/export_report/ex, notes = TRUE) // That's why a goddamn metal crate costs that much.
	. = ..()
	if(. && notes)
		. += " Thanks for participating in Nanotrasen Crates Recycling Program."

/datum/export/large/crate/wooden
	cost = 3 DOLLARS
	unit_name = "large wooden crate"
	export_types = list(/obj/structure/closet/crate/large)
	exclude_types = list()

/datum/export/large/crate/wooden/ore
	unit_name = "ore box"
	export_types = list(/obj/structure/ore_box)

/datum/export/large/crate/wood
	cost = 2 DOLLARS
	unit_name = "wooden crate"
	export_types = list(/obj/structure/closet/crate/wooden)
	exclude_types = list()

/datum/export/large/crate/coffin
	cost = 4 DOLLARS
	unit_name = "coffin"
	export_types = list(/obj/structure/closet/crate/coffin)

/datum/export/large/reagent_dispenser
	cost = 25 DOLLARS // +0-400 depending on amount of reagents left // okay buddy kill yourself
	var/contents_cost = 25 DOLLARS * 0.2

/datum/export/large/reagent_dispenser/get_cost(obj/O)
	var/obj/structure/reagent_dispensers/D = O
	var/ratio = D.reagents.total_volume / D.reagents.maximum_volume

	return ..() + round(contents_cost * ratio)


/datum/export/large/reagent_dispenser/water
	unit_name = "watertank"
	export_types = list(/obj/structure/reagent_dispensers/watertank)
	contents_cost = 10 DOLLARS

/datum/export/large/reagent_dispenser/fuel
	unit_name = "fueltank"
	export_types = list(/obj/structure/reagent_dispensers/fueltank)

/datum/export/large/reagent_dispenser/beer
	unit_name = "beer keg"
	contents_cost = 70 DOLLARS
	export_types = list(/obj/structure/reagent_dispensers/beerkeg)

/datum/export/large/pipedispenser
	cost = 17 DOLLARS
	unit_name = "pipe dispenser"
	export_types = list(/obj/machinery/pipedispenser)

/datum/export/large/emitter
	cost = 20 DOLLARS
	unit_name = "emitter"
	export_types = list(/obj/machinery/power/emitter)

/datum/export/large/field_generator
	cost = 10 DOLLARS
	unit_name = "field generator"
	export_types = list(/obj/machinery/field/generator)

/datum/export/large/tesla_coil
	cost = 9 DOLLARS
	unit_name = "tesla coil"
	export_types = list(/obj/machinery/power/energy_accumulator/tesla_coil)

/datum/export/large/supermatter
	cost = 140 DOLLARS
	unit_name = "supermatter shard"
	export_types = list(/obj/machinery/power/supermatter_crystal/shard)

/datum/export/large/grounding_rod
	cost = 16 DOLLARS
	unit_name = "grounding rod"
	export_types = list(/obj/machinery/power/energy_accumulator/grounding_rod)

/datum/export/large/iv
	cost = 4 DOLLARS
	unit_name = "iv drip"
	export_types = list(/obj/machinery/iv_drip)

/datum/export/large/barrier
	cost = 10 DOLLARS
	unit_name = "security barrier"
	export_types = list(/obj/item/grenade/barrier, /obj/structure/barricade/security)

/datum/export/large/gas_canister
	cost = 8 DOLLARS * 0.2 //Base cost of canister. You get more for nice gases inside.
	unit_name = "Gas Canister"
	export_types = list(/obj/machinery/portable_atmospherics/canister)
	k_elasticity = 0.00033

/datum/export/large/gas_canister/get_cost(obj/O)
	var/obj/machinery/portable_atmospherics/canister/C = O
	var/worth = cost
	var/datum/gas_mixture/canister_mix = C.return_air()
	var/canister_gas = canister_mix.gases
	var/list/gases_to_check = list(
								/datum/gas/bz,
								/datum/gas/stimulum,
								/datum/gas/hypernoblium,
								/datum/gas/miasma,
								/datum/gas/tritium,
								/datum/gas/pluoxium,
								/datum/gas/freon,
								/datum/gas/hydrogen,
								/datum/gas/healium,
								/datum/gas/proto_nitrate,
								/datum/gas/zauker,
								/datum/gas/helium,
								/datum/gas/antinoblium,
								/datum/gas/halon,
								)

	for(var/gasID in gases_to_check)
		canister_mix.assert_gas(gasID)
		if(canister_gas[gasID][MOLES] > 0)
			worth += get_gas_value(gasID, canister_gas[gasID][MOLES])

	canister_mix.garbage_collect()
	return worth

/datum/export/large/gas_canister/proc/get_gas_value(datum/gas/gasType, moles)
	var/baseValue = initial(gasType.base_value)
	return round((baseValue/k_elasticity) * (1 - NUM_E**(-1 * k_elasticity * moles)))
