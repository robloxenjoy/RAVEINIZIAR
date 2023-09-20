/datum/interaction/forbidden_fruits
	category = INTERACTION_CATEGORY_FORBIDDEN_FRUITS
	interaction_flags = INTERACTION_RESPECT_COOLDOWN|INTERACTION_NEEDS_PHYSICAL_CONTACT|INTERACTION_USER_CLIMAX|INTERACTION_TARGET_CLIMAX|INTERACTION_USER_LUST|INTERACTION_TARGET_LUST
	user_cooldown_duration = INTERACTION_COOLDOWN
	target_cooldown_duraction = INTERACTION_COOLDOWN
	user_sex_cooldown_duration = INTERACTION_COOLDOWN
	target_sex_cooldown_duraction = INTERACTION_COOLDOWN
	arousal_gain_target = AROUSAL_GAIN_NORMAL
	arousal_gain_user = AROUSAL_GAIN_NORMAL
	lust_gain_user = LUST_GAIN_NORMAL
	lust_gain_target = LUST_GAIN_NORMAL
	sound_volume = 65
	button_icon = "heart"
	var/gaysex_achievement = FALSE

/datum/interaction/forbidden_fruits/allow_interaction(datum/component/interactable/user, datum/component/interactable/target, silent = TRUE, check_cooldown = TRUE)
//	. = FALSE
	. = ..()
	if(!CONFIG_GET(flag/use_erp))
		return FALSE
	var/mob/living/carbon/human/humie_user = user.parent
	if(istype(humie_user))
		if(humie_user.arousal < 300)
			to_chat(user, span_love("I don't really want..."))
			return FALSE

/datum/interaction/forbidden_fruits/after_interact(datum/component/interactable/user, datum/component/interactable/target)
	. = ..()
	if(gaysex_achievement)
		var/mob/living/carbon/human/humie_user = user.parent
		var/mob/living/carbon/human/humie_target = target.parent
		if(istype(humie_user) && istype(humie_target) && (humie_user.gender == humie_target.gender))
			humie_user.client?.give_award(/datum/award/achievement/misc/faggot, humie_user)
			humie_target.client?.give_award(/datum/award/achievement/misc/faggot, humie_target)

//SELF INTERACTIONS
/datum/interaction/forbidden_fruits/masturbate
	name = "Jack Off"
	desc = "Jerk your soldier off."
	usage = INTERACT_SELF
	user_hands_required = 1
	message = list(span_love("%USER jerks themselves off."), \
				span_love("%USER strokes their soldier."), \
				span_love("%USER caresses their knob."))
	user_message = list(span_userlove("I jerk my weiner off."), \
				span_userlove("I stroke my soldier."), \
				span_userlove("I caress my knob."))
	sounds = list('modular_septic/sound/sexo/handjob1.ogg', \
				'modular_septic/sound/sexo/handjob2.ogg', \
				'modular_septic/sound/sexo/handjob3.ogg', \
				'modular_septic/sound/sexo/handjob4.ogg', \
				'modular_septic/sound/sexo/handjob5.ogg', \
				'modular_septic/sound/sexo/handjob6.ogg', \
				'modular_septic/sound/sexo/handjob7.ogg', \
				'modular_septic/sound/sexo/handjob8.ogg', \
				'modular_septic/sound/sexo/handjob9.ogg', \
				'modular_septic/sound/sexo/handjob10.ogg', \
				'modular_septic/sound/sexo/handjob11.ogg', \
				'modular_septic/sound/sexo/handjob12.ogg')
	sound_volume = 60
	button_icon = "fist-raised"

/datum/interaction/forbidden_fruits/masturbate/evaluate_user(datum/component/interactable/user, datum/component/interactable/target, silent)
	. = ..()
	var/mob/living/carbon/human/human_user = user.parent
	if((human_user.getorganslotefficiency(ORGAN_SLOT_PENIS) < ORGAN_FAILING_EFFICIENCY) || !human_user.genital_visible(ORGAN_SLOT_PENIS))
		return FALSE

/datum/interaction/forbidden_fruits/masturbate/do_interaction(datum/component/interactable/user, datum/component/interactable/target)
	. = ..()
	var/mob/living/fucker = user.parent
	INVOKE_ASYNC(fucker, /mob/.proc/do_fucking_animation)

/datum/interaction/forbidden_fruits/masturbate/handle_user_climax(datum/component/interactable/user, datum/component/interactable/target)
	var/mob/living/carbon/human/human_user = user.parent
	human_user.visible_message(span_love("<b>[human_user]</b> cums on their hands!"), \
							span_userlove("I cum on my hands!"))
	var/cum_receiver = human_user
	if(human_user.gloves)
		cum_receiver = human_user.gloves
	for(var/obj/item/organ/genital/genital in human_user.internal_organs)
		if(CHECK_BITFIELD(genital.genital_flags, GENITAL_CAN_CLIMAX))
			genital.handle_climax(cum_receiver, TOUCH)
	human_user.adjust_arousal(-1500)
	human_user.set_lust(0)
	human_user.SetStun(25)
	human_user.set_drugginess(25)
	SEND_SIGNAL(human_user, COMSIG_ADD_MOOD_EVENT, "sex", /datum/mood_event/goodmasturbation)
	return TRUE

/datum/interaction/forbidden_fruits/finger_self_vagina
	name = "Finger Your Vagina"
	desc = "Diddle your cunt."
	usage = INTERACT_SELF
	user_hands_required = 1
	message = list(span_love("%USER strokes their clit."), \
				span_love("%USER fingers their vagina."), \
				span_love("%USER caresses their cunt."))
	user_message = list(span_userlove("I stroke my clit."), \
				span_userlove("I finger my vagina."), \
				span_userlove("I caress my cunt."))
	sounds = list('modular_septic/sound/sexo/handjob1.ogg', \
				'modular_septic/sound/sexo/handjob2.ogg', \
				'modular_septic/sound/sexo/handjob3.ogg', \
				'modular_septic/sound/sexo/handjob4.ogg', \
				'modular_septic/sound/sexo/handjob5.ogg', \
				'modular_septic/sound/sexo/handjob6.ogg', \
				'modular_septic/sound/sexo/handjob7.ogg', \
				'modular_septic/sound/sexo/handjob8.ogg', \
				'modular_septic/sound/sexo/handjob9.ogg', \
				'modular_septic/sound/sexo/handjob10.ogg', \
				'modular_septic/sound/sexo/handjob11.ogg', \
				'modular_septic/sound/sexo/handjob12.ogg')
	sound_volume = 70
	button_icon = "hand-scissors"

/datum/interaction/forbidden_fruits/finger_self_vagina/evaluate_user(datum/component/interactable/user, datum/component/interactable/target, silent)
	. = ..()
	var/mob/living/carbon/human/human_user = user.parent
	if((human_user.getorganslotefficiency(ORGAN_SLOT_VAGINA) < ORGAN_FAILING_EFFICIENCY) || !human_user.genital_visible(ORGAN_SLOT_VAGINA))
		return FALSE

/datum/interaction/forbidden_fruits/finger_self_vagina/do_interaction(datum/component/interactable/user, datum/component/interactable/target)
	. = ..()
	var/mob/living/fucker = user.parent
	INVOKE_ASYNC(fucker, /mob/.proc/do_fucking_animation)

/datum/interaction/forbidden_fruits/finger_self_vagina/handle_user_climax(datum/component/interactable/user, datum/component/interactable/target)
	var/mob/living/carbon/human/human_user = user.parent
	human_user.visible_message(span_love("<b>[human_user]</b> squirts on their hands!"),\
							span_userlove("I squirt on my hands!"))
	var/cum_receiver = human_user
	if(human_user.gloves)
		cum_receiver = human_user.gloves
	for(var/obj/item/organ/genital/genital in human_user.internal_organs)
		if(CHECK_BITFIELD(genital.genital_flags, GENITAL_CAN_CLIMAX))
			genital.handle_climax(cum_receiver, TOUCH)
	human_user.adjust_arousal(-1500)
	human_user.set_lust(0)
	human_user.SetStun(25)
	human_user.set_drugginess(25)
	SEND_SIGNAL(human_user, COMSIG_ADD_MOOD_EVENT, "sex", /datum/mood_event/goodmasturbation)
	return TRUE

/datum/interaction/forbidden_fruits/finger_self_anus
	name = "Finger Your Anus"
	desc = "Diddle your anus."
	usage = INTERACT_SELF
	user_hands_required = 1
	message = list(span_love("%USER fingers their asshole."), \
				span_love("%USER strokes their asshole."))
	user_message = list(span_userlove("I finger my asshole."), \
				span_userlove("I stroke my asshole."))
	sounds = list('modular_septic/sound/sexo/handjob1.ogg', \
				'modular_septic/sound/sexo/handjob2.ogg', \
				'modular_septic/sound/sexo/handjob3.ogg', \
				'modular_septic/sound/sexo/handjob4.ogg', \
				'modular_septic/sound/sexo/handjob5.ogg', \
				'modular_septic/sound/sexo/handjob6.ogg', \
				'modular_septic/sound/sexo/handjob7.ogg', \
				'modular_septic/sound/sexo/handjob8.ogg', \
				'modular_septic/sound/sexo/handjob9.ogg', \
				'modular_septic/sound/sexo/handjob10.ogg', \
				'modular_septic/sound/sexo/handjob11.ogg', \
				'modular_septic/sound/sexo/handjob12.ogg')
	sound_volume = 70
	button_icon = "hand-point-up"

/datum/interaction/forbidden_fruits/finger_self_anus/evaluate_user(datum/component/interactable/user, datum/component/interactable/target, silent)
	. = ..()
	var/mob/living/carbon/human/human_user = user.parent
	if((human_user.getorganslotefficiency(ORGAN_SLOT_ANUS) < ORGAN_FAILING_EFFICIENCY) || !human_user.genital_visible(ORGAN_SLOT_ANUS))
		return FALSE

/datum/interaction/forbidden_fruits/finger_self_anus/do_interaction(datum/component/interactable/user, datum/component/interactable/target)
	. = ..()
	var/mob/living/fucker = user.parent
	INVOKE_ASYNC(fucker, /mob/.proc/do_fucking_animation)

/datum/interaction/forbidden_fruits/finger_self_anus/handle_user_climax(datum/component/interactable/user, datum/component/interactable/target)
	var/mob/living/carbon/human/human_user = user.parent
	if(human_user.getorganslot(ORGAN_SLOT_PENIS))
		human_user.visible_message(span_love("<b>[human_user]</b> cums on [human_user.loc]!"),\
								span_userlove("I cum on [human_user.loc]!"))
	else if(human_user.getorganslot(ORGAN_SLOT_VAGINA))
		human_user.visible_message(span_love("<b>[human_user]</b> squirts on [human_user.loc]!"),\
								span_userlove("I squirt on [human_user.loc]!"))
	else
		human_user.visible_message(span_love("<b>[human_user]</b> climaxes on [human_user.loc]!"),\
								span_userlove("I climax on [human_user.loc]!"))
	if(!human_user.Process_Spacemove(REVERSE_DIR(human_user.dir)))
		human_user.newtonian_move(REVERSE_DIR(human_user.dir))
	for(var/obj/item/organ/genital/genital in human_user.internal_organs)
		if(CHECK_BITFIELD(genital.genital_flags, GENITAL_CAN_CLIMAX))
			genital.handle_climax(get_turf(human_user), TOUCH)
	human_user.adjust_arousal(-1500)
	human_user.set_lust(0)
	human_user.SetStun(25)
	human_user.set_drugginess(25)
	SEND_SIGNAL(human_user, COMSIG_ADD_MOOD_EVENT, "goodsex", /datum/mood_event/goodmasturbation)
	return TRUE

//OTHER INTERACTIONS

//PASSIVE INTERACTIONS - TARGET CLIMAXES
/datum/interaction/forbidden_fruits/slapass
	name = "Slap Ass"
	desc = "Slap their ass. Make it wiggle."
	user_hands_required = 1
	message = span_love("%USER slaps %TARGET's ass!")
	user_message = span_userlove("I slap %TARGET's ass!")
	target_message = span_userlove("%USER slaps my ass!")
	sounds = 'sound/weapons/slap.ogg'
	arousal_gain_user = AROUSAL_GAIN_LOW
	arousal_gain_target = AROUSAL_GAIN_LOW
	lust_gain_user = LUST_GAIN_NONE
	lust_gain_target = LUST_GAIN_LOW
	sound_volume = 75
	button_icon = "hand-paper"

/datum/interaction/forbidden_fruits/slapass/evaluate_target(datum/component/interactable/user, datum/component/interactable/target, silent)
	. = ..()
	var/mob/living/carbon/human/human_target = target.parent
	if(!human_target.getorgan(/obj/item/organ/tendon/groin))
		return FALSE

/datum/interaction/forbidden_fruits/slapass/do_interaction(datum/component/interactable/user, datum/component/interactable/target)
	. = ..()
	var/mob/living/slapper = user.parent
	slapper.do_attack_animation(target.parent, ATTACK_EFFECT_DISARM, no_effect = TRUE)

/datum/interaction/forbidden_fruits/gropetits
	name = "Grope Tits"
	desc = "Grope their tits."
	user_hands_required = 1
	message = list(span_love("%USER gropes %TARGET's tits."), \
				span_love("%USER grip %TARGET's breasts."), \
				span_love("%USER squeezes %TARGET's honkers."), \
				span_love("%USER rubs %TARGET's tits."))
	user_message = list(span_userlove("I grope %TARGET's tits."), \
				span_userlove("I grip %TARGET's breasts."), \
				span_userlove("I squeeze %TARGET's honkers."), \
				span_userlove("I rub %TARGET's tits."))
	target_message = list(span_userlove("%USER gropes my tits!"), \
				span_userlove("%USER grips my breasts."), \
				span_userlove("%USER squeezes my honkers."), \
				span_userlove("%USER rubs tits."))
	lust_gain_user = LUST_GAIN_LOW
	lust_gain_target = LUST_GAIN_LOW
	button_icon = "hand-paper"

