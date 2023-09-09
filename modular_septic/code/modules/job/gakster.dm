/*
/datum/job/gakster
	title = "Gakster Scavenger"
	department_head = list("Head of Personnel")
	faction = list("neutral", "swarmer")
	supervisors = "no-one"
	selection_color = "#303234"

	outfit = /datum/outfit/gakster

/datum/job/gakster/after_spawn(mob/living/spawned, client/player_client)
	. = ..()
	if(ishuman(spawned))
		spawned.apply_status_effect(/datum/status_effect/gakster_dissociative_identity_disorder)

/datum/outfit/gakster
	name = "Gakster Uniform"

	uniform = /obj/item/clothing/under/itobe
	id = /obj/item/cellphone
	belt = /obj/item/crowbar
	l_pocket = /obj/item/simcard
	back = /obj/item/storage/backpack/satchel/itobe
	backpack_contents = list(
		/obj/item/reagent_containers/hypospray/medipen/retractible/blacktar = 1,
		/obj/item/flashlight/seclite = 1,
	)
	gloves = /obj/item/clothing/gloves/color/black
	shoes = /obj/item/clothing/shoes/jackboots

/datum/job/venturer
	title = "Venturer"
	department_head = list("Head of Personnel")
	faction = list(ROLE_AKT)
	supervisors = "no-one"
	selection_color = "#38e38e"

	outfit = /datum/outfit/venturer

/datum/job/gakster/after_spawn(mob/living/spawned, client/player_client)
	. = ..()
	if(ishuman(spawned))
		spawned.apply_status_effect(/datum/status_effect/gakster_dissociative_identity_disorder)

*/
/datum/job/venturer
	title = "Venturer"
	department_head = list("Head of Personnel")
	faction = list(ROLE_AKT)
	total_positions = 0
	spawn_positions = 0
	supervisors = "he's just traveling."
	selection_color = "#38e38e"
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/venturer

//	paycheck = PAYCHECK_MEDIUM
//	paycheck_department = ACCOUNT_CAR

	display_order = JOB_DISPLAY_ORDER_OUTER
//	bounty_types = CIV_JOB_MINE
	departments_list = list(
		/datum/job_department/cargo,
		)

//	family_heirlooms = list(/obj/item/pickaxe/mini, /obj/item/shovel)
//	rpg_title = "Adventurer"
	job_flags = JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS

/datum/outfit/venturer
	name = "Venturer Uniform"

	uniform = /obj/item/clothing/under/venturerclassic
	pants = /obj/item/clothing/pants/venturer
	r_pocket = /obj/item/storage/backpack/pouch/venturer
	id = /obj/item/key/podpol/woody/carehouse
	var/venturer_type = ""
//	id = /obj/item/cellphone
//	belt = /obj/item/crowbar
//	l_pocket = /obj/item/simcard
//	back = /obj/item/storage/backpack/satchel/itobe
//	backpack_contents = list(
//		/obj/item/reagent_containers/hypospray/medipen/retractible/blacktar = 1,
//		/obj/item/flashlight/seclite = 1,
//	)
//	gloves = /obj/item/clothing/gloves/color/black
	shoes = /obj/item/clothing/shoes/laceup

/datum/outfit/venturer/pre_equip(mob/living/carbon/human/H)
	..()
	var/result = rand(1, 5)
	switch(result)

		if(1)
			venturer_type = "woodcutter"
			l_hand = /obj/item/storage/backpack/basket
			wrists = /obj/item/clothing/gloves/wrists/leather
			belt = /obj/item/changeable_attacks/slashbash/axe/small/steel
			to_chat(H, span_achievementinteresting("I'm a woodcutter!"))
			to_chat(H, span_info("I have a real friend - an axe. I have to take care of it, otherwise it will break at such a difficult time."))


		if(2)
			venturer_type = "venturertrue"
			back = /obj/item/storage/backpack/satchel/itobe
			backpack_contents = list(
				/obj/item/reagent_containers/hypospray/medipen/retractible/blacktar = 1,
				/obj/item/stack/grown/log/tree/evil/logg/three = 1,
			)
			if(prob(75))
				glasses = /obj/item/clothing/glasses/itobe/sanfo
			to_chat(H, span_achievementinteresting("I'm a true venturer!"))
			to_chat(H, span_info("No one expects anything from me, rather I expect something."))
