/turf
	vis_flags = VIS_INHERIT_PLANE
	inspect_icon_state = "floor"
	bullet_bounce_sound = list(
		'modular_septic/sound/bullet/casing_bounce1.ogg',
		'modular_septic/sound/bullet/casing_bounce2.ogg',
		'modular_septic/sound/bullet/casing_bounce3.ogg',
	)
	/// This height is used exclusively for checking if mobs should fall or not!
	var/turf_height = 0
	/// Should this turf get the clingable element?
	var/clingable = FALSE
	var/easyclingable = FALSE
	/// If we are clingable, this var stores which sound we make when clung to
	var/clinging_sound = 'modular_septic/sound/effects/clung.ogg'
