/atom
	/**
	 * Icon path
	 * Smoothing objects larger than 32x32 require a visual object to represent the excess part,
	 * in order not to increase its hitbox. We call that a frill.
	 */
	var/icon/frill_icon
	/// Plane of the frill when it has a north connection
	var/upper_frill_plane = FRILL_PLANE
	/// Layer of the frill when it has a north connection
	var/upper_frill_layer = FRILL_LAYER
	/// Plane of the frill when it doesn't have a north connection
	var/lower_frill_plane = GAME_PLANE
	/// Layer of the frill when it doesn't have a north connection
	var/lower_frill_layer = ABOVE_MOB_LAYER
	/// If we use a frill, does the frill also use our icon_state?
	var/frill_uses_icon_state = FALSE
	/// Subtractible armor
	var/datum/subarmor/subarmor
	/// Default pixel w shifting for the atom's icon
	var/base_pixel_w = 0
	/// Default pixel z shifting for the atom's icon
	var/base_pixel_z = 0
	/// Maximum distance we can be examined from
	var/maximum_examine_distance = 7
	/// The icon_state we use for ghost images on inspect
	var/inspect_icon_state = "what"
	/// Duration of inspection
	var/inspect_duration = 4 SECONDS
	/**
	 *  Basically the level of dirtiness on an atom, which will spread to wounds and stuff and cause infections
	 */
	var/germ_level = GERM_LEVEL_AMBIENT
	/// Should we ignore any attempts to auto align? Mappers should edit this!
	var/manual_align = FALSE
	/// Some atoms can be hacked so awesome
	var/datum/hacking/hacking = null
