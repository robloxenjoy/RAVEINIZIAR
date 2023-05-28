/client
	show_popup_menus = FALSE
	/// Last matrix editor we opened if we happen to be an admin fucking around
	var/datum/matrix_editor/nobody_wants_to_learn_matrix_math
	/// Last attribute editor we opened if we happen to be an admin fucking around
	var/datum/attribute_editor/attribute_editor
	/// Defaults the country to niger i think that is funny
	var/country = DEFAULT_CLIENT_COUNTRY
	/// Political compass datum
	var/datum/political_compass/political_compass
	/// Used by the area music system to avoid repeating tracks
	var/last_droning_sound
	/// Current ambient track
	var/sound/droning_sound
