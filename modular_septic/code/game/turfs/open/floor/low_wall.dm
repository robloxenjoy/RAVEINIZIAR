/turf/open/floor/low_wall
	name = "low wall"
	desc = "A frame section to place a window on top."
	icon = 'modular_septic/icons/turf/tall/walls/low_walls/metal.dmi'
	frill_icon = null // we dont have a frill, our window does!
	icon_state = "low_wall-0"
	base_icon_state = "low_wall"
	plane = GAME_PLANE
	layer = CLOSED_TURF_LAYER
	pass_flags_self = LETPASSTHROW|PASSTABLE

	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_LOW_WALLS)
	canSmoothWith = list(SMOOTH_GROUP_WALLS, SMOOTH_GROUP_LOW_WALLS)

	opacity = FALSE
	density = FALSE
	blocks_air = FALSE
	rad_insulation = 0

	armor = list(MELEE = 40, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 10, BIO = 100, FIRE = 0, ACID = 0)
	max_integrity = 50
	uses_integrity = TRUE

	turf_height = TURF_HEIGHT_BLOCK_THRESHOLD
	overfloor_placed = FALSE

	clingable = TRUE
	/// Whether we start with a grille or not
	var/start_with_grille = FALSE
	/// Whether we spawn a window structure with us on mapload
	var/start_with_window = FALSE
	/**
	 * typepath. creates a corresponding window for this frame.
	 * is either a material sheet typepath (eg /obj/item/stack/sheet/glass) or a fulltile window typepath (eg /obj/structure/window/fulltile)
	 */
	var/window_type = /obj/item/stack/sheet/glass
	/**
	 * typepath. creates a corresponding grille for this frame.
	 * is either a material sheet typepath (eg /obj/item/stack/rods) or a grille typepath (eg /obj/structure/grille)
	 */
	var/grille_type = /obj/item/stack/rods

/turf/open/floor/low_wall/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_CLIMBABLE, INNATE_TRAIT)
	RegisterSignal(src, COMSIG_OBJ_PAINTED, .proc/on_painted)
	if(start_with_window)
		create_structure_window(window_type, TRUE)
	if(start_with_grille)
		create_structure_grille(grille_type, TRUE)
	update_appearance()

/turf/open/floor/low_wall/initialize_clinging()
	if(clingable)
		AddElement(/datum/element/clingable, SKILL_ACROBATICS, 15, clinging_sound)
		return TRUE
	return FALSE

/turf/open/floor/low_wall/setup_broken_states()
	return

/turf/open/floor/low_wall/setup_burnt_states()
	return

/turf/open/floor/low_wall/attackby(obj/item/attacking_item, mob/living/user, params)
	add_fingerprint(user)
	if(attacking_item.tool_behaviour == TOOL_WELDER)
		if(atom_integrity < max_integrity)
			if(!attacking_item.tool_start_check(user, amount = 0))
				return

			to_chat(user, span_notice("I begin repairing [src]..."))
			if(!attacking_item.use_tool(src, user, 40, volume = 50))
				return

			atom_integrity = max_integrity
			to_chat(user, span_notice("I repair [src]."))
			update_appearance()
		else
			to_chat(user, span_warning("[src] is already in good condition!"))
		return
	else if(isstack(attacking_item))
		var/obj/item/stack/adding_stack = attacking_item
		var/stack_name = "[adding_stack]" // in case the stack gets deleted after use()

		if(is_glass_sheet(adding_stack) && !has_window() && adding_stack.use(2))
			to_chat(user, span_notice("I start to add [stack_name] to [src]."))
			if(!do_after(user, 2 SECONDS, src))
				return

			to_chat(user, span_notice("I add [stack_name] to [src]."))
			create_structure_window(adding_stack.type, FALSE)

		else if(istype(adding_stack, /obj/item/stack/rods) && !has_grille() && adding_stack.use(2))
			to_chat(user, span_notice("I start to add [stack_name] to [src]."))
			if(!do_after(user, 2 SECONDS, src))
				return

			to_chat(user, span_notice("I add [stack_name] to [src]."))
			create_structure_grille(adding_stack.type, FALSE)

	return ..() || attacking_item.attack_atom(src, user, params)

/turf/open/floor/low_wall/attack_paw(mob/user, list/modifiers)
	return attack_hand(user, modifiers)

/turf/open/floor/low_wall/examine(mob/user)
	. = ..()
	var/has_window = has_window()
	var/has_grille = has_grille()
	if(has_window && has_grille)
		. += span_notice("The window is fully constructed.")
	else if(has_window)
		. += span_notice("The window set into the frame has no grilles.")
	else if(has_grille)
		. += span_notice("The window frame only has a grille set into it.")
	else
		. += span_notice("The window frame is empty.")

