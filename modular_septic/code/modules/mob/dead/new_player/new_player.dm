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
	if(client.should_not_play)
		alert("Ой, как жаль... Я не могу продолжать свой путь.")
		return
	if(SSticker.current_state < GAME_STATE_PLAYING)
		alert("Игрушка пока не началась.")
		return
	client.name_ch = name_generate()
	if(prob(70))
		client.age_ch = rand(18, 40)
	else
		client.age_ch = rand(18, 100)
	client.ready_char = TRUE
	alert("Я вспомнил кто я!")
	chooseRole()

/mob/dead/new_player/proc/name_generate()
	var/special_name
	var/second_thing = null
	var/third_thing = null
	var/first_thing = pick("Харк", "Безбокий", "Мор", "Нок", "Нокс", "Гарретт", "Эльвир", "Арсен", "Харамец", "Анклав", "Флакон", "Торнер", "Вэб", "Хвакс", "Койлер", "Бойд", "Хэкс", "Гекс", "Сакрец")
	special_name = "[first_thing]"
	if(prob(40))
		second_thing = pick("Мун", "Стоун", "Блэк", "Блок")
		special_name = "[first_thing] [second_thing]"
	if(prob(10))
		third_thing = pick("I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X")
		if(second_thing)
			special_name = "[first_thing] [second_thing] [third_thing]"
		else
			special_name = "[first_thing] [third_thing]"
	return special_name

/mob/dead/new_player/proc/chooseRole()
	if(!isnewplayer(src))
		return
	if(!client)
		return
	var/rolevich = input("Стоп, а какая роль?", "") as text
	switch(rolevich)
		if("Капнобатай")
			client.role_ch = "капнобатай"
		if("Конченный")
			client.role_ch = "конченный"
		if("Бог СВО")
			if(GLOB.world_deaths_crazy < 20)
				alert("Недостаточно смертей в мире.")
				client.ready_char = FALSE
				return
			client.role_ch = "бог сво"
		else
			alert("Непонятно. Роль обычного капнобатая.")
			client.role_ch = "капнобатай"
	dolboEbism()

