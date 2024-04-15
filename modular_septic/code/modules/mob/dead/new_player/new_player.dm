/mob/dead/new_player/LateChoices()
	var/list/dat = list()
	if(SSlag_switch.measures[DISABLE_NON_OBSJOBS])
		dat += "<div class='notice red' style='font-size: 125%'>Only Observers may join at this time.</div><br>"
	dat += "<div class='notice'>Идёт раунд: [DisplayTimeText(world.time - SSticker.round_start_time)]</div>"
	if(SSshuttle.emergency)
		switch(SSshuttle.emergency.mode)
			if(SHUTTLE_ESCAPE)
				dat += "<div class='notice red'>The village has been evacuated.</div><br>"
			if(SHUTTLE_CALL)
				if(!SSshuttle.canRecall())
					dat += "<div class='notice red'>The village is currently undergoing evacuation procedures.</div><br>"
	for(var/datum/job/prioritized_job in SSjob.prioritized_jobs)
		if(prioritized_job.current_positions >= prioritized_job.total_positions)
			SSjob.prioritized_jobs -= prioritized_job
	dat += "<table><tr><td valign='top'>"
	var/column_counter = 0
	for(var/datum/job_department/department as anything in SSjob.joinable_departments)
		var/department_color = department.latejoin_color
		dat += "<fieldset style='width: 185px; border: 2px solid [department_color]; display: inline'>"
		dat += "<legend align='center' style='color: [department_color]'>[department.department_name]</legend>"
		var/list/dept_data = list()
		for(var/datum/job/job_datum as anything in department.department_jobs)
			if(IsJobUnavailable(job_datum.title, TRUE) != JOB_AVAILABLE)
				continue

			var/command_bold = ""
			if(job_datum.departments_bitflags & DEPARTMENT_BITFLAG_COMMAND)
				command_bold = " command"

			if(job_datum in SSjob.prioritized_jobs)
				dept_data += "<a class='job[command_bold]' href='byond://?src=[REF(src)];SelectedJob=[job_datum.title]'><span class='priority'>[job_datum.title] ([job_datum.current_positions])</span></a>"
			else
				dept_data += "<a class='job[command_bold]' href='byond://?src=[REF(src)];SelectedJob=[job_datum.title]'>[job_datum.title] ([job_datum.current_positions])</a>"
		if(!length(dept_data))
			dept_data += "<span class='nopositions'>No positions open.</span>"
		dat += dept_data.Join()
		dat += "</fieldset><br>"
		column_counter++
		if(column_counter > 0 && !(column_counter % 3))
			dat += "</td><td valign='top'>"
	dat += "</td></tr></table></center>"
	dat += "</div></div>"
	var/datum/browser/popup = new(src, "latechoices", "Выбираю роль", 680, 580)
	popup.add_stylesheet("playeroptions", 'html/browser/playeroptions.css')
	popup.set_content(jointext(dat, ""))
	popup.open(FALSE) // 0 is passed to open so that it doesn't use the onclose() proc

/mob/dead/new_player/verb/playthis()
	set name = "Играть"
	set category = "OOC"

	if(!isnewplayer(src))
		return
	if(!client)
		return
	if(client.ready_char)
		return
	client.name_ch = pick("Харк", "Безбокий", "Мор", "Нок", "Нокс", "Гарретт", "Эльвир", "Харамец", "Анклав", "Арсен")
	client.age_ch = rand(18, 100)
	client.ready_char = TRUE
	alert("Я вспомнил кто я!")
	chooseRole()

/mob/dead/new_player/proc/chooseRole()
	if(!isnewplayer(src))
		return
	if(!client)
		return
	var/rolevich = input("Стоп, а какая роль?", "") as text
	switch(rolevich)
		if("Капнобатай")
			client.role_ch = "kapno"
		else
			alert("Непонятно. Роль обычного капнобатая.")
			client.role_ch = "kapno"
	dolboEbism()

/mob/dead/new_player/proc/dolboEbism()
	alert("Может другую роль?",,"Играем уже!","Давай-ка другую")
	if("Играем уже!")
		for(var/obj/effect/landing/spawn_point as anything in GLOB.jobber_list)
			if(spawn_point.name == client.role_ch)
				var/mob/living/carbon/human/character = new(spawn_point.loc)
				character.set_species(/datum/species/human)
				character.gender = MALE
				character.genitals = "Male"
				character.real_name = client.name_ch
				character.age = client.age_ch
				character.truerole = "Капнобатай"
				character.attributes?.add_sheet(/datum/attribute_holder/sheet/job/venturer)
				mind.active = FALSE
				mind.transfer_to(character)
				mind.set_original_character(character)
				character.key = key
				qdel(src)
				character.stop_sound_channel(CHANNEL_LOBBYMUSIC)
				var/area/joined_area = get_area(character.loc)
				if(joined_area)
					joined_area.on_joining_game(character)
				to_chat(character, span_notice("Я продолжаю искать свой верный путь."))
	else
		client.ready_char = FALSE
		return FALSE
