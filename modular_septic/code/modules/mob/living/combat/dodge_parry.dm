//proc for switching between dodging and parrying
/mob/living/proc/toggle_dodge_parry(new_dp, silent = FALSE)
	if(!ishuman(src))
		if(!silent)
			to_chat(src, div_infobox(span_warning("My inhuman form is incapable of dodging or parrying.")))
		return

	if(!new_dp)
		switch(dodge_parry)
			if(DP_DODGE)
				dodge_parry = DP_PARRY
				if(!silent)
					to_chat(src, div_infobox(span_notice("Now I will <b>parry</b> атаки.")))
			else
				dodge_parry = DP_DODGE
				if(!silent)
					to_chat(src, div_infobox(span_notice("Now I will <b>dodge</b> attacks.")))
	else
		if(dodge_parry == new_dp)
			return
		dodge_parry = new_dp
		if(!silent)
			switch(dodge_parry)
				if(DP_PARRY)
					to_chat(src, div_infobox(span_notice("Now I will <b>parry</b> attacks.")))
				else
					to_chat(src, div_infobox(span_notice("Now I will <b>dodge</b> attacks.")))
