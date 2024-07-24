//Proc for switching between jump, kick and bite
/mob/living/proc/toggle_special_attack(new_attack, silent = FALSE)
	if(!ishuman(src))
		if(!silent)
			to_chat(src, div_infobox(span_warning("Моя не человеческая форма не позволяет выполнять подобные выкрутасы.")))
		return

	if(!new_attack || new_attack == special_attack)
		special_attack = SPECIAL_ATK_NONE
		if(!silent)
			var/message = "<span class='infoplain'><div class='infobox'>"
			message += span_largeinfo("Nothing")
			message += "\n<br><hr class='infohr'>\n"
			message += span_info("Теперь всё по-нормальному.\n(MMB не будет выполнять специальные действия)")
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
					message += span_info("Я теперь могу пинать их.\n(MMB для пинка)")
				if(SPECIAL_ATK_BITE)
					message += span_largeinfo("Bite")
					message += "\n<br><hr class='infohr'>\n"
					message += span_info("Я теперь могу кусать их.\n(MMB для укуса)")
				if(SPECIAL_ATK_JUMP)
					message += span_largeinfo("Jump")
					message += "\n<br><hr class='infohr'>\n"
					message += span_info("Я теперь могу прыгать.\n(MMB для прыжка)")
				if(SPECIAL_ATK_STEAL)
					message += span_largeinfo("Steal")
					message += "\n<br><hr class='infohr'>\n"
					message += span_info("Я теперь могу красть.\n(MMB для кражи)")
			message += "</div></span>"
			to_chat(src, message)
