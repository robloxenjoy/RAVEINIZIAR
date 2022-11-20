/mob/Initialize(mapload)
	. = ..()
	RegisterSignal(src, SIGNAL_ADDTRAIT(TRAIT_TYPING_INDICATOR), .proc/update_typing_indicator)
	RegisterSignal(src, SIGNAL_REMOVETRAIT(TRAIT_TYPING_INDICATOR), .proc/update_typing_indicator)
	RegisterSignal(src, SIGNAL_ADDTRAIT(TRAIT_SSD_INDICATOR), .proc/update_ssd_indicator)
	RegisterSignal(src, SIGNAL_REMOVETRAIT(TRAIT_SSD_INDICATOR), .proc/update_ssd_indicator)

/mob/proc/update_typing_indicator()
	var/bubble_icon = "default"
	if(isliving(src))
		var/mob/living/living_source = src
		bubble_icon = living_source.bubble_icon
	var/image/typing_indicator = get_typing_indicator(bubble_icon)
	cut_overlay(typing_indicator)
	if(HAS_TRAIT(src, TRAIT_TYPING_INDICATOR))
		add_overlay(typing_indicator)

/mob/proc/update_ssd_indicator()
	var/ssd_bubble_icon = "default"
	if(isliving(src))
		var/mob/living/living_source = src
		ssd_bubble_icon = living_source.ssd_bubble_icon
	var/image/ssd_indicator = get_ssd_indicator(ssd_bubble_icon)
	cut_overlay(ssd_indicator)
	if(HAS_TRAIT(src, TRAIT_SSD_INDICATOR))
		add_overlay(ssd_indicator)

/mob/proc/set_typing_indicator(state = FALSE)
	if(state)
		ADD_TRAIT(src, TRAIT_TYPING_INDICATOR, COMMUNICATION_TRAIT)
	else
		REMOVE_TRAIT(src, TRAIT_TYPING_INDICATOR, COMMUNICATION_TRAIT)

/mob/proc/set_ssd_indicator(state = FALSE)
	if(state)
		ADD_TRAIT(src, TRAIT_SSD_INDICATOR, COMMUNICATION_TRAIT)
	else
		REMOVE_TRAIT(src, TRAIT_SSD_INDICATOR, COMMUNICATION_TRAIT)

/mob/Login()
	. = ..()
	REMOVE_TRAIT(src, TRAIT_SSD_INDICATOR, COMMUNICATION_TRAIT)

/mob/Logout()
	. = ..()
	if(mind && (stat < DEAD))
		ADD_TRAIT(src, TRAIT_SSD_INDICATOR, COMMUNICATION_TRAIT)

/mob/say_verb(message as text)
	. = ..()
	set_typing_indicator(FALSE)

/mob/whisper_verb(message as text)
	. = ..()
	set_typing_indicator(FALSE)

/mob/me_verb(message as text)
	. = ..()
	set_typing_indicator(FALSE)

/mob/say_dead(message as text)
	. = ..()
	set_typing_indicator(FALSE)

/mob/say(message, bubble_type, list/spans = list(), sanitize = TRUE, datum/language/language = null, ignore_spam = FALSE, forced = null, filterproof = null)
	. = ..()
	set_typing_indicator(FALSE)

/mob/emote(act, m_type, message, intentional, force_silence)
	. = ..()
	set_typing_indicator(FALSE)

/proc/animate_speechbubble(image/speechbubble_image, list/show_to, extraduration)
	var/matrix/old_matrix = matrix(speechbubble_image.transform)
	var/matrix/small_matrix = matrix(speechbubble_image.transform)
	small_matrix = small_matrix.Scale(0,0)
	small_matrix = small_matrix.Translate(-4, -2)
	speechbubble_image.transform = small_matrix
	speechbubble_image.alpha = 0
	for(var/client/client as anything in show_to)
		client.images += speechbubble_image
	animate(speechbubble_image, transform = old_matrix, alpha = 255, time = 5, easing = BACK_EASING, flags = ANIMATION_PARALLEL)
	sleep(extraduration+5)
	animate(speechbubble_image, alpha = 0, time = 5, easing = BACK_EASING, flags = ANIMATION_PARALLEL)
	sleep(5)
	for(var/client/client in show_to)
		client?.images -= speechbubble_image
