//proc for switching combat styles
/mob/living/proc/switch_combat_style(new_style, silent = FALSE)
	if(new_style == combat_style)
		return
	combat_style = new_style
	if(!silent)
		print_combat_style(combat_style)
	return TRUE

//proc for printing info about a combat style
/mob/living/proc/print_combat_style(print_style = combat_style)
	var/message = "<span class='infoplain'><div class='infobox'>"
	switch(print_style)
		if(CS_NONE)
			message += span_largeinfo("Nothing")
			message += "\n<br><hr class='infohr'>\n"
			message += span_info("RMB will not make a special attack.")
		if(CS_FEINT)
			message += span_largeinfo("Feint")
			message += "\n<br><hr class='infohr'>\n"
			message += span_info("RMB for feint. \
								If successful, the enemy will parry the blow prematurely, leaving him open to the real attack.\n\
								Cost: Regardless of success, protection remains open.")
		if(CS_DUAL)
			message += span_largeinfo("Dual")
			message += "\n<br><hr class='infohr'>\n"
			message += span_info("RMB for attacking with the other hand.\n\
								Cost: Nothing.")
		if(CS_GUARD)
			message += span_largeinfo("Guard")
			message += "\n<br><hr class='infohr'>\n"
			message += span_info("RMB in combat mode for guarding the nearest area. \
								Switching to another special attack will reset the guard.\n\
								Cost: Nothing.")
		if(CS_DEFEND)
			message += span_largeinfo("Defend")
			message += "\n<br><hr class='infohr'>\n"
			message += span_info("Dodge and parry capabilities are elevated.\n\
								Cost: Weaker damage.")
		if(CS_STRONG)
			message += span_largeinfo("Strong")
			message += "\n<br><hr class='infohr'>\n"
			message += span_info("RMB to deal more damage than usual.\n\
								Cost: Increased stamina drain + protection remains open.")
		if(CS_FURY)
			message += span_largeinfo("Fury")
			message += "\n<br><hr class='infohr'>\n"
			message += span_info("RMB for faster attack.\n\
								Cost: Increased chance of getting failed.")
		if(CS_AIMED)
			message += span_largeinfo("Aimed")
			message += "\n<br><hr class='infohr'>\n"
			message += span_info("RMB for aimed attack.\n\
								Cost: Attack slower + protection remains open.")
		if(CS_WEAK)
			message += span_largeinfo("Weak")
			message += "\n<br><hr class='infohr'>\n"
			message += span_info("RMB for weaker attack. \
								Reducing stamina drain.\n\
								Cost: Nothing.")
	message += "</div></span>"
	to_chat(src, message)
