// Atmos types used for planetary airs
/datum/atmosphere/nevado_surface
	id = NEVADO_SURFACE_DEFAULT_ATMOS

	base_gases = list(
		/datum/gas/oxygen=22,
		/datum/gas/nitrogen=78,
	)
	normal_gases = list(
		/datum/gas/nitrogen=1,
		/datum/gas/water_vapor=1,
	)
	restricted_gases = list()

	//some pretty normal pressures
	minimum_pressure = ONE_ATMOSPHERE
	maximum_pressure = ONE_ATMOSPHERE

	// -5 celsius average
	minimum_temp = T0C-10
	maximum_temp = T0C

/datum/atmosphere/nevado_caves
	id = NEVADO_CAVES_DEFAULT_ATMOS

	base_gases = list(
		/datum/gas/oxygen=22,
		/datum/gas/nitrogen=78,
	)
	normal_gases = list(
		/datum/gas/nitrogen=1,
		/datum/gas/water_vapor=1,
	)
	restricted_gases = list()

	//some pretty normal pressures
	minimum_pressure = ONE_ATMOSPHERE
	maximum_pressure = ONE_ATMOSPHERE

	// 5 celsius average
	minimum_temp = T0C
	maximum_temp = T0C+10
