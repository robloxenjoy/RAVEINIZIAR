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
			message += span_largeinfo("None")
			message += "\n<br><hr class='infohr'>\n"
			message += span_info("Right click will perform no special attacks - Useful to perform miscellaneous interactions.")
		if(CS_FEINT)
			message += span_largeinfo("Feint")
			message += "\n<br><hr class='infohr'>\n"
			message += span_info("Right click to perform a feint attack. \
								If successful, target will parry prematurely, leaving them open for a real attack.\n\
								Price: Regardless of success, your defenses are left open.")
		if(CS_DUAL)
			message += span_largeinfo("Dual")
			message += "\n<br><hr class='infohr'>\n"
			message += span_info("Right click to attack with the item in your offhand.\n\
								Price: None.")
		if(CS_GUARD)
			message += span_largeinfo("Guard")
			message += "\n<br><hr class='infohr'>\n"
			message += span_info("Right click in combat mode to automatically attack anyone who approaches. \
								A shooting weapon allows targetting any tile in vision. \
								Switching to another combat style will reset your guard.")
		if(CS_DEFEND)
			message += span_largeinfo("Defend")
			message += "\n<br><hr class='infohr'>\n"
			message += span_info("Dodge and parry abilities are greatly heightened.\n\
								Price: Reduced damage output.")
		if(CS_STRONG)
			message += span_largeinfo("Strong")
			message += "\n<br><hr class='infohr'>\n"
			message += span_info("Right click to perform a strong attack. You will hit for maximum damage.\n\
								Price: Regardless of success, your defenses are left open. Attack costs more stamina.")
		if(CS_FURY)
			message += span_largeinfo("Fury")
			message += "\n<br><hr class='infohr'>\n"
			message += span_info("Right click to attack quickly and recklessly. \
								Parrying furious attacks will greatly hinder the target's dodge and parry.\n\
								Price: -2 ST.")
		if(CS_AIMED)
			message += span_largeinfo("Aimed")
			message += "\n<br><hr class='infohr'>\n"
			message += span_info("Right click for an aimed attack. \
								Far less likely to miss attack attempts.\n\
								Price: Regardless of success, your defenses are left open. Attack is slower.")
		if(CS_WEAK)
			message += span_largeinfo("Weak")
			message += "\n<br><hr class='infohr'>\n"
			message += span_info("Significantly reduces damage in melee combat - \
								Useful for a friendly brawl or to non-lethally subdue someone.\n\
								Price: Reduced damage output, but the attack is less tiring.")
	message += "</div></span>"
	to_chat(src, message)
