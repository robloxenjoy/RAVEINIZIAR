/datum/job/assistant
	title = "Bum"

	outfit = /datum/outfit/job/assistant/zoomtech

/datum/job/assistant/after_spawn(mob/living/spawned, client/player_client)
	. = ..()
	ADD_TRAIT(spawned, TRAIT_ILLITERATE, "[type]")
//	ADD_TRAIT(spawned, TRAIT_FRAGGOT, "[type]")
	spawned.apply_status_effect(/datum/status_effect/gakster_dissociative_identity_disorder)
	var/datum/disease/advance/doggoned_astheneia = new /datum/disease/advance/random(rand(1, 2), rand(1, 5))
	doggoned_astheneia.name = "Bum Astheneia"
	doggoned_astheneia.try_infect(spawned)

/datum/outfit/job/assistant/zoomtech
	name = "Stowaway"

	uniform = /obj/item/clothing/under/color/grey/ancient
	id = null
	belt = null

	skillchips = null