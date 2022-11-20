/**
 * ## nobody wants to learn matrix math!
 *
 * More than just a completely true statement, this datum is created as a tgui interface
 * allowing you to modify each vector until you know what you're doing.
 * Much like filteriffic, 'nobody wants to learn matrix math' is meant for developers like you and I
 * to implement interesting matrix transformations without the hassle if needing to know... algebra? Damn, i'm stupid.
 */
/datum/matrix_editor
	var/datum/weakref/target
	var/matrix/testing_matrix

/datum/matrix_editor/New(atom/target)
	src.target = WEAKREF(target)
	testing_matrix = new(target.transform)

/datum/matrix_editor/Destroy(force)
	QDEL_NULL(testing_matrix)
	return ..()

/datum/matrix_editor/ui_state(mob/user)
	return GLOB.admin_state

/datum/matrix_editor/ui_close(mob/user)
	qdel(src)

/datum/matrix_editor/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "MatrixEditor")
		ui.open()

/datum/matrix_editor/ui_data()
	var/list/data = list()

	data["matrix_a"] = testing_matrix.a
	data["matrix_b"] = testing_matrix.b
	data["matrix_c"] = testing_matrix.c
	data["matrix_d"] = testing_matrix.d
	data["matrix_e"] = testing_matrix.e
	data["matrix_f"] = testing_matrix.f

	return data

/datum/matrix_editor/ui_act(action, list/params)
	. = ..()
	if(.)
		return

	var/atom/target_atom = target?.resolve()
	if(!target_atom)
		to_chat(usr, "The target atom is gone. Terrible job, supershit.", confidential = TRUE)
		qdel(src)
		return
	switch(action)
		if("change_var")
			var/matrix_var_name = params["var_name"]
			var/matrix_var_value = params["var_value"]
			if(testing_matrix.vv_edit_var(matrix_var_name, matrix_var_value) == FALSE)
				to_chat(usr, "Your edit was rejected by the object. This is a bug with the matrix tester, not your fault, so report it on github.", confidential = TRUE)
				return
			animate(target_atom, transform = testing_matrix, time = 0.5 SECONDS)
	return TRUE
