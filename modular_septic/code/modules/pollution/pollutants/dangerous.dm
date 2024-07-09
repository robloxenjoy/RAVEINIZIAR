///Dangerous fires release this from the waste they're burning
/datum/pollutant/carbon_air_pollution
	name = "Углеродное Загрязнение"
	pollutant_flags = POLLUTANT_APPEARANCE | POLLUTANT_BREATHE_ACT
	color = "#b49993"
	thickness = 2

/datum/pollutant/carbon_air_pollution/breathe_act(mob/living/carbon/victim, amount)
	if(amount <= 5)
		return
	victim.adjustToxLoss(1.5)
	if(prob(amount))
		victim.losebreath += 3
		victim.agony_gasp()

///Dust from mining drills
/datum/pollutant/dust
	name = "Пыль"
	pollutant_flags = POLLUTANT_APPEARANCE | POLLUTANT_BREATHE_ACT
	thickness = 2
	color = "#FFED9C"
	filter_wear = 0.25
	scent = "пыль"

/datum/pollutant/dust/breathe_act(mob/living/carbon/victim, amount)
	if(amount <= 5)
		return
	if(prob(amount))
		victim.losebreath += 3
		victim.emote("cough")

///Miasma coming from corpses
/datum/pollutant/miasma
	name = "Miasma"
	pollutant_flags = POLLUTANT_APPEARANCE | POLLUTANT_SMELL | POLLUTANT_BREATHE_ACT
	smell_intensity = 4
	thickness = 2
	descriptor = SCENT_DESC_ODOR
	scent = "rotting carcasses"
	color = "#9500b3"
	filter_wear = 0.5

/datum/pollutant/miasma/breathe_act(mob/living/carbon/victim, amount)
	var/message
	switch(amount)
		if(0 to 10)
			message = span_warning("What is this smell?!")
			if(prob(15))
				victim.emote("gag")
			if(prob(10))
				victim.vomit(rand(50, 70), prob(amount))
		if(10 to 30)
			message = span_warning("I'm gonna puke...")
			SEND_SIGNAL(victim, COMSIG_ADD_MOOD_EVENT, "pollution", /datum/mood_event/miasma)
			if(prob(25))
				victim.vomit(rand(50, 70), prob(amount))
		if(30 to INFINITY)
			message = span_bolddanger("This stench is unbearable!")
			SEND_SIGNAL(victim, COMSIG_ADD_MOOD_EVENT, "pollution", /datum/mood_event/miasma/harsh)
			victim.adjustToxLoss(2.5)
			if(prob(35))
				victim.vomit(rand(50, 75), prob(amount))
	if(message && prob(20))
		to_chat(victim, message)

///IG grenades
/datum/pollutant/incredible_gas
	name = "Ебанутый Газ"
	pollutant_flags = POLLUTANT_APPEARANCE | POLLUTANT_SMELL | POLLUTANT_BREATHE_ACT
	smell_intensity = 4
	thickness = 2
	descriptor = SCENT_DESC_ODOR
	scent = "смерть и кислота"
	color = "#00DA00"
	filter_wear = 1

/datum/pollutant/incredible_gas/breathe_act(mob/living/carbon/victim, amount)
	var/message
	switch(amount)
		if(0 to 3)
			message = span_warning("Чё за запах?!")
			SEND_SIGNAL(victim, COMSIG_ADD_MOOD_EVENT, "pollution", /datum/mood_event/incredible_gas)
			victim.adjustOrganLoss(ORGAN_SLOT_LUNGS, 2)
			victim.adjustToxLoss(2)
			if(prob(60))
				victim.vomit(40, blood = prob(amount), stun = FALSE, vomit_type = VOMIT_PURPLE, purge_ratio = 1)
		if(3 to 10)
			message = span_warning("Этот запах страшен!")
			SEND_SIGNAL(victim, COMSIG_ADD_MOOD_EVENT, "pollution", /datum/mood_event/incredible_gas/harsh)
			victim.apply_status_effect(/datum/status_effect/incredible_gas)
			victim.adjustOrganLoss(ORGAN_SLOT_LUNGS, 4)
			victim.adjustToxLoss(4)
			if(prob(75))
				victim.vomit(50, blood = prob(amount*3), stun = TRUE, vomit_type = VOMIT_PURPLE, purge_ratio = 1)
		if(10 to INFINITY)
			message = span_bolddanger("Этот запах ЕБАНУТО ОПАСЕН!")
			SEND_SIGNAL(victim, COMSIG_ADD_MOOD_EVENT, "pollution", /datum/mood_event/incredible_gas/harsh)
			victim.apply_status_effect(/datum/status_effect/incredible_gas)
			victim.adjustOrganLoss(ORGAN_SLOT_LUNGS, 8)
			victim.adjustToxLoss(8)
			victim.vomit(70, blood = TRUE, stun = TRUE, vomit_type = VOMIT_PURPLE, purge_ratio = 1)
	if(message && prob(40))
		to_chat(victim, message)