/datum/interaction/forbidden_fruits/gropetits/evaluate_target(datum/component/interactable/user, datum/component/interactable/target, silent)
	. = ..()
	var/mob/living/carbon/human/human_target = target.parent
	if(!human_target.getorganslot(ORGAN_SLOT_BREASTS))
		return FALSE

/datum/interaction/forbidden_fruits/gropetits/do_interaction(datum/component/interactable/user, datum/component/interactable/target)
	. = ..()
	var/mob/living/fucker = user.parent
	INVOKE_ASYNC(fucker, /mob/.proc/do_fucking_animation, get_dir(user.parent, target.parent))

/datum/interaction/forbidden_fruits/licknipples
	name = "Lick Nipples"
	desc = "Lick their nipples."
	message = list(span_love("%USER licks %TARGET's nipples."), \
				span_love("%USER nibs %TARGET's nipples."))
	user_message = list(span_userlove("I lick %TARGET's nipples."), \
				span_userlove("I nib on %TARGET's nipples."))
	target_message = list(span_userlove("%USER licks my nipples."), \
				span_userlove("%USER nibs my nipples."))
	lust_gain_user = LUST_GAIN_LOW
	lust_gain_target = LUST_GAIN_LOW
	sound_volume = 50
	button_icon = "grin-tongue"

/datum/interaction/forbidden_fruits/licknipples/evaluate_user(datum/component/interactable/user, datum/component/interactable/target, silent)
	. = ..()
	var/mob/living/carbon/human/human_user = user.parent
	if(!human_user.get_bodypart_nostump(BODY_ZONE_PRECISE_MOUTH))
		return FALSE
	if((human_user.getorganslotefficiency(ORGAN_SLOT_TONGUE) < ORGAN_FAILING_EFFICIENCY) || human_user.is_mouth_covered())
		return FALSE

/datum/interaction/forbidden_fruits/licknipples/evaluate_target(datum/component/interactable/user, datum/component/interactable/target, silent)
	. = ..()
	var/mob/living/carbon/human/human_target = target.parent
	if(LAZYLEN(human_target.clothingonpart(BODY_ZONE_CHEST)))
		return FALSE

/datum/interaction/forbidden_fruits/licknipples/do_interaction(datum/component/interactable/user, datum/component/interactable/target)
	. = ..()
	var/mob/living/fucker = user.parent
	INVOKE_ASYNC(fucker, /mob/.proc/do_fucking_animation, get_dir(user.parent, target.parent))

/datum/interaction/forbidden_fruits/sucknipples
	name = "Suck Nipples"
	desc = "Suck their nipples."
	message = list(span_love("%USER sucks %TARGET's nipples."), \
				span_love("%USER suckles on %TARGET's nipples."))
	user_message = list(span_userlove("I suck %TARGET's nipples."), \
				span_userlove("I suckle on %TARGET's nipples."))
	target_message = list(span_userlove("%USER suck my nipples."), \
				span_userlove("%USER suckles on my nipples."))
	lust_gain_user = LUST_GAIN_LOW
	lust_gain_target = LUST_GAIN_LOW
	sound_volume = 55
	button_icon = "kiss"

/datum/interaction/forbidden_fruits/sucknipples/do_interaction(datum/component/interactable/user, datum/component/interactable/target)
	if(user.last_interaction_as_user != src)
		message = list(span_love("%USER starts sucking %TARGET's nipples."), \
					span_love("%USER starts suckling on %TARGET's nipples."))
		user_message = list(span_userlove("I start sucking %TARGET's nipples."), \
					span_userlove("I start suckling on %TARGET's nipples."))
		target_message = list(span_userlove("%USER starts sucking my nipples."), \
					span_userlove("%USER starts suckling on my nipples."))
	else
		message = list(span_love("%USER sucks %TARGET's nipples."), \
					span_love("%USER suckles on %TARGET's nipples."))
		user_message = list(span_userlove("I suck %TARGET's nipples."), \
					span_userlove("I suckle on %TARGET's nipples."))
		target_message = list(span_userlove("%USER suck my nipples."), \
					span_userlove("%USER suckles on my nipples."))
	. = ..()
	var/mob/living/fucker = user.parent
	INVOKE_ASYNC(fucker, /mob/.proc/do_fucking_animation, get_dir(user.parent, target.parent))

/datum/interaction/forbidden_fruits/sucknipples/evaluate_user(datum/component/interactable/user, datum/component/interactable/target, silent)
	. = ..()
	var/mob/living/carbon/human/human_user = user.parent
	if(!human_user.get_bodypart_nostump(BODY_ZONE_PRECISE_MOUTH))
		return FALSE
	if((human_user.getorganslotefficiency(ORGAN_SLOT_TONGUE) < ORGAN_FAILING_EFFICIENCY) || human_user.is_mouth_covered())
		return FALSE

/datum/interaction/forbidden_fruits/sucknipples/evaluate_target(datum/component/interactable/user, datum/component/interactable/target, silent)
	. = ..()
	var/mob/living/carbon/human/human_target = target.parent
	if(LAZYLEN(human_target.clothingonpart(BODY_ZONE_CHEST)))
		return FALSE

/datum/interaction/forbidden_fruits/sucknipples/do_interaction(datum/component/interactable/user, datum/component/interactable/target)
	. = ..()
	var/mob/living/fucker = user.parent
	INVOKE_ASYNC(fucker, /mob/.proc/do_fucking_animation, get_dir(user.parent, target.parent))

/datum/interaction/forbidden_fruits/sucknipples/after_interact(datum/component/interactable/user, datum/component/interactable/target)
	. = ..()
	var/mob/living/carbon/human/human_user = user.parent
	var/mob/living/carbon/human/human_target = target.parent
	var/obj/item/organ/breasts = human_target.getorganslot(ORGAN_SLOT_BREASTS)
	if(breasts)
		breasts.reagents?.trans_to(human_user, 2 * (human_target.getorganslotefficiency(ORGAN_SLOT_BREASTS)/ORGAN_OPTIMAL_EFFICIENCY), methods = INGEST)

/datum/interaction/forbidden_fruits/lickfeet
	name = "Lick Feet"
	desc = "Lick their feet."
	message = span_love("%USER licks %TARGET's feet.")
	user_message = span_userlove("I lick %TARGET's feet.")
	target_message = span_userlove("%USER licks my feet.")
	lust_gain_user = LUST_GAIN_LOW
	lust_gain_target = LUST_GAIN_LOW
	sounds = list('modular_septic/sound/sexo/foot_wet1.ogg', \
				'modular_septic/sound/sexo/foot_wet2.ogg', \
				'modular_septic/sound/sexo/foot_wet3.ogg')
	sound_volume = 50
	maximum_distance = 0
	button_icon = "socks"

/datum/interaction/forbidden_fruits/lickfeet/evaluate_user(datum/component/interactable/user, datum/component/interactable/target, silent)
	. = ..()
	var/mob/living/carbon/human/human_user = user.parent
	if(!human_user.get_bodypart_nostump(BODY_ZONE_PRECISE_MOUTH))
		return FALSE
	if((human_user.getorganslotefficiency(ORGAN_SLOT_TONGUE) < ORGAN_FAILING_EFFICIENCY) || human_user.is_mouth_covered())
		return FALSE

/datum/interaction/forbidden_fruits/lickfeet/evaluate_target(datum/component/interactable/user, datum/component/interactable/target, silent)
	. = ..()
	var/mob/living/carbon/human/human_target = target.parent
	if(!human_target.get_bodypart_nostump(BODY_ZONE_PRECISE_L_FOOT) && !human_target.get_bodypart_nostump(BODY_ZONE_PRECISE_R_FOOT))
		return FALSE

/datum/interaction/forbidden_fruits/lickfeet/do_interaction(datum/component/interactable/user, datum/component/interactable/target)
	var/mob/living/carbon/human/human_target = target.parent
	if(target.last_interaction_as_user != src)
		if(human_target.shoes)
			message = span_love("%USER starts licking %TARGET's [human_target.shoes].")
			user_message = span_userlove("I starts licking %TARGET's [human_target.shoes].")
			target_message = span_userlove("%USER starts licking my [human_target.shoes].")
		else
			message = span_love("%USER starts licking %TARGET's feet.")
			user_message = span_userlove("I start licking %TARGET's feet.")
			target_message = span_userlove("%USER starts licking my feet.")
	else
		if(human_target.shoes)
			message = span_love("%USER licks %TARGET's [human_target.shoes].")
			user_message = span_userlove("I lick %TARGET's [human_target.shoes].")
			target_message = span_userlove("%USER licks my [human_target.shoes].")
		else
			message = span_love("%USER licks %TARGET's feet.")
			user_message = span_userlove("I lick %TARGET's feet.")
			target_message = span_userlove("%USER licks my feet.")
	. = ..()
	var/mob/living/fucker = user.parent
	INVOKE_ASYNC(fucker, /mob/.proc/do_fucking_animation, get_dir(user.parent, target.parent))

/datum/interaction/forbidden_fruits/face_feet
	name = "Grind Feet"
	desc = "Grind your feet against their mouth."
	maximum_distance = 0
	message = list(span_love("%USER presses their foot further into %TARGET's mouth."), \
				span_love("%USER wiggles their toes inside %TARGET's mouth."), \
				span_love("%USER grinds their sole on %TARGET's tongue."))
	user_message = list(span_userlove("I press my foot further into %TARGET's mouth."), \
			span_userlove("I wiggle my toes inside %TARGET's mouth."), \
			span_userlove("I grind my sole on %TARGET's tongue."))
	target_message = list(span_userlove("%USER presses their foot further into my mouth"), \
			span_userlove("%USER wiggles their toes inside my mouth."), \
			span_userlove("%USER grinds their sole on my tongue."))
	lust_gain_user = LUST_GAIN_LOW
	lust_gain_target = LUST_GAIN_LOW
	sounds = list('modular_septic/sound/sexo/foot_wet1.ogg', \
				'modular_septic/sound/sexo/foot_wet2.ogg', \
				'modular_septic/sound/sexo/foot_wet3.ogg')
	sound_volume = 50
	button_icon = "shoe-prints"

/datum/interaction/forbidden_fruits/face_feet/evaluate_user(datum/component/interactable/user, datum/component/interactable/target, silent)
	. = ..()
	var/mob/living/carbon/human/human_user = user.parent
	if(!human_user.get_bodypart_nostump(BODY_ZONE_PRECISE_MOUTH))
		return FALSE
	if(!human_user.get_bodypart_nostump(BODY_ZONE_PRECISE_L_FOOT) && !human_user.get_bodypart_nostump(BODY_ZONE_PRECISE_R_FOOT))
		return FALSE

/datum/interaction/forbidden_fruits/face_feet/evaluate_target(datum/component/interactable/user, datum/component/interactable/target, silent)
	. = ..()
	var/mob/living/carbon/human/human_target = target.parent
	if((human_target.getorganslotefficiency(ORGAN_SLOT_TONGUE) < ORGAN_FAILING_EFFICIENCY) || human_target.is_mouth_covered())
		return FALSE

/datum/interaction/forbidden_fruits/face_feet/do_interaction(datum/component/interactable/user, datum/component/interactable/target)
	var/mob/living/carbon/human/human_user = user.parent
	if(target.last_interaction_as_user != src)
		if(human_user.shoes)
			message = list(span_love("%USER grinds the tip of their [human_user.shoes] on %TARGET's lips."), \
					span_love("%USER forces their [human_user.shoes] inside %TARGET's mouth."))
			user_message = list(span_userlove("I grind the tip of my [human_user.shoes] on %TARGET's lips."), \
					span_userlove("I force my [human_user.shoes] inside %TARGET's mouth."))
			target_message = list(span_userlove("%USER grinds the tip of their [human_user.shoes] on my lips."), \
					span_userlove("%USER forces their [human_user.shoes] inside my mouth."))
		else
			message = list(span_love("%USER grinds the tip of their toes on %TARGET's lips."), \
					span_love("%USER forces their foot inside %TARGET's mouth."))
			user_message = list(span_userlove("I grind the tip of my toes on %TARGET's lips."), \
					span_userlove("I force my foot inside %TARGET's mouth."))
			target_message = list(span_userlove("%USER grinds their toes on my lips."), \
					span_userlove("%USER forces their foot inside my mouth."))
	else
		if(human_user.shoes)
			message = list(span_love("%USER presses their [human_user.shoes] further into %TARGET's mouth."), \
						span_love("%USER wiggles their [human_user.shoes] inside %TARGET's mouth."), \
						span_love("%USER grinds the sole of my [human_user.shoes] on %TARGET's tongue."))
			user_message = list(span_userlove("I press my [human_user.shoes] further into %TARGET's mouth."), \
					span_userlove("I wiggle my [human_user.shoes] inside %TARGET's mouth."), \
					span_userlove("I grind the sole of my [human_user.shoes] on %TARGET's tongue."))
			target_message = list(span_userlove("%USER presses their [human_user.shoes] further into my mouth"), \
					span_userlove("%USER wiggles their [human_user.shoes] inside my mouth."), \
					span_userlove("%USER grinds the sole of their [human_user.shoes] on my tongue."))
		else
			message = list(span_love("%USER presses their foot further into %TARGET's mouth."), \
						span_love("%USER wiggles their toes inside %TARGET's mouth."), \
						span_love("%USER grinds their sole on %TARGET's tongue."))
			user_message = list(span_userlove("I press my foot further into %TARGET's mouth."), \
					span_userlove("I wiggle my toes inside %TARGET's mouth."), \
					span_userlove("I grind my sole on %TARGET's tongue."))
			target_message = list(span_userlove("%USER presses their foot further into my mouth"), \
					span_userlove("%USER wiggles their toes inside my mouth."), \
					span_userlove("%USER grinds their sole on my tongue."))
	. = ..()
	var/mob/living/fucker = user.parent
	INVOKE_ASYNC(fucker, /mob/.proc/do_fucking_animation, get_dir(user.parent, target.parent))