/*

		if(2)
			venturer_type = "venturermeatwarrior"
			neck = /obj/item/clothing/neck/leather_cloak
			suit = /obj/item/clothing/suit/armor/vest/leatherbreast
			gloves = /obj/item/clothing/gloves/leathercool
			to_chat(H, span_achievementinteresting("I'm a meat warrior!"))
			to_chat(H, span_info("Maybe I'm an occultist, maybe I'm a maniac. But I have an equipment."))
*/
		if(3)
			venturer_type = "venturervillageowner"
			neck = /obj/item/clothing/neck/noble_cloak
//			uniform = /obj/item/clothing/under/rank/captain/zoomtech
			uniform = /obj/item/clothing/under/aktraiment
			pants = /obj/item/clothing/pants/aktliver
			r_pocket = /obj/item/storage/backpack/pouch/venturer/noble
			glasses = /obj/item/clothing/glasses/hud/security/sunglasses/zoomtech
			belt = /obj/item/knife/combat/goldenmisericorde
			to_chat(H, span_achievementinteresting("I'm a village owner!"))
			to_chat(H, span_info("Finally got out of the turmoil with the village and can breathe fresh air."))

		if(4)
			venturer_type = "venturergardener"
			shoes = /obj/item/clothing/shoes/frogshoes
			l_hand = /obj/item/storage/backpack/basket
			belt = /obj/item/changeable_attacks/slashstab/knife/small/steel
			to_chat(H, span_achievementinteresting("I'm a gardener!"))
			to_chat(H, span_info("I think I'm the most boring... Maybe."))
/*
		if(4)
			venturer_type = "venturerbandit"
			belt = /obj/item/changeable_attacks/slashstab/knife/small/steel
			to_chat(H, span_achievementinteresting("I am a bandit!"))
			to_chat(H, span_info("Hehe, how evil I am!"))

		if(7)
			venturer_type = "venturerlordbandit"
			shoes = /obj/item/clothing/shoes/frogshoes
			suit = /obj/item/clothing/suit/armor/vest/leatherbreastt
			neck = /obj/item/clothing/neck/bear_cloak
			if(prob(50))
				belt = /obj/item/changeable_attacks/slashstab/sabre/small/steel/hilt
			else
				belt = /obj/item/gun/ballistic/automatic/remis/smg/bolsa
			to_chat(H, span_achievementinteresting("I am the leader of the bandits!"))
			to_chat(H, span_info("I need to find other bandits, and maybe start something insidious."))
*/
		if(5)
			venturer_type = "venturergoer"
			l_pocket = /obj/item/food/gelatine/mesopelagic
			suit = /obj/item/clothing/suit/armor/vest/chainmail/steel
			belt = /obj/item/changeable_attacks/slashstabbash/sword/medium/steel
			to_chat(H, span_achievementinteresting("I am a goer!"))
			to_chat(H, span_info("I came here by solicitation!"))
