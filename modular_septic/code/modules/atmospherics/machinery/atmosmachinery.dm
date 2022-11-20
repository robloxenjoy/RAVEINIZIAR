/obj/machinery/atmospherics/proc/warning_plasmafloyder(mob/floyder, used_verb = "unfastened")
	var/area/A = get_area(src)
	for(var/obj/machinery/airalarm/alarm in A.contents)
		if(alarm.is_operational && alarm.radio)
			var/name_result = "Unknown"
			var/mob/living/carbon/human/george_floyd = floyder
			if(istype(george_floyd))
				name_result = george_floyd.get_id_name("Unknown")
			alarm.radio.talk_into(alarm, "[capitalize(src.name)] [used_verb] at [get_area_name(alarm)] by [name_result].", channel = RADIO_CHANNEL_ENGINEERING)
			break