/datum/interaction/forbidden_fruits/handjob
	name = "Handjob"
	desc = "Jerk their soldier off."
	user_hands_required = 1
	message = list(span_love("%USER strokes %TARGET's shaft."), \
				span_love("%USER wanks %TARGET's cock."), \
				span_love("%USER jerks %TARGET's knob."))
	user_message = list(span_userlove("I stroke %TARGET's shaft."), \
				span_userlove("I wank %TARGET's cock."), \
				span_userlove("I jerk %TARGET's knob."))
	target_message = list(span_userlove("%USER strokes my shaft."), \
				span_userlove("%USER wanks my cock."), \
				span_userlove("%USER jerks my knob."))
	sounds = list('modular_septic/sound/sexo/handjob1.ogg', \
				'modular_septic/sound/sexo/handjob2.ogg', \
				'modular_septic/sound/sexo/handjob3.ogg', \
				'modular_septic/sound/sexo/handjob4.ogg', \
				'modular_septic/sound/sexo/handjob5.ogg', \
				'modular_septic/sound/sexo/handjob6.ogg', \
				'modular_septic/sound/sexo/handjob7.ogg', \
				'modular_septic/sound/sexo/handjob8.ogg', \
				'modular_septic/sound/sexo/handjob9.ogg', \
				'modular_septic/sound/sexo/handjob10.ogg', \
				'modular_septic/sound/sexo/handjob11.ogg', \
				'modular_septic/sound/sexo/handjob12.ogg')
	sound_volume = 65
	lust_gain_user = LUST_GAIN_LOW
	lust_gain_target = LUST_GAIN_NORMAL
	button_icon = "fist-raised"
	gaysex_achievement = TRUE

/datum/interaction/forbidden_fruits/handjob/evaluate_target(datum/component/interactable/user, datum/component/interactable/target, silent)
	. = ..()
	var/mob/living/carbon/human/human_target = target.parent
	if((human_target.getorganslotefficiency(ORGAN_SLOT_PENIS) < ORGAN_FAILING_EFFICIENCY) || !human_target.genital_visible(ORGAN_SLOT_PENIS))
		return FALSE

/datum/interaction/forbidden_fruits/handjob/do_interaction(datum/component/interactable/user, datum/component/interactable/target)
	if(user.last_interaction_as_user != src)
		message = list(span_love("%USER wraps their hand around %TARGET's cock."), \
					span_love("%USER starts playing with %TARGET's cock."), \
					span_love("%USER starts stroking %TARGET's cock."))
		user_message = list(span_userlove("I wrap my hand around %TARGET's cock."), \
					span_userlove("I start playing with %TARGET's cock."), \
					span_userlove("I start stroking %TARGET's cock."))
		target_message = list(span_userlove("%USER wraps their hand around my cock."), \
					span_userlove("%USER starts playing with my cock."), \
					span_userlove("%USER starts stroking my cock."))
	else
		message = list(span_love("%USER strokes %TARGET's shaft."), \
					span_love("%USER wanks %TARGET's cock."), \
					span_love("%USER jerks %TARGET's knob."))
		user_message = list(span_userlove("I stroke %TARGET's shaft."), \
					span_userlove("I wank %TARGET's cock."), \
					span_userlove("I jerk %TARGET's knob."))
		target_message = list(span_userlove("%USER strokes my shaft."), \
					span_userlove("%USER wanks my cock."), \
					span_userlove("%USER jerks my knob."))
	. = ..()
	var/mob/living/fucker = user.parent
	INVOKE_ASYNC(fucker, /mob/.proc/do_fucking_animation, get_dir(user.parent, target.parent))

/datum/interaction/forbidden_fruits/handjob/handle_target_climax(datum/component/interactable/user, datum/component/interactable/target)
	var/mob/living/carbon/human/human_user = user.parent
	var/mob/living/carbon/human/human_target = target.parent
	human_target.visible_message(span_love("<b>[human_target]</b> cums on <b>[human_user]</b>'s hands!"),\
							span_userlove("I cum on <b>[human_user]</b>'s hands!"),
							ignored_mobs = human_user)
	to_chat(human_user, span_userlove("<b>[human_target]</b> cums on my hands!"))
	var/cum_receiver = human_user
	if(human_user.gloves)
		cum_receiver = human_user.gloves
	for(var/obj/item/organ/genital/genital in human_target.internal_organs)
		if(CHECK_BITFIELD(genital.genital_flags, GENITAL_CAN_CLIMAX))
			genital.handle_climax(cum_receiver, TOUCH)
	human_target.adjust_arousal(-1500)
	human_target.set_lust(0)
	human_target.SetStun(25)
	human_target.set_drugginess(25)
	SEND_SIGNAL(human_target, COMSIG_ADD_MOOD_EVENT, "goodsex", /datum/mood_event/goodsex)
	return TRUE

/datum/interaction/forbidden_fruits/finger_vagina
	name = "Finger Vagina"
	desc = "Finger their cunt."
	user_hands_required = 1
	message = list(span_love("%USER fingers %TARGET's pussy."), \
				span_love("%USER fingers %TARGET's cunt."), \
				span_love("%USER strokes %TARGET's pussy."))
	user_message = list(span_userlove("I finger %TARGET's pussy."), \
				span_love("I finger %TARGET's cunt."), \
				span_love("I stroke %TARGET's pussy."))
	target_message = list(span_userlove("%USER fingers my pussy."), \
				span_love("%USER fingers my cunt."), \
				span_love("%USER strokes my pussy."))
	sounds = list('modular_septic/sound/sexo/handjob1.ogg', \
				'modular_septic/sound/sexo/handjob2.ogg', \
				'modular_septic/sound/sexo/handjob3.ogg', \
				'modular_septic/sound/sexo/handjob4.ogg', \
				'modular_septic/sound/sexo/handjob5.ogg', \
				'modular_septic/sound/sexo/handjob6.ogg', \
				'modular_septic/sound/sexo/handjob7.ogg', \
				'modular_septic/sound/sexo/handjob8.ogg', \
				'modular_septic/sound/sexo/handjob9.ogg', \
				'modular_septic/sound/sexo/handjob10.ogg', \
				'modular_septic/sound/sexo/handjob11.ogg', \
				'modular_septic/sound/sexo/handjob12.ogg')
	sound_volume = 65
	lust_gain_user = LUST_GAIN_LOW
	lust_gain_target = LUST_GAIN_NORMAL
	button_icon = "hand-point-up"
	gaysex_achievement = TRUE

/datum/interaction/forbidden_fruits/finger_vagina/evaluate_target(datum/component/interactable/user, datum/component/interactable/target, silent)
	. = ..()
	var/mob/living/carbon/human/human_target = target.parent
	if((human_target.getorganslotefficiency(ORGAN_SLOT_VAGINA) < ORGAN_FAILING_EFFICIENCY) || !human_target.genital_visible(ORGAN_SLOT_VAGINA))
		return FALSE

/datum/interaction/forbidden_fruits/finger_vagina/do_interaction(datum/component/interactable/user, datum/component/interactable/target)
	if(user.last_interaction_as_user != src)
		message = list(span_love("%USER sticks their finger inside %TARGET's cunt."), \
					span_love("%USER starts fingering %TARGET's pussy."), \
					span_love("%USER starts playing with %TARGET's pussy."))
		user_message = list(span_userlove("I stick my finger inside %TARGET's cunt."), \
					span_userlove("I start fingering %TARGET's pussy."), \
					span_userlove("I start playing with %TARGET's pussy."))
		target_message = list(span_userlove("%USER sticks their finger inside my cunt."), \
					span_userlove("%USER starts fingering my pussy."), \
					span_userlove("%USER starts playing with my pussy."))
	else
		message = list(span_love("%USER fingers %TARGET's pussy."), \
					span_love("%USER fingers %TARGET's cunt."), \
					span_love("%USER strokes %TARGET's pussy."))
		user_message = list(span_userlove("I finger %TARGET's pussy."), \
					span_userlove("I finger %TARGET's cunt."), \
					span_userlove("I stroke %TARGET's pussy."))
		target_message = list(span_userlove("%USER fingers my pussy."), \
					span_userlove("%USER fingers my cunt."), \
					span_userlove("%USER strokes my pussy."))
	. = ..()
	var/mob/living/fucker = user.parent
	INVOKE_ASYNC(fucker, /mob/.proc/do_fucking_animation, get_dir(user.parent, target.parent))

/datum/interaction/forbidden_fruits/finger_vagina/handle_target_climax(datum/component/interactable/user, datum/component/interactable/target)
	var/mob/living/carbon/human/human_user = user.parent
	var/mob/living/carbon/human/human_target = target.parent
	human_target.visible_message(span_love("<b>[human_target]</b> squirts on <b>[human_user]</b>'s hands!"),\
							span_userlove("I squirt on <b>[human_user]</b>'s hands!"),
							ignored_mobs = human_user)
	to_chat(human_user, span_userlove("<b>[human_target]</b> squirts on my hands!"))
	var/cum_receiver = human_user
	if(human_user.gloves)
		cum_receiver = human_user.gloves
	for(var/obj/item/organ/genital/genital in human_target.internal_organs)
		if(CHECK_BITFIELD(genital.genital_flags, GENITAL_CAN_CLIMAX))
			genital.handle_climax(cum_receiver, TOUCH)
	human_target.adjust_arousal(-1500)
	human_target.set_lust(0)
	human_target.SetStun(25)
	human_target.set_drugginess(25)
	SEND_SIGNAL(human_target, COMSIG_ADD_MOOD_EVENT, "goodsex", /datum/mood_event/goodsex)
	return TRUE

/datum/interaction/forbidden_fruits/finger_asshole
	name = "Finger Ass"
	desc = "Finger their asshole."
	user_hands_required = 1
	message = list(span_love("%USER fingers %TARGET's ass."), \
				span_love("%USER fingers %TARGET's asshole."), \
				span_love("%USER strokes %TARGET's anus."))
	user_message = list(span_userlove("I finger %TARGET's ass."), \
				span_love("I finger %TARGET's asshole."), \
				span_love("I stroke %TARGET's anus."))
	target_message = list(span_userlove("%USER fingers my ass."), \
				span_love("%USER fingers my asshole."), \
				span_love("%USER strokes my anus."))
	sounds = list('modular_septic/sound/sexo/handjob1.ogg', \
				'modular_septic/sound/sexo/handjob2.ogg', \
				'modular_septic/sound/sexo/handjob3.ogg', \
				'modular_septic/sound/sexo/handjob4.ogg', \
				'modular_septic/sound/sexo/handjob5.ogg', \
				'modular_septic/sound/sexo/handjob6.ogg', \
				'modular_septic/sound/sexo/handjob7.ogg', \
				'modular_septic/sound/sexo/handjob8.ogg', \
				'modular_septic/sound/sexo/handjob9.ogg', \
				'modular_septic/sound/sexo/handjob10.ogg', \
				'modular_septic/sound/sexo/handjob11.ogg', \
				'modular_septic/sound/sexo/handjob12.ogg')
	sound_volume = 65
	lust_gain_user = LUST_GAIN_LOW
	lust_gain_target = LUST_GAIN_NORMAL
	button_icon = "hand-point-up"
	gaysex_achievement = TRUE

/datum/interaction/forbidden_fruits/finger_asshole/evaluate_target(datum/component/interactable/user, datum/component/interactable/target, silent)
	. = ..()
	var/mob/living/carbon/human/human_target = target.parent
	if((human_target.getorganslotefficiency(ORGAN_SLOT_ANUS) < ORGAN_FAILING_EFFICIENCY) || !human_target.genital_visible(ORGAN_SLOT_ANUS))
		return FALSE

/datum/interaction/forbidden_fruits/finger_asshole/do_interaction(datum/component/interactable/user, datum/component/interactable/target)
	if(user.last_interaction_as_user != src)
		message = list(span_love("%USER sticks their finger inside %TARGET's asshole."), \
					span_love("%USER starts fingering %TARGET's ass."), \
					span_love("%USER starts playing with %TARGET's anus."))
		user_message = list(span_userlove("I stick my finger inside %TARGET's asshole."), \
					span_userlove("I start fingering %TARGET's ass."), \
					span_userlove("I start playing with %TARGET's anus."))
		target_message = list(span_userlove("%USER sticks their finger inside my asshole."), \
					span_userlove("%USER starts fingering my ass."), \
					span_userlove("%USER starts playing with my anus."))
	else
		message = list(span_love("%USER fingers %TARGET's ass."), \
					span_love("%USER fingers %TARGET's asshole."), \
					span_love("%USER strokes %TARGET's anus."))
		user_message = list(span_userlove("I finger %TARGET's ass."), \
					span_love("I finger %TARGET's asshole."), \
					span_love("I stroke %TARGET's anus."))
		target_message = list(span_userlove("%USER fingers my ass."), \
					span_love("%USER fingers my asshole."), \
					span_love("%USER strokes my anus."))
	. = ..()
	var/mob/living/fucker = user.parent
	INVOKE_ASYNC(fucker, /mob/.proc/do_fucking_animation, get_dir(user.parent, target.parent))

