/obj/item/clothing/Topic(href, href_list)
	. = ..()
	if(href_list["armor"])
		if((get_dist(src, usr) > 1) && !usr.DirectAccess(src))
			to_chat(usr, span_warning("I can't inspect it clearly at this distance."))
			return
		var/list/readout = list("<span class='infoplain'><div class='infobox'>")
		readout += span_info("<center><u><b>DEFENSIVE CAPABILITIES</b></u></center>")
		if(subarmor.subarmor_flags & SUBARMOR_FLEXIBLE)
			readout += span_info(span_small("\n<center><i><b>FLEXIBLE ARMOR</b></i></center>"))
		else
			readout += span_info(span_small("\n<center><i><b>HARD ARMOR</b></i></center>"))
		readout += "<br><hr class='infohr'>"
		if(LAZYLEN(armor_list))
			readout += span_notice("\n<b>ARMOR</b>")
			for(var/dam_type in armor_list)
				var/armor_amount = armor_list[dam_type]
				readout += span_info("\n[dam_type] [armor_to_protection_class(armor_amount)]") //e.g. BOMB IV
		if(LAZYLEN(durability_list))
			readout += span_notice("\n<b>RESISTANCE</b>")
			for(var/dam_type in durability_list)
				var/durability_amount = durability_list[dam_type]
				readout += span_info("\n[dam_type] [armor_to_protection_class(durability_amount)]") //e.g. FIRE II
		readout += "</div></span>" //div infobox

		to_chat(usr, "[readout.Join()]")
	if(href_list["coverage"])
		if((get_dist(src, usr) > 1) && !usr.DirectAccess(src))
			to_chat(usr, span_warning("I can't inspect it clearly at this distance."))
			return
		var/list/readout = list("<span class='infoplain'><div class='infobox'>")
		readout += span_info("<center><u><b>COVERAGE</b></u></center>")
		if(LAZYLEN(body_parts_list))
			readout += "<br><hr class='infohr'>"
			for(var/body_zone in body_parts_list)
				readout += span_info("\n[body_zone]")
		readout += "</div></span>" //div infobox

		to_chat(usr, "[readout.Join()]")
