/atom/movable/screen/spacesuit
	name = "suit cell"
	icon = 'modular_septic/icons/hud/quake/screen_quake.dmi'
	icon_state = "spacesuit_missing"
	screen_loc = ui_spacesuit

/atom/movable/screen/spacesuit/Click(location, control, params)
	. = ..()
	if(!ishuman(usr))
		to_chat(usr, div_infobox(span_warning("I'm incapable of wearing a space suit.")))
		return
	var/mob/living/carbon/human/humie = usr
	var/obj/item/clothing/suit/space/spacesuit = humie.wear_suit
	if(istype(spacesuit))
		var/obj/item/stock_parts/cell/cell = spacesuit.cell
		if(!istype(cell))
			to_chat(humie, div_infobox(span_warning("Power cell missing.")))
		else if(cell.charge > cell.maxcharge * 0.2)
			to_chat(humie, div_infobox(span_notice("Cell charge OK: [CEILING((cell.charge/cell.maxcharge)*100, 1)]%")))
		else
			to_chat(humie, div_infobox(span_alert("Cell charge LOW: [CEILING((cell.charge/cell.maxcharge)*100, 1)]%")))
	else
		to_chat(humie, div_infobox(span_warning("I am not wearing a spacesuit.")))
