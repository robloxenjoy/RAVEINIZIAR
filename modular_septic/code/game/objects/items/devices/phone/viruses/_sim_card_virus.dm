/datum/simcard_virus
	/// Name of the virus, not sure if this will be used anywhere tbh
	var/name = "WANNACHUNGUS"
	/// Host sim card
	var/obj/item/simcard/parent

/datum/simcard_virus/New(obj/item/simcard/new_parent)
	. = ..()
	if(new_parent)
		set_parent(new_parent)

/datum/simcard_virus/Destroy(force)
	. = ..()
	set_parent(null)

/datum/simcard_virus/proc/install(obj/item/simcard/new_parent)

/datum/simcard_virus/proc/uninstall(obj/item/simcard/new_parent)

/datum/simcard_virus/proc/simcard_installed(obj/item/cellphone/new_phone)

/datum/simcard_virus/proc/simcard_uninstalled(obj/item/cellphone/new_phone)

/datum/simcard_virus/proc/set_parent(obj/item/simcard/new_parent)
	if(parent)
		uninstall(parent)
		LAZYREMOVE(parent.viruses, src)
		parent = null
	if(!new_parent)
		return
	LAZYADD(new_parent.viruses, src)
	parent = new_parent
	install(new_parent)
