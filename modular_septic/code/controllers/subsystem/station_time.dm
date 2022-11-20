SUBSYSTEM_DEF(station_time)
	name = "Station time"
	flags = SS_NO_INIT|SS_NO_FIRE

// Byond is awesome and causes integer overflows with STATION_YEAR_OFFSET, keep that in mind
/datum/controller/subsystem/station_time/proc/get_station_realtime()
	// This always returns a stupid fuckoff huge number, use sparingly
	return world.realtime+GLOB.yeartime_offset+SSticker.gametime_offset

/datum/controller/subsystem/station_time/proc/get_station_year()
	return text2num(time2text(get_station_realtime(), "YYYY")) + STATION_YEAR_OFFSET