/datum/interaction/forbidden_fruits/blowjob
	name = "Blowjob"
	desc = "Savor their knob."
	message = list(span_love("%USER sucks %TARGET's cock off."), \
				span_love("%USER runs their tongue up the shape of %TARGET's cock."), \
				span_love("%USER traces %TARGET's cock with their tongue."), \
				span_love("%USER darts the tip of their tongue around the tip of %TARGET's cock."), \
				span_love("%USER laps slowly at %TARGET's cock."), \
				span_love("%USER takes %TARGET's cock deep into their mouth."))
	user_message = list(span_userlove("I suck %TARGET's cock off."), \
				span_userlove("I run my tongue up the shape of %TARGET's cock."), \
				span_userlove("I trace %TARGET's cock with my tongue."), \
				span_userlove("I dart the tip of my tongue around the tip of %TARGET's cock."), \
				span_userlove("I lap slowly at %TARGET's cock."), \
				span_userlove("I take %TARGET's cock deep into my mouth."))
	target_message = list(span_userlove("%USER sucks my cock off."), \
				span_userlove("%USER runs their tongue up the shape of my cock."), \
				span_userlove("%USER traces my cock with their tongue."), \
				span_userlove("%USER darts the tip of their tongue around the tip of my cock."), \
				span_userlove("%USER laps slowly at my cock."), \
				span_userlove("%USER takes my cock deep into their mouth."))
	sounds = list('modular_septic/sound/sexo/bj1.ogg', \
				'modular_septic/sound/sexo/bj2.ogg', \
				'modular_septic/sound/sexo/bj3.ogg', \
				'modular_septic/sound/sexo/bj4.ogg', \
				'modular_septic/sound/sexo/bj5.ogg', \
				'modular_septic/sound/sexo/bj6.ogg', \
				'modular_septic/sound/sexo/bj7.ogg', \
				'modular_septic/sound/sexo/bj8.ogg', \
				'modular_septic/sound/sexo/bj9.ogg', \
				'modular_septic/sound/sexo/bj10.ogg', \
				'modular_septic/sound/sexo/bj11.ogg', \
				'modular_septic/sound/sexo/bj12.ogg', \
				'modular_septic/sound/sexo/bj13.ogg')
	sound_volume = 70
	button_icon = "kiss-beam"
	gaysex_achievement = TRUE

/datum/interaction/forbidden_fruits/blowjob/evaluate_user(datum/component/interactable/user, datum/component/interactable/target, silent)
	. = ..()
	var/mob/living/carbon/human/human_user = user.parent
	if(!human_user.get_bodypart_nostump(BODY_ZONE_PRECISE_MOUTH))
		return FALSE
	if((human_user.getorganslotefficiency(ORGAN_SLOT_TONGUE) < ORGAN_FAILING_EFFICIENCY) || human_user.is_mouth_covered())
		return FALSE

/datum/interaction/forbidden_fruits/blowjob/evaluate_target(datum/component/interactable/user, datum/component/interactable/target, silent)
	. = ..()
	var/mob/living/carbon/human/human_target = target.parent
	if((human_target.getorganslotefficiency(ORGAN_SLOT_PENIS) < ORGAN_FAILING_EFFICIENCY) || !human_target.genital_visible(ORGAN_SLOT_PENIS))
		return FALSE

/datum/interaction/forbidden_fruits/blowjob/do_interaction(datum/component/interactable/user, datum/component/interactable/target)
	if(user.last_interaction_as_user != src)
		message = list(span_love("%USER takes %TARGET's cock into their mouth."), \
					span_love("%USER wraps their lips around %TARGET's cock."), \
					span_love("%USER finds their mouth on top of %TARGET's cock."), \
					span_love("%USER grips %TARGET's legs and starts sucking their cock."), \
					span_love("%USER starts going down on %TARGET's cock."))
		user_message = list(span_userlove("I take %TARGET's cock into my mouth."), \
					span_userlove("I wrap my lips around %TARGET's cock."), \
					span_userlove("I find my mouth on top of %TARGET's cock."), \
					span_userlove("I grip %TARGET's legs and start sucking their cock."), \
					span_userlove("I start going down on %TARGET's cock."))
		target_message = list(span_userlove("%USER takes my cock into their mouth."), \
					span_userlove("%USER wraps their lips around my cock."), \
					span_userlove("%USER finds their mouth on top of my cock."), \
					span_userlove("%USER grips my legs and starts sucking my cock."), \
					span_userlove("%USER starts going down on my cock."))
	else
		message = list(span_love("%USER sucks %TARGET's cock off."), \
					span_love("%USER runs their tongue up the shape of %TARGET's cock."), \
					span_love("%USER traces %TARGET's cock with their tongue."), \
					span_love("%USER darts the tip of their tongue around the tip of %TARGET's cock."), \
					span_love("%USER laps slowly at %TARGET's cock."), \
					span_love("%USER takes %TARGET's cock deep into their mouth."))
		user_message = list(span_userlove("I suck %TARGET's cock off."), \
					span_userlove("I run my tongue up the shape of %TARGET's cock."), \
					span_userlove("I trace %TARGET's cock with my tongue."), \
					span_userlove("I dart the tip of my tongue around the tip of %TARGET's cock."), \
					span_userlove("I lap slowly at %TARGET's cock."), \
					span_userlove("I take %TARGET's cock deep into my mouth."))
		target_message = list(span_userlove("%USER sucks my cock off."), \
					span_userlove("%USER runs their tongue up the shape of my cock."), \
					span_userlove("%USER traces my cock with their tongue."), \
					span_userlove("%USER darts the tip of their tongue around the tip of my cock."), \
					span_userlove("%USER laps slowly at my cock."), \
					span_userlove("%USER takes my cock deep into their mouth."))
	. = ..()
	var/mob/living/fucker = user.parent
	INVOKE_ASYNC(fucker, /mob/.proc/do_fucking_animation, get_dir(user.parent, target.parent))

/datum/interaction/forbidden_fruits/blowjob/handle_target_climax(datum/component/interactable/user, datum/component/interactable/target)
	var/mob/living/carbon/human/human_user = user.parent
	var/mob/living/carbon/human/human_target = target.parent
	human_target.visible_message(span_love("<b>[human_target]</b> cums inside <b>[human_user]</b>'s mouth!"),\
							span_userlove("I cum inside <b>[human_user]</b>'s mouth!"),
							ignored_mobs = human_user)
	to_chat(human_user, span_userlove("<b>[human_target]</b> cums inside my mouth!"))
	for(var/obj/item/organ/genital/genital in human_target.internal_organs)
		if(CHECK_BITFIELD(genital.genital_flags, GENITAL_CAN_CLIMAX))
			if(genital.handle_climax(human_user, INGEST))
				if(istype(genital, /obj/item/organ/genital/penis) || istype(genital, /obj/item/organ/genital/vagina))
					genital.cum_on_face(human_target)
	human_target.adjust_arousal(-1500)
	human_target.set_lust(0)
	human_target.SetStun(25)
	human_target.set_drugginess(25)
	SEND_SIGNAL(human_target, COMSIG_ADD_MOOD_EVENT, "goodsex", /datum/mood_event/goodsex)
	return TRUE

/datum/interaction/forbidden_fruits/godownon
	name = "Go Down On"
	desc = "Savor their cunt. Mmm."
	message = list(span_love("%USER licks %TARGET's pussy."), \
				span_love("%USER runs their tongue up the shape of %TARGET's pussy."), \
				span_love("%USER traces %TARGET's slit with their tongue."), \
				span_love("%USER darts the tip of their tongue around %TARGET's clit."), \
				span_love("%USER laps slowly at %TARGET's pussy."), \
				span_love("%USER licks %TARGET's vaginal folds."))
	user_message = list(span_userlove("I lick %TARGET's pussy."), \
				span_userlove("I run my tongue up the shape of %TARGET's pussy."), \
				span_userlove("I trace %TARGET's slit with my tongue."), \
				span_userlove("I dart the tip of my tongue around %TARGET's clit."), \
				span_userlove("I lap slowly at %TARGET's pussy."), \
				span_userlove("I lick %TARGET's vaginal folds."))
	target_message = list(span_userlove("%USER licks my pussy."), \
				span_userlove("%USER runs their tongue up the shape of my pussy."), \
				span_userlove("%USER traces my slit with their tongue."), \
				span_userlove("%USER darts the tip of their tongue around my clit."), \
				span_userlove("%USER laps slowly at my pussy."), \
				span_userlove("%USER licks my vaginal folds."))
	sounds = list('modular_septic/sound/sexo/bj1.ogg', \
				'modular_septic/sound/sexo/bj2.ogg', \
				'modular_septic/sound/sexo/bj3.ogg', \
				'modular_septic/sound/sexo/bj4.ogg', \
				'modular_septic/sound/sexo/bj5.ogg', \
				'modular_septic/sound/sexo/bj6.ogg', \
				'modular_septic/sound/sexo/bj7.ogg', \
				'modular_septic/sound/sexo/bj8.ogg', \
				'modular_septic/sound/sexo/bj9.ogg', \
				'modular_septic/sound/sexo/bj10.ogg', \
				'modular_septic/sound/sexo/bj11.ogg', \
				'modular_septic/sound/sexo/bj12.ogg', \
				'modular_septic/sound/sexo/bj13.ogg')
	sound_volume = 70
	button_icon = "grin-tongue-squint"
	gaysex_achievement = TRUE

/datum/interaction/forbidden_fruits/godownon/evaluate_user(datum/component/interactable/user, datum/component/interactable/target, silent)
	. = ..()
	var/mob/living/carbon/human/human_user = user.parent
	if(!human_user.get_bodypart_nostump(BODY_ZONE_PRECISE_MOUTH))
		return FALSE
	if((human_user.getorganslotefficiency(ORGAN_SLOT_TONGUE) < ORGAN_FAILING_EFFICIENCY) || human_user.is_mouth_covered())
		return FALSE

/datum/interaction/forbidden_fruits/godownon/evaluate_target(datum/component/interactable/user, datum/component/interactable/target, silent)
	. = ..()
	var/mob/living/carbon/human/human_target = target.parent
	if((human_target.getorganslotefficiency(ORGAN_SLOT_VAGINA) < ORGAN_FAILING_EFFICIENCY) || !human_target.genital_visible(ORGAN_SLOT_VAGINA))
		return FALSE

/datum/interaction/forbidden_fruits/godownon/do_interaction(datum/component/interactable/user, datum/component/interactable/target)
	if(user.last_interaction_as_user != src)
		message = list(span_love("%USER buries their face into %TARGET's pussy."), \
					span_love("%USER nuzzles %TARGET's wet pussy."), \
					span_love("%USER finds their mouth on top of %TARGET's pussy."), \
					span_love("%USER grips %TARGET's legs and starts licking their pussy."), \
					span_love("%USER starts going down on %TARGET's pussy."))
		user_message = list(span_userlove("I bury my face into %TARGET's pussy."), \
					span_userlove("I nuzzle %TARGET's wet pussy."), \
					span_userlove("I find my mouth on top of %TARGET's pussy."), \
					span_userlove("I grip %TARGET's legs and start licking their pussy."), \
					span_userlove("I start going down on %TARGET's pussy."))
		target_message = list(span_userlove("%USER buries their face in my pussy."), \
					span_userlove("%USER nuzzles my wet pussy."), \
					span_userlove("%USER finds their mouth on top of my pussy."), \
					span_userlove("%USER grip my legs and starts licking my pussy."), \
					span_userlove("%USER starts going down on my pussy."))
	else
		message = list(span_love("%USER licks %TARGET's pussy."), \
					span_love("%USER runs their tongue up the shape of %TARGET's pussy."), \
					span_love("%USER traces %TARGET's slit with their tongue."), \
					span_love("%USER darts the tip of their tongue around %TARGET's clit."), \
					span_love("%USER laps slowly at %TARGET's pussy."), \
					span_love("%USER licks %TARGET's vaginal folds."))
		user_message = list(span_userlove("I lick %TARGET's pussy."), \
					span_userlove("I run my tongue up the shape of %TARGET's pussy."), \
					span_userlove("I trace %TARGET's slit with my tongue."), \
					span_userlove("I dart the tip of my tongue around %TARGET's clit."), \
					span_userlove("I lap slowly at %TARGET's pussy."), \
					span_userlove("I lick %TARGET's vaginal folds."))
		target_message = list(span_userlove("%USER licks my pussy."), \
					span_userlove("%USER runs their tongue up the shape of my pussy."), \
					span_userlove("%USER traces my slit with their tongue."), \
					span_userlove("%USER darts the tip of their tongue around my clit."), \
					span_userlove("%USER laps slowly at my pussy."), \
					span_userlove("%USER licks my vaginal folds."))
	. = ..()
	var/mob/living/fucker = user.parent
	INVOKE_ASYNC(fucker, /mob/.proc/do_fucking_animation, get_dir(user.parent, target.parent))

/datum/interaction/forbidden_fruits/godownon/handle_target_climax(datum/component/interactable/user, datum/component/interactable/target)
	var/mob/living/carbon/human/human_user = user.parent
	var/mob/living/carbon/human/human_target = target.parent
	human_target.visible_message(span_love("<b>[human_target]</b> squirts on <b>[human_user]</b>'s mouth!"),\
							span_userlove("I squirt on <b>[human_user]</b>'s mouth!"),
							ignored_mobs = human_user)
	to_chat(human_user, span_userlove("<b>[human_target]</b> squirts my mouth!"))
	for(var/obj/item/organ/genital/genital in human_target.internal_organs)
		if(CHECK_BITFIELD(genital.genital_flags, GENITAL_CAN_CLIMAX))
			if(genital.handle_climax(human_user, INGEST))
				if(istype(genital, /obj/item/organ/genital/penis) || istype(genital, /obj/item/organ/genital/vagina))
					genital.cum_on_face(human_target)
	human_target.adjust_arousal(-1500)
	human_target.set_lust(0)
	human_target.SetStun(25)
	human_target.set_drugginess(25)
	SEND_SIGNAL(human_target, COMSIG_ADD_MOOD_EVENT, "goodsex", /datum/mood_event/goodsex)
	return TRUE

