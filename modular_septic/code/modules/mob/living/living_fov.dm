/// Updates the applied FOV value and applies the handler to client if able
/mob/living/proc/update_fov()
	var/datum/component/field_of_vision/fov_component = GetComponent(/datum/component/field_of_vision)
	var/highest_fov = fov_type
	for(var/trait_type in fov_traits)
		var/fov_type = fov_traits[trait_type]
		if(fov_type > highest_fov)
			highest_fov = fov_type
	fov_component.generate_fov_holder(src, get_fov_angle(highest_fov), highest_fov)
