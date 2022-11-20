/obj/item/simcard
	name = "\improper sim card"
	desc = "Sim, sim, I agree with your statement"
	icon = 'modular_septic/icons/obj/items/phone.dmi'
	icon_state = "simcard"
	base_icon_state = "simcard"
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_TINY
	/// Username of the sim card, used even when not public
	var/username
	/// Phone number (this is actually a string lol)
	var/phone_number
	/// Whether we are in the public phone list or not
	var/publicity = TRUE
	/// Phone we are inside of
	var/obj/item/cellphone/parent
	/// List of applications we are storing (lazylist)
	var/list/datum/simcard_application/applications
	/**
	 * List of viruses we are storing
	 * Viruses get processed frequently, unlike applications
	 */
	var/list/datum/simcard_virus/viruses

	/**
	 * Firewall health of the simcard
	 * When this is above 0, we can defend ourselves against DoS attacks.
	 */
	var/firewall_health = 0
	/// Maximum firewall health of the simcard
	var/firewall_maxhealth = 0
	/// Sim cards with virus immunity will not get infected by viruses, ever
	var/virus_immunity = FALSE
	/// The amount of power hacker phonese get from hacking these
	var/binary_essence = 50

/obj/item/simcard/Initialize(mapload)
	. = ..()
	generate_phone_number()
	GLOB.simcard_list[phone_number] = src
	if(LAZYLEN(applications))
		var/list/old_apps = applications.Copy()
		applications = list()
		for(var/application in old_apps)
			new application(src)

/obj/item/simcard/Destroy()
	. = ..()
	for(var/app in applications)
		qdel(app)
	for(var/viros in viruses)
		qdel(viros)
	GLOB.active_public_simcard_list -= username
	GLOB.active_simcard_list -= phone_number
	GLOB.simcard_list -= phone_number
	GLOB.simcard_list_by_username -= username

/obj/item/simcard/attackby(obj/item/attacking_item, mob/living/user, params)
	. = ..()
	if(istype(attacking_item, /obj/item/cellphone))
		var/obj/item/cellphone/attacker_cellphone = attacking_item
		var/datum/simcard_application/hacking/hacking_application = locate(/datum/simcard_application/hacking) in attacker_cellphone.simcard?.applications
		if(hacking_application)
			hacking_application.level_progress += binary_essence
			hacking_application.check_level_up(user)
			audible_message(span_boldwarning("[user] hacks!"))
			fry(silent = FALSE)

/obj/item/simcard/proc/toggle_publicity()
	publicity = !publicity
	if(publicity && parent && username)
		GLOB.active_public_simcard_list[username] = src
	else
		GLOB.active_public_simcard_list -= username

/obj/item/simcard/proc/generate_phone_number()
	if(phone_number)
		GLOB.simcard_list -= phone_number
	phone_number = "[rand(0,9)][rand(0,9)][rand(0,9)][rand(0,9)]-[rand(0,9)][rand(0,9)][rand(0,9)][rand(0,9)]"
	GLOB.simcard_list[phone_number] = src

/obj/item/simcard/proc/fry(silent = FALSE)
	if(!silent)
		do_sparks(3, FALSE, src)
		audible_message(span_bolddanger("[src] fizzles, smoking at the edges!"))
		playsound(src, 'modular_septic/sound/efn/hacker_phone_zap.ogg', 65, FALSE)
	new /obj/item/trash/simcard(get_turf(src)) //fried!
	qdel(src)
	if(parent)
		parent.update_appearance(UPDATE_ICON)
