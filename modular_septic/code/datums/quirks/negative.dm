//Mostly used by Shibu species
/datum/quirk/congenial
	name = "Congenial"
	desc = "You hate being alone."
	mood_desc = "I hate being alone."
	icon = "users"
	value = -4
	medical_record_text = "Patient is congenial, and does not enjoy being alone."
	hardcore_value = 5
	var/static/time_to_bad_mood = 5 MINUTES
	var/time_alone = 0

/datum/quirk/congenial/add_to_holder(mob/living/new_holder, quirk_transfer)
	. = ..()
	START_PROCESSING(SSslow_processing, src)

/datum/quirk/congenial/remove_from_current_holder(quirk_transfer)
	STOP_PROCESSING(SSslow_processing, src)
	return ..()

/datum/quirk/congenial/process(delta_time)
	if(check_lonely())
		time_alone += delta_time
		if(time_alone >= time_to_bad_mood)
			SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, "loneliness", /datum/mood_event/congenial)
		return
	time_alone = 0
	SEND_SIGNAL(quirk_holder, COMSIG_CLEAR_MOOD_EVENT, "loneliness")

/datum/quirk/congenial/proc/check_lonely()
	. = TRUE
	var/friend_range = world.view
	if(quirk_holder.is_blind())
		friend_range = 1
	for(var/mob/living/friend in fov_view(friend_range, quirk_holder))
		if((friend.stat < DEAD) && (friend.ai_controller || friend.mind))
			return FALSE

//Mostly used by Perluni species
/datum/quirk/uncongenial
	name = "Uncongenial"
	desc = "You hate having company."
	mood_desc = "I hate company."
	icon = "user"
	value = -4
	medical_record_text = "Patient is uncongenial, and does not enjoy having company."
	hardcore_value = 5
	var/static/time_to_bad_mood = 5 MINUTES
	var/time_company = 0

/datum/quirk/uncongenial/add_to_holder(mob/living/new_holder, quirk_transfer)
	. = ..()
	START_PROCESSING(SSslow_processing, src)

/datum/quirk/uncongenial/remove_from_current_holder(quirk_transfer)
	STOP_PROCESSING(SSslow_processing, src)
	return ..()

/datum/quirk/uncongenial/process(delta_time)
	if(check_company())
		time_company += delta_time
		if(time_company >= 5 MINUTES)
			SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, "loneliness", /datum/mood_event/uncongenial)
		return
	time_company = 0
	SEND_SIGNAL(quirk_holder, COMSIG_CLEAR_MOOD_EVENT, "loneliness")

/datum/quirk/uncongenial/proc/check_company()
	. = FALSE
	var/enemy_range = world.view
	if(quirk_holder.is_blind())
		enemy_range = 1
	for(var/mob/living/enemy in fov_view(enemy_range, quirk_holder))
		if((enemy.stat < DEAD) && (enemy.ai_controller || enemy.mind))
			return TRUE

//Mostly used by parotin species
/datum/quirk/glass_bones
	name = "Glass Bones"
	desc = "Your bones are brittle and easily fractured."
	mood_desc = "My bones are easy to fracture."
	icon = "bone"
	value = -6
	medical_record_text = "Patient has porous bones that are especially prone to damage."
	hardcore_value = 5

/datum/quirk/glass_bones/add()
	var/mob/living/carbon/human/human_holder = quirk_holder
	for(var/obj/item/organ/bone/bone in human_holder.internal_organs)
		if(bone.is_robotic_organ())
			continue
		bone.name = "brittle [bone.name]"
		bone.wound_resistance -= 5