/mob/dead/new_player/proc/dolboEbism()
	var/crazyalert = alert("А может была другая роль?",,"Продолжаем уже!","Да вроде другая...")
	switch(crazyalert)
		if("Продолжаем уже!")
			for(var/obj/effect/landing/spawn_point as anything in GLOB.jobber_list)
				if(client)
					if(spawn_point.name == client.role_ch)
						if(spawn_point.spending)
							if(spawn_point.spending <= 0)
								alert("Больше нет слотов.")
								client.ready_char = FALSE
								return FALSE
							else
								spawn_point.spending--
						var/mob/living/carbon/human/character = new(spawn_point.loc)
						character.set_species(/datum/species/human)
						character.gender = MALE
						character.genitals = GENITALS_MALE
						character.body_type = MALE
						character.chat_color = ""
						character.real_name = client.name_ch
						character.name = character.real_name
						character.age = client.age_ch
						character.handed_flags = DEFAULT_HANDEDNESS
						character.fully_heal(TRUE)

						var/eye_coloring = pick("#000000", "#1f120f")

						switch(client.role_ch)
							if("капнобатай")
								character.truerole = "Капнобатай"
								character.pod_faction = "капнобатай"
								character.hairstyle = "Bedhead 2"
								character.facial_hairstyle = "Shaved"
								character.hair_color = pick("#000000", "#1f120f", "#d7d49f")
							if("конченный")
								character.truerole = "Конченный"
								character.pod_faction = "конченный"
								character.hairstyle = "Bald"
								character.facial_hairstyle = "Shaved"
								eye_coloring = "#c30000"
	//							character.hair_color = pick("#000000", "#1f120f", "#d7d49f")
						switch(character.truerole)
							if("Капнобатай")
								var/mutable_appearance/appearance = mutable_appearance('modular_septic/icons/mob/human/overlays/signs.dmi', "kapno", ROLES_LAYER)
								character.add_overlay(appearance)
								character.attributes?.add_sheet(/datum/attribute_holder/sheet/job/kapno)
								if(prob(10))
									character.equipOutfit(/datum/outfit/kapnofather)
									character.special_zvanie = "Отец Капнобатаев"
								else
									character.equipOutfit(/datum/outfit/kapno)
							if("Конченный")
								var/mutable_appearance/appearance = mutable_appearance('modular_septic/icons/mob/human/overlays/signs.dmi', "konch", ROLES_LAYER)
								character.add_overlay(appearance)
								character.attributes?.add_sheet(/datum/attribute_holder/sheet/job/konch)
								if(prob(10))
									character.equipOutfit(/datum/outfit/mostkonch)
									character.special_zvanie = "Самый Конченный"
								else
									character.equipOutfit(/datum/outfit/konch)
							if("Бог СВО")
								character.attributes?.add_sheet(/datum/attribute_holder/sheet/job/svogod)
								character.equipOutfit(/datum/outfit/svogod)
						for(var/obj/item/organ/eyes/organ_eyes in character.internal_organs)
	//						if(initial(organ_eyes.eye_color))
	//							continue
							if(organ_eyes.current_zone == BODY_ZONE_PRECISE_L_EYE)
								character.left_eye_color = sanitize_hexcolor(eye_coloring, 6, FALSE)
								organ_eyes.old_eye_color = eye_coloring
								character.dna.update_ui_block(DNA_LEFT_EYE_COLOR_BLOCK)
							else
								character.right_eye_color = sanitize_hexcolor(eye_coloring, 6, FALSE)
								organ_eyes.old_eye_color = eye_coloring
								character.dna.update_ui_block(DNA_RIGHT_EYE_COLOR_BLOCK)

						for(var/obj/item/organ/genital/genital in character.internal_organs)
							genital.Remove(character)
							qdel(genital)
/*
						var/min_dicksize = 1
						var/max_dicksize = 20
						var/min_breastsize = 1
						var/max_breastsize = 7
						character.dna.features["penis_size"] = clamp(rand(min_dicksize, max_dicksize), PENIS_MIN_LENGTH, PENIS_MAX_LENGTH)
						character.dna.features["penis_girth"] = clamp(character.dna.features["penis_size"] - 3, PENIS_MIN_GIRTH, PENIS_MAX_GIRTH)
						character.dna.features["breasts_size"] = clamp(rand(min_breastsize, max_breastsize), BREASTS_MIN_SIZE, BREASTS_MAX_SIZE)
						character.dna.features["breasts_lactation"] = FALSE
						character.dna.features["penis_circumcised"] = FALSE
						for(var/obj/item/organ/genital/genital in character.internal_organs)
							genital.build_from_dna(character.dna, genital.mutantpart_key)
*/
						mind.active = FALSE
						mind.transfer_to(character)
						mind.set_original_character(character)
						character.key = key
						qdel(src)

						var/datum/component/babble/babble = character.GetComponent(/datum/component/babble)
						if(!babble)
							switch(character.truerole)
								if("Капнобатай")
									character.AddComponent(/datum/component/babble, 'modular_septic/sound/voice/babble/plimpus.ogg')
								if("Конченный")
									character.AddComponent(/datum/component/babble, 'modular_septic/sound/voice/babble/babble_male.ogg')
								else
									character.AddComponent(/datum/component/babble, 'modular_septic/sound/voice/babble/babble_agender.ogg')
						else
							switch(character.truerole)
								if("Капнобатай")
									babble.babble_sound_override = 'modular_septic/sound/voice/babble/plimpus.ogg'
								if("Конченный")
									babble.babble_sound_override = 'modular_septic/sound/voice/babble/babble_male.ogg'
								else
									babble.babble_sound_override = 'modular_septic/sound/voice/babble/babble_agender.ogg'
							babble.volume = BABBLE_DEFAULT_VOLUME
							babble.duration = BABBLE_DEFAULT_DURATION

						character.stop_sound_channel(CHANNEL_LOBBYMUSIC)
						var/area/joined_area = get_area(character.loc)
						if(joined_area)
							joined_area.on_joining_game(character)
						var/obj/item/organ/brain/brain = character.getorganslot(ORGAN_SLOT_BRAIN)
						if(brain)
							(brain.maxHealth = BRAIN_DAMAGE_DEATH + GET_MOB_ATTRIBUTE_VALUE(character, STAT_ENDURANCE))
						character.gain_extra_effort(1, TRUE)
						to_chat(character, span_dead("Я продолжаю искать свой верный путь."))
						character.playsound_local(character, 'modular_pod/sound/eff/podpol_hello.ogg', 90, FALSE)
						character.cursings()
