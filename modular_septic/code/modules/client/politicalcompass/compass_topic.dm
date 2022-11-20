/datum/political_compass/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "PoliticalCompass")
		ui.open()

/datum/political_compass/ui_state(mob/user)
	return GLOB.always_state

/datum/political_compass/ui_data(mob/user)
	var/list/data = list()
	var/list/questions = list()
	for(var/question in all_questions)
		var/list/this_question = list()
		this_question["question"] = question
		var/qid = all_questions.Find(question)
		this_question["qid"] = qid
		var/list/unparsed_answers = all_questions[question]
		var/list/answers = list()
		for(var/answer in all_questions[question])
			var/list/this_answer = list()
			this_answer["answer"] = answer
			var/aid = unparsed_answers.Find(answer)
			this_answer["aid"] = aid
			this_answer["selected"] = (questions_answered[question] == answer ? TRUE : FALSE)

			answers += list(this_answer)
		this_question["answers"] = answers
		this_question["unanswered"] = !questions_answered[question]

		questions += list(this_question)
	data["questions"] = questions
	data["final_result"] = get_result()
	data["final_color"] = get_color()
	var/flag = get_flag()
	if(flag)
		var/icon/iconflag = icon('modular_septic/icons/ui_icons/chat/ooc.dmi', get_flag())
		data["flagicon64"] = icon2base64(iconflag)
	return data

/datum/political_compass/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	switch(action)
		if("reset")
			reset()
			. = TRUE
		if("answerquestion")
			var/question = LAZYACCESS(all_questions, params["question_id"])
			var/answer = LAZYACCESS(all_questions[question], params["answer_id"])
			if(answer)
				questions_answered[question] = answer
			update_and_save()
			. = TRUE
		if("removeanswer")
			var/question = LAZYACCESS(all_questions, params["question_id"])
			questions_answered -= question
			update_and_save()
			. = TRUE

/datum/political_compass/ui_close(mob/user)
	. = ..()
	update_and_save()

/datum/political_compass/proc/reset()
	classification = ""
	right_axis = 0
	auth_axis = 0
	prog_axis = 0
	questions_answered = list()
	save_save()

/datum/political_compass/proc/update()
	calculate()
	classification = get_result()

/datum/political_compass/proc/update_and_save()
	update()
	save_save()
