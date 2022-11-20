/proc/setup_efforts()
	. = list()
	for(var/datum/effort/effort as anything in init_subtypes(/datum/effort))
		.[effort.type] = effort
