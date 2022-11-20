/datum/element/decal/blood/generate_appearance(_icon, _icon_state, _dir, _plane, _layer, _color, _alpha, _smoothing, source)
	var/obj/item/item_source = source
	if(!_icon)
		_icon = 'modular_septic/icons/effects/blood.dmi'
	if(!_icon_state)
		_icon_state = "itemblood"
	var/icon = item_source.icon
	var/icon_state = item_source.icon_state
	if(!icon || !icon_state)
		// It's something which takes on the look of other items, probably
		icon = item_source.icon
		icon_state = item_source.icon_state
	var/static/list/blood_splatter_appearances = list()
	//try to find a pre-processed blood-splatter. otherwise, make a new one
	var/index = "[REF(icon)]-[icon_state]"
	pic = blood_splatter_appearances[index]
	if(!pic)
		var/icon/item_icon = icon(item_source.icon, item_source.icon_state, , 1)
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
		pic = mutable_appearance(item_icon, item_source.icon_state)
		blood_splatter_appearances[index] = pic
	return TRUE

/datum/element/decal/blood/get_examine_name(datum/source, mob/user, list/override)
	var/atom/A = source
	override[EXAMINE_POSITION_ARTICLE] = A.gender == PLURAL? "some" : "a"
	override[EXAMINE_POSITION_BEFORE] = span_bloody(" <b>blood-stained</b> ")
	return COMPONENT_EXNAME_CHANGED
