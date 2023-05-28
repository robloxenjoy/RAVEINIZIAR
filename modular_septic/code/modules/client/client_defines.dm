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
	/// Used by the area music system to avoid repeating tracks from the start - Associative list, file = sound file
	var/list/droning_sounds
	/// Last droning sound file played, used so we don't try to update tracks when we don't have to
	var/current_droning_file
	/// Current ambient track
	var/sound/current_droning_sound
