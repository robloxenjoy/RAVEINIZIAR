/obj/machinery/computer/exports
	name = "\improper RobinHood"
	desc = "A terminal used to keep up to date with the ever changing capitalist universe.\n\
			<i>Buy high, sell low!</i>"
	icon = 'modular_septic/icons/obj//machinery/computer.dmi'
	icon_state = "computer_small"
	icon_screen = "exports"
	icon_keyboard = "exports_key"
	light_color = COLOR_BRIGHT_ORANGE
	var/currently_viewed_export

/obj/machinery/computer/exports/Initialize(mapload, obj/item/circuitboard/C)
	. = ..()
	SSmarket.market_consoles += src

/obj/machinery/computer/exports/Destroy()
	. = ..()
	SSmarket.market_consoles -= src

/obj/machinery/computer/exports/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Exports")
		ui.set_autoupdate(FALSE)
		ui.open()

/obj/machinery/computer/exports/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	switch(action)
		if("graph_view")
			var/typepath = text2path(params["type"])
			if(typepath)
				var/datum/export/viewed_export = GLOB.exports_by_type[typepath]
				if(!viewed_export)
					return
				currently_viewed_export = typepath
			else
				currently_viewed_export = null
			if(ui)
				ui.close()
			ui_interact(usr)

/obj/machinery/computer/exports/ui_static_data(mob/user)
	var/list/data = list()

	if(currently_viewed_export)
		var/list/this_export = list()

		var/datum/export/export = GLOB.exports_by_type[currently_viewed_export]
		this_export["unit_name"] = capitalize(export.unit_name)
		this_export["cost"] = export.cost
		this_export["previous_cost"] = export.previous_cost
		this_export["initial_cost"] = export.init_cost
		this_export["cost_history"] = export.cost_history
		this_export["type"] = export.type

		data["current_export"] = this_export

	var/list/export_information = list()

	for(var/datum/export/export as anything in GLOB.exports_list)
		if(!export.unit_name || export.secret)
			continue
		var/list/this_export = list()

		this_export["unit_name"] = capitalize(export.unit_name)
		this_export["cost"] = export.cost
		this_export["previous_cost"] = export.previous_cost
		this_export["initial_cost"] = export.init_cost
		this_export["type"] = export.type

		export_information += list(this_export)

	data["exports"] = export_information

	return data

/obj/structure/table/exportstable
	name = "exports table"
	desc = "A square piece of iron for placing documents, stamps, pens, and revolvers."
	icon = 'modular_septic/icons/obj/structures/structures.dmi'
	icon_state = "table_small"
	smoothing_flags = null
	smoothing_groups = null
	canSmoothWith = null
