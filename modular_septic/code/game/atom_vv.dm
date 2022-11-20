/atom/vv_get_dropdown()
	. = ..()
	VV_DROPDOWN_OPTION(VV_HK_EDIT_MATRIXES, "Modify Transform as Matrix")

/atom/vv_do_topic(list/href_list)
	. = ..()
	if(href_list[VV_HK_EDIT_MATRIXES] && check_rights(R_VAREDIT))
		usr.client?.open_matrix_tester(src)
