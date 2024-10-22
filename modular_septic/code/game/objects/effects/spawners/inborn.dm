/obj/effect/mob_spawn/human/inborn
	name = "inborn's spawner"
	desc = "wow this is fantastic!"
	random = TRUE
	icon = 'icons/obj/lavaland/survival_pod.dmi'
	icon_state = "bed"
	mob_name = "a black criminal"
	roundstart = FALSE
	death = FALSE
	anchored = TRUE
	density = FALSE
	show_flavour = FALSE
	outfit = /datum/outfit/inborn
	mob_species = /datum/species/inborn
	uses = 2

/datum/outfit/inborn
	name = "Inborn uniform"

	uniform = /obj/item/clothing/under/stray
	r_pocket = /obj/item/keycard/inborn
	gloves = /obj/item/clothing/gloves/color/black
	shoes = /obj/item/clothing/shoes/jackboots
//	r_hand = /obj/item/changeable_attacks/sword/kukri


/obj/effect/mob_spawn/human/inborn/attack_ghost(mob/user)
	if(!SSticker.HasRoundStarted() || !loc || !ghost_usable)
		return
	if(!radial_based)
		var/ghost_role = tgui_alert(usr, "Become a vicious creature?",, list("Yes", "No"))
		do_sparks(3, FALSE, user)
		if(ghost_role != "Yes" || !loc || QDELETED(user))
			return
	if(!(GLOB.ghost_role_flags & GHOSTROLE_SPAWNER) && !(flags_1 & ADMIN_SPAWNED_1))
		to_chat(user, span_warning("An admin has temporarily disabled non-admin ghost roles!"))
		return
	if(!uses)
		to_chat(user, span_warning("This spawner is out of charges!"))
		return
	if(is_banned_from(user.key, banType))
		to_chat(user, span_warning("You are jobanned!"))
		return
	if(!allow_spawn(user))
		return
	if(QDELETED(src) || QDELETED(user))
		return
	log_game("[key_name(user)] became [mob_name]")
	create(user)

/obj/effect/mob_spawn/human/inborn/equip(mob/living/carbon/human/H)
	. = ..()
	H.apply_status_effect(/datum/status_effect/thug_shaker)

/obj/effect/mob_spawn/human/inborn/special(mob/living/new_spawn)
	. = ..()
	new_spawn.fully_replace_character_name(new_spawn.real_name, "Inborn")
	new_spawn.mind.add_antag_datum(/datum/antagonist/inborn)
	var/datum/component/babble/babble = new_spawn.GetComponent(/datum/component/babble)
	if(!babble)
		new_spawn.AddComponent(/datum/component/babble, 'modular_septic/sound/voice/babble/inborn.ogg')
	else
		babble.babble_sound_override = 'modular_septic/sound/voice/babble/inborn.ogg'
		babble.volume = BABBLE_DEFAULT_VOLUME
		babble.duration = BABBLE_DEFAULT_DURATION
