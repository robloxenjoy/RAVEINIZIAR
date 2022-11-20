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
		/datum/job_department/outer,
		)

//	family_heirlooms = list(/obj/item/pickaxe/mini, /obj/item/shovel)
//	rpg_title = "Adventurer"
	job_flags = JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS


/datum/outfit/venturer
	name = "Venturer Uniform"

	uniform = /obj/item/clothing/under/venturerclassic
	r_hand = /obj/item/shard/crystal/blue
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


/datum/outfit/chaot
	name = "Chaot Uniform"

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
		/datum/job_department/outer,
		)

	job_flags = JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS

/datum/outfit/liver
	name = "Akt Liver Uniform"

	uniform = /obj/item/clothing/under/venturerclassic
	r_hand = /obj/item/shard/crystal/blue
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