/datum/interaction/forbidden_fruits/rimjob
	name = "Rimjob"
	desc = "Savor their asshole. Mmm."
	message = list(span_love("%USER licks %TARGET's asshole."), \
				span_love("%USER runs their tongue up %TARGET's asshole."), \
				span_love("%USER traces %TARGET's asshole with their tongue."), \
				span_love("%USER darts the tip of their tongue around %TARGET's asshole."),
				span_love("%USER licks %TARGET's vaginal asshole."))
	user_message = list(span_userlove("I lick %TARGET's asshole."), \
				span_userlove("I run my tongue up %TARGET's asshole."), \
				span_userlove("I trace %TARGET's asshole with my tongue."), \
				span_userlove("I dart the tip of my tongue around %TARGET's asshole."), \
				span_userlove("I lick %TARGET's asshole."))
	target_message = list(span_userlove("%USER licks my pussy."), \
				span_userlove("%USER runs their tongue up my asshole."), \
				span_userlove("%USER traces my asshole with their tongue."), \
				span_userlove("%USER darts the tip of their tongue around my asshole."), \
				span_userlove("%USER licks my asshole."))
	sounds = list('modular_septic/sound/sexo/bj1.ogg', \
				'modular_septic/sound/sexo/bj2.ogg', \
				'modular_septic/sound/sexo/bj3.ogg', \
				'modular_septic/sound/sexo/bj4.ogg', \
				'modular_septic/sound/sexo/bj5.ogg', \
				'modular_septic/sound/sexo/bj6.ogg', \
				'modular_septic/sound/sexo/bj7.ogg', \
				'modular_septic/sound/sexo/bj8.ogg', \
				'modular_septic/sound/sexo/bj9.ogg', \
				'modular_septic/sound/sexo/bj10.ogg', \
				'modular_septic/sound/sexo/bj11.ogg', \
				'modular_septic/sound/sexo/bj12.ogg', \
				'modular_septic/sound/sexo/bj13.ogg')
	sound_volume = 70
	button_icon = "grin-tongue-squint"
	gaysex_achievement = TRUE

/datum/interaction/forbidden_fruits/rimjob/evaluate_user(datum/component/interactable/user, datum/component/interactable/target, silent)
	. = ..()
	var/mob/living/carbon/human/human_user = user.parent
	if(!human_user.get_bodypart_nostump(BODY_ZONE_PRECISE_MOUTH))
		return FALSE
	if((human_user.getorganslotefficiency(ORGAN_SLOT_TONGUE) < ORGAN_FAILING_EFFICIENCY) || human_user.is_mouth_covered())
		return FALSE

/datum/interaction/forbidden_fruits/rimjob/evaluate_target(datum/component/interactable/user, datum/component/interactable/target, silent)
	. = ..()
	var/mob/living/carbon/human/human_target = target.parent
	if((human_target.getorganslotefficiency(ORGAN_SLOT_ANUS) < ORGAN_FAILING_EFFICIENCY) || !human_target.genital_visible(ORGAN_SLOT_ANUS))
		return FALSE

/datum/interaction/forbidden_fruits/rimjob/do_interaction(datum/component/interactable/user, datum/component/interactable/target)
	if(user.last_interaction_as_user != src)
		message = list(span_love("%USER buries their face into %TARGET's asshole."), \
					span_love("%USER nuzzles %TARGET's asshole."), \
					span_love("%USER finds their mouth on top of %TARGET's asshole."), \
					span_love("%USER grips %TARGET's legs and starts licking their asshole."), \
					span_love("%USER starts going down on %TARGET's asshole."))
		user_message = list(span_userlove("I bury my face into %TARGET's asshole."), \
					span_userlove("I nuzzle %TARGET's asshole."), \
					span_userlove("I find my mouth on top of %TARGET's asshole."), \
					span_userlove("I grip %TARGET's legs and start licking their asshole."), \
					span_userlove("I start going down on %TARGET's asshole."))
		target_message = list(span_userlove("%USER buries their face in my asshole."), \
					span_userlove("%USER nuzzles my asshole."), \
					span_userlove("%USER finds their mouth on top of my asshole."), \
					span_userlove("%USER grip my legs and starts licking my asshole."), \
					span_userlove("%USER starts licking my asshole."))
	else
		message = list(span_love("%USER licks %TARGET's asshole."), \
					span_love("%USER runs their tongue up %TARGET's asshole."), \
					span_love("%USER traces %TARGET's asshole with their tongue."), \
					span_love("%USER darts the tip of their tongue around %TARGET's asshole."),
					span_love("%USER licks %TARGET's vaginal asshole."))
		user_message = list(span_userlove("I lick %TARGET's asshole."), \
					span_userlove("I run my tongue up %TARGET's asshole."), \
					span_userlove("I trace %TARGET's asshole with my tongue."), \
					span_userlove("I dart the tip of my tongue around %TARGET's asshole."), \
					span_userlove("I lick %TARGET's asshole."))
		target_message = list(span_userlove("%USER licks my pussy."), \
					span_userlove("%USER runs their tongue up my asshole."), \
					span_userlove("%USER traces my asshole with their tongue."), \
					span_userlove("%USER darts the tip of their tongue around my asshole."), \
					span_userlove("%USER licks my asshole."))
	. = ..()
	var/mob/living/fucker = user.parent
	INVOKE_ASYNC(fucker, /mob/.proc/do_fucking_animation, get_dir(user.parent, target.parent))

/datum/interaction/forbidden_fruits/rimjob/handle_target_climax(datum/component/interactable/user, datum/component/interactable/target)
	var/mob/living/carbon/human/human_user = user.parent
	var/mob/living/carbon/human/human_target = target.parent
	if(human_target.getorganslot(ORGAN_SLOT_PENIS))
		human_target.visible_message(span_love("<b>[human_target]</b> cums on [human_user]!"), \
								span_userlove("I cum on [human_user]!"), \
								ignored_mobs = human_user)
		to_chat(human_user, span_userlove("<b>[human_target]</b> cums on me!"))
	else if(human_target.getorganslot(ORGAN_SLOT_VAGINA))
		human_target.visible_message(span_love("<b>[human_target]</b> squirts on [human_user]!"), \
								span_userlove("I squirt on [human_user]!"), \
								ignored_mobs = human_user)
		to_chat(human_user, span_userlove("<b>[human_target]</b> squirts on me!"))
	else
		human_target.visible_message(span_love("<b>[human_target]</b> climaxes on [human_user]!"), \
								span_userlove("I climax on [human_user]!"), \
								ignored_mobs = human_user)
		to_chat(human_user, span_userlove("<b>[human_target]</b> climaxes on me!"))
	for(var/obj/item/organ/genital/genital in human_target.internal_organs)
		if(CHECK_BITFIELD(genital.genital_flags, GENITAL_CAN_CLIMAX))
			genital.handle_climax(human_user, TOUCH)
	human_target.adjust_arousal(-1500)
	human_target.set_lust(0)
	human_target.SetStun(25)
	human_target.set_drugginess(25)
	SEND_SIGNAL(human_target, COMSIG_ADD_MOOD_EVENT, "goodsex", /datum/mood_event/goodsex)
	return TRUE

/datum/interaction/forbidden_fruits/titjob
	name = "Titjob"
	desc = "Coddle their knob with your jugs."
	message = list(span_love("%USER coddles %TARGET's cock with their breasts."), \
				span_love("%USER presses %TARGET's cock between their breasts."), \
				span_love("%USER rubs %TARGET's cock between their breasts."))
	user_message = list(span_userlove("I coddle %TARGET's cock with my breasts."), \
				span_userlove("I press %TARGET's cock between my breasts."), \
				span_userlove("I rub %TARGET's cock between my breasts."))
	target_message = list(span_userlove("%USER coddles my cock with their breasts."), \
				span_userlove("%USER presses my cock between their breasts."), \
				span_userlove("%USER rubs my cock between their breasts."))
	sounds = list('modular_septic/sound/sexo/bang1.ogg', \
				'modular_septic/sound/sexo/bang2.ogg', \
				'modular_septic/sound/sexo/bang3.ogg', \
				'modular_septic/sound/sexo/bang4.ogg', \
				'modular_septic/sound/sexo/bang5.ogg', \
				'modular_septic/sound/sexo/bang6.ogg')
	sound_volume = 70
	button_icon = "hotdog"
	gaysex_achievement = TRUE

/datum/interaction/forbidden_fruits/titjob/evaluate_user(datum/component/interactable/user, datum/component/interactable/target, silent)
	. = ..()
	var/mob/living/carbon/human/human_user = user.parent
	if((human_user.getorganslotefficiency(ORGAN_SLOT_BREASTS) < ORGAN_FAILING_EFFICIENCY) || !human_user.genital_visible(ORGAN_SLOT_BREASTS))
		return FALSE

/datum/interaction/forbidden_fruits/titjob/evaluate_target(datum/component/interactable/user, datum/component/interactable/target, silent)
	. = ..()
	var/mob/living/carbon/human/human_target = target.parent
	if((human_target.getorganslotefficiency(ORGAN_SLOT_PENIS) < ORGAN_FAILING_EFFICIENCY) || !human_target.genital_visible(ORGAN_SLOT_PENIS))
		return FALSE

/datum/interaction/forbidden_fruits/titjob/do_interaction(datum/component/interactable/user, datum/component/interactable/target)
	if(user.last_interaction_as_user != src)
		message = span_love("%USER push their breasts together around %TARGET's cock.")
		user_message = span_userlove("I push my breasts together around %TARGET's cock.")
		target_message = span_userlove("%USER pushes their breasts together around my cock.")
	else
		message = list(span_love("%USER coddles %TARGET's cock with their breasts."), \
					span_love("%USER presses %TARGET's cock between their breasts."), \
					span_love("%USER rubs %TARGET's cock between their breasts."))
		user_message = list(span_userlove("I coddle %TARGET's cock with my breasts."), \
					span_userlove("I press %TARGET's cock between my breasts."), \
					span_userlove("I rub %TARGET's cock between my breasts."))
		target_message = list(span_userlove("%USER coddles my cock with their breasts."), \
					span_userlove("%USER presses my cock between their breasts."), \
					span_userlove("%USER rubs my cock between their breasts."))
	. = ..()
	var/mob/living/fucker = user.parent
	INVOKE_ASYNC(fucker, /mob/.proc/do_fucking_animation, get_dir(user.parent, target.parent))

/datum/interaction/forbidden_fruits/titjob/handle_target_climax(datum/component/interactable/user, datum/component/interactable/target)
	var/mob/living/carbon/human/human_user = user.parent
	var/mob/living/carbon/human/human_target = target.parent
	human_target.visible_message(span_love("<b>[human_target]</b> cums on <b>[human_target]</b>'s tits!"),\
							span_userlove("I cum on <b>[human_target]</b>'s tits!"),
							ignored_mobs = human_target)
	to_chat(human_user, span_userlove("<b>[human_target]</b> cums on my tits!"))
	for(var/obj/item/organ/genital/genital in human_target.internal_organs)
		if(CHECK_BITFIELD(genital.genital_flags, GENITAL_CAN_CLIMAX))
			if(genital.handle_climax(human_user, INGEST))
				if(istype(genital, /obj/item/organ/genital/penis) || istype(genital, /obj/item/organ/genital/vagina))
					genital.cum_on_face(human_target)
	human_target.adjust_arousal(-1500)
	human_target.set_lust(0)
	human_target.SetStun(25)
	human_target.set_drugginess(25)
	SEND_SIGNAL(human_target, COMSIG_ADD_MOOD_EVENT, "goodsex", /datum/mood_event/goodsex)
	return TRUE

//ACTIVE INTERACTIONS - USER CLIMAXES
/datum/interaction/forbidden_fruits/face_cock
	name = "Facefuck"
	desc = "Stick your cock inside their mouth."
	message = list(span_love("%USER fucks %TARGET's mouth."), \
				span_love("%USER forces their cock down %TARGET's mouth."), \
				span_love("%USER ravages %TARGET's mouth with their cock."))
	user_message = list(span_userlove("I fuck %TARGET's mouth."), \
				span_userlove("I force my cock down %TARGET's mouth."), \
				span_userlove("I ravage %TARGET's mouth with my cock."))
	target_message = list(span_userlove("%USER fucks my mouth."), \
				span_userlove("%USER forces their cock down my mouth."), \
				span_userlove("%USER ravages my mouth with their cock."))
	sounds = list('modular_septic/sound/sexo/bj1.ogg', \
				'modular_septic/sound/sexo/bj2.ogg', \
				'modular_septic/sound/sexo/bj3.ogg', \
				'modular_septic/sound/sexo/bj4.ogg', \
				'modular_septic/sound/sexo/bj5.ogg', \
				'modular_septic/sound/sexo/bj6.ogg', \
				'modular_septic/sound/sexo/bj7.ogg', \
				'modular_septic/sound/sexo/bj8.ogg', \
				'modular_septic/sound/sexo/bj9.ogg', \
				'modular_septic/sound/sexo/bj10.ogg', \
				'modular_septic/sound/sexo/bj11.ogg', \
				'modular_septic/sound/sexo/bj12.ogg', \
				'modular_septic/sound/sexo/bj13.ogg')
	sound_volume = 75
	button_icon = "surprise"
	gaysex_achievement = TRUE

