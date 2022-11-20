/datum/supply_pack/goody
	goody = FALSE

//UK worst crime pack
/datum/supply_pack/goody/zhunter
	name = "Z-Hunter Surplus"
	desc = "No one wants to buy this junk and it's filling up the warehouse. Comes with 8 Z-Hunter brand knives."
	cost = 5 DOLLARS
	contains = list(
		/obj/item/knife/combat/zhunter,
		/obj/item/knife/combat/zhunter,
		/obj/item/knife/combat/zhunter,
		/obj/item/knife/combat/zhunter,
		/obj/item/knife/combat/zhunter,
		/obj/item/knife/combat/zhunter,
	)
	crate_name = "illegal chinesium knives"

/datum/supply_pack/goody/hammer
	name = "Hammer Surplus"
	desc = "Some iron hammers for general nail-striking and small-scale demolition"
	cost = 12 DOLLARS
	contains = list(
		/obj/item/hammer,
		/obj/item/hammer,
		/obj/item/hammer
	)
	crate_name = "hammers"

/datum/supply_pack/goody/firstaidbruises_single
	name = "Bruise Treatment Kit Single-Pack"
	desc = "A single brute first-aid kit, perfect for recovering from being crushed in an airlock. Did you know people get crushed in airlocks all the time? Interesting..."
	cost = 25 DOLLARS
	contains = list(/obj/item/storage/firstaid/brute)

/datum/supply_pack/goody/firstaidburns_single
	name = "Burn Treatment Kit Single-Pack"
	desc = "A single burn first-aid kit. The advertisement displays a winking atmospheric technician giving a thumbs up, saying \"Mistakes happen!\""
	cost = 22.50 DOLLARS
	contains = list(/obj/item/storage/firstaid/fire)

/datum/supply_pack/goody/firstaid_single
	name = "First Aid Kit Single-Pack"
	desc = "A single first-aid kit, fit for healing most types of bodily harm."
	cost = 20 DOLLARS
	contains = list(/obj/item/storage/firstaid/regular)

/datum/supply_pack/goody/firstaidoxygen_single
	name = "Oxygen Deprivation Kit Single-Pack"
	desc = "A single oxygen deprivation first-aid kit, marketed heavily to those with crippling fears of asphyxiation."
	cost = 15.25 DOLLARS
	contains = list(/obj/item/storage/firstaid/o2)

/datum/supply_pack/goody/firstaidtoxins_single
	name = "Toxin Treatment Kit Single-Pack"
	desc = "A single first aid kit focused on healing damage dealt by heavy toxins."
	cost = 35 DOLLARS
	contains = list(/obj/item/storage/firstaid/toxin)

/datum/supply_pack/goody/toolbox // mostly just to water down coupon probability
	name = "Mechanical Toolbox"
	desc = "A fully stocked mechanical toolbox."
	cost = 20 DOLLARS
	contains = list(/obj/item/storage/toolbox/mechanical)

/datum/supply_pack/goody/valentine
	name = "Valentine Card"
	desc = "Make an impression on that special someone! Comes with one valentine card and a free candy heart!"
	cost = 2 DOLLARS
	contains = list(/obj/item/valentine, /obj/item/food/candyheart)

/datum/supply_pack/goody/beeplush
	name = "Bee Plushie"
	desc = "The most important thing you could possibly spend your hard-earned money on."
	cost = 5 DOLLARS
	contains = list(/obj/item/toy/plush/beeplushie)

/*
/datum/supply_pack/goody/dyespray
	name = "Hair Dye Spray"
	desc = "A cool spray to dye your hair with awesome colors!"
	cost = 90000000000000000 DOLLARS // I hate alt girls
	contains = list(/obj/item/dyespray)*/

/datum/supply_pack/goody/beach_ball
	name = "Beach Ball"
	// uses desc from item
	cost = 3.25 DOLLARS
	contains = list(/obj/item/toy/beach_ball/branded)

/datum/supply_pack/goody/beach_ball/New()
	..()
	var/obj/item/toy/beach_ball/branded/beachball_type = /obj/item/toy/beach_ball/branded
	desc = initial(beachball_type.desc)

/datum/supply_pack/goody/medipen_twopak
	name = "Medipen Two-Pak"
	desc = "Contains one standard epinephrine medipen and one standard emergency first-aid kit medipen. For when you want to prepare for the worst."
	cost = 10.25 DOLLARS
	contains = list(/obj/item/reagent_containers/hypospray/medipen, /obj/item/reagent_containers/hypospray/medipen/ekit)
