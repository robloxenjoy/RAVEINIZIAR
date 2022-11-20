/obj/structure/grille
	icon = 'modular_septic/icons/obj/structures/smooth_structures/tall/grille.dmi'
	frill_icon = 'modular_septic/icons/obj/structures/smooth_structures/tall/grille_frill.dmi'
	icon_state = "grille-0"
	base_icon_state = "grille"
	plane = GAME_PLANE_ABOVE_WINDOW
	layer = GRILLE_LAYER
	upper_frill_plane = FRILL_PLANE_LOW
	upper_frill_layer = GRILLE_FRILL_LAYER
	lower_frill_plane = GAME_PLANE_ABOVE_WINDOW
	lower_frill_layer = ABOVE_GRILLE_LAYER
	frill_uses_icon_state = TRUE
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_GRILLES)
	canSmoothWith = list(SMOOTH_GROUP_WALLS, SMOOTH_GROUP_GRILLES)
	obj_flags = CAN_BE_HIT|BLOCK_Z_OUT_DOWN|BLOCK_Z_OUT_UP|BLOCK_Z_IN_DOWN|BLOCK_Z_IN_UP
	/// Whether or not this is a grille that goes above windows
	var/window_grille = FALSE

/obj/structure/grille/Initialize()
	. = ..()
	AddElement(/datum/element/conditional_brittle, "fireaxe")

/obj/structure/grille/update_icon_state()
	. = ..()
	var/damage_state = ""
	var/damage_percentage = clamp(CEILING((1 - atom_integrity/max_integrity) * 100, 25), 0, 75)
	if(window_grille && (damage_percentage >= 25))
		damage_state = "-d[damage_percentage]"
	else if(damage_percentage >= 50)
		damage_state = "-d50"
	if(!isnull(smoothing_junction) && (smoothing_flags & (SMOOTH_CORNERS|SMOOTH_BITMASK)))
		icon_state = "[base_icon_state][damage_state]-[smoothing_junction]"
	else
		icon_state = "[base_icon_state][damage_state]"

/obj/structure/grille/set_smoothed_icon_state(new_junction)
	. = smoothing_junction
	smoothing_junction = new_junction
	update_appearance(UPDATE_ICON)
	var/damage_state = ""
	var/damage_percentage = clamp(CEILING((1 - atom_integrity/max_integrity) * 100, 25), 0, 75)
	if(window_grille && (damage_percentage >= 25))
		damage_state = "-d[damage_percentage]"
	else if(damage_percentage >= 50)
		damage_state = "-d50"
	cut_overlays()
	SEND_SIGNAL(src, COMSIG_ATOM_SET_SMOOTHED_ICON_STATE, new_junction, "[base_icon_state][damage_state]")

/obj/structure/grille/Moved(atom/OldLoc, Dir)
	. = ..()
	update_nearby_icons()

/obj/structure/grille/Bumped(atom/movable/bumped_atom)
	if(!ismob(bumped_atom))
		return
	//Don't shock if we have a fulltile winddow here
	if(window_grille)
		for(var/obj/structure/window/window in loc)
			if(window.fulltile)
				return FALSE
	shock(bumped_atom, 70)

/obj/structure/grille/shock(mob/user, prob)
	// Anchored/broken grilles are never connected
	if(!anchored || broken || !prob(prob))
		return FALSE
	// To prevent TK and mech users from getting shocked
	if(!in_range(src, user))
		return FALSE
	var/turf/T = get_turf(src)
	var/obj/structure/cable/C = T.get_cable_node()
	if(C)
		if(electrocute_mob(user, C, src, 1, TRUE))
			var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
			s.set_up(3, 1, src)
			s.start()
			return TRUE
		else
			return FALSE
	return FALSE

/obj/structure/grille/proc/update_nearby_icons()
	update_appearance()
	if(smoothing_flags & (SMOOTH_CORNERS|SMOOTH_BITMASK))
		QUEUE_SMOOTH_NEIGHBORS(src)
