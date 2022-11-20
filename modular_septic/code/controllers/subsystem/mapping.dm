/datum/controller/subsystem/mapping
	var/surface_levels_so_far = 0
	var/list/surface_z_list
	var/datum/space_level/empty_surface
	var/cave_levels_so_far = 0
	var/list/cave_z_list
	var/datum/space_level/empty_cave

/datum/controller/subsystem/mapping/proc/create_planetary_levels()
	//SURFACE
	// Create surface ruin levels
	while (surface_levels_so_far < config.surface_ruin_levels)
		++surface_levels_so_far
		var/new_level = add_new_zlevel("Nevado Surface [surface_levels_so_far]", ZTRAITS_PLANETARY_SURFACE)
		load_planetary_level(new_level, /datum/map_template/nevado_surface)
	// and one level with no ruins, if necessary
	for (var/i in 1 to config.surface_empty_levels)
		++surface_levels_so_far
		empty_surface = add_new_zlevel("Nevado Surface [surface_levels_so_far]", list(ZTRAIT_LINKAGE = CROSSLINKED_SURFACE, \
																					ZTRAIT_NEVADO = TRUE, \
																					ZTRAIT_BASETURF = /turf/open/floor/plating/asteroid/snow/nevado_surface))
		load_planetary_level(empty_surface, /datum/map_template/nevado_surface)

	//CAVES
	// Create cave ruin levels
	while (cave_levels_so_far < config.cave_ruin_levels)
		++cave_levels_so_far
		var/new_level = add_new_zlevel("Nevado Caves [cave_levels_so_far]", ZTRAITS_PLANETARY_CAVE)
		load_planetary_level(new_level, /datum/map_template/nevado_cave)
	// and one level with no ruins, if necessary
	for (var/i in 1 to config.cave_empty_levels)
		++cave_levels_so_far
		empty_cave = add_new_zlevel("Nevado Caves [cave_levels_so_far]", list(ZTRAIT_LINKAGE = CROSSLINKED_CAVE, \
																			ZTRAIT_NEVADO = TRUE, \
																			ZTRAIT_BASETURF = /turf/open/floor/plating/asteroid/nevado_caves))
		load_planetary_level(empty_surface, /datum/map_template/nevado_cave)

/datum/controller/subsystem/mapping/proc/load_planetary_level(datum/space_level/planetary_level, template_type = /datum/map_template/nevado_surface)
	var/datum/map_template/template = new template_type(null, null, TRUE)
	if(!template.cached_map || template.cached_map.check_for_errors())
		return FALSE

	var/x = round((world.maxx - template.width) * 0.5) + 1
	var/y = round((world.maxy - template.height) * 0.5) + 1

	var/datum/parsed_map/parsed = load_map(file(template.mappath), x, y, planetary_level.z_value, no_changeturf=(SSatoms.initialized == INITIALIZATION_INSSATOMS), placeOnTop=template.should_place_on_top)
	var/list/bounds = parsed.bounds
	if(!bounds)
		return FALSE

	repopulate_sorted_areas()

	//initialize things that are normally initialized after map load
	template.initTemplateBounds(bounds)
	smooth_zlevel(world.maxz)
	log_game("Z-level [template.name] ([planetary_level.name]) loaded at [x],[y],[world.maxz]")

	return planetary_level

/datum/map_template/nevado_surface
	name = "Nevado Surface Level"
	width = 255
	height = 255
	mappath = '_maps/_septic/templates/nevado_surface.dmm'

/datum/map_template/nevado_cave
	name = "Nevado Cave Level"
	width = 255
	height = 255
	mappath = '_maps/_septic/templates/nevado_cave.dmm'