/*
		if(5)
			venturer_type = "venturerthief"
			neck = /obj/item/clothing/neck/darkproject
			l_hand = /obj/item/lamp/self_lit
			r_pocket = /obj/item/akt/lockpick/square
			l_pocket = /obj/item/akt/lockpick/square/triangle
			if(prob(75))
				glasses = /obj/item/clothing/glasses/sunglasses/sungrasses
			to_chat(H, span_achievementinteresting("I am a thief!"))
			to_chat(H, span_info("Well, shall we begin?"))
*/
/datum/outfit/venturer/equip(mob/living/carbon/human/H)
	..()
	if(venturer_type == "woodcutter")
		H.attributes?.add_sheet(/datum/attribute_holder/sheet/job/venturer)
	if(venturer_type == "venturertrue")
		H.attributes?.add_sheet(/datum/attribute_holder/sheet/job/venturertrue)
	if(venturer_type == "venturervillageowner")
		H.attributes?.add_sheet(/datum/attribute_holder/sheet/job/venturervillageowner)
	if(venturer_type == "venturergardener")
		H.attributes?.add_sheet(/datum/attribute_holder/sheet/job/venturergardener)
	if(venturer_type == "venturergoer")
		H.attributes?.add_sheet(/datum/attribute_holder/sheet/job/venturergoer)

/datum/job/leader
	title = "Leader Of Bandits"
	department_head = list("Head of Personnel")
	faction = list(ROLE_AKT)
	total_positions = 1
	spawn_positions = 1
	supervisors = "Banditism."
	selection_color = "#94009b"
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/leader

	display_order = JOB_DISPLAY_ORDER_OUTER
	departments_list = list(
		/datum/job_department/security,
		)

	job_flags = JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS

/datum/outfit/leader
	name = "Leader Uniform"

	uniform = /obj/item/clothing/under/venturerclassic
	pants = /obj/item/clothing/pants/venturer
	oversuit = /obj/item/clothing/suit/armor/vest/bulletproofer
	suit = /obj/item/clothing/suit/armor/vest/fullcrazy/copper
	shoes = /obj/item/clothing/shoes/frogshoes

/datum/outfit/leader/equip(mob/living/carbon/human/H)
	..()
	ADD_TRAIT(H, TRAIT_MISANTHROPE, "misanthrope")

/datum/job/submercenary
	title = "Subconscious Mercenary"
	department_head = list("Head of Personnel")
	faction = list(ROLE_AKT)
	total_positions = 10
	spawn_positions = 10
	supervisors = "Banditism."
	selection_color = "#94009b"
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/submercenary

	display_order = JOB_DISPLAY_ORDER_OUTER
	departments_list = list(
		/datum/job_department/security,
		)

	job_flags = JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS

/datum/outfit/submercenary
	name = "Submercenary Uniform"

	uniform = /obj/item/clothing/under/blackshirt
	pants = /obj/item/clothing/pants/leatherpants
	suit = /obj/item/clothing/suit/armor/vest/leatherjacket
	r_pocket = /obj/item/cellphone
	l_pocket = /obj/item/simcard
	id = /obj/item/storage/backpack/pouch
	shoes = /obj/item/clothing/shoes/laceup

/datum/outfit/submercenary/pre_equip(mob/living/carbon/human/H)
	..()
	if(prob(10))
		belt = /obj/item/gun/ballistic/automatic/pistol/cortes

/datum/outfit/submercenary/equip(mob/living/carbon/human/H)
	..()
	ADD_TRAIT(H, TRAIT_MISANTHROPE, "misanthrope")
	H.mind?.add_antag_datum(/datum/antagonist/custom/submerc)
	GLOB.mercenary_list += 1

/datum/job/thief
	title = "Thief"
	department_head = list("Head of Personnel")
	faction = list(ROLE_AKT)
	total_positions = 5
	spawn_positions = 5
	supervisors = "Banditism."
	selection_color = "#94009b"
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/thief

	display_order = JOB_DISPLAY_ORDER_OUTER
	departments_list = list(
		/datum/job_department/security,
		)

	job_flags = JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS

/datum/outfit/thief
	name = "Thief Uniform"

	uniform = /obj/item/clothing/under/venturerclassic
	pants = /obj/item/clothing/pants/venturer
	suit = /obj/item/clothing/neck/darkproject
	r_pocket = /obj/item/cellphone
	l_pocket = /obj/item/simcard
	belt = /obj/item/storage/belt/blackin/full
	shoes = /obj/item/clothing/shoes/laceup
	head = /obj/item/clothing/head/blackhood
	r_hand = /obj/item/melee/bita/dark

