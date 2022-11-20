/datum/supply_pack/science
	access = FALSE
	access_view = FALSE
	crate_type = /obj/structure/closet/crate/science

/datum/supply_pack/science/rped
	name = "RPED crate"
	desc = "Need to rebuild the ORM but science got annihialted after a bomb test? Buy this for the most advanced parts NT can give you."
	cost = 18 DOLLARS
	access = FALSE
	access_view = FALSE
	contains = list(/obj/item/storage/part_replacer/cargo)
	crate_name = "\improper RPED crate"

/datum/supply_pack/science/shieldwalls
	name = "Shield Generator Crate"
	desc = "These high powered Shield Wall Generators are guaranteed to keep any unwanted lifeforms on the outside, where they belong! Contains four shield wall generators. Requires Teleporter access to open."
	cost = 40 DOLLARS
	access = FALSE
	access_view = FALSE
	contains = list(/obj/machinery/power/shieldwallgen,
					/obj/machinery/power/shieldwallgen,
					/obj/machinery/power/shieldwallgen,
					/obj/machinery/power/shieldwallgen)
	crate_name = "shield generators crate"
	crate_type = /obj/structure/closet/crate/secure/science

/datum/supply_pack/science/transfer_valves
	name = "Tank Transfer Valves Crate"
	desc = "The key ingredient for making a lot of people very angry very fast. Contains two tank transfer valves."
	cost = 10 DOLLARS
	access = FALSE
	access_view = FALSE
	contains = list(/obj/item/transfer_valve,
					/obj/item/transfer_valve)
	crate_name = "tank transfer valves crate"
	crate_type = /obj/structure/closet/crate/secure/science
	dangerous = TRUE

/datum/supply_pack/science/cytology
	name = "Cytology supplies crate"
	desc = "Did out of control specimens pulverize xenobiology? Here is some more supplies for further testing."
	cost = 20.5 DOLLARS
	access = FALSE
	access_view = FALSE
	contains = list(/obj/structure/microscope,
					/obj/item/biopsy_tool,
					/obj/item/storage/box/petridish,
					/obj/item/storage/box/petridish,
					/obj/item/storage/box/swab,
					/obj/item/construction/plumbing/research)
	crate_name = "cytology supplies crate"

/datum/supply_pack/science/robotics
	cost = 20 DOLLARS
	desc = "The tools you need to replace those finicky humans with a loyal robot army! \
			Contains four proximity sensors, two empty first aid kits, two health analyzers, two red hardhats, \
			two mechanical toolboxes, four cyborg arms and two cleanbot assemblies! Requires Robotics access to open."
	access = FALSE
	access_view = FALSE
	contains = list(/obj/item/assembly/prox_sensor,
					/obj/item/assembly/prox_sensor,
					/obj/item/assembly/prox_sensor,
					/obj/item/assembly/prox_sensor,
					/obj/item/clothing/head/hardhat/red,
					/obj/item/clothing/head/hardhat/red,
					/obj/item/storage/toolbox/mechanical,
					/obj/item/storage/toolbox/mechanical,
					/obj/item/bodypart/r_arm/robot,
					/obj/item/bodypart/r_arm/robot,
					/obj/item/bodypart/r_arm/robot,
					/obj/item/bodypart/r_arm/robot,
					/obj/item/bot_assembly/cleanbot,
					/obj/item/bot_assembly/cleanbot)

/datum/supply_pack/science/cyborg_parts
	name = "Cyborg Parts Crate" //I've peppered the "R­o­b­o­C­o­p" with zero-widths. I'm not taking any risks.
	desc = "Did you lose your arm and can't seem to find it? Was your every limb swallowed by gangrene? Are you just trying to cosplay as­ RoboCop?\
			If you answered yes to any of these questions, this is the pack for you! Contains a set of cyborg arms, legs, a head and a chest.\
			Miscellaneous limbs and organs may be sold seperately. Requires Robotics access to open. No copyright infringement intended."
	cost = 40 DOLLARS
	access = FALSE
	access_view = FALSE
	contains = list(/obj/item/bodypart/head/robot,
					/obj/item/bodypart/r_arm/robot,
					/obj/item/bodypart/l_arm/robot,
					/obj/item/bodypart/r_leg/robot,
					/obj/item/bodypart/l_leg/robot,
					/obj/item/bodypart/chest/robot)
	crate_name = "robotics assembly crate"
	crate_type = /obj/structure/closet/crate/secure/science
