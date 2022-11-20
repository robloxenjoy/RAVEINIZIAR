/atom/Topic(href, list/href_list)
	. = ..()
	if(href_list["integrity"])
		if((get_dist(src, usr) > 1) && !usr.DirectAccess(src))
			to_chat(usr, span_warning("I can't inspect it clearly at this distance."))
			return
		var/list/readout = list("<span class='infoplain'><div class='infobox'>")
		readout += span_info("<center><u><b>INTEGRITY</b></u></center>")
		var/integrity_percent = CEILING((atom_integrity/max_integrity)*100, 1)
		readout += span_info(span_small("\n<center><i><b>[integrity_percent]/100%</b></i></center>"))
		readout += "<br><hr class='infohr'>"
		readout += span_info("\n<b>Max Integrity:</b> [max_integrity]")
		readout += span_info("\n<b>Failure Integrity:</b> [integrity_failure*max_integrity]")
		readout += span_info("\n<b>Current Integrity:</b> [atom_integrity]")
		readout += "</div></span>" //div infobox

		to_chat(usr, "[readout.Join()]")