/*
/obj/effect/mob_spawn/human/weakwillet
	name = "Weak Willet Spawner"
	desc = "Wow this is fantastic!"
	short_desc = "Particle of chaos."
	random = FALSE
	icon = 'icons/obj/lavaland/survival_pod.dmi'
	icon_state = "willete"
//	mob_name = "a black criminal"
//	roundstart = TRUE
	death = FALSE
	anchored = TRUE
	density = FALSE
	show_flavour = FALSE
	permanent = FALSE
	instant = TRUE
	outfit = FALSE
	ghost_usable = TRUE
	mob_species = /datum/species/weakwillet
	uses = -1

/obj/effect/mob_spawn/human/weakwillet/special(mob/living/carbon/human/new_spawn)
	. = ..()
	new_spawn.fully_replace_character_name(new_spawn.real_name, "Weak Willet")
	new_spawn.grant_all_languages(TRUE, TRUE, TRUE, LANGUAGE_WEAKWILLET)
	var/datum/component/babble/babble = new_spawn.GetComponent(/datum/component/babble)
	if(!babble)
		new_spawn.AddComponent(/datum/component/babble, 'modular_septic/sound/voice/babble/inborn.ogg')
	else
		babble.babble_sound_override = 'modular_septic/sound/voice/babble/inborn.ogg'
		babble.volume = BABBLE_DEFAULT_VOLUME
		babble.duration = BABBLE_DEFAULT_DURATION

	if(prob(5))
		new_spawn.attributes.add_sheet(/datum/attribute_holder/sheet/job/strongwillet)
		new_spawn.height = HUMAN_HEIGHT_TALLEST
		ADD_TRAIT(new_spawn, TRAIT_GIANT, GENETIC_MUTATION)
		if(prob(65))
			new_spawn.put_in_hands(new /obj/item/changeable_attacks/slashstabbash/axe/big/steel(new_spawn.drop_location()), FALSE)
	else
		new_spawn.attributes.add_sheet(/datum/attribute_holder/sheet/job/weakwillet)
		new_spawn.height = HUMAN_HEIGHT_MEDIUM

//	new_spawn.attributes.update_attributes()

/obj/effect/mob_spawn/human/weakwillet/attack_ghost(mob/user)
	if(!SSticker.HasRoundStarted() || !loc || !ghost_usable)
		return
	if(!radial_based)
		var/ghost_role = tgui_alert(usr, "Become a weak willet?",, list("Sure", "No!"))
		do_sparks(3, FALSE, user)
		if(ghost_role != "Yes" || !loc || QDELETED(user))
			return
	if(!(GLOB.ghost_role_flags & GHOSTROLE_SPAWNER) && !(flags_1 & ADMIN_SPAWNED_1))
		to_chat(user, span_warning("An admin has temporarily disabled non-admin ghost roles!"))
		return
	if(!uses)
		to_chat(user, span_warning("This spawner is out of charges!"))
		return
	if(is_banned_from(user.key, banType))
		to_chat(user, span_warning("You are jobanned!"))
		return
	if(!allow_spawn(user))
		return
	if(QDELETED(src) || QDELETED(user))
		return
	log_game("[key_name(user)] became [mob_name]")
	create(user)

/obj/effect/mob_spawn/human/weakwillet/Initialize(mapload)
	. = ..()
	if(ghost_usable)
//		SSpoints_of_interest.make_point_of_interest(src)
		LAZYADD(GLOB.mob_spawners[name], src)

/obj/effect/mob_spawn/human/vampyre
	name = "Vampyric"
	desc = "Wow this is fantastic!"
	random = FALSE
	icon = 'icons/obj/lavaland/survival_pod.dmi'
	icon_state = "willete"
	death = FALSE
	anchored = TRUE
	density = FALSE
	show_flavour = FALSE
	permanent = FALSE
	instant = TRUE
	outfit = FALSE
	mob_species = /datum/species/vampire
	uses = 5

/obj/effect/mob_spawn/human/vampyre/special(mob/living/carbon/human/new_spawn)
	. = ..()
	new_spawn.fully_replace_character_name(new_spawn.real_name, "Blackskinned Vampyre")
	new_spawn.left_eye_color = "#a90000"
	new_spawn.right_eye_color = "#a90000"
	var/datum/component/babble/babble = new_spawn.GetComponent(/datum/component/babble)
	if(!babble)
		new_spawn.AddComponent(/datum/component/babble, 'modular_pod/sound/voice/vampvoice.ogg')
	else
		babble.babble_sound_override = 'modular_pod/sound/voice/vampvoice.ogg'
		babble.volume = BABBLE_DEFAULT_VOLUME
		babble.duration = BABBLE_DEFAULT_DURATION

	new_spawn.attributes.add_sheet(/datum/attribute_holder/sheet/job/venturergoer)
	new_spawn.height = HUMAN_HEIGHT_TALLEST

	new_spawn.attributes.update_attributes()
*/