/datum/outfit/thief/equip(mob/living/carbon/human/H)
	..()
	ADD_TRAIT(H, TRAIT_MISANTHROPE, "misanthrope")

/datum/job/chaot
	title = "Chaot"
	department_head = list("Head of Personnel")
	faction = list("chaos")
	total_positions = 5
	spawn_positions = 5
	supervisors = "CHAOTIC."
	selection_color = "#94009b"
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/chaot

	display_order = JOB_DISPLAY_ORDER_STATION_ENGINEER
	departments_list = list(
		/datum/job_department/engineering,
		)

	job_flags = JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS


/datum/outfit/chaot
	name = "Chaot Uniform"

	uniform = /obj/item/clothing/under/venturerclassic
	pants = /obj/item/clothing/pants/venturer
	suit = /obj/item/clothing/suit/hooded/labcoat/podpol/robe/chaotic
//	mask = /obj/item/shard/crystal/green
	id = /obj/item/keycard/chaot
	r_pocket = /obj/item/cellphone
	l_pocket = /obj/item/simcard
	shoes = /obj/item/clothing/shoes/laceup

/datum/job/outcombat
	title = "Outcombat"
	department_head = list("Head of Personnel")
	faction = list(ROLE_AKT)
	total_positions = 0
	spawn_positions = 0
	supervisors = "he's just attacking."
	selection_color = "#38e38e"
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/nothinger

	display_order = JOB_DISPLAY_ORDER_OUTER
	departments_list = list(
		/datum/job_department/silicon,
		)

	job_flags = JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS

/datum/outfit/nothinger
	name = "Nothing Uniform"


/datum/job/aktliver
	title = "Akt Liver"
	department_head = list("Head of Personnel")
	faction = list(ROLE_AKT)
	total_positions = 30
	spawn_positions = 30
	supervisors = "living in Akt!"
	selection_color = "#8e4a57"
	exp_granted_type = EXP_TYPE_CREW
	min_dicksize = 15
	max_dicksize = 25

	outfit = /datum/outfit/liver

	display_order = JOB_DISPLAY_ORDER_OUTER
	departments_list = list(
		/datum/job_department/science,
		)

	job_flags = JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS

/datum/outfit/liver
	name = "Akt Liver Uniform"

	uniform = /obj/item/clothing/under/aktraiment
	pants = /obj/item/clothing/pants/aktliver
	id = /obj/item/key/podpol/woody/lair
	belt = /obj/item/storage/backpack/pouch
	shoes = /obj/item/clothing/shoes/barhatki
	r_pocket = /obj/item/cellphone
	l_pocket = /obj/item/simcard

/datum/job/aktassertor
	title = "Akt Assertor"
	department_head = list("Head of Personnel")
	faction = list(ROLE_AKT)
	total_positions = 10
	spawn_positions = 10
	supervisors = "living in Akt!"
	selection_color = "#8e4a57"
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/assertor

	display_order = JOB_DISPLAY_ORDER_OUTER
	departments_list = list(
		/datum/job_department/science,
		)

	job_flags = JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS

/datum/outfit/assertor
	name = "Akt Assertor Uniform"

	uniform = /obj/item/clothing/under/aktraiment
	pants = /obj/item/clothing/pants/aktliver
	id = /obj/item/key/podpol/woody/hut
	suit = /obj/item/clothing/suit/armor/vest/chainmail/steel
	belt = /obj/item/changeable_attacks/slashstabbash/sword/medium/steel
	shoes = /obj/item/clothing/shoes/barhatki
	neck = /obj/item/clothing/neck/clodcoater
	r_pocket = /obj/item/cellphone
	l_pocket = /obj/item/simcard

