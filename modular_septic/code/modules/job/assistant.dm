/datum/job/assistant
	title = "Autism"
	total_positions = 0
	spawn_positions = 0
	required_languages = null

	outfit = /datum/outfit/job/assistant/zoomtech

/datum/job/assistant/after_spawn(mob/living/spawned, client/player_client)
	. = ..()
	ADD_TRAIT(spawned, TRAIT_ILLITERATE, "[type]")

/datum/outfit/job/assistant/zoomtech
	name = "Stowaway"

	uniform = /obj/item/clothing/under/color/grey/ancient
	id = null
	belt = null

	skillchips = null
