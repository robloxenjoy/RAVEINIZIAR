/datum/job/assistant
	title = "Doggoned"
	total_positions = 45
	spawn_positions = 2
	required_languages = null

	outfit = /datum/outfit/job/assistant/zoomtech

/datum/job/assistant/after_spawn(mob/living/spawned, client/player_client)
	. = ..()
	ADD_TRAIT(spawned, TRAIT_ILLITERATE, "[type]")
	ADD_TRAIT(spawned, TRAIT_FRAGGOT, "[type]")
	spawned.apply_status_effect(/datum/status_effect/gakster_dissociative_identity_disorder)

/datum/outfit/job/assistant/zoomtech
	name = "Stowaway"

	uniform = null
	id = null
	shoes = null
	suit = null
	gloves = null
	head = null
	back = null
//	r_hand = null
//	l_hand = null

	ears = null
	id = null
	belt = null
	l_pocket = null
	r_pocket = null

	skillchips = null
