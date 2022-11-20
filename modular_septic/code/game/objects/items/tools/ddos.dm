/obj/item/ddos
	name = "denial of service device"
	desc = "A compact, hastily thrown together circuitboard used to hack into a myriad of electronics.\n\
			A note on the back reads: \"" + \
			span_green("D") + span_yellow("D") + span_green("o") + span_white("S") + " " + \
			span_yellow("N") + span_white("I") + span_yellow("G") + span_white("G") + span_yellow("A") + span_green("S") + \
			"\"."
	icon = 'modular_septic/icons/obj/items/2pacalypse.dmi'
	icon_state = "ddos"
	lefthand_file = 'modular_septic/icons/obj/items/inhands/2pacalypse_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/inhands/2pacalypse_righthand.dmi'
	tool_behaviour = TOOL_HACKING
	toolspeed = 1
	w_class = WEIGHT_CLASS_SMALL
	carry_weight = 500 GRAMS

/obj/item/ddos/examine_more(mob/user)
	. = list()
	var/botnets = rand(1, 100)
	. += span_info("[src] reports...")
	. += span_big(span_alert("[botnets] BOTNET[botnets == 1 ? "" : "S"] ONLINE"))
