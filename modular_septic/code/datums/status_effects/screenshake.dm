/datum/status_effect/thug_shaker
	id = "thugshaker"
	duration = -1
	tick_interval = 2
	alert_type = null
	var/intensity = 1

/datum/status_effect/thug_shaker/on_apply()
	. = ..()
	RegisterSignal(owner, COMSIG_LIVING_SET_COMBAT_MODE, .proc/check_thug_shaker)
	check_thug_shaker()

/datum/status_effect/thug_shaker/on_remove()
	. = ..()
	UnregisterSignal(owner, COMSIG_LIVING_SET_COMBAT_MODE)

/datum/status_effect/thug_shaker/proc/check_thug_shaker(mob/living/source, new_mode, silent = FALSE)
	SIGNAL_HANDLER

	if(owner.combat_mode && owner.client)
		shake_thug()
	else
		unshake_thug()

/datum/status_effect/thug_shaker/proc/shake_thug()
	animate(owner.client, pixel_y = intensity, time = intensity, loop = -1, flags = ANIMATION_RELATIVE)
	animate(pixel_y = -intensity, time = intensity, flags = ANIMATION_RELATIVE)

/datum/status_effect/thug_shaker/proc/unshake_thug()
	animate(owner.client)
