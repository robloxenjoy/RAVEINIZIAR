#define AUTOFIRE_MOUSEUP 0
#define AUTOFIRE_MOUSEDOWN 1

/datum/component/automatic_fire

/datum/component/automatic_fire/Initialize(_autofire_shot_delay)
	. = ..()
	var/obj/item/gun = parent
	if(istype(gun, /obj/item/gun/ballistic/automatic))
		var/firemode_exists = FALSE
		for(var/action in gun.actions)
			if(istype(action, /datum/action/item_action/toggle_firemode))
				firemode_exists = TRUE
				break
		if(!firemode_exists)
			new /datum/action/item_action/toggle_firemode(gun)

/datum/component/automatic_fire/start_autofiring()
	if(autofire_stat == AUTOFIRE_STAT_FIRING)
		return
	autofire_stat = AUTOFIRE_STAT_FIRING

	clicker.mouse_override_icon = 'modular_septic/icons/effects/mouse_pointers/weapon_pointer_auto.dmi'
	shooter.update_mouse_pointer()

	//See mouse_status definition for the reason for this
	if(mouse_status == AUTOFIRE_MOUSEUP)
		RegisterSignal(clicker, COMSIG_CLIENT_MOUSEUP, .proc/on_mouse_up)
		mouse_status = AUTOFIRE_MOUSEDOWN

	RegisterSignal(shooter, COMSIG_MOB_SWAP_HANDS, .proc/stop_autofiring)
	if(isgun(parent))
		var/obj/item/gun/gun = parent
		//This is needed because the minigun has a do_after before firing and signals are async
		if(!gun.on_autofire_start(shooter))
			stop_autofiring()
			return
	if(autofire_stat != AUTOFIRE_STAT_FIRING)
		return //Things may have changed while on_autofire_start() was being processed, due to do_after's sleep.

	if(!process_shot()) //First shot is processed instantly.
		return //If it fails, such as when the gun is empty, then there's no need to schedule a second shot.

	START_PROCESSING(SSprojectiles, src)
	RegisterSignal(clicker, COMSIG_CLIENT_MOUSEDRAG, .proc/on_mouse_drag)

/datum/component/automatic_fire/stop_autofiring(datum/source, atom/object, turf/location, control, params)
	if(autofire_stat != AUTOFIRE_STAT_FIRING)
		return
	STOP_PROCESSING(SSprojectiles, src)
	autofire_stat = AUTOFIRE_STAT_ALERT
	if(clicker)
		clicker.mouse_override_icon = null
		clicker.mouse_pointer_icon = clicker.mouse_override_icon
		UnregisterSignal(clicker, COMSIG_CLIENT_MOUSEDRAG)
	if(!QDELETED(shooter))
		UnregisterSignal(shooter, COMSIG_MOB_SWAP_HANDS)
		shooter.update_mouse_pointer()
	target = null
	target_loc = null
	mouse_parameters = null

#undef AUTOFIRE_MOUSEUP
#undef AUTOFIRE_MOUSEDOWN