///UP grenades
/datum/pollutant/urinepoo_gas
	name = "UrinePoo Gas"
	pollutant_flags = POLLUTANT_APPEARANCE | POLLUTANT_SMELL | POLLUTANT_BREATHE_ACT
	smell_intensity = 4
	thickness = 2
	descriptor = SCENT_DESC_ODOR
	scent = "urine and poo"
	color = "#636e4a"
	filter_wear = 1

/datum/pollutant/urinepoo_gas/breathe_act(mob/living/carbon/victim, amount)
	var/message
	switch(amount)
		if(0 to 3)
			message = span_warning("What is this smell?!")
			SEND_SIGNAL(victim, COMSIG_ADD_MOOD_EVENT, "pollution", /datum/mood_event/urinepoo_gas)
			victim.adjustToxLoss(1)
			if(prob(50))
				victim.vomit(rand(50, 70), prob(amount))
		if(3 to 11)
			message = span_warning("This is DISGUSTING!!")
			SEND_SIGNAL(victim, COMSIG_ADD_MOOD_EVENT, "pollution", /datum/mood_event/urinepoo_gas/harsh)
			victim.adjustToxLoss(2)
			if(prob(80))
				victim.vomit(rand(50, 70), prob(amount))
		if(11 to INFINITY)
			message = span_bolddanger("THIS IS INCREDIBLY DISGUSTING!")
			SEND_SIGNAL(victim, COMSIG_ADD_MOOD_EVENT, "pollution", /datum/mood_event/urinepoo_gas/harsh)
			victim.adjustToxLoss(3)
			victim.vomit(rand(50, 75), prob(amount))
	if(message && prob(60))
		to_chat(victim, message)

///SP grenades
/datum/pollutant/sleeptime_gas
	name = "Sleeptime Gas"
	pollutant_flags = POLLUTANT_APPEARANCE | POLLUTANT_SMELL | POLLUTANT_BREATHE_ACT
	smell_intensity = 4
	thickness = 2
	descriptor = SCENT_DESC_ODOR
	scent = "sweet pancakes"
	color = "#a26ea7"
	filter_wear = 1

/datum/pollutant/sleeptime_gas/breathe_act(mob/living/carbon/victim, amount)
	var/message
	switch(amount)
		if(0 to 6)
			message = span_warning("What is this smell???")
			SEND_SIGNAL(victim, COMSIG_ADD_MOOD_EVENT, "pollution", /datum/mood_event/sleeptime_gas)
			if(prob(70))
				victim.Unconscious(25)
		if(6 to 9)
			message = span_warning("This smell is so good!")
			SEND_SIGNAL(victim, COMSIG_ADD_MOOD_EVENT, "pollution", /datum/mood_event/sleeptime_gas/harsh)
			if(prob(70))
				victim.Unconscious(35)
		if(9 to INFINITY)
			message = span_bolddanger("Because of this smell, I really want to sleep...")
			SEND_SIGNAL(victim, COMSIG_ADD_MOOD_EVENT, "pollution", /datum/mood_event/sleeptime_gas/harsh)
			victim.Unconscious(50)
	if(message && prob(20))
		to_chat(victim, message)

///Vilir
/datum/pollutant/vilir
	name = "Vilir"
	pollutant_flags = POLLUTANT_SMELL | POLLUTANT_APPEARANCE
	smell_intensity = 3
	descriptor = SCENT_DESC_ODOR
	scent = "stars"
	color = "#a340fe"
	thickness = 2

/datum/pollutant/vilir/breathe_act(mob/living/carbon/victim, amount)
	var/message
	switch(amount)
		if(0 to 6)
			message = span_warning("OOFSICEIMDCWIDUR!")
			SEND_SIGNAL(victim, COMSIG_ADD_MOOD_EVENT, "pollution", /datum/mood_event/vilir)
			victim.clear_fullscreen("fuckaaafu")
			if(prob(50))
//				victim.Dizzy(25)
				victim.emote("scream")
			if(prob(20))
				victim.emote("laugh")
		if(6 to 9)
			message = span_warning("IIIWHY WE ARE WHYISACNDIWC STARSIASCODSC CHAOSIANDOC!")
			SEND_SIGNAL(victim, COMSIG_ADD_MOOD_EVENT, "pollution", /datum/mood_event/vilir/harsh)
			if(prob(60))
//				victim.Dizzy(25)
				victim.emote("scream")
			if(prob(30))
				victim.emote("laugh")
		if(9 to INFINITY)
			message = span_bolddanger("CANUSESSTNRAOEPGODA!!!! CXDSNNXARAPSENIOSIYAANT!!! DOSCNSN!")
			SEND_SIGNAL(victim, COMSIG_ADD_MOOD_EVENT, "pollution", /datum/mood_event/vilir/harsh)
			victim.overlay_fullscreen("fuckaaafu", /atom/movable/screen/fullscreen/willetbecome)
			if(prob(70))
//				victim.Dizzy(25)
				victim.emote("scream")
			if(prob(40))
				victim.emote("laugh")
			if(prob(40))
				victim.emote("cry")
	if(message && prob(20))
		to_chat(victim, message)