/datum/job/aktnailer
	title = "Akt Nailer"
	department_head = list("Head of Personnel")
	faction = list(ROLE_AKT)
	total_positions = 10
	spawn_positions = 10
	supervisors = "living in Akt!"
	selection_color = "#8e4a57"
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/nailer

	display_order = JOB_DISPLAY_ORDER_OUTER
	departments_list = list(
		/datum/job_department/science,
		)

	job_flags = JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS

/datum/outfit/nailer
	name = "Akt Nailer Uniform"

	uniform = /obj/item/clothing/under/aktraiment
	pants = /obj/item/clothing/pants/aktliver
	shoes = /obj/item/clothing/shoes/barhatki
	id = /obj/item/key/podpol/woody/nailer
	r_pocket = /obj/item/cellphone
	l_pocket = /obj/item/simcard

/datum/job/aktgranger
	title = "Akt Granger"
	department_head = list("Head of Personnel")
	faction = list(ROLE_AKT)
	total_positions = 6
	spawn_positions = 6
	supervisors = "living in Akt!"
	selection_color = "#8e4a57"
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/granger

	display_order = JOB_DISPLAY_ORDER_OUTER
	departments_list = list(
		/datum/job_department/science,
		)

	job_flags = JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS

/datum/outfit/granger
	name = "Akt Granger Uniform"

	uniform = /obj/item/clothing/under/aktraiment
	shoes = /obj/item/clothing/shoes/frogshoes
	pants = /obj/item/clothing/pants/aktliver
	suit = /obj/item/clothing/suit/armor/vest/leatherbreastt
	id = /obj/item/key/podpol/woody/granger
	head = /obj/item/clothing/head/leather_headbag
	shoes = /obj/item/clothing/shoes/barhatki
	r_pocket = /obj/item/cellphone
	l_pocket = /obj/item/simcard

/datum/job/aktcurer
	title = "Akt Curer"
	department_head = list("Head of Personnel")
	faction = list(ROLE_AKT)
	total_positions = 6
	spawn_positions = 6
	supervisors = "living in Akt!"
	selection_color = "#8e4a57"
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/curer

	display_order = JOB_DISPLAY_ORDER_OUTER
	departments_list = list(
		/datum/job_department/science,
		)

	job_flags = JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS

/datum/outfit/curer
	name = "Akt Curer Uniform"

	uniform = /obj/item/clothing/under/aktraiment
	pants = /obj/item/clothing/pants/aktliver
	neck = /obj/item/clothing/neck/noble_cloak
	belt = /obj/item/key/podpol/woody/infirmary
	gloves = /obj/item/clothing/gloves/color/latex/nitrile
	shoes = /obj/item/clothing/shoes/barhatki
	r_pocket = /obj/item/cellphone
	l_pocket = /obj/item/simcard

/datum/job/aktgargohelper
	title = "Akt Accepter-helper"
	department_head = list("Head of Personnel")
	faction = list(ROLE_AKT)
	total_positions = 6
	spawn_positions = 6
	supervisors = "living in Akt!"
	selection_color = "#8e4a57"
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/gargohelper

	display_order = JOB_DISPLAY_ORDER_OUTER
	departments_list = list(
		/datum/job_department/science,
		)

	job_flags = JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS

/datum/outfit/gargohelper
	name = "Akt Gargohelper Uniform"

	uniform = /obj/item/clothing/under/aktraiment
	pants = /obj/item/clothing/pants/aktliver
	glasses = /obj/item/clothing/glasses/itobe/sanfo
	r_hand = /obj/item/crystal/green
	id = /obj/item/key/podpol/woody/accepter
	r_pocket = /obj/item/cellphone
	l_pocket = /obj/item/simcard
	shoes = /obj/item/clothing/shoes/barhatki