/datum/interaction/forbidden_fruits/face_cock/evaluate_user(datum/component/interactable/user, datum/component/interactable/target, silent)
	. = ..()
	var/mob/living/carbon/human/human_user = user.parent
	if((human_user.getorganslotefficiency(ORGAN_SLOT_PENIS) < ORGAN_FAILING_EFFICIENCY) || !human_user.genital_visible(ORGAN_SLOT_PENIS))
		return FALSE

/datum/interaction/forbidden_fruits/face_cock/evaluate_target(datum/component/interactable/user, datum/component/interactable/target, silent)
	. = ..()
	var/mob/living/carbon/human/human_target = target.parent
	if(!human_target.get_bodypart_nostump(BODY_ZONE_PRECISE_MOUTH))
		return FALSE
	if((human_target.getorganslotefficiency(ORGAN_SLOT_TONGUE) < ORGAN_FAILING_EFFICIENCY) || human_target.is_mouth_covered())
		return FALSE

/datum/interaction/forbidden_fruits/face_cock/do_interaction(datum/component/interactable/user, datum/component/interactable/target)
	if(user.last_interaction_as_user != src)
		message = span_love("%USER pushes their cock inside %TARGET's mouth.")
		user_message = span_userlove("I push my cock inside %TARGET's mouth.")
		target_message = span_userlove("%USER pushes their cock inside my mouth.")
	else
		message = list(span_love("%USER fucks %TARGET's mouth."), \
					span_love("%USER forces their cock down %TARGET's mouth."), \
					span_love("%USER ravages %TARGET's mouth with their cock."))
		user_message = list(span_userlove("I fuck %TARGET's mouth."), \
					span_userlove("I force my cock down %TARGET's mouth."), \
					span_userlove("I ravage %TARGET's mouth with my cock."))
		target_message = list(span_userlove("%USER fucks my mouth."), \
					span_userlove("%USER forces their cock down my mouth."), \
					span_userlove("%USER ravages my mouth with their cock."))
	. = ..()
	var/mob/living/fucker = user.parent
	INVOKE_ASYNC(fucker, /mob/.proc/do_fucking_animation, get_dir(user.parent, target.parent))

/datum/interaction/forbidden_fruits/face_cock/handle_user_climax(datum/component/interactable/user, datum/component/interactable/target)
	var/mob/living/carbon/human/human_user = user.parent
	var/mob/living/carbon/human/human_target = target.parent
	human_user.visible_message(span_love("<b>[human_user]</b> cums inside <b>[human_target]</b>'s mouth!"),\
							span_userlove("I cum inside <b>[human_target]</b>'s mouth!"),
							ignored_mobs = human_target)
	to_chat(human_target, span_userlove("<b>[human_user]</b> cums inside my mouth!"))
	for(var/obj/item/organ/genital/genital in human_user.internal_organs)
		if(CHECK_BITFIELD(genital.genital_flags, GENITAL_CAN_CLIMAX))
			if(genital.handle_climax(human_target, INGEST))
				if(istype(genital, /obj/item/organ/genital/penis) || istype(genital, /obj/item/organ/genital/vagina))
					genital.cum_on_face(human_target)
	human_user.adjust_arousal(-1500)
	human_user.set_lust(0)
	human_user.SetStun(25)
	human_user.set_drugginess(25)
	SEND_SIGNAL(human_user, COMSIG_ADD_MOOD_EVENT, "sex", /datum/mood_event/goodsex)
	return TRUE

/datum/interaction/forbidden_fruits/face_vagina
	name = "Grind Pussy"
	desc = "Grind your pussy against their mouth."
	message = list(span_love("%USER grinds their pussy on %TARGET's mouth."), \
				span_love("%USER slides their pussy against %TARGET's mouth."), \
				span_love("%USER presses their pussy against %TARGET's mouth."))
	user_message = list(span_userlove("I grind my pussy on %TARGET's mouth."), \
				span_userlove("I slide my pussy on %TARGET's mouth."), \
				span_userlove("I press my pussy on %TARGET's mouth."))
	target_message = list(span_userlove("%USER grinds their pussy on my mouth."), \
				span_userlove("%USER slides their pussy against my mouth."), \
				span_userlove("%USER presses their pussy against my mouth"))
	sounds = list('modular_septic/sound/sexo/bj1.ogg', \
				'modular_septic/sound/sexo/bj2.ogg', \
				'modular_septic/sound/sexo/bj3.ogg', \
				'modular_septic/sound/sexo/bj4.ogg', \
				'modular_septic/sound/sexo/bj5.ogg', \
				'modular_septic/sound/sexo/bj6.ogg', \
				'modular_septic/sound/sexo/bj7.ogg', \
				'modular_septic/sound/sexo/bj8.ogg', \
				'modular_septic/sound/sexo/bj9.ogg', \
				'modular_septic/sound/sexo/bj10.ogg', \
				'modular_septic/sound/sexo/bj11.ogg', \
				'modular_septic/sound/sexo/bj12.ogg', \
				'modular_septic/sound/sexo/bj13.ogg')
	sound_volume = 75
	button_icon = "surprise"
	gaysex_achievement = TRUE

/datum/interaction/forbidden_fruits/face_vagina/evaluate_user(datum/component/interactable/user, datum/component/interactable/target, silent)
	. = ..()
	var/mob/living/carbon/human/human_user = user.parent
	if((human_user.getorganslotefficiency(ORGAN_SLOT_VAGINA) < ORGAN_FAILING_EFFICIENCY) || !human_user.genital_visible(ORGAN_SLOT_VAGINA))
		return FALSE

/datum/interaction/forbidden_fruits/face_vagina/evaluate_target(datum/component/interactable/user, datum/component/interactable/target, silent)
	. = ..()
	var/mob/living/carbon/human/human_target = target.parent
	if(!human_target.get_bodypart_nostump(BODY_ZONE_PRECISE_MOUTH))
		return FALSE
	if((human_target.getorganslotefficiency(ORGAN_SLOT_TONGUE) < ORGAN_FAILING_EFFICIENCY) || human_target.is_mouth_covered())
		return FALSE

/datum/interaction/forbidden_fruits/face_vagina/do_interaction(datum/component/interactable/user, datum/component/interactable/target)
	if(user.last_interaction_as_user != src)
		message = span_love("%USER forces %TARGET's face against their pussy.")
		user_message = span_userlove("I force %TARGET's face against my pussy.")
		target_message = span_userlove("%USER forces my face against their pussy.")
	else
		message = list(span_love("%USER grinds their pussy on %TARGET's mouth."), \
					span_love("%USER slides their pussy against %TARGET's mouth."), \
					span_love("%USER presses their pussy against %TARGET's mouth."))
		user_message = list(span_userlove("I grind my pussy on %TARGET's mouth."), \
					span_userlove("I slide my pussy on %TARGET's mouth."), \
					span_userlove("I press my pussy on %TARGET's mouth."))
		target_message = list(span_userlove("%USER grinds their pussy on my mouth."), \
					span_userlove("%USER slides their pussy against my mouth."), \
					span_userlove("%USER presses their pussy against my mouth"))
	. = ..()
	var/mob/living/fucker = user.parent
	INVOKE_ASYNC(fucker, /mob/.proc/do_fucking_animation, get_dir(user.parent, target.parent))

/datum/interaction/forbidden_fruits/face_vagina/handle_user_climax(datum/component/interactable/user, datum/component/interactable/target)
	var/mob/living/carbon/human/human_user = user.parent
	var/mob/living/carbon/human/human_target = target.parent
	human_user.visible_message(span_love("<b>[human_user]</b> squirts on <b>[human_target]</b>'s mouth!"),\
							span_userlove("I squirt on <b>[human_target]</b>'s mouth!"),
							ignored_mobs = human_target)
	to_chat(human_target, span_userlove("<b>[human_user]</b> squirts on my mouth!"))
	for(var/obj/item/organ/genital/genital in human_user.internal_organs)
		if(CHECK_BITFIELD(genital.genital_flags, GENITAL_CAN_CLIMAX))
			if(genital.handle_climax(human_target, INGEST))
				if(istype(genital, /obj/item/organ/genital/penis) || istype(genital, /obj/item/organ/genital/vagina))
					genital.cum_on_face(human_target)
	human_user.adjust_arousal(-1500)
	human_user.set_lust(0)
	human_user.SetStun(25)
	human_user.set_drugginess(25)
	SEND_SIGNAL(human_user, COMSIG_ADD_MOOD_EVENT, "sex", /datum/mood_event/goodsex)
	return TRUE

/datum/interaction/forbidden_fruits/face_ass
	name = "Grind Ass"
	desc = "Grind your ass against their mouth."
	message = list(span_love("%USER grinds their ass on %TARGET's mouth."), \
				span_love("%USER slides their ass against %TARGET's mouth."), \
				span_love("%USER presses their ass against %TARGET's mouth."))
	user_message = list(span_userlove("I grind my ass on %TARGET's mouth."), \
				span_userlove("I slide my ass on %TARGET's mouth."), \
				span_userlove("I press my ass  on%TARGET's mouth."))
	target_message = list(span_userlove("%USER grinds their ass on my mouth."), \
				span_userlove("%USER slides their ass against my mouth."), \
				span_userlove("%USER presses their ass against my mouth"))
	sounds = list('modular_septic/sound/sexo/bang1.ogg', \
				'modular_septic/sound/sexo/bang2.ogg', \
				'modular_septic/sound/sexo/bang3.ogg', \
				'modular_septic/sound/sexo/bang4.ogg', \
				'modular_septic/sound/sexo/bang5.ogg', \
				'modular_septic/sound/sexo/bang6.ogg')
	sound_volume = 75
	button_icon = "surprise"
	gaysex_achievement = TRUE

/datum/interaction/forbidden_fruits/face_ass/evaluate_user(datum/component/interactable/user, datum/component/interactable/target, silent)
	. = ..()
	var/mob/living/carbon/human/human_user = target.parent
	if((human_user.getorganslotefficiency(ORGAN_SLOT_ANUS) < ORGAN_FAILING_EFFICIENCY) || !human_user.genital_visible(ORGAN_SLOT_ANUS))
		return FALSE

/datum/interaction/forbidden_fruits/face_ass/do_interaction(datum/component/interactable/user, datum/component/interactable/target)
	if(user.last_interaction_as_user != src)
		message = span_love("%USER forces %TARGET's face against their ass.")
		user_message = span_userlove("I force %TARGET's face against my ass.")
		target_message = span_userlove("%USER forces my face against their ass.")
	else
		message = list(span_love("%USER grinds their ass on %TARGET's mouth."), \
					span_love("%USER slides their ass against %TARGET's mouth."), \
					span_love("%USER presses their ass against %TARGET's mouth."))
		user_message = list(span_userlove("I grind my ass on %TARGET's mouth."), \
					span_userlove("I slide my ass on %TARGET's mouth."), \
					span_userlove("I press my ass  on%TARGET's mouth."))
		target_message = list(span_userlove("%USER grinds their ass on my mouth."), \
					span_userlove("%USER slides their ass against my mouth."), \
					span_userlove("%USER presses their ass against my mouth"))
	. = ..()
	var/mob/living/fucker = user.parent
	INVOKE_ASYNC(fucker, /mob/.proc/do_fucking_animation, get_dir(user.parent, target.parent))

/datum/interaction/forbidden_fruits/face_ass/handle_user_climax(datum/component/interactable/user, datum/component/interactable/target)
	var/mob/living/carbon/human/human_user = user.parent
	var/mob/living/carbon/human/human_target = target.parent
	if(human_user.getorganslot(ORGAN_SLOT_PENIS))
		human_user.visible_message(span_love("<b>[human_user]</b> cums on [human_target]!"),\
								span_userlove("I cum on [human_target]!"), \
								ignored_mobs = human_target)
		to_chat(human_target, span_userlove("<b>[human_user]</b> cums on me!"))
	else if(human_user.getorganslot(ORGAN_SLOT_VAGINA))
		human_user.visible_message(span_love("<b>[human_user]</b> squirts on [human_target]!"),\
								span_userlove("I squirt on [human_target]!"), \
								ignored_mobs = human_target)
		to_chat(human_target, span_userlove("<b>[human_user]</b> squirts on me!"))
	else
		human_user.visible_message(span_love("<b>[human_user]</b> climaxes on [human_target]!"),\
								span_userlove("I climax on [human_target]!"), \
								ignored_mobs = human_target)
		to_chat(human_target, span_userlove("<b>[human_user]</b> climaxes on me!"))
	for(var/obj/item/organ/genital/genital in human_user.internal_organs)
		if(CHECK_BITFIELD(genital.genital_flags, GENITAL_CAN_CLIMAX))
			genital.handle_climax(human_target, TOUCH)
	human_user.adjust_arousal(-1500)
	human_user.set_lust(0)
	human_user.SetStun(25)
	human_user.set_drugginess(25)
	SEND_SIGNAL(human_user, COMSIG_ADD_MOOD_EVENT, "sex", /datum/mood_event/goodsex)
	return TRUE

/datum/interaction/forbidden_fruits/breastfuck
	name = "Paizuri"
	desc = "Fuck their tits."
	message = list(span_love("%USER fucks %TARGET's breasts."), \
				span_love("%USER grinds their dick between %TARGET's boobs."), \
				span_love("%USER thrusts their cock %TARGET's tits."), \
				span_love("%USER rubs their cock between %TARGET's breasts."))
	user_message = list(span_userlove("I fuck %TARGET's breasts."), \
				span_userlove("I grind my dick between %TARGET's boobs."), \
				span_userlove("I thrust my cock into %TARGET's tits."), \
				span_userlove("I rub my cock between %TARGET's breasts."))
	target_message = list(span_userlove("%USER fucks my breasts."), \
				span_userlove("%USER grinds their dick between my boobs."), \
				span_userlove("%USER thrusts into my tits."), \
				span_userlove("%USER rubs their cock between my breasts."))
	sounds = list('modular_septic/sound/sexo/bang1.ogg', \
				'modular_septic/sound/sexo/bang2.ogg', \
				'modular_septic/sound/sexo/bang3.ogg', \
				'modular_septic/sound/sexo/bang4.ogg', \
				'modular_septic/sound/sexo/bang5.ogg', \
				'modular_septic/sound/sexo/bang6.ogg')
	sound_volume = 75
	button_icon = "hotdog"
	gaysex_achievement = TRUE

