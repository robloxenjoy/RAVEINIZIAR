/mob/living/verb/succumb(whispered as null)
	set name = "sabdasdbasdn"
	set category = "IC"
	set desc = "so shitty."

	return FALSE
/*
	if(!CAN_SUCCUMB(src))
		to_chat(src, span_info("I am unable to succumb to death! This life continues."))
		return
	log_message("Has [whispered ? "whispered his final words" : "succumbed to death"] with [round(health, 0.1)] points of health!", LOG_ATTACK)
	ADJUSTBRAINLOSS(src, src.maxHealth)
	if(!whispered)
		to_chat(src, span_dead("I have given up life and succumbed to death."))
	death()
	updatehealth()
*/

/*
/mob/living/carbon/human/verb/belynx(whispered as null)
	set name = "Become a Lynx"
	set category = "IC"
	set desc = "You want?"
	set hidden = TRUE

	if(belief == "Hadot")
		if(HAS_TRAIT(src, TRAIT_LYNXER))
			var/lynx_ask = tgui_alert(usr, "Become a lynx?", "Do you wish to sleep in bushes and eat noobs?", list("Yes", "No"))
			if(lynx_ask == "No" || QDELETED(src))
				return FALSE
			if(can_heartattack())
				set_heartattack(TRUE)
			var/obj/effect/landmark/spawnedmob/lynx/lyn = locate() in world
			var/mob/living/simple_animal/hostile/podozl/caracal/newlynx = new(lyn.loc)
			newlynx.key = key
*/

/mob/living/carbon/human/verb/vomited(whispered as null)
	set name = "Vomit"
	set category = "Extra"
	set desc = "You want?"

	if(stat == CONSCIOUS)
		vomit(lost_nutrition = 10, blood = FALSE, stun = TRUE, distance = rand(1,2), message = TRUE, vomit_type = VOMIT_TOXIC, harm = TRUE, force = FALSE, purge_ratio = 0.1, button = TRUE)