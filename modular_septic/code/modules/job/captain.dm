/datum/job/captain
	total_positions = 0
	spawn_positions = 0
	outfit = /datum/outfit/job/captain/mayor

/datum/job/captain/get_captaincy_announcement(mob/living/captain)
	return "[title] [captain.real_name] on deck!"

/datum/job/captain/after_spawn(mob/living/spawned, client/player_client)
	. = ..()
	var/datum/bank_account/master_budget = SSeconomy.get_dep_account(ACCOUNT_MASTER)
	if(!master_budget)
		return

	spawned.mind?.add_memory(MEMORY_BUDGET, list(DETAIL_ACCOUNT_ID = master_budget.account_id), story_value = STORY_VALUE_NONE, memory_flags = MEMORY_FLAG_NOLOCATION)
	addtimer(CALLBACK(src, .proc/friendly_reminder, spawned, master_budget), 3 SECONDS)

/datum/job/captain/proc/friendly_reminder(mob/living/reminded, datum/bank_account/master_budget)
	if(QDELETED(reminded))
		return
	to_chat(reminded, span_warning("The master budget has an account ID of [master_budget.account_id]. <i>I should not forget that.</i>"))

/datum/outfit/job/captain/mayor
	name = "ZoomTech Captain"

	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/zoomtech
	gloves = /obj/item/clothing/gloves/combat/zoomtech
	uniform =  /obj/item/clothing/under/rank/captain/zoomtech
	suit = /obj/item/clothing/suit/armor/vest/capcarapace/zoomtech
	shoes = /obj/item/clothing/shoes/jackboots
	head = /obj/item/clothing/head/caphat/zoomtech
	backpack = /obj/item/storage/backpack/satchel/leather
	satchel = /obj/item/storage/backpack/satchel/leather
	duffelbag = /obj/item/storage/backpack/satchel/leather
	backpack_contents = list(/obj/item/melee/baton/telescopic=1, /obj/item/station_charter=1)

	skillchips = null
