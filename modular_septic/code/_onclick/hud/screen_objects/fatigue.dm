//fatigue shit
/atom/movable/screen/fatigue
	icon = 'modular_septic/icons/hud/quake/screen_quake.dmi'
	name = "fatigue"
	icon_state = "fatigue20"
	base_icon_state = "fatigue"
	screen_loc = ui_fatigue

/atom/movable/screen/fatigue/Click(location,control,params)
	. = ..()
	if(isliving(usr))
		var/mob/living/user = usr
		var/msg = list("<span class='infoplain'><div class='infobox'>")
		msg += span_notice("<EM>Fatigue</EM>")
		if(LAZYLEN(user.fatigue_modification))
			var/list/meaningful_fatigue_mods = list()
			for(var/thing in user.fatigue_modification)
				var/datum/fatigue_modifier/modifier = user.fatigue_modification[thing]
				var/fatigue_add = initial(modifier.fatigue_add)
				var/modifier_desc = initial(modifier.desc)
				var/left_symbols = get_signs_from_number(FLOOR(initial(modifier.fatigue_add)/10, 1), 1)
				var/right_symbols = get_signs_from_number(FLOOR(initial(modifier.fatigue_add)/10, 1), 0)
				if(initial(modifier.variable))
					fatigue_add = modifier.fatigue_add
					modifier_desc = modifier.desc
					left_symbols = get_signs_from_number(FLOOR(modifier.fatigue_add/10, 1), 1)
					right_symbols = get_signs_from_number(FLOOR(modifier.fatigue_add/10, 1), 0)
				if(!fatigue_add)
					continue
				meaningful_fatigue_mods |= thing
				msg += span_info("\n[left_symbols][modifier_desc][right_symbols]")
			if(!LAZYLEN(meaningful_fatigue_mods))
				msg += span_info("\nNothing is affecting my fatigue at the moment.")
		else
			msg += span_info("\nNothing is affecting my fatigue at the moment.")
		msg += "</div></span>" //div infobox
		to_chat(user, jointext(msg, ""))

/atom/movable/screen/fatigue/update_icon_state()
	. = ..()
	var/mob/living/carbon/user = hud?.mymob
	if(!istype(user))
		return
	if(user.stat >= DEAD || (user.hal_screwyhud in 1 to 2))
		icon_state = "[base_icon_state]0"
	else if((user.hal_screwyhud == SCREWYHUD_HEALTHY))
		icon_state = "[base_icon_state]20"
	else
		var/tired = clamp(FATIGUE_CRIT_THRESHOLD-user.getFatigueLoss(), 0, FATIGUE_CRIT_THRESHOLD)
		icon_state = "[base_icon_state][clamp(FLOOR(tired/FATIGUE_CRIT_THRESHOLD*20, 1), 0, 20)]"

/atom/movable/screen/fatigue/update_overlays()
	. = ..()
	var/mob/living/carbon/user = hud?.mymob
	if(!istype(user))
		return
	var/fatigue_reduction = user.total_fatigue_reduction()
	if(fatigue_reduction >= 0)
		return
	if(user.hal_screwyhud == SCREWYHUD_HEALTHY)
		return
	var/image/overfatigue = image(icon, src, "overfatigue[clamp(FLOOR(abs(fatigue_reduction)/FATIGUE_CRIT_THRESHOLD*20, 1), 0, 20)]", layer+1)
	. += overfatigue
