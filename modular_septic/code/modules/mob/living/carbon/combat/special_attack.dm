//Proc for switching between jump, kick and bite
/mob/living/proc/toggle_special_attack(new_attack, silent = FALSE)
	if(!ishuman(src))
		if(!silent)
			to_chat(src, div_infobox(span_warning("My inhuman form is incapable of doing special attacks.")))
		return

	if(!new_attack || new_attack == special_attack)
		special_attack = SPECIAL_ATK_NONE
		if(!silent)
			var/message = "<span class='infoplain'><div class='infobox'>"
			message += span_largeinfo("None")
			message += "\n<br><hr class='infohr'>\n"
			message += span_info("I will now attack my targets normally.\n(MMB will not perform special attacks)")
			message += "</div></span>"
			to_chat(src, message)
	else
		special_attack = new_attack
		if(!silent)
			var/message = "<span class='infoplain'><div class='infobox'>"
			switch(new_attack)
				if(SPECIAL_ATK_KICK)
					message += span_largeinfo("Kick")
					message += "\n<br><hr class='infohr'>\n"
					message += span_info("I will now try to kick my targets.\n(MMB to kick)")
				if(SPECIAL_ATK_BITE)
					message += span_largeinfo("Bite")
					message += "\n<br><hr class='infohr'>\n"
					message += span_info("I will now try to bite my targets.\n(MMB to bite)")
				if(SPECIAL_ATK_JUMP)
					message += span_largeinfo("Jump")
					message += "\n<br><hr class='infohr'>\n"
					message += span_info("I will now attempt to tackle at my targets.\n(MMB to jump at a target)")
				if(SPECIAL_ATK_STEAL)
					message += span_largeinfo("Steal")
					message += "\n<br><hr class='infohr'>\n"
					message += span_info("I will now attempt to steal from my targets.\n(MMB to pickpocket)")
			message += "</div></span>"
			to_chat(src, message)
