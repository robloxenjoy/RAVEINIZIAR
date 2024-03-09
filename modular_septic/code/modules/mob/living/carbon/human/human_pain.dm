/mob/living/carbon/human/check_self_for_injuries(detailed = FALSE)
	if(stat < UNCONSCIOUS)
		visible_message("<span class='notice'><b>[src]</b> осматривает [p_themselves()].</span>", \
						"<span class='notice'><b>Я осматриваю себя.</b></span>")

	var/list/return_text = list("<span class='infoplain'><div class='infobox'>")
	return_text += "<span class='notice'><EM>Узнаем как дела у меня...</EM></span>"
	if(stat < DEAD)
		return_text += "\n<span class='notice'>Я всё ещё жив.</span>"
		return_text += "\n<span class='notice'>Я могу нести до <b>[CEILING(maximum_carry_weight, 1)]кг</b>.</span>"
		return_text += "\n<span class='notice'>Базовое поднималово: <b>[CEILING(maximum_carry_weight/10, 1)]кг</b>.</span>"
		return_text += "\n<span class='notice'>Груз: [encumbrance_text()] (<b>[CEILING(carry_weight, 1)]кг</b>)</span>"
		if(stat >= UNCONSCIOUS)
			return_text += "\n<span class='notice'>Я [HAS_TRAIT(src, TRAIT_TRYINGTOSLEEP) ? "сплю" : "без сознания"].</span>"
		if(get_blood_circulation() < GET_EFFECTIVE_BLOOD_VOL(BLOOD_VOLUME_OKAY, total_blood_req))
			return_text += "\n<span class='artery'>Я бледный!</span>"
		if(HAS_TRAIT(src, TRAIT_PARALYSIS_L_LEG) && HAS_TRAIT(src, TRAIT_PARALYSIS_R_LEG) && HAS_TRAIT(src, TRAIT_PARALYSIS_R_ARM) && HAS_TRAIT(src, TRAIT_PARALYSIS_L_ARM))
			return_text += "\n<span class='flashingdanger'>Я тетраплегик!</span>"
		if(undergoing_septic_shock())
			return_text += "\n<span class='necrosis'>Я под септическим шоком!</span>"
		if(HAS_TRAIT(src, TRAIT_DEATHS_DOOR))
			return_text += "\n<span class='flashingdanger'>Я готовлюсь умереть!</span>"
		if((stat >= UNCONSCIOUS) && (jitteriness >= 300))
			return_text += "\n<span class='flashingdanger'>У меня приступ!</span>"
	else
		return_text += "\n<span class='dead'>Я мёртв.</span>"
	return_text += "\n<br><hr class='infohr'>"
	var/static/list/detailed_bodyparts = ALL_BODYPARTS_CHECKSELF_DETAILED
	var/static/list/undetailed_bodyparts = ALL_BODYPARTS_CHECKSELF
	var/list/check_bodyparts = (detailed ? detailed_bodyparts : undetailed_bodyparts)
	var/obj/item/bodypart/LB
	for(var/zone in check_bodyparts)
		LB = get_bodypart(zone)
		if(!LB)
			return_text += "\n<span class='info'>☼ [capitalize(parse_zone(zone))]: <span class='dead'><b>ОТСУТСТВУЕТ</b></span> </span>"
			continue

		if(LB.is_stump())
			return_text += "\n<span class='info'>☼ [capitalize(parse_zone(zone))]: <span class='dead'><b>ОБРУБОК</b></span> </span>"
			continue

		var/limb_max_damage = LB.max_damage
		var/list/status = list()
		var/brutedamage = LB.brute_dam
		var/burndamage = LB.burn_dam
		var/paindamage = LB.get_shock(TRUE, TRUE)
		if(hallucination)
			if(prob(30))
				brutedamage += rand(30,40)
			if(prob(30))
				burndamage += rand(30,40)
			if(prob(30))
				paindamage += rand(30,40)

		if(HAS_TRAIT(src, TRAIT_SELF_AWARE))
			if(brutedamage)
				status += "<span class='[brutedamage >= 5 ? "danger" : "notice"]'>[brutedamage] УРОНА</span>"
			if(burndamage)
				status += "<span class='[burndamage >= 5 ? "danger" : "notice"]'>[burndamage] ОЖОГИ</span>"
			if(paindamage)
				status += "<span class='[paindamage >= 10 ? "danger" : "notice"]'>[paindamage] БОЛИ</span>"
		else
			if(brutedamage >= (limb_max_damage*0.75))
				status += "<span class='userdanger'><b>[LB.heavy_brute_msg]</b></span>"
			else if(brutedamage >= (limb_max_damage*0.5))
				status += "<span class='userdanger'>[LB.heavy_brute_msg]</span>"
			else if(brutedamage >= (limb_max_damage*0.25))
				status += "<span class='danger'>[LB.medium_brute_msg]</span>"
			else if(brutedamage > 0)
				status += "<span class='warning'>[LB.light_brute_msg]</span>"

			if(burndamage >= (limb_max_damage*0.75))
				status += "<span class='userdanger'><b>[LB.heavy_burn_msg]</b></span>"
			else if(burndamage >= (limb_max_damage*0.5))
				status += "<span class='userdanger'>[LB.medium_burn_msg]</span>"
			else if(burndamage >= (limb_max_damage*0.25))
				status += "<span class='danger'>[LB.medium_burn_msg]</span>"
			else if(burndamage > 0)
				status += "<span class='warning'>[LB.light_burn_msg]</span>"

			if(paindamage >= (limb_max_damage*0.75))
				status += "<span class='userdanger'><b>[LB.heavy_pain_msg]</b></span>"
			else if(paindamage >= (limb_max_damage*0.5))
				status += "<span class='userdanger'>[LB.medium_pain_msg]</span>"
			else if(paindamage >= (limb_max_damage*0.25))
				status += "<span class='lowpain'>[LB.medium_pain_msg]</span>"
			else if(paindamage > 0)
				status += "<span class='lowestpain'>[LB.light_pain_msg]</span>"

		for(var/datum/wound/hurted as anything in LB.wounds)
			var/woundmsg
			woundmsg = "[uppertext(hurted.name)]"
			switch(hurted.severity)
				if(WOUND_SEVERITY_TRIVIAL)
					status += "<span class='warning'>[woundmsg]</span>"
				if(WOUND_SEVERITY_MODERATE)
					status += "<span class='warning'>[woundmsg]</span>"
				if(WOUND_SEVERITY_SEVERE)
					status += "<span class='danger'><b>[woundmsg]</b></span>"
				if(WOUND_SEVERITY_CRITICAL)
					status += "<span class='userdanger'><b>[woundmsg]</b></span>"
			if(hurted.show_wound_topic(src))
				status = "<a href='?src=[REF(hurted)];'>[woundmsg]</a>"

		for(var/finger_type in LB.starting_digits)
			var/obj/item/digit/kid_named_finger = LB.get_digit(finger_type)
			if(!kid_named_finger)
				. += "<span class='danger'>ОТСУТСТВУЕТ [uppertext(finger_type)]</span>"

		if(LB.embedded_objects)
			for(var/obj/item/item in LB.embedded_objects)
				if(item.isEmbedHarmless())
					status += "<span class='notice'><b>[uppertext(item.name)]</b></span>"
				else
					status += "<span class='warning'><b>[uppertext(item.name)]</b></span>"

		if(LB.get_bleed_rate())
			if(LB.get_bleed_rate() > 1) //Totally arbitrary value
				status += "<span class='danger'><b>КРОВОИЗЛИТИЕ</b></span>"
			else
				status += "<span class='danger'>КРОВОТЕЧЕНИЕ</span>"

		if(LB.get_incision(TRUE))
			status += "<span class='userdanger'>НАДРЕЗ</span>"

		if(LB.is_artery_torn())
			status += "<span class='userdanger'><span class='artery'><b>АРТЕРИЯ</b></span></span>"

		if(LB.is_fractured())
			status += "<span class='boned'><b>ПЕРЕЛОМ</b></span>"
		else if(LB.is_dislocated())
			status += "<span class='boned'><b>ВЫВИХ</b></span>"

		if(LB.is_tendon_torn())
			status += "<span class='userdanger'><b>СУХОЖИЛИЕ</b></span>"

		if(LB.is_nerve_torn())
			status += "<span class='userdanger'><b>НЕРВ</b></span>"

		if(LB.is_cut_away())
			status += "<span class='userdanger'><b>ОТСОЕДИНЕНО</b></span>"

		if(LB.is_dead())
			status += "<span class='necrosis'>НЕКРОЗ</span>"
		else if(LB.germ_level >= INFECTION_LEVEL_ONE)
			status += "<span class='infection'>ГНОЙ</span>"

		if(LB.is_deformed())
			status += "<span class='necrosis'>ИЗУРОДОВАНО</span>"

		if(HAS_TRAIT(LB, TRAIT_DISFIGURED))
			status += "<span class='necrosis'><b>ИЗУРОДОВАНО</b></span>"

		if(LB.body_zone == BODY_ZONE_PRECISE_MOUTH)
			var/obj/item/bodypart/mouth/jaw = LB
			if(jaw.tapered)
				if(!wear_mask)
					status += "<span class='warning'><a href='?src=[REF(jaw)];tape=[jaw.tapered];'>СКОТЧ</a></span>"

		if(LB.current_splint)
			status += "<span class='info'><a href='?src=[REF(LB)];splint=1;'><b>ШИНА</b></a></span>"
			if(LB.current_gauze)
				status += "<span class='info'><b>БИНТ</b></span>"

		else if(LB.current_gauze)
			status += "<span class='info'><a href='?src=[REF(LB)];gauze=1;'><b>БИНТ</b></a></span>"

		if(LB.bodypart_disabled)
			status += "<span class='cyanicdream'><b>ИЗУВЕЧЕНО</b></span>"

		if(!length(status))
			status += "<span class='nicegreen'><b>ОК</b></span>"

		if(zone == check_bodyparts[1])
			return_text += "<span class='info'>☼ [capitalize(LB.name)]: <span class='info'>[jointext(status, " | ")]</span>"
		else
			return_text += "\n<span class='info'>☼ [capitalize(LB.name)]: <span class='info'>[jointext(status, " | ")]</span>"
	return_text += "</div></span>" //div infobox
	to_chat(src, jointext(return_text, ""))
	return TRUE
