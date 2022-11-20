/atom/movable/screen/grab
	name = "grab"
	desc = "Holy shit you really shouldn't be reading this."
	icon = 'modular_septic/icons/hud/quake/grab.dmi'
	icon_state = "grab_wrench"
	base_icon_state = "grab"
	plane = HUD_PLANE
	layer = GRAB_LAYER
	//Grab item we are allied to
	var/obj/item/grab/parent

/atom/movable/screen/grab/Click(location, control, params)
	var/list/modifiers = params2list(params)
	if(parent)
		if(LAZYACCESS(modifiers, SHIFT_CLICK))
			usr.examinate(parent)
			return
		if((usr == parent.owner) && usr.canUseTopic(parent, be_close = TRUE, need_hands = FALSE, floor_okay = TRUE))
			var/icon_y = text2num(LAZYACCESS(modifiers, ICON_Y))
			var/mob/living/carbon/was_owner = parent.owner
			switch(parent.grab_mode)
				if(GM_TEAROFF)
					if(COOLDOWN_FINISHED(usr, next_move))
						if(icon_y <= 16)
							. = parent.tear_off_limb()
						else
							. = parent.wrench_limb()
				if(GM_EMBEDDED)
					if(COOLDOWN_FINISHED(usr, next_move))
						if(icon_y <= 16)
							. = parent.pull_embedded()
						else
							. = parent.twist_embedded()
				if(GM_BITE)
					if(LAZYACCESS(modifiers, RIGHT_CLICK))
						parent.owner.dropItemToGround(parent)
					else if(COOLDOWN_FINISHED(usr, next_move))
						. = parent.bite_limb()
				if(GM_GUTBUSTED)
					if(COOLDOWN_FINISHED(usr, next_move))
						. = parent.tear_off_gut()
				else
					. = usr.ClickOn(parent, params)
			for(var/obj/item/grab/grabber in (was_owner.held_items | was_owner.get_item_by_slot(ITEM_SLOT_MASK)))
				grabber.update_grab_mode()
		return
	return ..()

/atom/movable/screen/grab/MouseDrop(atom/over, src_location, over_location, src_control, over_control, params)
	. = ..()
	if(istype(over, /atom/movable/screen/inventory/hand))
		parent?.owner?.dropItemToGround(parent)

/atom/movable/screen/grab/update_name(updates)
	. = ..()
	if(parent)
		if(parent.bite_grab)
			name = "biting [parent.victim]"
		else
			name = "grabbing [parent.victim]"
		parent.name = name
		return
	name = "grab"

/atom/movable/screen/grab/examine(mob/user)
	if(parent)
		return parent.examine(user)
	return ..()

/atom/movable/screen/grab/update_icon_state()
	. = ..()
	if(parent?.grab_mode)
		icon_state = "[base_icon_state]_[parent.grab_mode]"
	else
		icon_state = base_icon_state

/atom/movable/screen/grab/update_overlays()
	. = ..()
	if(!parent?.active)
		return
	switch(parent.grab_mode)
		if(GM_STRANGLE)
			. += "strangle_active"
		if(GM_TAKEDOWN)
			. += "takedown_active"
