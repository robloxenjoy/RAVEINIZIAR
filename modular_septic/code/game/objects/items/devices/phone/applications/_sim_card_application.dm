/datum/simcard_application
	/**
	 * Name of the application
	 * Ideally, should have .jar at the end because old nokia phones used java applications
	*/
	var/name = "minecraft.jar"
	/// Host sim card
	var/obj/item/simcard/parent

/datum/simcard_application/New(obj/item/simcard/new_parent)
	. = ..()
	if(new_parent)
		set_parent(new_parent)

/datum/simcard_application/Destroy(force)
	. = ..()
	set_parent(null)

/datum/simcard_application/proc/execute(mob/living/user)

/datum/simcard_application/proc/install(obj/item/simcard/new_parent)

/datum/simcard_application/proc/uninstall(obj/item/simcard/new_parent)

/datum/simcard_application/proc/simcard_installed(obj/item/cellphone/new_phone)

/datum/simcard_application/proc/simcard_uninstalled(obj/item/cellphone/new_phone)

/datum/simcard_application/proc/set_parent(obj/item/simcard/new_parent)
	if(parent)
		uninstall(parent)
		LAZYREMOVE(parent.applications, src)
		parent = null
	if(!new_parent)
		return
	LAZYADD(new_parent.applications, src)
	parent = new_parent
	install(new_parent)
