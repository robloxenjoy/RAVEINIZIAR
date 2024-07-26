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
	set name = "Play"
	set category = "OOC"

	if(!isnewplayer(src))
		return
	if(!client)
		return
	if(client.ready_char)
		return
	if(client.should_not_play)
		alert("Oh, what a pity... I can't continue my way.")
		return
	if(SSticker.current_state < GAME_STATE_PLAYING)
		alert("The game hasn't started yet.")
		return
	client.name_ch = name_generate()
	if(prob(70))
		client.age_ch = rand(18, 40)
	else
		client.age_ch = rand(18, 100)
	client.ready_char = TRUE
	alert("I remembered who I am!")
	chooseRole()

/mob/dead/new_player/proc/name_generate()
	var/special_name
	var/second_thing = null
	var/third_thing = null
	var/first_thing = pick("Hark", "Sideless", "Mor", "Nok", "Nox", "Garrett", "Haramec", "Enclave", "Vial", "Torner", "Web", "Hvax", "Coiler", "Boyd", "Hex", "Sacrec", "Rave")
	special_name = "[first_thing]"
	if(prob(40))
		second_thing = pick("Moon", "Stone", "Black", "Block")
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
	var/rolevich = input("Wait, what role?", "") as text
	switch(rolevich)
		if("Kapnobatai")
			client.role_ch = "kapnobatai"
		if("Asshole")
			client.role_ch = "asshole"
		if("God SMO")
			var/smo = "[global.config.directory]/smo.txt"
			if(ckey in world.file2list(smo))
				client.role_ch = "god smo"
			else
				alert("Donate for this role.")
				client.ready_char = FALSE
				return
			if(GLOB.world_deaths_crazy < 20)
				alert("Not enough deaths in the world.")
				client.ready_char = FALSE
				return
		if("Halbermensch")
			var/hal = "[global.config.directory]/hal.txt"
			if(ckey in world.file2list(hal))
				client.role_ch = "halbermensch"
			else
				alert("Donate for this role.")
				client.ready_char = FALSE
				return
//			if(GLOB.world_deaths_crazy < 20)
//				alert("Not enough deaths in the world.")
//				client.ready_char = FALSE
//				return
		else
			alert("Unclear. The role of the common Kapnobatai.")
			client.role_ch = "kapnobatai"
	dolboEbism()

/mob/dead/new_player/proc/dolboEbism()
	var/crazyalert = alert("Or maybe there was another role?",,"Let's continue!","Yes, it seems like a different role...")
	switch(crazyalert)
		if("Let's continue!")
			for(var/obj/effect/landing/spawn_point as anything in GLOB.jobber_list)
				if(client)
					if(spawn_point.name == client.role_ch)
						if(spawn_point.spending > 0)
							spawn_point.spending--
							if(character.truerole == "Halbermensch")
								var/mob/living/carbon/human/species/halbermensch/character = new(pick(spawn_point.loc))
							else
								var/mob/living/carbon/human/character = new(pick(spawn_point.loc))
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
//							var/height = HUMAN_HEIGHT_MEDIUM
							switch(client.role_ch)
								if("kapnobatai")
									character.truerole = "Kapnobatai"
									character.pod_faction = "kapnobatai"
									character.hairstyle = "Bedhead 2"
									character.facial_hairstyle = "Shaved"
									character.hair_color = pick("#000000", "#1f120f", "#d7d49f")
								if("asshole")
									character.truerole = "Asshole"
									character.pod_faction = "asshole"
									character.hairstyle = "Bald"
									character.facial_hairstyle = "Shaved"
									eye_coloring = "#c30000"
								if("halbermensch")
									character.pod_faction = "Halbermensch"
									character.truerole = "Halbermensch"
									character.pod_faction = null
									character.hairstyle = "Bald"
									character.facial_hairstyle = "Shaved"
								if("god smo")
									character.truerole = "God SMO"
									character.pod_faction = "god smo"
									character.hairstyle = "Bedhead 2"
									character.facial_hairstyle = "Shaved"
									character.hair_color = pick("#ff0aff")
									character.kaotiks_body = 100
									character.real_name = "God SMO"
									character.name = character.real_name
									character.height = HUMAN_HEIGHT_TALLEST
							switch(character.truerole)
								if("Kapnobatai")
									var/mutable_appearance/appearance = mutable_appearance('modular_septic/icons/mob/human/overlays/signs.dmi', "kapno", ROLES_LAYER)
									character.add_overlay(appearance)
									character.attributes?.add_sheet(/datum/attribute_holder/sheet/job/kapno)
									if(prob(10))
										character.equipOutfit(/datum/outfit/kapnofather)
										character.special_zvanie = "Kapnobataes Father"
									else
										character.equipOutfit(/datum/outfit/kapno)
								if("Asshole")
									var/mutable_appearance/appearance = mutable_appearance('modular_septic/icons/mob/human/overlays/signs.dmi', "konch", ROLES_LAYER)
									character.add_overlay(appearance)
									character.attributes?.add_sheet(/datum/attribute_holder/sheet/job/konch)
									if(prob(10))
										character.equipOutfit(/datum/outfit/mostkonch)
										character.special_zvanie = "The Most Asshole"
									else
										character.equipOutfit(/datum/outfit/konch)
								if("God SMO")
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
/*
							for(var/obj/item/organ/genital/genital in character.internal_organs)
								genital.Remove(character)
								qdel(genital)
*/
							mind.active = FALSE
							mind.transfer_to(character)
							mind.set_original_character(character)
							character.key = key
							qdel(src)

							var/datum/component/babble/babble = character.GetComponent(/datum/component/babble)
							if(!babble)
								switch(character.truerole)
									if("Kapnobatai")
										character.AddComponent(/datum/component/babble, 'modular_septic/sound/voice/babble/plimpus.ogg')
									if("Asshole")
										character.AddComponent(/datum/component/babble, 'modular_septic/sound/voice/babble/babble_male.ogg')
									if("Halbermensch")
										character.AddComponent(/datum/component/babble, 'modular_pod/sound/mobs_yes/babble/halber.ogg')
									else
										character.AddComponent(/datum/component/babble, 'modular_septic/sound/voice/babble/babble_agender.ogg')
							else
								switch(character.truerole)
									if("Kapnobatai")
										babble.babble_sound_override = 'modular_septic/sound/voice/babble/plimpus.ogg'
									if("Asshole")
										babble.babble_sound_override = 'modular_septic/sound/voice/babble/babble_male.ogg'
									if("Halbermensch")
										character.AddComponent(/datum/component/babble, 'modular_pod/sound/mobs_yes/babble/halber.ogg')
									else
										babble.babble_sound_override = 'modular_septic/sound/voice/babble/babble_agender.ogg'
								babble.volume = BABBLE_DEFAULT_VOLUME
								babble.duration = BABBLE_DEFAULT_DURATION

							character.stop_sound_channel(CHANNEL_LOBBYMUSIC)
							var/area/joined_area = get_area(character.loc)
							if(joined_area)
								joined_area.on_joining_game(character)
