/datum/component/radiation_countdown/Initialize(minimum_exposure_time)
	if (!CAN_IRRADIATE(parent))
		return COMPONENT_INCOMPATIBLE

	src.minimum_exposure_time = minimum_exposure_time

	time_added = world.time

	to_chat(parent, span_userdanger("The air around me feels warmer than normal..."))

	start_deletion_timer()
