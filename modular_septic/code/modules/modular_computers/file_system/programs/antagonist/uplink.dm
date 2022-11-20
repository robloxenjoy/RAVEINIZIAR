/datum/computer_file/program/uplink
	filename = "limewire"
	filedesc = "LimeWire 1.2"
	category = PROGRAM_CATEGORY_MISC
	program_icon = "tasks"
	program_icon_state = "assign"
	requires_ntnet = FALSE
	available_on_ntnet = FALSE
	undeletable = FALSE
	size = 8
	var/stored_tc = 20
	var/datum/component/uplink/uplink

/datum/computer_file/program/uplink/Destroy()
	. = ..()
	if(uplink)
		qdel(uplink)
	uplink = null

/datum/computer_file/program/uplink/ui_interact(mob/user, datum/tgui/ui)
	return uplink?.ui_interact(user, ui)

/datum/computer_file/program/uplink/clone()
	var/datum/computer_file/program/uplink/temp = ..()
	if(uplink)
		temp.stored_tc = uplink.telecrystals
	else
		temp.stored_tc = stored_tc
	// Destroy the parent file
	qdel(src)
	return temp

/datum/computer_file/program/uplink/can_run(mob/user, loud, access_to_check, transfer, list/access)
	. = ..()
	if(.)
		var/existing_uplink = holder.GetComponent(/datum/component/uplink)
		if(existing_uplink && (existing_uplink != uplink))
			return FALSE

/datum/computer_file/program/uplink/run_program(mob/living/user)
	. = ..()
	if(!.)
		return
	undeletable = TRUE
	unsendable = TRUE
	var/existing_uplink = holder.GetComponent(/datum/component/uplink)
	// We add the component to the hard drive - I am mad.
	if(!existing_uplink)
		uplink = holder.AddComponent(/datum/component/uplink, FALSE, TRUE, UPLINK_TRAITORS, stored_tc)
	else
		uplink = existing_uplink
	if(uplink)
		RegisterSignal(uplink, COMSIG_PARENT_QDELETING, .proc/uplink_deleted, TRUE)
		if(holder?.holder)
			uplink.RegisterSignal(holder.holder, COMSIG_PARENT_ATTACKBY, /datum/component/uplink/proc/OnAttackBy)

/datum/computer_file/program/uplink/proc/uplink_deleted()
	SIGNAL_HANDLER

	UnregisterSignal(uplink, COMSIG_PARENT_QDELETING)
	stored_tc = uplink.telecrystals
	uplink = null

/datum/computer_file/program/uplink/proc/uplink_closed()
	SIGNAL_HANDLER

	if(uplink && holder?.holder)
		stored_tc = uplink.telecrystals
	kill_program(forced = TRUE)
