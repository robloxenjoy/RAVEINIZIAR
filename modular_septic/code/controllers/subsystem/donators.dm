SUBSYSTEM_DEF(donators)
	name = "Donators"
	flags = SS_NO_FIRE
	var/list/connected_donators = list()
	var/list/donator_to_ooc_color = list()
	var/list/donator_to_ooc_flag = list()

/datum/controller/subsystem/donators/Initialize(start_timeofday)
	. = ..()
	load_donator_flags()
	load_donator_colors()

/datum/controller/subsystem/donators/proc/add_donator(ckey = "", rank = "")
	if(!LAZYLEN(ckey))
		return
	connected_donators[ckey] = rank

/datum/controller/subsystem/donators/proc/load_donator_flags()
	var/list/flags = icon_states('modular_septic/icons/ui_icons/chat/donator.dmi')
	for(var/flag in flags)
		donator_to_ooc_flag[flag] = flag

/datum/controller/subsystem/donators/proc/load_donator_colors()
	var/list/unsanitized_donators = world.file2list('config/septic/donator_colors.txt')
	for(var/unsanitized_donator in unsanitized_donators)
		if(findtext(unsanitized_donator, "#", 1, 2))
			continue
		unsanitized_donator = replacetext(unsanitized_donator, " ", "")
		var/list/donator_and_color = splittext(unsanitized_donator, "=")
		donator_to_ooc_color[donator_and_color[1]] = donator_and_color[2]
