/datum/hacking/airlock
	holder_type = /obj/machinery/door/airlock
	proper_name = "Generic Airlock"
	hacking_actions = "airlock"

/datum/hacking/airlock/generate_hacking_actions()
	GLOB.hacking_actions_by_key[hacking_actions] = list(
		"Scan" = .proc/scan_wires,
		"Scramble" = .proc/scramble_lock,
		"Bolts" = .proc/bolt_airlock,
		"Open" = .proc/open_airlock,
		"Destroy" = .proc/destroy_holder,
	)
	return GLOB.hacking_actions_by_key[hacking_actions]

/datum/hacking/airlock/destroy_holder(mob/living/hackerman)
	var/obj/machinery/door/airlock/airlock = holder
	airlock.deconstruct(FALSE)

/datum/hacking/airlock/proc/scan_wires(atom/hackerman)
	holder.wires?.revealed_wires = TRUE

/datum/hacking/airlock/proc/bolt_airlock(atom/hackerman)
	var/obj/machinery/door/airlock/airlock = holder
	if(airlock.locked)
		airlock.unbolt()
	else
		airlock.bolt()

/datum/hacking/airlock/proc/open_airlock(atom/hackerman)
	var/obj/machinery/door/airlock/airlock = holder
	if(airlock.locked)
		airlock.unbolt()
	airlock.open()

/datum/hacking/airlock/proc/scramble_lock(atom/hackerman)
	var/obj/machinery/door/door = holder
	door.req_access = list(ACCESS_CENT_SPECOPS)
