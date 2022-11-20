// Things that are already irradiated can get irradiated again
/datum/controller/subsystem/radiation/pulse(atom/source, datum/radiation_pulse_information/pulse_information)
	var/list/cached_rad_insulations = list()

	for(var/atom/movable/target in range(pulse_information.max_range, source))
		//We should only irradiate ourselves once
		if(!can_irradiate_basic(target))
			continue
		if((target == source) && target.GetComponent(/datum/component/irradiated))
			continue

		var/current_insulation = RAD_NO_INSULATION
		for(var/turf/turf_in_between in get_line(source, target) - get_turf(source))
			var/insulation = cached_rad_insulations[turf_in_between]
			if(isnull(insulation))
				insulation = turf_in_between.rad_insulation
				for (var/atom/on_turf as anything in turf_in_between.contents)
					insulation *= on_turf.rad_insulation
				cached_rad_insulations[turf_in_between] = insulation

			current_insulation *= insulation
			if(current_insulation <= pulse_information.threshold)
				break

		SEND_SIGNAL(target, COMSIG_IN_RANGE_OF_IRRADIATION, pulse_information, current_insulation)

		if(current_insulation <= pulse_information.threshold)
			continue

		var/irradiation_result = SEND_SIGNAL(target, COMSIG_IN_THRESHOLD_OF_IRRADIATION, pulse_information)
		if(irradiation_result & CANCEL_IRRADIATION)
			continue
		else if(pulse_information.minimum_exposure_time && !(irradiation_result & SKIP_MINIMUM_EXPOSURE_TIME_CHECK))
			target.AddComponent(/datum/component/radiation_countdown, pulse_information.minimum_exposure_time)
			continue

		if(!prob(pulse_information.chance))
			continue

		if(irradiate_after_basic_checks(target))
			target.investigate_log("was irradiated by [source].", INVESTIGATE_RADIATION)

/datum/controller/subsystem/radiation/can_irradiate_basic(atom/target)
	if(!CAN_IRRADIATE(target))
		return FALSE

	if(HAS_TRAIT(target, TRAIT_IRRADIATED) && !HAS_TRAIT(target, TRAIT_BYPASS_EARLY_IRRADIATED_CHECK))
		return FALSE

	if(HAS_TRAIT(target, TRAIT_RADIMMUNE))
		return FALSE

	return TRUE

/datum/controller/subsystem/radiation/irradiate_after_basic_checks(atom/target)
	if(ishuman(target) && wearing_rad_protected_clothing(target))
		return FALSE

	target.AddComponent(/datum/component/irradiated)
	return TRUE

/datum/controller/subsystem/radiation/irradiate(atom/target)
	if(!can_irradiate_basic(target))
		return FALSE

	irradiate_after_basic_checks(target)
	return TRUE
