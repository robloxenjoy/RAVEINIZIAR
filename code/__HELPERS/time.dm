GLOBAL_VAR_INIT(tod, FALSE)
GLOBAL_LIST_EMPTY(sunlights)

/proc/settod()
	var/time = station_time()
//	var/oldtod = GLOB.tod
	if(time >= SSnightshift.nightshift_start_time || time <= SSnightshift.nightshift_dawn_start)
		GLOB.tod = "night"
//		testing("set [tod]")
	if(time > SSnightshift.nightshift_dawn_start && time <= SSnightshift.nightshift_day_start)
		GLOB.tod = "dawn"
//		testing("set [tod]")
	if(time > SSnightshift.nightshift_day_start && time <= SSnightshift.nightshift_dusk_start)
		GLOB.tod = "day"
//		testing("set [tod]")
	if(time > SSnightshift.nightshift_dusk_start && time <= SSnightshift.nightshift_start_time)
		GLOB.tod = "dusk"
//		testing("set [tod]")
/*
	if(GLOB.todoverride)
		GLOB.tod = GLOB.todoverride
	if((GLOB.tod != oldtod) && !GLOB.todoverride && (GLOB.dayspassed>1)) //weather check on tod changes
		if(!GLOB.forecast)
			switch(GLOB.tod)
				if("dawn")
					if(prob(12))
						GLOB.forecast = "fog"
					if(prob(13))
						GLOB.forecast = "rain"
				if("day")
					if(prob(5))
						GLOB.forecast = "rain"
				if("dusk")
					if(prob(13))
						GLOB.forecast = "rain"
				if("night")
					if(prob(5))
						GLOB.forecast = "fog"
					if(prob(21))
						GLOB.forecast = "rain"

			if(GLOB.forecast == "rain")
				var/foundnd
				for(var/datum/weather/rain/R in SSweather.curweathers)
					foundnd = TRUE
				if(!foundnd)
					SSweather.run_weather(/datum/weather/rain, 1)
			if(GLOB.forecast == "fog")
				var/foundnd
				for(var/datum/weather/fog/R in SSweather.curweathers)
					foundnd = TRUE
				if(!foundnd)
					SSweather.run_weather(/datum/weather/fog, 1)

		else
			switch(GLOB.forecast) //end the weather now
				if("rain")
					if(GLOB.tod == "day")
						GLOB.forecast = "rainbow"
					else
						GLOB.forecast = null
				if("rainbow")
					GLOB.forecast = null
				if("fog")
					GLOB.forecast = null

	if(GLOB.tod != oldtod)
		if(GLOB.tod == "dawn")
			GLOB.dayspassed++
			if(GLOB.dayspassed == 8)
				GLOB.dayspassed = 1
		for(var/mob/living/player in GLOB.mob_list)
			if(player.stat != DEAD && player.client)
				player.do_time_change()
*/
	if(GLOB.tod)
		return GLOB.tod
	else
		testing("COULDNT FIND TOD [GLOB.tod] .. [time]")
		return null

//Returns the world time in english
/proc/worldtime2text()
	return gameTimestamp("hh:mm:ss", world.time)

/proc/time_stamp(format = "hh:mm:ss", show_ds)
	var/time_string = time2text(world.timeofday, format)
	return show_ds ? "[time_string]:[world.timeofday % 10]" : time_string

/proc/gameTimestamp(format = "hh:mm:ss", wtime=null)
	if(!wtime)
		wtime = world.time
	return time2text(wtime - GLOB.timezoneOffset, format)

/proc/station_time(display_only = FALSE, wtime=world.time)
	return ((((wtime - SSticker.round_start_time) * SSticker.station_time_rate_multiplier) + SSticker.gametime_offset) % 864000) - (display_only? GLOB.timezoneOffset : 0)

//MOJAVE MODULE OUTDOOR_EFFECTS -- BEGIN
//returns time diff of two times normalized to time_rate_multiplier
/proc/daytimeDiff(timeA, timeB)

	//if the time is less than station time, add 24 hours (MIDNIGHT_ROLLOVER)
	var/time_diff = timeA > timeB ? (timeB + 24 HOURS) - timeA : timeB - timeA
	return time_diff / SSticker.station_time_rate_multiplier // normalise with the time rate multiplier
//MOJAVE MODULE OUTDOOR_EFFECTS -- END

/proc/station_time_timestamp(format = "hh:mm:ss", wtime)
	return time2text(station_time(TRUE, wtime), format)

