/obj/item/bodypart
	/// Maximum amount of teeth this limb can hae
	var/max_teeth = 0
	/// Lisp modifier for when this limb is missing teeth
	var/datum/speech_modifier/lisp/teeth_mod
	/// Stack of teeth of the limb
	var/obj/item/stack/teeth/teeth_object

/// Returns how many teeth we currently have
/obj/item/bodypart/proc/get_teeth_amount()
	return teeth_object?.amount

/// Fills the bodypart with it's maximum amount of teeth
/obj/item/bodypart/proc/fill_teeth()
	if(max_teeth)
		if(!teeth_object)
			teeth_object = new(src)
		teeth_object.amount = max_teeth
		return TRUE
	return FALSE

/// Updates our lisp and other teeth related stuff
/obj/item/bodypart/proc/update_teeth()
	if(teeth_mod)
		teeth_mod.update_lisp()
	else
		if(get_teeth_amount() < max_teeth)
			teeth_mod = new()
			teeth_mod.add_speech_modifier(owner)
	update_limb_efficiency()
	return TRUE

/// Proc for knocking teeth off from suitable bodyparts
/obj/item/bodypart/proc/knock_out_teeth(amount = 1, throw_dir = NONE, throw_range = -1)
	//this is HORRIBLE but it prevents runtimes
	if(SSticker.current_state < GAME_STATE_PLAYING)
		return
	if(!owner || !get_turf(owner))
		return
	var/drop = min(teeth_object?.amount, amount)
	if(!drop)
		return
	var/teeth_type = teeth_object.type
	for(var/i in 1 to drop)
		if(QDELETED(teeth_object) || !teeth_object.use(1))
			break
		var/obj/item/stack/teeth/dropped_teeth = new teeth_type(get_turf(owner), 1, FALSE)
		dropped_teeth.add_mob_blood(owner)
		dropped_teeth.amount = 1
		var/final_throw_dir = throw_dir
		if(final_throw_dir == NONE)
			final_throw_dir = pick(GLOB.alldirs)
		var/final_throw_range = throw_range
		if(final_throw_range == -1)
			final_throw_range = rand(0, 1)
		var/turf/target_turf = get_ranged_target_turf(dropped_teeth, final_throw_dir, final_throw_range)
		INVOKE_ASYNC(dropped_teeth, /atom/movable/proc/throw_at, target_turf, final_throw_range, rand(1,3))
		INVOKE_ASYNC(dropped_teeth, /obj/item/stack/teeth/proc/do_knock_out_animation)
	if(teeth_mod)
		teeth_mod.update_lisp()
	else
		teeth_mod = new()
		if(owner)
			teeth_mod.add_speech_modifier(owner)
	. = drop
	if(.)
		owner.Stun(2 SECONDS)
		if(body_zone == BODY_ZONE_PRECISE_MOUTH)
			owner.AddComponent(/datum/component/creamed/blood)