/datum/interaction/forbidden_fruits/breastfuck/evaluate_user(datum/component/interactable/user, datum/component/interactable/target, silent)
	. = ..()
	var/mob/living/carbon/human/human_user = user.parent
	if((human_user.getorganslotefficiency(ORGAN_SLOT_PENIS) < ORGAN_FAILING_EFFICIENCY) || !human_user.genital_visible(ORGAN_SLOT_PENIS))
		return FALSE

/datum/interaction/forbidden_fruits/breastfuck/evaluate_target(datum/component/interactable/user, datum/component/interactable/target, silent)
	. = ..()
	var/mob/living/carbon/human/human_target = target.parent
	if((human_target.getorganslotefficiency(ORGAN_SLOT_BREASTS) < ORGAN_FAILING_EFFICIENCY) || !human_target.genital_visible(ORGAN_SLOT_BREASTS))
		return FALSE

/datum/interaction/forbidden_fruits/breastfuck/do_interaction(datum/component/interactable/user, datum/component/interactable/target)
	if(user.last_interaction_as_user != src)
		message = span_love("%USER pushes %TARGET's breasts together and presses their dick in between.")
		user_message = span_userlove("I push %TARGET's breasts together and press my dick in between.")
		target_message = span_userlove("%USER pushes my breasts together and presses their dick in between.")
	else
		message = list(span_love("%USER fucks %TARGET's breasts."), \
					span_love("%USER grinds their dick between %TARGET's boobs."), \
					span_love("%USER thrusts their cock %TARGET's tits."), \
					span_love("%USER rubs their cock between %TARGET's breasts."))
		user_message = list(span_userlove("I fuck %TARGET's breasts."), \
					span_userlove("I grind my dick between %TARGET's boobs."), \
					span_userlove("I thrust my cock into %TARGET's tits."), \
					span_userlove("I rub my cock between %TARGET's breasts."))
		target_message = list(span_userlove("%USER fucks my breasts."), \
					span_userlove("%USER grinds their dick between my boobs."), \
					span_userlove("%USER thrusts into my tits."), \
					span_userlove("%USER rubs their cock between my breasts."))
	. = ..()
	var/mob/living/fucker = user.parent
	INVOKE_ASYNC(fucker, /mob/.proc/do_fucking_animation, get_dir(user.parent, target.parent))

/datum/interaction/forbidden_fruits/breastfuck/handle_user_climax(datum/component/interactable/user, datum/component/interactable/target)
	var/mob/living/carbon/human/human_user = user.parent
	var/mob/living/carbon/human/human_target = target.parent
	human_user.visible_message(span_love("<b>[human_user]</b> cums on <b>[human_target]</b>'s tits!"),\
							span_userlove("I cum on <b>[human_target]</b>'s tits!"),
							ignored_mobs = human_target)
	to_chat(human_target, span_userlove("<b>[human_user]</b> cums on my tits!"))
	for(var/obj/item/organ/genital/genital in human_user.internal_organs)
		if(CHECK_BITFIELD(genital.genital_flags, GENITAL_CAN_CLIMAX))
			if(genital.handle_climax(human_target, INGEST))
				if(istype(genital, /obj/item/organ/genital/penis) || istype(genital, /obj/item/organ/genital/vagina))
					genital.cum_on_face(human_target)
	human_user.adjust_arousal(-1500)
	human_user.set_lust(0)
	human_user.SetStun(25)
	human_user.set_drugginess(25)
	SEND_SIGNAL(human_user, COMSIG_ADD_MOOD_EVENT, "sex", /datum/mood_event/goodsex)
	return TRUE

//COOPERATIVE INTERACTIONS - BOTH PARTIES CLIMAX
/datum/interaction/forbidden_fruits/vaginal
	name = "Vaginal"
	desc = "Fuck their vagina."
	message = list(span_love("%USER pounds into %TARGET's pussy."), \
				span_love("%USER shoves their dick deep into %TARGET's pussy."), \
				span_love("%USER thrusts inside %TARGET's cunt."), \
				span_love("%USER goes balls deep inside %TARGET's pussy."))
	user_message = list(span_userlove("I pound into %TARGET's pussy."), \
				span_userlove("I shove my dick deep into %TARGET's pussy."), \
				span_userlove("I thrust inside %TARGET's cunt."), \
				span_userlove("I go balls deep inside %TARGET's pussy."))
	target_message = list(span_userlove("%USER pounds into my pussy."), \
				span_userlove("%USER shoves their dick deep into my pussy."), \
				span_userlove("%USER thrusts inside my cunt."), \
				span_userlove("%USER goes balls deep inside my pussy."))
	sounds = list('modular_septic/sound/sexo/champ1.ogg', \
				'modular_septic/sound/sexo/champ2.ogg')
	sound_volume = 75
	button_icon = "hotdog"
	gaysex_achievement = TRUE

/datum/interaction/forbidden_fruits/vaginal/evaluate_user(datum/component/interactable/user, datum/component/interactable/target, silent)
	. = ..()
	var/mob/living/carbon/human/human_user = user.parent
	if((human_user.getorganslotefficiency(ORGAN_SLOT_PENIS) < ORGAN_FAILING_EFFICIENCY) || !human_user.genital_visible(ORGAN_SLOT_PENIS))
		return FALSE

/datum/interaction/forbidden_fruits/vaginal/evaluate_target(datum/component/interactable/user, datum/component/interactable/target, silent)
	. = ..()
	var/mob/living/carbon/human/human_target = target.parent
	if((human_target.getorganslotefficiency(ORGAN_SLOT_VAGINA) < ORGAN_FAILING_EFFICIENCY) || !human_target.genital_visible(ORGAN_SLOT_VAGINA))
		return FALSE

/datum/interaction/forbidden_fruits/vaginal/do_interaction(datum/component/interactable/user, datum/component/interactable/target)
	if(user.last_interaction_as_user != src)
		message = span_love("%USER starts fucking %TARGET's pussy.")
		user_message = span_userlove("I start fucking %TARGET's pussy.")
		target_message = span_userlove("%USER starts fucking my pussy.")
	else
		message = list(span_love("%USER pounds into %TARGET's pussy."), \
					span_love("%USER shoves their dick deep into %TARGET's pussy."), \
					span_love("%USER thrusts inside %TARGET's cunt."), \
					span_love("%USER goes balls deep inside %TARGET's pussy."))
		user_message = list(span_userlove("I pound into %TARGET's pussy."), \
					span_userlove("I shove my dick inside %TARGET's pussy."), \
					span_userlove("I thrust inside %TARGET's cunt."), \
					span_userlove("I go balls deep inside %TARGET's pussy."))
		target_message = list(span_userlove("%USER pounds into my pussy."), \
					span_userlove("%USER shoves their dick inside my pussy."), \
					span_userlove("%USER thrusts inside my cunt."), \
					span_userlove("%USER goes balls deep inside my pussy."))
	. = ..()
	var/mob/living/fucker = user.parent
	INVOKE_ASYNC(fucker, /mob/.proc/do_fucking_animation, get_dir(user.parent, target.parent))

/datum/interaction/forbidden_fruits/vaginal/handle_user_climax(datum/component/interactable/user, datum/component/interactable/target)
	var/mob/living/carbon/human/human_user = user.parent
	var/mob/living/carbon/human/human_target = target.parent
	human_user.visible_message(span_love("<b>[human_user]</b> cums inside <b>[human_target]</b>'s pussy!"),\
							span_userlove("I cum inside <b>[human_target]</b>'s pussy!"),
							ignored_mobs = human_target)
	to_chat(human_target, span_userlove("<b>[human_user]</b> cums inside my pussy!"))
	for(var/obj/item/organ/genital/genital in human_user.internal_organs)
		if(CHECK_BITFIELD(genital.genital_flags, GENITAL_CAN_CLIMAX))
			genital.handle_climax(human_target, INJECT)
	human_user.adjust_arousal(-1500)
	human_user.set_lust(0)
	human_user.SetStun(25)
	human_user.set_drugginess(25)
	SEND_SIGNAL(human_user, COMSIG_ADD_MOOD_EVENT, "sex", /datum/mood_event/goodsex)
	return TRUE

/datum/interaction/forbidden_fruits/vaginal/handle_target_climax(datum/component/interactable/user, datum/component/interactable/target)
	var/mob/living/carbon/human/human_user = user.parent
	var/mob/living/carbon/human/human_target = target.parent
	human_target.visible_message(span_love("<b>[human_target]</b> squirts over <b>[human_user]</b>'s cock!"),\
							span_userlove("I squirt over <b>[human_user]</b>'s cock!"),
							ignored_mobs = human_user)
	to_chat(human_user, span_userlove("<b>[human_target]</b> squirts over my cock!"))
	for(var/obj/item/organ/genital/genital in human_target.internal_organs)
		if(CHECK_BITFIELD(genital.genital_flags, GENITAL_CAN_CLIMAX))
			genital.handle_climax(human_user, TOUCH)
	human_target.adjust_arousal(-1500)
	human_target.set_lust(0)
	human_target.SetStun(25)
	human_target.set_drugginess(25)
	SEND_SIGNAL(human_target, COMSIG_ADD_MOOD_EVENT, "sex", /datum/mood_event/goodsex)
	return TRUE

/datum/interaction/forbidden_fruits/anal
	name = "Anal"
	desc = "Fuck their ass."
	message = list(span_love("%USER pounds into %TARGET's ass."), \
				span_love("%USER shoves their dick deep into %TARGET's ass."), \
				span_love("%USER thrusts inside %TARGET's ass."), \
				span_love("%USER goes balls deep inside %TARGET's asshole."))
	user_message = list(span_userlove("I pound into %TARGET's ass."), \
				span_userlove("I shove my dick deep into %TARGET's ass."), \
				span_userlove("I thrust inside %TARGET's ass."), \
				span_userlove("I go balls deep inside %TARGET's asshole."))
	target_message = list(span_userlove("%USER pounds into my ass."), \
				span_userlove("%USER shoves their dick deep inside my ass."), \
				span_userlove("%USER thrusts inside my ass."), \
				span_userlove("%USER goes balls deep inside my asshole."))
	sounds = list('modular_septic/sound/sexo/bang1.ogg', \
				'modular_septic/sound/sexo/bang2.ogg', \
				'modular_septic/sound/sexo/bang3.ogg', \
				'modular_septic/sound/sexo/bang4.ogg', \
				'modular_septic/sound/sexo/bang5.ogg', \
				'modular_septic/sound/sexo/bang6.ogg')
	sound_volume = 75
	button_icon = "hotdog"
	gaysex_achievement = TRUE

/datum/interaction/forbidden_fruits/anal/evaluate_user(datum/component/interactable/user, datum/component/interactable/target, silent)
	. = ..()
	var/mob/living/carbon/human/human_user = user.parent
	if((human_user.getorganslotefficiency(ORGAN_SLOT_PENIS) < ORGAN_FAILING_EFFICIENCY) || !human_user.genital_visible(ORGAN_SLOT_PENIS))
		return FALSE

/datum/interaction/forbidden_fruits/anal/evaluate_target(datum/component/interactable/user, datum/component/interactable/target, silent)
	. = ..()
	var/mob/living/carbon/human/human_target = target.parent
	if((human_target.getorganslotefficiency(ORGAN_SLOT_ANUS) < ORGAN_FAILING_EFFICIENCY) || !human_target.genital_visible(ORGAN_SLOT_ANUS))
		return FALSE

/datum/interaction/forbidden_fruits/anal/do_interaction(datum/component/interactable/user, datum/component/interactable/target)
	if(user.last_interaction_as_user != src)
		message = span_love("%USER starts fucking %TARGET's ass.")
		user_message = span_userlove("I start fucking %TARGET's ass.")
		target_message = span_userlove("%USER starts fucking my ass.")
	else
		message = list(span_love("%USER pounds into %TARGET's ass."), \
					span_love("%USER shoves their dick deep into %TARGET's ass."), \
					span_love("%USER thrusts inside %TARGET's ass."), \
					span_love("%USER goes balls deep inside %TARGET's asshole."))
		user_message = list(span_userlove("I pound into %TARGET's ass."), \
					span_userlove("I shove my dick deep into %TARGET's ass."), \
					span_userlove("I thrust inside %TARGET's ass."), \
					span_userlove("I go balls deep inside %TARGET's asshole."))
		target_message = list(span_userlove("%USER pounds into my ass."), \
					span_userlove("%USER shoves their dick deep inside my ass."), \
					span_userlove("%USER thrusts inside my ass."), \
					span_userlove("%USER goes balls deep inside my asshole."))
	. = ..()
	var/mob/living/fucker = user.parent
	INVOKE_ASYNC(fucker, /mob/.proc/do_fucking_animation, get_dir(user.parent, target.parent))

/datum/interaction/forbidden_fruits/anal/handle_user_climax(datum/component/interactable/user, datum/component/interactable/target)
	var/mob/living/carbon/human/human_user = user.parent
	var/mob/living/carbon/human/human_target = target.parent
	human_user.visible_message(span_love("<b>[human_user]</b> cums inside <b>[human_target]</b>'s ass!"),\
							span_userlove("I cum inside <b>[human_target]</b>'s ass!"),
							ignored_mobs = human_target)
	to_chat(human_target, span_userlove("<b>[human_user]</b> cums inside my ass!"))
	for(var/obj/item/organ/genital/genital in human_user.internal_organs)
		if(CHECK_BITFIELD(genital.genital_flags, GENITAL_CAN_CLIMAX))
			genital.handle_climax(human_target, INJECT)
	human_user.adjust_arousal(-1500)
	human_user.set_lust(0)
	human_user.SetStun(25)
	human_user.set_drugginess(25)
	SEND_SIGNAL(human_user, COMSIG_ADD_MOOD_EVENT, "sex", /datum/mood_event/goodsex)
	return TRUE

