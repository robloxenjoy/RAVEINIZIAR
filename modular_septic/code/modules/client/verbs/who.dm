/client/who()
	set name = "Who"
	set category = "OOC"

	if(!SSwho?.who_datum)
		to_chat(src, span_warning("The who subsystem has not been loaded yet."))
		return
	SSwho?.who_datum?.ui_interact(mob)

/client/adminwho()
	set category = "Admin"
	set name = "Adminwho"

	if(!SSwho?.adminwho_datum)
		to_chat(src, span_warning("The who subsystem has not been loaded yet."))
		return
	SSwho.adminwho_datum.ui_interact(mob)