//						character.friendroles()

						if(character.special_zvanie)
							switch(character.special_zvanie)
								if("Отец Капнобатаев")
									to_chat(character, span_yellowteamradio("Я Отец Капнобатаев!"))
								if("Самый Конченный")
									to_chat(character, span_yellowteamradio("Я Самый Конченный!"))

	//					for(var/obj/item/organ/genital/genital in character.internal_organs)
	//						genital.build_from_dna(character.dna, genital.mutantpart_key)
						character.dna.features["body_size"] = BODY_SIZE_NORMAL
						character.dna.update_body_size()
						character.dna.update_dna_identity()
						character.attributes?.update_attributes()
						character.regenerate_icons()

		if("Да вроде другая...")
			client.ready_char = FALSE
			return FALSE

/datum/outfit/kapno
	name = "Kapno Uniform"

	l_pocket = /obj/item/key/podpol/woody/kapnodvorkey
	uniform = /obj/item/clothing/under/codec/purp
	pants = /obj/item/clothing/pants/codec/purp
	shoes = /obj/item/clothing/shoes/jackboots
	suit = /obj/item/clothing/suit/armor/roba

/datum/outfit/kapnofather
	name = "Kapnofather Uniform"

	uniform = null
	r_pocket = /obj/item/key/podpol/woody/kapnokey
	l_pocket = /obj/item/key/podpol/woody/kapnodvorkey
	belt = /obj/item/gun/ballistic/automatic/pistol/cortes
	suit = /obj/item/clothing/suit/armor/roba
	oversuit = /obj/item/clothing/suit/armor/vest/bulletproofer
	pants = /obj/item/clothing/pants/codec/purp/red
	shoes = /obj/item/clothing/shoes/jackboots
	head = /obj/item/clothing/head/helmet/codec/def_yel

/datum/outfit/konch
	name = "Konch Uniform"

	l_pocket = /obj/item/key/podpol/woody/konchkey
	uniform = /obj/item/clothing/under/codec/purp/black
	pants = /obj/item/clothing/pants/codec/purp/black
	shoes = /obj/item/clothing/shoes/jackboots

/datum/outfit/mostkonch
	name = "Mostkonch Uniform"

	mask = /obj/item/clothing/mask/gas/ballisticarmor
	l_pocket = /obj/item/key/podpol/woody/konchkey
	uniform = /obj/item/clothing/under/codec/purp/black
	pants = /obj/item/clothing/pants/codec/purp/black
	shoes = /obj/item/clothing/shoes/jackboots
	belt = /obj/item/melee/bita/cep/iron
	suit = /obj/item/clothing/suit/armor/vest/chainmail/steel
	back = /obj/item/melee/shieldo/buckler/wooden

/datum/outfit/svogod
	name = "Svogod Uniform"

	shoes = /obj/item/clothing/shoes/jackboots
	suit = /obj/item/clothing/suit/armor/vest/bulletproofer
	back = /obj/item/storage/belt/military/itobe/svo
	suit_store = /obj/item/gun/ballistic/automatic/remis/svd
