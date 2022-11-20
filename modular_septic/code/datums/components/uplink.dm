/datum/component/uplink/Initialize(_owner, _lockable, _enabled, uplink_flag, starting_tc)
	. = ..()
	if(.)
		return
	if(istype(parent, /obj/item/computer_hardware/hard_drive))
		UnregisterSignal(parent, COMSIG_PARENT_ATTACKBY)
		UnregisterSignal(parent, COMSIG_ITEM_ATTACK_SELF)

/datum/component/uplink/ui_status(mob/user, datum/ui_state/state)
	if(istype(parent, /obj/item/computer_hardware/hard_drive))
		var/obj/item/computer_hardware/hard_drive/hdd = parent
		if(istype(hdd.holder))
			return user.shared_ui_interaction(hdd.holder)
		else
			return UI_CLOSE
	else
		return ..()

// This is awful
/datum/component/uplink/ui_close(mob/user)
	if(istype(parent, /obj/item/computer_hardware/hard_drive))
		var/obj/item/computer_hardware/hard_drive/hdd = parent
		for(var/datum/computer_file/program/uplink/uplink_program in hdd.stored_files)
			if(uplink_program.uplink == src)
				uplink_program.uplink_closed()
