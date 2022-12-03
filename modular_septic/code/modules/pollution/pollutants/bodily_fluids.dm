///Splashing blood makes a tiny bit of this
/datum/pollutant/metallic_scent
	name = "Metallic Scent"
	pollutant_flags = POLLUTANT_APPEARANCE | POLLUTANT_SMELL
	smell_intensity = 2
	thickness = 2
	descriptor = SCENT_DESC_ODOR
	scent = "something metallic"
	color = "#bf0057"

///Vomit
/datum/pollutant/vomit
	name = "Vomit"
	pollutant_flags = POLLUTANT_SMELL | POLLUTANT_APPEARANCE
	smell_intensity = 3
	descriptor = SCENT_DESC_ODOR
	scent = "vomit"
	color = "#30600e"
	thickness = 3

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
	name = "Urine"
	pollutant_flags = POLLUTANT_SMELL | POLLUTANT_APPEARANCE
	smell_intensity = 3
	descriptor = SCENT_DESC_ODOR
	scent = "stale urine"
	color = "#fcbc2c"
	thickness = 2

/datum/pollutant/shit
	name = "Shit"
	pollutant_flags = POLLUTANT_APPEARANCE | POLLUTANT_SMELL | POLLUTANT_BREATHE_ACT
	smell_intensity = 4
	thickness = 3
	descriptor = SCENT_DESC_ODOR
	scent = "shit"
	color = "#30600e"
	filter_wear = 0.2

/datum/pollutant/shit/breathe_act(mob/living/carbon/victim, amount)
	var/message
	switch(amount)
		if(0 to 10)
			message = span_warning("What is this smell?!")
			if(prob(15))
				victim.emote("gag")
			if(prob(10))
				victim.vomit(rand(5, 10), prob(amount))
		if(10 to 30)
			message = span_warning("I'm gonna puke...")
			SEND_SIGNAL(victim, COMSIG_ADD_MOOD_EVENT, "pollution", /datum/mood_event/shit)
			if(prob(25))
				victim.vomit(rand(5, 10), prob(amount))
		if(30 to INFINITY)
			message = span_bolddanger("This stench is unbearable!")
			SEND_SIGNAL(victim, COMSIG_ADD_MOOD_EVENT, "pollution", /datum/mood_event/shit/harsh)
			victim.adjustToxLoss(2.5)
			if(prob(35))
				victim.vomit(rand(10, 15), prob(amount))
	if(message && prob(20))
		to_chat(victim, message)
