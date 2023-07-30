/datum/job/assistant
	title = "Doggoned"
	total_positions = 0
	spawn_positions = 0
	required_languages = null
	department_head = list("Head of Personnel")
	faction = list("neutral", "swarmer")
	supervisors = "he's just suffering."
	selection_color = "#596000"
	exp_granted_type = EXP_TYPE_CREW

	departments_list = list(
		/datum/job_department/cargo,
		)


	outfit = /datum/outfit/job/assistant/zoomtech

/datum/job/assistant/after_spawn(mob/living/spawned, client/player_client)
	. = ..()
	ADD_TRAIT(spawned, TRAIT_ILLITERATE, "[type]")
//	ADD_TRAIT(spawned, TRAIT_FRAGGOT, "[type]")
	spawned.apply_status_effect(/datum/status_effect/gakster_dissociative_identity_disorder)
	var/datum/disease/advance/doggoned_astheneia = new /datum/disease/advance/random(rand(1, 2), rand(1, 5))
	doggoned_astheneia.name = "Doggoned Astheneia"
	doggoned_astheneia.try_infect(spawned)

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
	backpack = null