/proc/station_time_debug(force_set)
	if(isnum(force_set))
		SSticker.gametime_offset = force_set
		return
	SSticker.gametime_offset = rand(0, 864000) //hours in day * minutes in hour * seconds in minute * deciseconds in second
	if(prob(50))
		SSticker.gametime_offset = FLOOR(SSticker.gametime_offset, 3600)
	else
		SSticker.gametime_offset = CEILING(SSticker.gametime_offset, 3600)

//returns timestamp in a sql and a not-quite-compliant ISO 8601 friendly format
/proc/SQLtime(timevar)
	return time2text(timevar || world.timeofday, "YYYY-MM-DD hh:mm:ss")


GLOBAL_VAR_INIT(midnight_rollovers, 0)
GLOBAL_VAR_INIT(rollovercheck_last_timeofday, 0)
/proc/update_midnight_rollover()
	if (world.timeofday < GLOB.rollovercheck_last_timeofday) //TIME IS GOING BACKWARDS!
		GLOB.midnight_rollovers++
	GLOB.rollovercheck_last_timeofday = world.timeofday
	return GLOB.midnight_rollovers


///Returns a string day as an integer in ISO format 1 (Monday) - 7 (Sunday)
/proc/weekday_to_iso(ddd)
	switch (ddd)
		if (MONDAY)
			return 1
		if (TUESDAY)
			return 2
		if (WEDNESDAY)
			return 3
		if (THURSDAY)
			return 4
		if (FRIDAY)
			return 5
		if (SATURDAY)
			return 6
		if (SUNDAY)
			return 7

///Returns the first day of the given year and month in number format, from 1 (monday) - 7 (sunday).
/proc/first_day_of_month(year, month)
	// https://en.wikipedia.org/wiki/Zeller%27s_congruence
	var/m = month < 3 ? month + 12 : month // month (march = 3, april = 4...february = 14)
	var/K = year % 100 // year of century
	var/J = round(year / 100) // zero-based century
	// day 0-6 saturday to sunday:
	var/h = (1 + round(13 * (m + 1) / 5) + K + round(K / 4) + round(J / 4) - 2 * J) % 7
	//convert to ISO 1-7 monday first format
	return ((h + 5) % 7) + 1


//Takes a value of time in deciseconds.
//Returns a text value of that number in hours, minutes, or seconds.
/proc/DisplayTimeText(time_value, round_seconds_to = 0.1)
	var/second = FLOOR(time_value * 0.1, round_seconds_to)
	if(!second)
		return "right now"
	if(second < 60)
		return "[second] секунд[(second != 1)? "":""]"
	var/minute = FLOOR(second / 60, 1)
	second = FLOOR(MODULUS(second, 60), round_seconds_to)
	var/secondT
	if(second)
		secondT = " и [second] секунд[(second != 1)? "":""]"
	if(minute < 60)
		return "[minute] минут[(minute != 1)? "":""][secondT]"
	var/hour = FLOOR(minute / 60, 1)
	minute = MODULUS(minute, 60)
	var/minuteT
	if(minute)
		minuteT = " и [minute] минут[(minute != 1)? "":""]"
	if(hour < 24)
		return "[hour] час[(hour != 1)? "ов":""][minuteT][secondT]"
	var/day = FLOOR(hour / 24, 1)
	hour = MODULUS(hour, 24)
	var/hourT
	if(hour)
		hourT = " и [hour] час[(hour != 1)? "ов":""]"
	return "[day] день[(day != 1)? "":""][hourT][minuteT][secondT]"


/proc/daysSince(realtimev)
	return round((world.realtime - realtimev) / (24 HOURS))

/**
 * Converts a time expressed in deciseconds (like world.time) to the 12-hour time format.
 * the format arg is the format passed down to time2text() (e.g. "hh:mm" is hours and minutes but not seconds).
 * the timezone is the time value offset from the local time. It's to be applied outside time2text() to get the AM/PM right.
 */
/proc/time_to_twelve_hour(time, format = "hh:mm:ss", timezone = TIMEZONE_UTC)
	time = MODULUS(time + (timezone - GLOB.timezoneOffset) HOURS, 24 HOURS)
	var/am_pm = "AM"
	if(time > 12 HOURS)
		am_pm = "PM"
		if(time > 13 HOURS)
			time -= 12 HOURS // e.g. 4:16 PM but not 00:42 PM
	else if (time < 1 HOURS)
		time += 12 HOURS // e.g. 12.23 AM
	return "[time2text(time, format)] [am_pm]"
