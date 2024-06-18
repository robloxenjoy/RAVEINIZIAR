/client/who()
	set name = "Кто"
	set category = "OOC"
/*
	if(!check_rights(R_ADMIN))
		return FALSE
*/
	if(!SSwho?.who_datum)
		to_chat(src, span_warning("The who subsystem has not been loaded yet."))
		return
/*
	SSwho?.who_datum?.ui_interact(mob)
*/

/client/adminwho()
	set category = "Admin"
	set name = "Adminwho"

	if(!SSwho?.adminwho_datum)
		to_chat(src, span_warning("The who subsystem has not been loaded yet."))
		return
	SSwho.adminwho_datum.ui_interact(mob)
