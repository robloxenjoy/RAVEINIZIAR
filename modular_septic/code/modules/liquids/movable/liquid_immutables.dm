/atom/movable/liquid/immutable
	immutable = TRUE
	vaporizes = FALSE

/atom/movable/liquid/immutable/ocean
	icon_state = "ocean"
	base_icon_state = "ocean"
	smoothing_flags = NONE
	plane = BLACKNESS_PLANE //Same as weather, etc.
	layer = ABOVE_MOB_LAYER
	temperature = T20C-150
	no_effects = TRUE
	vis_flags = NONE

/atom/movable/liquid/immutable/ocean/warm
	temperature = T20C

/atom/movable/liquid/immutable/ocean/warm/warmer
	temperature = T20C+20

/atom/movable/liquid/immutable/ocean/nevado
	temperature = T0C-10

/atom/movable/liquid/immutable/ocean/shallow
	temperature = T0C-20
	vaporizes = FALSE
	starting_mixture = list(
		/datum/reagent/toxin/badwater/shallow = 100,
	)

/atom/movable/liquid/immutable/ocean/shallow/deep
	temperature = T0C-10
	vaporizes = FALSE
	starting_mixture = list(
		/datum/reagent/toxin/badwater/shallow = 400,
	)

/atom/movable/liquid/immutable/ocean/shallow/verydeep
	temperature = T0C-20
	vaporizes = FALSE
	starting_mixture = list(
		/datum/reagent/toxin/badwater/shallow = 400,
	)
