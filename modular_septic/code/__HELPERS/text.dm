//Like capitalize, but you capitalize EVERYTHING
/proc/capitalize_like_old_man(t)
	. = t
	if(!length(t))
		return
	var/list/binguslist = splittext(t, " ")
	for(var/bingus in binguslist)
		binguslist -= bingus
		if(!length(bingus))
			binguslist += bingus
			continue
		var/chonker = uppertext(bingus[1])
		bingus = chonker + copytext(bingus, 1 + length(chonker))
		binguslist += bingus
	return jointext(binguslist, " ")

//Sometimes, \an does not work like you'd expect
/proc/prefix_a_or_an(text)
	if(!length(text))
		return "a"
	var/start = lowertext(text[1])
	if(start == "a" || start == "e" || start == "i" || start == "o" || start == "u")
		return "an"
	else
		return "a"

//Get only the initials of t joined together
/proc/get_name_initials(t)
	. = t
	if(!length(t))
		return
	var/list/binguslist = splittext(t, " ")
	for(var/bingus in binguslist)
		binguslist -= bingus
		if(!length(bingus))
			binguslist += bingus
			continue
		binguslist += uppertext(bingus[1])
	return jointext(binguslist, "")

/proc/fail_string(capitalize = FALSE)
	return copytext(capitalize ? capitalize(pick(GLOB.whoopsie)) : pick(GLOB.whoopsie), 1, -1)

/proc/fail_msg()
	return capitalize(pick(GLOB.whoopsie))

/proc/random_adjective()
	return pick(GLOB.random_adjectives)

/proc/eww_msg()
	return capitalize(pick(GLOB.eww))

/proc/xbox_rage_msg()
	return capitalize(pick(GLOB.xbox_rage))

/proc/godforsaken_success()
	return capitalize(pick(GLOB.godforsaken_success))

/proc/godforsaken_failure()
	return capitalize(pick(GLOB.godforsaken_failure))

/proc/denominator_first()
	return capitalize(pick(GLOB.denominator_first))

/proc/denominator_last()
	return capitalize(pick(GLOB.denominator_last))

/proc/click_fail_msg()
	return span_alert(pick("I'm not ready!", "No!", "I did all i could!", "I can't!", "Not yet!"))

/proc/get_signs_from_number(num, index = 0)
	var/signs = num
	var/symbol = span_green("<b>+</b>")
	if(!signs)
		symbol = ""
	else if(signs < 0)
		symbol = span_red("<b>-</b>")
	signs = abs(signs)
	var/total_symbols = ""
	if(signs && symbol)
		if(index)
			signs = CEILING(signs/2, 1)
		else
			signs = FLOOR(signs/2, 1)
		var/bingus = 0
		while(bingus < signs)
			bingus++
			total_symbols += symbol
	return total_symbols

/proc/malbolge_string(text)
	var/malbolge = ""
	var/text_len = length(text)
	if(text_len >= 1)
		for(var/i in 1 to length(text))
			var/lowered_text = lowertext(text[i])
			if(!(lowered_text in GLOB.alphabet))
				malbolge += text[i]
			else
				if(lowered_text == text[i])
					malbolge += pick(GLOB.alphabet)
				else
					malbolge += pick(GLOB.alphabet_upper)
	return malbolge

/proc/chat_progress_characters(progressed = 0, total = 10)
	. = ""
	progressed = min(progressed, total)
	for(var/i in 1 to progressed)
		. += "*"
	var/remaining = total-progressed
	for(var/i in 1 to remaining)
		. += "-"
