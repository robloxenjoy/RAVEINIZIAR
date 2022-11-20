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
	r_hand = /obj/item/changeable_attacks/sword/kukri


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
		new_spawn.AddComponent(/datum/component/babble, 'modular_septic/sound/voice/babble/inborn.wav')
	else
		babble.babble_sound_override = 'modular_septic/sound/voice/babble/inborn.wav'
		babble.volume = BABBLE_DEFAULT_VOLUME
		babble.duration = BABBLE_DEFAULT_DURATION