/datum/job/aktcontroller
	title = "Akt Controller"
	department_head = list("Head of Personnel")
	faction = list(ROLE_AKT)
	total_positions = 1
	spawn_positions = 1
	supervisors = "living in Akt!"
	selection_color = "#8e4a57"
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/controller

	display_order = JOB_DISPLAY_ORDER_OUTER
	departments_list = list(
		/datum/job_department/science,
		)

	job_flags = JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS

/datum/outfit/controller
	name = "Akt Controller Uniform"

	uniform = /obj/item/clothing/under/aktraiment
	pants = /obj/item/clothing/pants/aktliver
	belt = /obj/item/changeable_attacks/slashstab/sabre/small/steel
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/zoomtech
	suit = /obj/item/clothing/neck/noble_cloak
	neck = /obj/item/clothing/neck/gorget/steel
	id = /obj/item/key/podpol/woody/controller
	r_pocket = /obj/item/cellphone
	l_pocket = /obj/item/simcard
	shoes = /obj/item/clothing/shoes/barhatki
//	r_hand = /obj/item/pinker_caller

/datum/job/alchemist
	title = "Akt Al-Chemist"
	department_head = list("Head of Personnel")
	faction = list(ROLE_AKT)
	total_positions = 5
	spawn_positions = 5
	supervisors = "living in Akt!"
	selection_color = "#8e4a57"
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/alchemist

	display_order = JOB_DISPLAY_ORDER_OUTER
	departments_list = list(
		/datum/job_department/science,
		)

	job_flags = JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS

/datum/outfit/alchemist
	name = "Al-Chemist Uniform"

	uniform = /obj/item/clothing/under/aktraiment
	pants = /obj/item/clothing/pants/aktliver
	suit = /obj/item/clothing/suit/hooded/labcoat/podpol/robe/mystical
	id = /obj/item/key/podpol/woody/alchemist
	shoes = /obj/item/clothing/shoes/frogshoes
	r_pocket = /obj/item/cellphone
	l_pocket = /obj/item/simcard

/*
/datum/job/evilwarlock
	title = "Evil Warlock"
	department_head = list("Head of Personnel")
	faction = list("neutral", "swarmer")
	total_positions = 2
	spawn_positions = 2
	supervisors = "EVIL."
	selection_color = "#94009b"
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/evilwarlock

//	paycheck = PAYCHECK_MEDIUM
//	paycheck_department = ACCOUNT_CAR

	display_order = JOB_DISPLAY_ORDER_STATION_ENGINEER
//	bounty_types = CIV_JOB_MINE
	departments_list = list(
		/datum/job_department/engineering,
		)

//	family_heirlooms = list(/obj/item/pickaxe/mini, /obj/item/shovel)
//	rpg_title = "Adventurer"
	job_flags = JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS


/datum/outfit/evilwarlock
	name = "Evil Warlock Uniform"

	uniform = /obj/item/clothing/under/venturerclassic
	suit = /obj/item/clothing/suit/hooded/labcoat/podpol/robe/chaotic
	id = /obj/item/storage/backpack/pouch
//	r_hand = /obj/item/shard/crystal/blue
//	r_pocket = /obj/item/shit
//	id = /obj/item/cellphone
//	belt = /obj/item/crowbar
//	l_pocket = /obj/item/simcard
//	back = /obj/item/storage/backpack/satchel/itobe
//	backpack_contents = list(
//		/obj/item/reagent_containers/hypospray/medipen/retractible/blacktar = 1,
//		/obj/item/flashlight/seclite = 1,
//	)
//	gloves = /obj/item/clothing/gloves/color/black
	shoes = /obj/item/clothing/shoes/laceup

/datum/job/evilwarlock/after_spawn(mob/living/spawned, client/player_client)
	. = ..()
	if(ishuman(spawned))
		//var/obj/effect/proc_holder/spell/pointed/abyssal_gaze/abyssal_gaze
		//abyssal_gaze = new
		//abyssal_gaze.charge_counter = 0
		//spawned.AddSpell(abyssal_gaze)
		ADD_TRAIT(spawned, TRAIT_HORROR_STARE, type)
		spawned.apply_status_effect(/datum/status_effect/gakster_dissociative_identity_disorder)
		spawned.maximum_examine_distance = EYE_CONTACT_HORROR_RANGE
*/

