/mob/living/verb/succumb(whispered as null)
	set name = "Succumb"
	set category = "IC"
	set desc = "Give up the gift of life."

	if(!CAN_SUCCUMB(src))
		to_chat(src, span_info("I am unable to succumb to death! This life continues."))
		return
	log_message("Has [whispered ? "whispered his final words" : "succumbed to death"] with [round(health, 0.1)] points of health!", LOG_ATTACK)
	ADJUSTBRAINLOSS(src, src.maxHealth)
	if(!whispered)
		to_chat(src, span_dead("I have given up life and succumbed to death."))
	death()
	updatehealth()
