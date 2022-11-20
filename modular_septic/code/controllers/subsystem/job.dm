/datum/controller/subsystem/job
	chain_of_command = list(
		"Mayor" = 1,
		"Gatekeeper" = 2,
		"Coordinator" = 3
	)

/datum/controller/subsystem/job/setup_officer_positions()
	return

/datum/controller/subsystem/job/EquipRank(mob/living/equipping, datum/job/job, client/player_client)
	equipping.job = job.title

	SEND_SIGNAL(equipping, COMSIG_JOB_RECEIVED, job)

	equipping.mind?.set_assigned_role(job)

	if(player_client)
		var/introduction = span_infoplain("<b>I am [prefix_a_or_an(job.title)] [job.title].</b>")
		var/station_realtime = SSstation_time.get_station_realtime()
		var/YYYY = SSstation_time.get_station_year() // current year (numeric)
		var/DD = text2num(time2text(station_realtime, "DD")) //  current day (numeric)
		var/month = lowertext(time2text(station_realtime, "Month")) // current month (text)
		var/day_of_the_week = lowertext(time2text(station_realtime, "Day")) // current weekday (text)
		introduction += span_infoplain("\nToday is the [DD][st_nd_rd_th(DD)] of [month] of [YYYY].")
		introduction += span_infoplain("\nIt is [prefix_a_or_an(day_of_the_week)] [day_of_the_week].")
		if(ishuman(equipping))
			var/mob/living/carbon/human/equipping_human = equipping
			//assign random date of birth
			equipping_human.month_born = rand(JANUARY, DECEMBER)
			equipping_human.day_born = rand(1, days_in_month(equipping_human.month_born))
			var/birth_DD = equipping_human.day_born
			var/birthday_month = month_text(equipping_human.month_born)
			var/YYYY_born = YYYY-equipping_human.age
			var/lucky_or_unlucky = (job.departments_bitflags & DEPARTMENT_BITFLAG_UNPEOPLE ? "unlucky" : "lucky")
			if((birth_DD == DD) && (month == birthday_month))
				introduction += span_nicegreen(span_big("\nToday is my birthday!"))
				equipping_human.age++
				equipping_human.mind?.add_memory(memory_type = MEMORY_BIRTHDAY,
												extra_info = list(DETAIL_PROTAGONIST = equipping_human, DETAIL_BIRTHDAY_AGE = equipping_human.age), \
												story_value = STORY_VALUE_LEGENDARY, \
												memory_flags = MEMORY_FLAG_NOPERSISTENCE|MEMORY_SKIP_UNCONSCIOUS)
			introduction += span_infoplain("\nI was [lucky_or_unlucky] to be born [equipping_human.age] years ago, \
										on the [birth_DD][st_nd_rd_th(birth_DD)] of [birthday_month] of [YYYY_born].")
		to_chat(player_client, introduction)

	equipping.on_job_equipping(job)

	job.announce_job(equipping)

	if(player_client?.holder)
		if(CONFIG_GET(flag/auto_deadmin_players) || (player_client.prefs?.toggles & DEADMIN_ALWAYS))
			player_client.holder.auto_deadmin()
		else
			handle_auto_deadmin_roles(player_client, job.title)

	job.radio_help_message(equipping)

	if(ishuman(equipping))
		var/mob/living/carbon/human/wageslave = equipping
		wageslave.mind.add_memory(MEMORY_ACCOUNT, list(DETAIL_ACCOUNT_ID = wageslave.account_id), story_value = STORY_VALUE_NONE, memory_flags = MEMORY_FLAG_NOLOCATION)

	job.after_spawn(equipping, player_client)

/atom/JoinPlayerHere(mob/joining_mob, buckle)
	// By default, just place the mob on the same turf as the marker or whatever.
	joining_mob.forceMove(get_turf(src))
	// And update the attribute hud of course
	if(joining_mob.attributes)
		joining_mob.attributes.update_attributes()