/datum/interaction/forbidden_fruits/anal/handle_target_climax(datum/component/interactable/user, datum/component/interactable/target)
	var/mob/living/carbon/human/human_user = user.parent
	var/mob/living/carbon/human/human_target = target.parent
	if(human_target.getorganslot(ORGAN_SLOT_PENIS))
		human_target.visible_message(span_love("<b>[human_target]</b> cums on [human_user]!"),\
								span_userlove("I cum on [human_user]!"), \
								ignored_mobs = human_user)
		to_chat(human_user, span_userlove("<b>[human_target]</b> cums on me!"))
	else if(human_target.getorganslot(ORGAN_SLOT_VAGINA))
		human_target.visible_message(span_love("<b>[human_target]</b> squirts on [human_user]!"),\
								span_userlove("I squirt on [human_user]!"), \
								ignored_mobs = human_user)
		to_chat(human_user, span_userlove("<b>[human_target]</b> squirts on me!"))
	else
		human_target.visible_message(span_love("<b>[human_target]</b> climaxes on [human_user]!"),\
								span_userlove("I climax on [human_user]!"), \
								ignored_mobs = human_user)
		to_chat(human_user, span_userlove("<b>[human_target]</b> climaxes on me!"))
	for(var/obj/item/organ/genital/genital in human_target.internal_organs)
		if(CHECK_BITFIELD(genital.genital_flags, GENITAL_CAN_CLIMAX))
			genital.handle_climax(human_user, TOUCH)
	human_target.adjust_arousal(-1500)
	human_target.set_lust(0)
	human_target.SetStun(25)
	human_target.set_drugginess(25)
	SEND_SIGNAL(human_target, COMSIG_ADD_MOOD_EVENT, "sex", /datum/mood_event/goodsex)
	return TRUE

/datum/interaction/forbidden_fruits/mount_vaginal
	name = "Vaginal Mounting"
	desc = "Ride their cock with your pussy."
	maximum_distance = 0 //must be on the same tile
	message = list(span_love("%USER rides %TARGET's cock with their pussy."), \
				span_love("%USER shoves their pussy deep on %TARGET's dick."), \
				span_love("%USER slides their pussy on %TARGET's cock."))
	user_message = list(span_userlove("I ride %TARGET's cock with my pussy."), \
				span_userlove("I shove my pussy deep on %TARGET's dick."), \
				span_userlove("I slide my pussy on %TARGET's cock."))
	target_message = list(span_userlove("%USER rides my cock with their pussy."), \
				span_userlove("%USER shoves their pussy deep on my cock."), \
				span_userlove("%USER slides their pussy on my cock."))
	sounds = list('modular_septic/sound/sexo/champ1.ogg', \
				'modular_septic/sound/sexo/champ2.ogg')
	sound_volume = 75
	button_icon = "hotdog"
	gaysex_achievement = TRUE

/datum/interaction/forbidden_fruits/mount_vaginal/evaluate_user(datum/component/interactable/user, datum/component/interactable/target, silent)
	. = ..()
	var/mob/living/carbon/human/human_user = user.parent
	if((human_user.getorganslotefficiency(ORGAN_SLOT_VAGINA) < ORGAN_FAILING_EFFICIENCY) || !human_user.genital_visible(ORGAN_SLOT_VAGINA))
		return FALSE

/datum/interaction/forbidden_fruits/mount_vaginal/evaluate_target(datum/component/interactable/user, datum/component/interactable/target, silent)
	. = ..()
	var/mob/living/carbon/human/human_target = target.parent
	if((human_target.getorganslotefficiency(ORGAN_SLOT_PENIS) < ORGAN_FAILING_EFFICIENCY) || !human_target.genital_visible(ORGAN_SLOT_PENIS))
		return FALSE

/datum/interaction/forbidden_fruits/mount_vaginal/do_interaction(datum/component/interactable/user, datum/component/interactable/target)
	if(user.last_interaction_as_user != src)
		message = span_love("%USER starts riding on %TARGET's cock with their pussy.")
		user_message = span_userlove("I start riding on %TARGET's cock with my pussy.")
		target_message = span_userlove("%USER starts riding my cock with their pussy.")
	else
		message = list(span_love("%USER rides %TARGET's cock with their pussy."), \
					span_love("%USER shoves their pussy deep on %TARGET's dick."), \
					span_love("%USER slides their pussy on %TARGET's cock."))
		user_message = list(span_userlove("I ride %TARGET's cock with my pussy."), \
					span_userlove("I shove my pussy deep on %TARGET's dick."), \
					span_userlove("I slide my pussy on %TARGET's cock."))
		target_message = list(span_userlove("%USER rides my cock with their pussy."), \
					span_userlove("%USER shoves their pussy deep on my cock."), \
					span_userlove("%USER slides their pussy on my cock."))
	. = ..()
	var/mob/living/fucker = user.parent
	INVOKE_ASYNC(fucker, /mob/.proc/do_fucking_animation, get_dir(user.parent, target.parent))

/datum/interaction/forbidden_fruits/mount_vaginal/handle_user_climax(datum/component/interactable/user, datum/component/interactable/target)
	var/mob/living/carbon/human/human_user = user.parent
	var/mob/living/carbon/human/human_target = target.parent
	human_user.visible_message(span_love("<b>[human_target]</b> squirts over <b>[human_target]</b>'s cock!"),\
							span_userlove("I squirt over <b>[human_target]</b>'s cock!"),
							ignored_mobs = human_target)
	to_chat(human_target, span_userlove("<b>[human_user]</b> squirts over my cock!"))
	for(var/obj/item/organ/genital/genital in human_user.internal_organs)
		if(CHECK_BITFIELD(genital.genital_flags, GENITAL_CAN_CLIMAX))
			genital.handle_climax(human_user, TOUCH)
	human_user.adjust_arousal(-1500)
	human_user.set_lust(0)
	human_user.SetStun(25)
	human_user.set_drugginess(25)
	SEND_SIGNAL(human_user, COMSIG_ADD_MOOD_EVENT, "sex", /datum/mood_event/goodsex)
	return TRUE

/datum/interaction/forbidden_fruits/mount_vaginal/handle_target_climax(datum/component/interactable/user, datum/component/interactable/target)
	var/mob/living/carbon/human/human_user = user.parent
	var/mob/living/carbon/human/human_target = target.parent
	human_target.visible_message(span_love("<b>[human_target]</b> cums inside <b>[human_user]</b>'s pussy!"),\
							span_userlove("I cum inside <b>[human_user]</b>'s pussy!"),
							ignored_mobs = human_target)
	to_chat(human_user, span_userlove("<b>[human_target]</b> cums inside my pussy!"))
	for(var/obj/item/organ/genital/genital in human_target.internal_organs)
		if(CHECK_BITFIELD(genital.genital_flags, GENITAL_CAN_CLIMAX))
			genital.handle_climax(human_target, INJECT)
	human_target.adjust_arousal(-1500)
	human_target.set_lust(0)
	human_target.SetStun(25)
	human_target.set_drugginess(25)
	SEND_SIGNAL(human_target, COMSIG_ADD_MOOD_EVENT, "sex", /datum/mood_event/goodsex)
	return TRUE

/datum/interaction/forbidden_fruits/mount_anal
	name = "Anal Mounting"
	desc = "Ride their cock with your ass."
	maximum_distance = 0 //must be on the same tile
	message = list(span_love("%USER rides %TARGET's cock with their ass."), \
				span_love("%USER shoves their ass deep %TARGET's dick."), \
				span_love("%USER slides their ass on %TARGET's cock."))
	user_message = list(span_userlove("I ride %TARGET's cock with my ass."), \
				span_userlove("I shove my ass deep on %TARGET's dick."), \
				span_userlove("I slide my ass on %TARGET's cock."))
	target_message = list(span_userlove("%USER rides my cock with their ass."), \
				span_userlove("%USER shoves their ass deep on my cock."), \
				span_userlove("%USER slides their ass on my cock."))
	sounds = list('modular_septic/sound/sexo/bang1.ogg', \
				'modular_septic/sound/sexo/bang2.ogg', \
				'modular_septic/sound/sexo/bang3.ogg', \
				'modular_septic/sound/sexo/bang4.ogg', \
				'modular_septic/sound/sexo/bang5.ogg', \
				'modular_septic/sound/sexo/bang6.ogg')
	sound_volume = 75
	button_icon = "hotdog"
	gaysex_achievement = TRUE

/datum/interaction/forbidden_fruits/mount_anal/evaluate_user(datum/component/interactable/user, datum/component/interactable/target, silent)
	. = ..()
	var/mob/living/carbon/human/human_user = user.parent
	if((human_user.getorganslotefficiency(ORGAN_SLOT_ANUS) < ORGAN_FAILING_EFFICIENCY) || !human_user.genital_visible(ORGAN_SLOT_ANUS))
		return FALSE

/datum/interaction/forbidden_fruits/mount_anal/evaluate_target(datum/component/interactable/user, datum/component/interactable/target, silent)
	. = ..()
	var/mob/living/carbon/human/human_target = target.parent
	if((human_target.getorganslotefficiency(ORGAN_SLOT_PENIS) < ORGAN_FAILING_EFFICIENCY) || !human_target.genital_visible(ORGAN_SLOT_PENIS))
		return FALSE

/datum/interaction/forbidden_fruits/mount_anal/do_interaction(datum/component/interactable/user, datum/component/interactable/target)
	if(user.last_interaction_as_user != src)
		message = span_love("%USER starts riding on %TARGET's cock with their ass.")
		user_message = span_userlove("I start riding on %TARGET's cock with my ass.")
		target_message = span_userlove("%USER starts riding my cock with their ass.")
	else
		message = list(span_love("%USER rides %TARGET's cock with their ass."), \
					span_love("%USER shoves their ass deep %TARGET's dick."), \
					span_love("%USER slides their ass on %TARGET's cock."))
		user_message = list(span_userlove("I ride %TARGET's cock with my ass."), \
					span_userlove("I shove my ass deep on %TARGET's dick."), \
					span_userlove("I slide my ass on %TARGET's cock."))
		target_message = list(span_userlove("%USER rides my cock with their ass."), \
					span_userlove("%USER shoves their ass deep on my cock."), \
					span_userlove("%USER slides their ass on my cock."))
	. = ..()
	var/mob/living/fucker = user.parent
	INVOKE_ASYNC(fucker, /mob/.proc/do_fucking_animation, get_dir(user.parent, target.parent))

/datum/interaction/forbidden_fruits/mount_anal/handle_user_climax(datum/component/interactable/user, datum/component/interactable/target)
	var/mob/living/carbon/human/human_user = user.parent
	var/mob/living/carbon/human/human_target = target.parent
	if(human_user.getorganslot(ORGAN_SLOT_PENIS))
		human_user.visible_message(span_love("<b>[human_user]</b> cums on [human_target]!"),\
								span_userlove("I cum on [human_target]!"), \
								ignored_mobs = human_target)
		to_chat(human_target, span_userlove("<b>[human_user]</b> cums on me!"))
	else if(human_user.getorganslot(ORGAN_SLOT_VAGINA))
		human_user.visible_message(span_love("<b>[human_target]</b> squirts on [human_target]!"),\
								span_userlove("I squirt on [human_target]!"), \
								ignored_mobs = human_target)
		to_chat(human_target, span_userlove("<b>[human_user]</b> squirts on me!"))
	else
		human_user.visible_message(span_love("<b>[human_user]</b> climaxes on [human_target]!"),\
								span_userlove("I climax on [human_target]!"), \
								ignored_mobs = human_target)
		to_chat(human_target, span_userlove("<b>[human_user]</b> climaxes on me!"))
	for(var/obj/item/organ/genital/genital in human_user.internal_organs)
		if(CHECK_BITFIELD(genital.genital_flags, GENITAL_CAN_CLIMAX))
			genital.handle_climax(human_user, TOUCH)
	human_user.adjust_arousal(-1500)
	human_user.set_lust(0)
	human_user.SetStun(25)
	human_user.set_drugginess(25)
	SEND_SIGNAL(human_user, COMSIG_ADD_MOOD_EVENT, "sex", /datum/mood_event/goodsex)
	return TRUE

/datum/interaction/forbidden_fruits/mount_anal/handle_target_climax(datum/component/interactable/user, datum/component/interactable/target)
	var/mob/living/carbon/human/human_user = user.parent
	var/mob/living/carbon/human/human_target = target.parent
	human_target.visible_message(span_love("<b>[human_target]</b> cums inside <b>[human_user]</b>'s ass!"),\
							span_userlove("I cum inside <b>[human_user]</b>'s ass!"),
							ignored_mobs = human_target)
	to_chat(human_user, span_userlove("<b>[human_target]</b> cums inside my ass!"))
	for(var/obj/item/organ/genital/genital in human_target.internal_organs)
		if(CHECK_BITFIELD(genital.genital_flags, GENITAL_CAN_CLIMAX))
			genital.handle_climax(human_target, INJECT)
	human_target.adjust_arousal(-1500)
	human_target.set_lust(0)
	human_target.SetStun(25)
	human_target.set_drugginess(25)
	SEND_SIGNAL(human_target, COMSIG_ADD_MOOD_EVENT, "sex", /datum/mood_event/goodsex)
	return TRUE
