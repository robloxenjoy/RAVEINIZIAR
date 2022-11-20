/datum/supply_pack/engineering
	group = "Engineering"
	access = FALSE
	access_view = FALSE
	crate_type = /obj/structure/closet/crate/engineering

/datum/supply_pack/engineering/shieldgen
	name = "Anti-breach Shield Projector Crate"
	desc = "Hull breaches again? Say no more with the Nanotrasen Anti-Breach Shield Projector! Uses forcefield technology to keep the air in, and the space out. Contains two shield projectors."
	cost = 20 DOLLARS
	contains = list(/obj/machinery/shieldgen,
					/obj/machinery/shieldgen)
	crate_name = "anti-breach shield projector crate"

/datum/supply_pack/engineering/conveyor
	name = "Conveyor Assembly Crate"
	desc = "Keep production moving along with thirty conveyor belts. Conveyor switch included. If you have any questions, check out the enclosed instruction book."
	cost = 10 DOLLARS
	contains = list(/obj/item/stack/conveyor/thirty,
					/obj/item/conveyor_switch_construct,
					/obj/item/paper/guides/conveyor)
	crate_name = "conveyor assembly crate"

/datum/supply_pack/engineering/engiequipment
	name = "Engineering Gear Crate"
	desc = "Gear up with three toolbelts, high-visibility vests, welding helmets, hardhats, and two pairs of meson goggles!"
	cost = 13 DOLLARS
	contains = list(/obj/item/storage/belt/utility,
					/obj/item/storage/belt/utility,
					/obj/item/storage/belt/utility,
					/obj/item/clothing/suit/hazardvest,
					/obj/item/clothing/suit/hazardvest,
					/obj/item/clothing/suit/hazardvest,
					/obj/item/clothing/head/welding,
					/obj/item/clothing/head/welding,
					/obj/item/clothing/head/welding,
					/obj/item/clothing/head/hardhat,
					/obj/item/clothing/head/hardhat,
					/obj/item/clothing/head/hardhat,
					/obj/item/clothing/glasses/meson/engine,
					/obj/item/clothing/glasses/meson/engine)
	crate_name = "engineering gear crate"

/datum/supply_pack/engineering/powergamermitts
	name = "Insulated Gloves Crate"
	desc = "The backbone of modern society. Barely ever ordered for actual engineering. Contains three insulated gloves."
	cost = 15 DOLLARS
	contains = list(/obj/item/clothing/gloves/color/yellow,
					/obj/item/clothing/gloves/color/yellow,
					/obj/item/clothing/gloves/color/yellow)
	crate_name = "insulated gloves crate"
	crate_type = /obj/structure/closet/crate/engineering/electrical

/datum/supply_pack/engineering/inducers
	name = "NT-75 Electromagnetic Power Inducers Crate"
	desc = "No rechargers? No problem, with the NT-75 EPI, you can recharge any standard cell-based equipment anytime, anywhere. Contains two Inducers."
	cost = 12 DOLLARS
	contains = list(/obj/item/inducer/sci {cell_type = /obj/item/stock_parts/cell/inducer_supply; opened = 0}, /obj/item/inducer/sci {cell_type = /obj/item/stock_parts/cell/inducer_supply; opened = 0}) //FALSE doesn't work in modified type paths apparently.
	crate_name = "inducer crate"
	crate_type = /obj/structure/closet/crate/engineering/electrical

/datum/supply_pack/engineering/pacman
	name = "P.A.C.M.A.N Generator Crate"
	desc = "Engineers can't set up the engine? Not an issue for you, once you get your hands on this P.A.C.M.A.N. Generator! Takes in plasma and spits out sweet sweet energy."
	cost = 15 DOLLARS
	contains = list(/obj/machinery/power/port_gen/pacman)
	crate_name = "PACMAN generator crate"
	crate_type = /obj/structure/closet/crate/engineering/electrical

/datum/supply_pack/engineering/power
	name = "Power Cell Crate"
	desc = "Looking for power overwhelming? Look no further. Contains three high-voltage power cells."
	cost = 8 DOLLARS
	contains = list(/obj/item/stock_parts/cell/high,
					/obj/item/stock_parts/cell/high,
					/obj/item/stock_parts/cell/high)
	crate_name = "power cell crate"
	crate_type = /obj/structure/closet/crate/engineering/electrical

/datum/supply_pack/engineering/tools
	name = "Toolbox Crate"
	desc = "Any robust spaceman is never far from their trusty toolbox. Contains three electrical toolboxes and three mechanical toolboxes."
	cost = 10 DOLLARS
	contains = list(/obj/item/storage/toolbox/electrical,
					/obj/item/storage/toolbox/electrical,
					/obj/item/storage/toolbox/electrical,
					/obj/item/storage/toolbox/mechanical,
					/obj/item/storage/toolbox/mechanical,
					/obj/item/storage/toolbox/mechanical)
	crate_name = "toolbox crate"

/datum/supply_pack/engineering/portapump
	name = "Portable Air Pump Crate"
	desc = "Did someone let the air out of the shuttle again? We've got you covered. Contains two portable air pumps."
	cost = 8 DOLLARS
	contains = list(/obj/machinery/portable_atmospherics/pump,
					/obj/machinery/portable_atmospherics/pump)
	crate_name = "portable air pump crate"

/datum/supply_pack/engineering/portascrubber
	name = "Portable Scrubber Crate"
	desc = "Clean up that pesky plasma leak with your very own set of two portable scrubbers."
	cost = 10 DOLLARS
	contains = list(/obj/machinery/portable_atmospherics/scrubber,
					/obj/machinery/portable_atmospherics/scrubber)
	crate_name = "portable scrubber crate"

