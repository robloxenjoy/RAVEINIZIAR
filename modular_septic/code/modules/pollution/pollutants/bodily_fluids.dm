///Splashing blood makes a tiny bit of this
/datum/pollutant/metallic_scent
	name = "Металлический аромат"
	pollutant_flags = POLLUTANT_APPEARANCE | POLLUTANT_SMELL
	smell_intensity = 2
	thickness = 2
	descriptor = SCENT_DESC_ODOR
	scent = "что-то металлическое"
	color = "#bf0057"

/datum/pollutant/metallic_scent/breathe_act(mob/living/carbon/victim, amount)
	var/message
	switch(amount)
		if(10 to INFINITY)
			message = span_warning("I'm saturating with this blood...")
			if(prob(25))
				victim.adjust_bloodvolume(5)
	if(message && prob(20))
		to_chat(victim, message)

///Vomit
/datum/pollutant/vomit
	name = "Блевотня"
	pollutant_flags = POLLUTANT_SMELL | POLLUTANT_APPEARANCE
	smell_intensity = 3
	descriptor = SCENT_DESC_ODOR
	scent = "блевотина"
	color = "#789433"
	thickness = 3

/datum/pollutant/vomit/breathe_act(mob/living/carbon/victim, amount)
	var/message
	switch(amount)
		if(0 to 10)
			message = span_warning("Чё за запах?!")
			if(prob(15))
				victim.emote("gag")
			if(prob(10))
				victim.vomit(rand(40, 50), prob(amount))
		if(10 to 30)
			message = span_warning("Я щас блевать буду...")
			SEND_SIGNAL(victim, COMSIG_ADD_MOOD_EVENT, "pollution", /datum/mood_event/retarded)
			if(prob(25))
				victim.vomit(rand(50, 60), prob(amount))
		if(30 to INFINITY)
			message = span_bolddanger("Этот запах ужасен!")
			SEND_SIGNAL(victim, COMSIG_ADD_MOOD_EVENT, "pollution", /datum/mood_event/retarded/harsh)
			victim.adjustToxLoss(1.5)
			if(prob(35))
				victim.vomit(rand(60, 70), prob(amount))
	if(message && prob(20))
		to_chat(victim, message)

///Cum
/datum/pollutant/cum
	name = "Cum"
	pollutant_flags = POLLUTANT_SMELL | POLLUTANT_APPEARANCE
	smell_intensity = 1
	descriptor = SCENT_DESC_ODOR
	scent = "stale cum"
	color = "#FFFFFF"
	thickness = 2

///Piss
/datum/pollutant/urine
	name = "Моча"
	pollutant_flags = POLLUTANT_SMELL | POLLUTANT_APPEARANCE
	smell_intensity = 3
	descriptor = SCENT_DESC_ODOR
	scent = "моча"
	color = "#fcbc2c"
	thickness = 2

/datum/pollutant/urine/breathe_act(mob/living/carbon/victim, amount)
	var/message
	switch(amount)
		if(0 to 10)
			message = span_warning("Что это за запах?!")
			if(prob(15))
				victim.emote("gag")
			if(prob(10))
				victim.vomit(rand(15, 20), prob(amount))
		if(10 to 30)
			message = span_warning("Блять, этот запах...")
			SEND_SIGNAL(victim, COMSIG_ADD_MOOD_EVENT, "pollution", /datum/mood_event/retarded)
			if(prob(25))
				victim.vomit(rand(20, 40), prob(amount))
		if(30 to INFINITY)
			message = span_bolddanger("ЗАПАХ! СУКА, ФУ!")
			SEND_SIGNAL(victim, COMSIG_ADD_MOOD_EVENT, "pollution", /datum/mood_event/retarded/harsh)
			victim.adjustToxLoss(1.5)
			if(prob(35))
				victim.vomit(rand(40, 50), prob(amount))
	if(message && prob(20))
		to_chat(victim, message)

/datum/pollutant/shit
	name = "Говно"
	pollutant_flags = POLLUTANT_APPEARANCE | POLLUTANT_SMELL | POLLUTANT_BREATHE_ACT
	smell_intensity = 4
	thickness = 3
	descriptor = SCENT_DESC_ODOR
	scent = "говно"
	color = "#30600e"
	filter_wear = 0.2

/datum/pollutant/shit/breathe_act(mob/living/carbon/victim, amount)
	var/message
	switch(amount)
		if(0 to 10)
			message = span_warning("Чё за запах то?!")
			if(prob(15))
				victim.emote("gag")
			if(prob(10))
				victim.vomit(rand(15, 20), prob(amount))
		if(10 to 30)
			message = span_warning("Этот запах пиздец...")
			SEND_SIGNAL(victim, COMSIG_ADD_MOOD_EVENT, "pollution", /datum/mood_event/shit)
			if(prob(25))
				victim.vomit(rand(20, 30), prob(amount))
		if(30 to INFINITY)
			message = span_bolddanger("ДА ВСЁ БЛЯТЬ! Я НЕ ХОЧУ ЭТО НЮХАТЬ!")
			SEND_SIGNAL(victim, COMSIG_ADD_MOOD_EVENT, "pollution", /datum/mood_event/shit/harsh)
			victim.adjustToxLoss(2.5)
			if(prob(45))
				victim.vomit(rand(30, 50), prob(amount))
	if(message && prob(20))
		to_chat(victim, message)
