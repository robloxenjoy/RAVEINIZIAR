/datum/antagonist/inborn
	combat_music = null
	show_to_ghosts = TRUE

/datum/antagonist/inborn/greet()
	to_chat(owner, span_notice("You are weak willet. You need create pure chaos... Also, you can find egg of halyab and eat this, for rebirth."))

/datum/antagonist/inborn/on_gain()
	. = ..()
	if(combat_music)
		owner.combat_music = pick(combat_music)

/datum/antagonist/denominator
	name = "Third Denomination Agent"
	roundend_category = "denominators"
	antagpanel_category = "Denominator"
	preview_outfit = /datum/outfit/denominator
	combat_music = 'modular_septic/sound/music/combat/deathmatch/denominator.ogg'
	show_to_ghosts = TRUE
	antag_hud_type = ANTAG_HUD_DENOMINATOR
	var/employer = "OcularTech"

/datum/team/denominator
	name = "Denominator"

/datum/antagonist/denominator/create_team(datum/team/denominator/new_team)

/datum/antagonist/denominator/greet()
	owner.current.playsound_local(get_turf(owner.current), 'modular_septic/sound/greetings/deno_greet.ogg',100,0, use_reverb = FALSE)
	to_chat(owner, span_notice("You are an Agent of the Third Denomination.\nIt's been a-long time since you've been sleeping. It's time to INVESTIGATE the Abandoned Warehouse with my TEAM. \
	And see what's going on."))

/datum/antagonist/denominator/on_gain()
	. = ..()
	ADD_TRAIT(owner.current, TRAIT_DENOMINATOR_ACCESS, SAFEZONE_ACCESS)
	var/datum/component/babble/babble = owner.current.GetComponent(/datum/component/babble)
	if(!babble)
		owner.current.AddComponent(/datum/component/babble, 'modular_septic/sound/voice/babble/denom.ogg')
	else
		babble.babble_sound_override = 'modular_septic/sound/voice/babble/denom.ogg'
		babble.volume = BABBLE_DEFAULT_VOLUME
		babble.duration = BABBLE_DEFAULT_DURATION

/datum/antagonist/denominator/shotgunner
	name = "Third Denomination Shotgunner"
	preview_outfit = /datum/outfit/denominator/shotgunner
	antag_hud_name = "deno_shotgunner"
	combat_music = 'modular_septic/sound/music/combat/deathmatch/denominator_shotgunner.ogg'

/datum/antagonist/denominator/shotgunner/on_gain()
	. = ..()
	ADD_TRAIT(owner, TRAIT_DENOMINATOR_REDSCREEN, MEGALOMANIAC_TRAIT)