/datum/job/slave
	title = "Slave"
	department_head = list("Head of Personnel")
	faction = list(ROLE_AKT)
	total_positions = 64
	spawn_positions = 64
	supervisors = "he's just works."
	selection_color = "#38e38e"
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/slave

	display_order = JOB_DISPLAY_ORDER_OUTER
	departments_list = list(
		/datum/job_department/service,
		)

	job_flags = JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS

/datum/outfit/slave
	name = "Slave Uniform"

	var/strong_slave
	uniform = /obj/item/clothing/under/darkshirt
	pants = /obj/item/clothing/pants/dark
//	r_pocket = /obj/item/shard/crystal/blue
	shoes = /obj/item/clothing/shoes/veinshoes
//	belt = /obj/item/melee/hehe/pickaxe/iron

/datum/outfit/slave/pre_equip(mob/living/carbon/human/H)
	..()
	if(prob(5))
		strong_slave = TRUE
	else
		strong_slave = FALSE

/datum/outfit/slave/equip(mob/living/carbon/human/H)
	..()
	if(strong_slave)
		H.attributes?.add_sheet(/datum/attribute_holder/sheet/job/strongslave)
		to_chat(H, span_achievementinteresting("I'm a strong slave, really strong!"))
		to_chat(H, span_info("Even a hard life has its upsides... Maybe..."))
	else
		H.attributes?.add_sheet(/datum/attribute_holder/sheet/job/aktnailer)

/datum/job/manhunter
	title = "Manhunter"
	department_head = list("Head of Personnel")
	faction = list(ROLE_AKT)
	total_positions = 8
	spawn_positions = 8
	supervisors = "he's just works."
	selection_color = "#38e38e"
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/manhunter

	display_order = JOB_DISPLAY_ORDER_OUTER
	departments_list = list(
		/datum/job_department/service,
		)

	job_flags = JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS

/datum/outfit/manhunter
	name = "Manhunter Uniform"

	uniform = /obj/item/clothing/under/darkshirt
	suit = /obj/item/clothing/suit/armor/vest/bulletproofer
	pants = /obj/item/clothing/pants/dark
	shoes = /obj/item/clothing/shoes/frogshoes
	head = /obj/item/clothing/head/aphexcap
	r_pocket = /obj/item/simcard
	id = /obj/item/cellphone/aphexphone

/datum/job/slavekeeper
	title = "Slavekeeper"
	department_head = list("Head of Personnel")
	faction = list(ROLE_AKT)
	total_positions = 1
	spawn_positions = 1
	supervisors = "he's just works."
	selection_color = "#38e38e"
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/slavekeeper

	display_order = JOB_DISPLAY_ORDER_OUTER
	departments_list = list(
		/datum/job_department/service,
		)

	job_flags = JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS

/datum/outfit/slavekeeper
	name = "Slavekeeper Uniform"

	uniform = /obj/item/clothing/under/darkshirt
	suit = /obj/item/clothing/suit/armor/vest/redjacket
	pants = /obj/item/clothing/pants/dark
	shoes = /obj/item/clothing/shoes/frogshoes
	gloves = /obj/item/clothing/gloves/reddyred

/datum/outfit/pinker
	name = "Pinker Uniform"

	head = /obj/item/clothing/head/helmet/space/stray
	suit = /obj/item/clothing/suit/space/stray
	uniform = /obj/item/clothing/under/pinker
	pants = /obj/item/clothing/pants/pinker
	id = /obj/item/key/podpol/woody/controller
	shoes =/obj/item/clothing/shoes/frogshoes