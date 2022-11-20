#define STARTING_FILTER_PRIORITY 20

//HEAD RAPE
//DURATION SHOULD ALWAYS BE DIVISIBLE BY 40 (4 SECONDS) TO ENSURE SMOOTH ANIMATION.
//IF YOU DON'T ABIDE BY THE ABOVE, YOUR MAILBOX WILL RECEIVE A VERY FUN SURPRISE.
/datum/status_effect/incapacitating/headrape
	id = "head_rape"
	status_type = STATUS_EFFECT_REFRESH
	processing_speed = STATUS_EFFECT_NORMAL_PROCESS
	tick_interval = 4 SECONDS
	/// Alpha of the first composite layer
	var/starting_alpha = 64
	/// How many total layers we get, each new layer halving the previous layer's alpha
	var/intensity = 3
	/// How much we are allowed to vary in x
	var/variation_x = 32
	/// How much we are allowed to vary in y
	var/variation_y = 32
	/// Render relay plate we get our render_source from
	var/atom/movable/screen/plane_master/rendering_plate/source_plate
	/// Render relay plate we are actually messing with
	var/atom/movable/screen/plane_master/rendering_plate/filter_plate
	/// Funny tinnitus sound effect
	var/datum/looping_sound/tinnitus/tinnitus
	/// Each filter we are handling, assoc list
	var/list/list/filters_handled = list()
	/// Black layer filter that makes shit actually look normal
	var/list/black_filter_params = list()

/datum/status_effect/incapacitating/headrape/Destroy()
	if(!QDELETED(filter_plate))
		INVOKE_ASYNC(src, .proc/end_animation)
		QDEL_IN(tinnitus, 4 SECONDS)
	else
		qdel(tinnitus)
	tinnitus = null
	source_plate = null
	filter_plate = null
	filters_handled = null
	black_filter_params = null
	return ..()

/datum/status_effect/incapacitating/headrape/on_apply()
	. = ..()
	tinnitus = new(owner, TRUE, TRUE, TRUE)
	if(owner?.hud_used?.plane_masters["[RENDER_PLANE_GAME_PROCESSING]"] && owner.hud_used.plane_masters["[RENDER_PLANE_GAME_POST_PROCESSING]"])
		source_plate = owner.hud_used.plane_masters["[RENDER_PLANE_GAME_PROCESSING]"]
		filter_plate = owner.hud_used.plane_masters["[RENDER_PLANE_GAME_POST_PROCESSING]"]
		black_filter_params = layering_filter(render_source = source_plate.render_target, \
											blend_mode = BLEND_OVERLAY, \
											x = 0, \
											y = 0, \
											color = "#000000")
		for(var/i in 1 to intensity)
			var/filter_intensity = max(16, starting_alpha/(2**(i-1)))
			var/filter_color = rgb(255, 255, 255, filter_intensity)
			filters_handled["headrape[i]"] = layering_filter(render_source = source_plate.render_target, \
															blend_mode = BLEND_MULTIPLY, \
															x = 0, \
															y = 0, \
															color = filter_color)
		for(var/filter_name in filters_handled)
			var/filter_index = filters_handled.Find(filter_name)
			var/list/filter_params = filters_handled[filter_name]
			filter_plate.add_filter(filter_name, STARTING_FILTER_PRIORITY+1-filter_index, filter_params)
	if(!QDELETED(filter_plate))
		INVOKE_ASYNC(src, .proc/perform_animation)

/datum/status_effect/incapacitating/headrape/tick()
	. = ..()
	if(!QDELETED(filter_plate))
		INVOKE_ASYNC(src, .proc/perform_animation)

/datum/status_effect/incapacitating/headrape/proc/perform_animation()
	for(var/filter_name in filters_handled)
		filters_handled[filter_name]["x"] = rand(-variation_x, variation_x)
		filters_handled[filter_name]["y"] = rand(-variation_y, variation_y)
	update_filters(4 SECONDS)

/datum/status_effect/incapacitating/headrape/proc/end_animation()
	var/atom/movable/screen/plane_master/rendering_plate/old_filter_plate = filter_plate
	var/list/old_filters_handled = list()
	var/kill_color = rgb(255, 255, 255, 0)
	for(var/filter_name in filters_handled)
		filters_handled[filter_name]["x"] = 0
		filters_handled[filter_name]["y"] = 0
		filters_handled[filter_name]["color"] = kill_color
		old_filters_handled += filter_name
	update_filters(4 SECONDS)
	//Sleep call ensures the ending looks smooth no matter what
	sleep(4 SECONDS)
	//KILL the filters now
	if(!QDELETED(old_filter_plate))
		for(var/filter_name in old_filters_handled)
			old_filter_plate.remove_filter(filter_name)

/datum/status_effect/incapacitating/headrape/proc/update_filters(time = 4 SECONDS)
	for(var/filter_name in filters_handled)
		var/list/filter_params = filters_handled[filter_name].Copy()
		filter_params -= "type"
		filter_params -= "render_source"
		filter_plate.transition_filter(filter_name, time, filter_params, LINEAR_EASING, FALSE)

#undef STARTING_FILTER_PRIORITY
