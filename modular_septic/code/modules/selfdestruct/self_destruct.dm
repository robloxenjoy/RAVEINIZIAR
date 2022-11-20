/obj/machinery/nuclearbomb
	var/auth_code_1 = ""

/obj/machinery/nuclearbomb/Initialize()
	. = ..()
	auth_code_1 = get_authcode()

/proc/get_authcode(fake = FALSE)
	if(GLOB.nuke_authcode && !fake)
		return GLOB.nuke_authcode

	var/raw_code
	for(var/n in 1 to 5)
		raw_code += random_string(4, GLOB.alphabet + GLOB.alphabet_upper + GLOB.numerals)
		raw_code += "-"
	raw_code += random_string(4, GLOB.alphabet + GLOB.alphabet_upper + GLOB.numerals)

	if(!fake) //the nuke code is real, and we don't have one already
		GLOB.nuke_authcode = raw_code
	return raw_code

/obj/machinery/nuclearbomb/proc/disk_check(obj/item/disk/nuclear/D)
	if(D.auth_code != auth_code_1)
		say("Authentication failure; disk not recognised.")
		return FALSE
	else
		return TRUE

/obj/item/disk/nuclear
	var/auth_code

/obj/item/disk/nuclear/Initialize()
	. = ..()
	auth_code = get_authcode(fake)

/obj/item/disk/nuclear/examine(mob/user)
	. = ..()
	if(auth_code)
		. += span_notice("There's a serial number imprinted on the back...\n[auth_code]")

/obj/item/disk/nuclear/fake/obvious/Initialize()
	. = ..()
	auth_code = null
