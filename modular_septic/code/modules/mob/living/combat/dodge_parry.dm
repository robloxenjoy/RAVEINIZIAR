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
					to_chat(src, div_infobox(span_notice("I will now <b>parry</b> incoming attacks.")))
			else
				dodge_parry = DP_DODGE
				if(!silent)
					to_chat(src, div_infobox(span_notice("I will now <b>dodge</b> incoming attacks.")))
	else
		if(dodge_parry == new_dp)
			return
		dodge_parry = new_dp
		if(!silent)
			switch(dodge_parry)
				if(DP_PARRY)
					to_chat(src, div_infobox(span_notice("I will now <b>parry</b> incoming attacks.")))
				else
					to_chat(src, div_infobox(span_notice("I will now <b>dodge</b> incoming attacks.")))