/datum/supply_pack/engineering/hugescrubber
	name = "Huge Portable Scrubber Crate"
	desc = "A huge portable scrubber for huge atmospherics mistakes."
	cost = 15 DOLLARS
	contains = list(/obj/machinery/portable_atmospherics/scrubber/huge/movable/cargo)
	crate_name = "huge portable scrubber crate"
	crate_type = /obj/structure/closet/crate/large

/datum/supply_pack/engineering/space_heater
	name = "Space Heater Crate"
	desc = "A dual purpose heater/cooler for when things are too chilly/toasty."
	cost = 7 DOLLARS
	contains = list(/obj/machinery/space_heater)
	crate_name = "space heater crate"
	crate_type = /obj/structure/closet/crate/large

/datum/supply_pack/engineering/shield_sat
	name = "Shield Generator Satellite"
	desc = "Protect the very existence of this station with these Anti-Meteor defenses. Contains three Shield Generator Satellites."
	cost = 10 DOLLARS
	special = TRUE
	contains = list(
					/obj/machinery/satellite/meteor_shield,
					/obj/machinery/satellite/meteor_shield,
					/obj/machinery/satellite/meteor_shield
					)
	crate_name= "shield sat crate"


/datum/supply_pack/engineering/shield_sat_control
	name = "Shield System Control Board"
	desc = "A control system for the Shield Generator Satellite system."
	cost = 5 DOLLARS
	special = TRUE
	contains = list(/obj/item/circuitboard/computer/sat_control)
	crate_name= "shield control board crate"


//////////////////////////////////////////////////////////////////////////////
//////////////////////// Engine Construction /////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

/datum/supply_pack/engine
	group = "Engine Construction"
	access = FALSE
	access_view = FALSE
	crate_type = /obj/structure/closet/crate/engineering

/datum/supply_pack/engine/emitter
	name = "Emitter Crate"
	desc = "Useful for powering forcefield generators while destroying locked crates and intruders alike. Contains two high-powered energy emitters. Requires CE access to open."
	cost = 55 DOLLARS
	contains = list(/obj/machinery/power/emitter,
					/obj/machinery/power/emitter)
	crate_name = "emitter crate"
	crate_type = /obj/structure/closet/crate/secure/engineering
	dangerous = TRUE

/datum/supply_pack/engine/field_gen
	name = "Field Generator Crate"
	desc = "Typically the only thing standing between the station and a messy death. Powered by emitters. Contains two field generators."
	cost = 25 DOLLARS
	contains = list(/obj/machinery/field/generator,
					/obj/machinery/field/generator)
	crate_name = "field generator crate"

/datum/supply_pack/engine/grounding_rods
	name = "Grounding Rod Crate"
	desc = "Four grounding rods guaranteed to keep any uppity tesla coil's lightning under control."
	cost = 15 DOLLARS
	contains = list(/obj/machinery/power/energy_accumulator/grounding_rod,
					/obj/machinery/power/energy_accumulator/grounding_rod,
					/obj/machinery/power/energy_accumulator/grounding_rod,
					/obj/machinery/power/energy_accumulator/grounding_rod)
	crate_name = "grounding rod crate"
	crate_type = /obj/structure/closet/crate/engineering/electrical

/datum/supply_pack/engine/solar
	name = "Solar Panel Crate"
	desc = "Go green with this DIY advanced solar array. Contains twenty one solar assemblies, a solar-control circuit board, and tracker. If you have any questions, please check out the enclosed instruction book."
	cost = 40 DOLLARS
	contains = list(/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/circuitboard/computer/solar_control,
					/obj/item/electronics/tracker,
					/obj/item/paper/guides/jobs/engi/solars)
	crate_name = "solar panel crate"
	crate_type = /obj/structure/closet/crate/engineering/electrical

/datum/supply_pack/engine/supermatter_shard
	name = "Supermatter Shard Crate"
	desc = "The power of the heavens condensed into a single crystal."
	cost = 100 DOLLARS
	contains = list(/obj/machinery/power/supermatter_crystal/shard)
	crate_name = "supermatter shard crate"
	crate_type = /obj/structure/closet/crate/secure/engineering
	dangerous = TRUE

/datum/supply_pack/engine/tesla_coils
	name = "Tesla Coil Crate"
	desc = "Whether it's high-voltage executions, creating research points, or just plain old assistant electrofrying: This pack of four Tesla coils can do it all!"
	cost = 30 DOLLARS
	contains = list(/obj/machinery/power/energy_accumulator/tesla_coil,
					/obj/machinery/power/energy_accumulator/tesla_coil,
					/obj/machinery/power/energy_accumulator/tesla_coil,
					/obj/machinery/power/energy_accumulator/tesla_coil)
	crate_name = "tesla coil crate"
	crate_type = /obj/structure/closet/crate/engineering/electrical

/datum/supply_pack/engine/hypertorus_fusion_reactor
	name = "HFR Crate"
	desc = "The new and improved fusion reactor."
	cost = 150 DOLLARS
	contains = list(/obj/item/hfr_box/corner,
					/obj/item/hfr_box/corner,
					/obj/item/hfr_box/corner,
					/obj/item/hfr_box/corner,
					/obj/item/hfr_box/body/fuel_input,
					/obj/item/hfr_box/body/moderator_input,
					/obj/item/hfr_box/body/waste_output,
					/obj/item/hfr_box/body/interface,
					/obj/item/hfr_box/core)
	crate_name = "HFR crate"
	crate_type = /obj/structure/closet/crate/secure/engineering
	dangerous = TRUE