/turf/open/floor/low_wall/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = NONE)
	switch(damage_type)
		if(BRUTE)
			if(damage_amount)
				playsound(src, 'sound/effects/grillehit.ogg', 80, TRUE)
			else
				playsound(src, 'sound/weapons/tap.ogg', 50, TRUE)
		if(BURN)
			playsound(src, 'sound/items/welder.ogg', 80, TRUE)

/turf/open/floor/low_wall/rcd_vals(mob/user, obj/item/construction/rcd/the_rcd)
	if(the_rcd.mode == RCD_DECONSTRUCT)
		return list("mode" = RCD_DECONSTRUCT, "delay" = 20, "cost" = 5)
	return FALSE

/turf/open/floor/low_wall/rcd_act(mob/user, obj/item/construction/rcd/the_rcd)
	if(the_rcd.mode == RCD_DECONSTRUCT)
		to_chat(user, span_notice("I deconstruct the low wall."))
		ScrapeAway(flags = CHANGETURF_INHERIT_AIR)
		return TRUE
	return FALSE

/turf/open/floor/low_wall/MakeDirty()
	return

/turf/open/floor/low_wall/atom_destruction(damage_flag)
	ScrapeAway(flags = CHANGETURF_INHERIT_AIR)

/turf/open/floor/low_wall/break_tile()
	ScrapeAway(flags = CHANGETURF_INHERIT_AIR)

/turf/open/floor/low_wall/proc/on_painted(turf/closed/wall/low_wall/source, is_dark_color = FALSE)
	SIGNAL_HANDLER

	if(is_dark_color)
		set_opacity(255)
	else
		set_opacity(initial(opacity))

///helper proc to check if we already have a window
/turf/open/floor/low_wall/proc/has_window()
	SHOULD_BE_PURE(TRUE)
	for(var/obj/structure/window/window in src)
		if(window.fulltile)
			return TRUE

	return FALSE

///helper proc to check if we already have a grille
/turf/open/floor/low_wall/proc/has_grille()
	SHOULD_BE_PURE(TRUE)
	for(var/obj/structure/grille/grille in src)
		return TRUE

	return FALSE

///creates a window from the typepath given from window_type, which is either a glass sheet typepath or a /obj/structure/window subtype
/turf/open/floor/low_wall/proc/create_structure_window(window_type, start_anchored = TRUE)
	var/obj/structure/window/our_window

	if(ispath(window_type, /obj/structure/window))
		our_window = new window_type(src)
		if(!our_window.fulltile)
			stack_trace("window frames cant use non fulltile windows!")

	//window_type isnt a window typepath, so check if its a material typepath
	if(ispath(window_type, /obj/item/stack/sheet/glass))
		our_window = new /obj/structure/window/fulltile(src)

	if(ispath(window_type, /obj/item/stack/sheet/rglass))
		our_window = new /obj/structure/window/reinforced/fulltile(src)

	if(ispath(window_type, /obj/item/stack/sheet/plasmaglass))
		our_window = new /obj/structure/window/plasma/fulltile(src)

	if(ispath(window_type, /obj/item/stack/sheet/plasmarglass))
		our_window = new /obj/structure/window/reinforced/plasma/fulltile(src)

	if(ispath(window_type, /obj/item/stack/sheet/titaniumglass))
		our_window = new /obj/structure/window/reinforced/shuttle(src)

	if(ispath(window_type, /obj/item/stack/sheet/plastitaniumglass))
		our_window = new /obj/structure/window/reinforced/plasma/plastitanium(src)

	if(ispath(window_type, /obj/item/stack/sheet/paperframes))
		our_window = new /obj/structure/window/paperframe(src)

	if(!start_anchored)
		our_window.set_anchored(FALSE)
		our_window.state = WINDOW_OUT_OF_FRAME

	our_window.update_appearance()

///creates a window from the typepath given from window_type, which is either a glass sheet typepath or a /obj/structure/window subtype
/turf/open/floor/low_wall/proc/create_structure_grille(window_type, start_anchored = TRUE)
	var/obj/structure/grille/our_grille

	if(ispath(window_type, /obj/structure/grille))
		our_grille = new grille_type(src)

	//grille_type isnt a window typepath, so check if its a material typepath
	if(ispath(window_type, /obj/item/stack/rods))
		our_grille = new /obj/structure/grille(src)

	if(!start_anchored)
		our_grille.set_anchored(FALSE)

	our_grille.update_appearance()

/turf/open/floor/low_wall/grille
	start_with_grille = TRUE

/turf/open/floor/low_wall/grille_and_window
	start_with_grille = TRUE
	start_with_window = TRUE

/turf/open/floor/low_wall/window
	start_with_grille = FALSE
	start_with_window = TRUE
