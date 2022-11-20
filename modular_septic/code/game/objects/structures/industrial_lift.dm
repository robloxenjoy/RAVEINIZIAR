/obj/structure/industrial_lift/tram/central/baluarte
	icon = 'modular_septic/icons/turf/floors.dmi'
	icon_state = "textured"
	base_icon_state = "textured"
	initial_id = "arrival_station"

/obj/structure/industrial_lift/tram/baluarte
	icon = 'modular_septic/icons/turf/floors.dmi'
	icon_state = "textured"
	base_icon_state = "textured"
	initial_id = "arrival_station"

// i don't want lattice to be taken away by the train lol
/obj/structure/industrial_lift/AddItemOnLift(datum/source, atom/movable/AM)
	var/static/list/bad_types_typecache
	if(!LAZYLEN(bad_types_typecache))
		bad_types_typecache = list()
		bad_types_typecache |= typecacheof(/obj/structure/cable)
		bad_types_typecache |= typecacheof(/obj/structure/fluff/tram_rail)
		bad_types_typecache |= typecacheof(/obj/structure/lattice)
		bad_types_typecache |= typecacheof(/obj/structure/holosign/barrier/atmos/sturdy)
		bad_types_typecache |= typecacheof(/atom/movable/liquid)
		bad_types_typecache |= typecacheof(/atom/movable/fire)
	if((AM.invisibility == INVISIBILITY_ABSTRACT) || is_type_in_typecache(AM, bad_types_typecache)) //prevents the tram from stealing things like landmarks
		return
	if(AM in lift_load)
		return
	LAZYADD(lift_load, AM)
	RegisterSignal(AM, COMSIG_PARENT_QDELETING, .proc/RemoveItemFromLift)

/obj/structure/industrial_lift
	icon = 'modular_septic/icons/turf/floors.dmi'
	icon_state = "lift"
	base_icon_state = "lift"
	smoothing_flags = null
	smoothing_groups = null
	canSmoothWith = null

/obj/structure/industrial_lift/Initialize(mapload)
	. = ..()
	var/static/list/bad_initialize = list(INITIALIZE_HINT_QDEL, INITIALIZE_HINT_QDEL_FORCE)
	if(!(. in bad_initialize))
		AddComponent(/datum/component/footstep_changer, FOOTSTEP_HARDCATWALK)

/obj/effect/landmark/tram/arrival_station
	name = "Arrivals"
	destination_id = "arrival_station"
	tgui_icons = list("Arrival Station" = "subway")

/obj/effect/landmark/tram/entrance_station
	name = "Entrance"
	destination_id = "entrance_station"
	tgui_icons = list("Train Station" = "subway")
