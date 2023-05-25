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
	faction = list("neutral", "swarmer")
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
	faction = list("neutral", "swarmer")
	total_positions = 64
	spawn_positions = 64
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
	r_pocket = /obj/item/shard/crystal/blue
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
	var/result = rand(1, 9)
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

		if(3)
			venturer_type = "venturermeatwarrior"
			neck = /obj/item/clothing/neck/leather_cloak
			suit = /obj/item/clothing/suit/armor/vest/leatherbreast
			gloves = /obj/item/clothing/gloves/leathercool
			to_chat(H, span_achievementinteresting("I'm a meat warrior!"))
			to_chat(H, span_info("Maybe I'm an occultist, maybe I'm a maniac. But I have an equipment."))

		if(4)
			venturer_type = "venturervillageowner"
			neck = /obj/item/clothing/neck/noble_cloak
//			uniform = /obj/item/clothing/under/rank/captain/zoomtech
			uniform = /obj/item/clothing/under/aktraiment
			pants = /obj/item/clothing/pants/aktliver
			r_pocket = /obj/item/shard/crystal/purple
			glasses = /obj/item/clothing/glasses/hud/security/sunglasses/zoomtech
			belt = /obj/item/knife/combat/goldenmisericorde
			to_chat(H, span_achievementinteresting("I'm a village owner!"))
			to_chat(H, span_info("Finally got out of the turmoil with the village and can breathe fresh air."))

		if(5)
			venturer_type = "venturergardener"
			l_hand = /obj/item/storage/backpack/basket
			belt = /obj/item/changeable_attacks/slashstab/knife/small/steel
			to_chat(H, span_achievementinteresting("I'm a gardener!"))
			to_chat(H, span_info("I think I'm the most boring... Maybe."))

		if(6)
			venturer_type = "venturerbandit"
			belt = /obj/item/changeable_attacks/slashstab/knife/small/steel
			to_chat(H, span_achievementinteresting("I am a bandit!"))
			to_chat(H, span_info("Hehe, how evil I am!"))

		if(7)
			venturer_type = "venturerlordbandit"
			neck = /obj/item/clothing/neck/bear_cloak
			belt = /obj/item/changeable_attacks/slashstab/sabre/small/steel/hilt
			to_chat(H, span_achievementinteresting("I am the leader of the bandits!"))
			to_chat(H, span_info("I need to find other bandits, and maybe start something insidious."))

		if(8)
			venturer_type = "venturergoer"
			l_pocket = /obj/item/food/gelatine/mesopelagic
			suit = /obj/item/clothing/suit/armor/vest/chainmail/steel
			belt = /obj/item/changeable_attacks/slashstabbash/sword/medium/steel
			to_chat(H, span_achievementinteresting("I am a goer!"))
			to_chat(H, span_info("I came here by solicitation!"))

		if(9)
			venturer_type = "venturerthief"
			neck = /obj/item/clothing/neck/darkproject
			l_hand = /obj/item/lamp/self_lit
			r_pocket = /obj/item/akt/lockpick/square
			l_pocket = /obj/item/akt/lockpick/triangle
			if(prob(75))
				glasses = /obj/item/clothing/glasses/sunglasses/sungrasses
			to_chat(H, span_achievementinteresting("I am a thief!"))
			to_chat(H, span_info("Well, shall we begin?"))

/datum/outfit/venturer/equip(mob/living/carbon/human/H)
	..()
	if(venturer_type == "woodcutter")
		H.attributes?.add_sheet(/datum/attribute_holder/sheet/job/venturer)
	if(venturer_type == "venturertrue")
		H.attributes?.add_sheet(/datum/attribute_holder/sheet/job/venturertrue)
	if(venturer_type == "venturermeatwarrior")
		H.attributes?.add_sheet(/datum/attribute_holder/sheet/job/venturermeatwarrior)
	if(venturer_type == "venturervillageowner")
		H.attributes?.add_sheet(/datum/attribute_holder/sheet/job/venturervillageowner)
	if(venturer_type == "venturergardener")
		H.attributes?.add_sheet(/datum/attribute_holder/sheet/job/venturergardener)
	if(venturer_type == "venturerlordbandit")
		H.attributes?.add_sheet(/datum/attribute_holder/sheet/job/venturermeatwarrior)
	if(venturer_type == "venturerbandit")
		H.attributes?.add_sheet(/datum/attribute_holder/sheet/job/venturer)
	if(venturer_type == "venturergoer")
		H.attributes?.add_sheet(/datum/attribute_holder/sheet/job/venturergoer)
	if(venturer_type == "venturerthief")
		H.attributes?.add_sheet(/datum/attribute_holder/sheet/job/venturerthief)

/datum/job/chaot
	title = "Chaot"
	department_head = list("Head of Personnel")
	faction = list("neutral", "swarmer")
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
	r_pocket = /obj/item/shard/crystal/green
	id = /obj/item/keycard/chaot
//	l_hand = /obj/item/cellphone
//	belt = /obj/item/crowbar
//	l_pocket = /obj/item/simcard
//	back = /obj/item/storage/backpack/satchel/itobe
//	backpack_contents = list(
//		/obj/item/reagent_containers/hypospray/medipen/retractible/blacktar = 1,
//		/obj/item/flashlight/seclite = 1,
//	)
//	gloves = /obj/item/clothing/gloves/color/black
	shoes = /obj/item/clothing/shoes/laceup

/datum/job/aktliver
	title = "Akt Liver"
	department_head = list("Head of Personnel")
	faction = list("neutral", "swarmer")
	total_positions = 30
	spawn_positions = 30
	supervisors = "living in Akt!"
	selection_color = "#8e4a57"
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/liver

	display_order = JOB_DISPLAY_ORDER_OUTER
	departments_list = list(
		/datum/job_department/service,
		)

	job_flags = JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS

/datum/outfit/liver
	name = "Akt Liver Uniform"

	uniform = /obj/item/clothing/under/aktraiment
	pants = /obj/item/clothing/pants/aktliver
	r_pocket = /obj/item/keycard/akt/lair
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
	shoes = /obj/item/clothing/shoes/barhatki

/datum/job/aktassertor
	title = "Akt Assertor"
	department_head = list("Head of Personnel")
	faction = list("neutral", "swarmer")
	total_positions = 10
	spawn_positions = 10
	supervisors = "living in Akt!"
	selection_color = "#8e4a57"
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/assertor

	display_order = JOB_DISPLAY_ORDER_OUTER
	departments_list = list(
		/datum/job_department/service,
		)

	job_flags = JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS

/datum/outfit/assertor
	name = "Akt Assertor Uniform"

	uniform = /obj/item/clothing/under/aktraiment
	pants = /obj/item/clothing/pants/aktliver
	r_pocket = /obj/item/keycard/akt/hut
	suit = /obj/item/clothing/suit/armor/vest/chainmail/steel
	belt = /obj/item/changeable_attacks/slashstabbash/sword/medium/steel
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
	shoes = /obj/item/clothing/shoes/barhatki

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
