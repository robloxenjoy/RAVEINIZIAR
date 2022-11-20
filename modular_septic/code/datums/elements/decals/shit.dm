/datum/element/decal/shit

/datum/element/decal/shit/Attach(datum/target, _icon, _icon_state, _dir, _plane, _layer, _alpha, _color, _smoothing, _cleanable=CLEAN_TYPE_BLOOD, _description, mutable_appearance/_pic)
	if(!isitem(target))
		return ELEMENT_INCOMPATIBLE

	. = ..()
	RegisterSignal(target, COMSIG_ATOM_GET_EXAMINE_NAME, .proc/get_examine_name, TRUE)

/datum/element/decal/shit/Detach(atom/source)
	UnregisterSignal(source, COMSIG_ATOM_GET_EXAMINE_NAME)
	return ..()

/datum/element/decal/shit/generate_appearance(_icon, _icon_state, _dir, _plane, _layer, _color, _alpha, _smoothing, source)
	var/obj/item/I = source
	if(!_icon)
		_icon = 'modular_septic/icons/effects/shit.dmi'
	if(!_icon_state)
		_icon_state = "itemshit"
	var/icon = I.icon
	var/icon_state = I.icon_state
	if(!icon || !icon_state)
		// It's something which takes on the look of other items, probably
		icon = I.icon
		icon_state = I.icon_state
	var/static/list/shit_splatter_appearances = list()
	//try to find a pre-processed blood-splatter. otherwise, make a new one
	var/index = "[REF(icon)]-[icon_state]"
	pic = shit_splatter_appearances[index]
	if(!pic)
		var/icon/item_icon = icon(I.icon, I.icon_state, , 1)
		var/width_height = "[item_icon.Width()]x[item_icon.Height()]"
		var/icon/decal_icon
		switch(width_height)
			if("40x32")
				decal_icon = icon('modular_septic/icons/effects/40x32.dmi', _icon_state)
			if("48x32")
				decal_icon = icon('modular_septic/icons/effects/48x32.dmi', _icon_state)
			if("64x32")
				decal_icon = icon('modular_septic/icons/effects/64x32.dmi', _icon_state)
			if("64x64")
				decal_icon = icon('modular_septic/icons/effects/64x64.dmi', _icon_state)
			else
				decal_icon = icon(_icon, _icon_state)
		item_icon.Blend("#ffffff", ICON_ADD) //fills the icon_state with white (except where it's transparent)
		item_icon.Blend(decal_icon, ICON_MULTIPLY) //adds blood and the remaining white areas become transparent
		pic = mutable_appearance(item_icon, I.icon_state)
		shit_splatter_appearances[index] = pic
	return TRUE

/datum/element/decal/shit/proc/get_examine_name(datum/source, mob/user, list/override)
	SIGNAL_HANDLER

	var/atom/A = source
	override[EXAMINE_POSITION_ARTICLE] = A.gender == PLURAL? "some" : "a"
	override[EXAMINE_POSITION_BEFORE] = span_shitty(" <b>shit-stained</b> ")
	return COMPONENT_EXNAME_CHANGED
