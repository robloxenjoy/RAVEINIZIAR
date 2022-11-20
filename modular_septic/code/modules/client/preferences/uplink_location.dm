/datum/preference/choiced/uplink_location

/datum/preference/choiced/uplink_location/create_default_value()
	return UPLINK_SDCARD

/datum/preference/choiced/uplink_location/init_possible_values()
	return list(UPLINK_SDCARD)

/datum/preference/choiced/uplink_location/is_accessible(datum/preferences/preferences)
	return FALSE