//							var/obj/item/organ/brain/brain = character.getorganslot(ORGAN_SLOT_BRAIN)
//							if(brain)
	//							(brain.maxHealth = BRAIN_DAMAGE_DEATH + GET_MOB_ATTRIBUTE_VALUE(character, STAT_ENDURANCE))
							for(var/obj/item/organ/genital/genital in character.internal_organs)
								genital.build_from_dna(character.dna, genital.mutantpart_key)
							for(var/obj/item/organ/plushp in character.internal_organs)
								plushp.maxHealth += GET_MOB_ATTRIBUTE_VALUE(character, STAT_ENDURANCE)
							for(var/obj/item/bodypart/plusbodyhp as anything in character.bodyparts)
								plusbodyhp.max_damage += GET_MOB_ATTRIBUTE_VALUE(character, STAT_ENDURANCE)
								plusbodyhp.max_stamina_damage += GET_MOB_ATTRIBUTE_VALUE(character, STAT_ENDURANCE)
							character.gain_extra_effort(1, TRUE)
							to_chat(character, span_dead("I keep looking for my right way."))
							character.playsound_local(character, 'modular_pod/sound/eff/podpol_hello.ogg', 90, FALSE)
							character.cursings()
	//						character.friendroles()

							if(character.special_zvanie)
								switch(character.special_zvanie)
									if("Kapnobataes Father")
										to_chat(character, span_yellowteamradio("I'm Kapnobataes Father!"))
									if("The Most Asshole")
										to_chat(character, span_yellowteamradio("I'm The Most Asshole!"))
//							character.height = height
							character.dna.features["body_size"] = BODY_SIZE_NORMAL
							character.dna.update_body_size()
							character.dna.update_dna_identity()
							character.attributes?.update_attributes()
							character.regenerate_icons()

						else
							alert("No more slots.")
							client.ready_char = FALSE
							return FALSE
		if("Yes, it seems like a different role...")
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
	belt = /obj/item/podpol_weapon/sword/steel
	suit = /obj/item/clothing/suit/armor/roba
	oversuit = /obj/item/clothing/suit/armor/vest/bulletproofer
	pants = /obj/item/clothing/pants/codec/purp/red
	shoes = /obj/item/clothing/shoes/jackboots
	head = /obj/item/clothing/head/helmet/codec/def_yel

/datum/outfit/konch
	name = "Konch Uniform"

	l_pocket = /obj/item/key/podpol/woody/konchkey
	r_pocket = /obj/item/reagent_containers/pill/carbonylmethamphetamine
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
//	belt = /obj/item/melee/bita/cep/iron
	r_hand = /obj/item/melee/bita/hammer/sledge
	suit = /obj/item/clothing/suit/armor/vest/chainmail/steel
	back = /obj/item/melee/shieldo/buckler/wooden

/datum/outfit/svogod
	name = "Svogod Uniform"

	r_hand = /obj/item/podpol_weapon/axe/big
	belt = /obj/item/melee/hehe/pickaxe/iron
	shoes = /obj/item/clothing/shoes/jackboots
	suit = /obj/item/clothing/suit/armor/vest/bulletproofer
	back = /obj/item/storage/belt/military/itobe/svo
	suit_store = /obj/item/gun/ballistic/automatic/remis/svd
