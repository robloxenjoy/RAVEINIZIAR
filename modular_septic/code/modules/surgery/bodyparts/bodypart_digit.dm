/*
Teacher: okay class, today we are going to finger paint

Kid named finger:

⠀⠀⠀⠀⠀⠀⠀⠀⣀⣴⣶⣿⣿⣿⣿⣿⣿⣿⣶⣦⣀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⣤⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣄⠀⠀⠀⠀⠀
⠀⠀⠀⠀⢀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠀⠀⠀⢠
⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣟⣛⣻⣿⣿⣟⣿⣿⣿⣷⠀⠀⠀
⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣫⣽⣾⣻⣾⣿⣿⣿⣿⡿⣿⣿⠀⠀⠀
⠀⠀⠀⢰⣿⣿⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠻⡿⠿⠟⠛⣟⣿⣽⠀⠀⠀
⠀⠀⠀⠸⣿⣿⣿⣷⣿⣿⣿⣿⡿⠍⠈⠀⠁⣴⡆⠀⠀⠠⢭⣮⣿⡶⠀⠀
⠀⡴⠲⣦⢽⣿⣿⣿⣿⣿⣟⣩⣨⣀⡄⣐⣾⣿⣿⣇⠠⣷⣶⣿⣿⡠⠁⠀
⠀⠃⢀⡄⠀⢻⣿⣿⣿⣿⣽⢿⣿⣯⣾⣿⣿⣿⣿⣿⢿⣿⣿⡟⣿⠀⠀⠀
⠀⠀⠣⠧⠀⢿⣿⣿⣿⣿⣿⣿⣿⣿⠟⢸⣿⠿⠿⠿⣧⠙⣿⣿⡿⠀⠀⠀
⠀⠀⠀⠁⠼⣒⡿⣿⣿⣿⣿⣿⣿⣿⣠⣬⠀⠀⠀⠀⣾⣷⡈⣿⡇⠀⠀⠀
⠀⠀⠀⠀⠀⠉⢳⣿⣿⣿⣿⣿⣿⣿⢟⠗⠼⠖⠒⠔⠉⠉⠻⣿⠇⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠈⣻⡿⣿⣿⣿⣿⡿⡀⣤⡄⠸⣰⣾⡒⣷⣴⣿⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠂⢸⡗⡄⠘⠭⣭⣷⣿⣮⣠⣌⣫⣿⣷⣿⣿⠃⠀⠈⠀⠀
⠀⠀⠀⠀⠀⠈⠀⢸⣿⣾⣷⣦⡿⣿⣿⣿⡿⢻⠞⣹⣿⣿⠏⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⢘⠀⠘⢻⡿⢿⣋⣤⣤⠌⠉⠛⠛⠀⠈⠉⠁⠀⠀⠀⠀⠀⡀
*/
/obj/item/bodypart
	/// Digits we currently have
	var/list/digits
	/// Digits we start with, associative list (digit name = digit typepath)
	var/list/starting_digits

/// Returns the digit associated with this digit_type
/obj/item/bodypart/proc/get_digit(digit_type)
	return LAZYACCESS(digits, digit_type)

/// Returns amount of digits on this limb
/obj/item/bodypart/proc/get_digits_amount()
	return length(digits)

/// Returns amount of digits this limb should have
/obj/item/bodypart/proc/get_max_digits()
	return length(starting_digits)

/// Creates initial digits (fingers/toes)
/obj/item/bodypart/proc/fill_digits()
	if(!length(starting_digits))
		return FALSE
	for(var/finger_name in starting_digits)
		var/finger_type = starting_digits[finger_name]
		add_digit(new finger_type(src))
	return TRUE

/// Properly adds a digit (finger/toe) to the digits list, and removes a previously existing digit if there is one
/obj/item/bodypart/proc/add_digit(obj/item/digit/digit, update = TRUE)
	if(!istype(digit) || !digit.digit_type)
		return FALSE
	if(LAZYACCESS(digits, digit.digit_type))
		var/finger = LAZYACCESS(digits, digit.digit_type)
		remove_digit(finger)
		qdel(finger)
	digit.skin_color = (mutation_color || species_color || skintone2hex(skin_tone))
	digit.forceMove(src)
	LAZYADDASSOC(digits, digit.digit_type, digit)
	if(update)
		update_limb_efficiency()
	return TRUE

/// Properly removes a digit (finger/toe) from the digits list
/obj/item/bodypart/proc/remove_digit(obj/item/digit/digit, update = TRUE)
	if(!istype(digit) || !digit.digit_type || (LAZYACCESS(digits, digit.digit_type) != digit))
		return FALSE
	digit.skin_color = (mutation_color || species_color || skintone2hex(skin_tone))
	LAZYREMOVE(digits, digit.digit_type)
	if(update)
		update_limb_efficiency()
	return TRUE

/// Knocks amount of fingers out, throwing them in throw_dir
/obj/item/bodypart/proc/knock_out_digits(amount = 1, throw_dir = NONE, throw_range = -1)
	//this is HORRIBLE but it prevents runtimes
	if(SSticker.current_state < GAME_STATE_PLAYING)
		return
	if(!owner || !get_turf(owner))
		return
	var/drop = clamp(amount, 0, get_digits_amount())
	if(!drop)
		return
	for(var/i in 1 to drop)
		if(!length(digits))
			break
		var/obj/item/digit/kid_named_finger = get_digit(pick(digits))
		remove_digit(kid_named_finger)
		kid_named_finger.add_mob_blood(owner)
		kid_named_finger.forceMove(get_turf(owner))
		var/final_throw_dir = throw_dir
		if(final_throw_dir == NONE)
			final_throw_dir = pick(GLOB.alldirs)
		var/final_throw_range = throw_range
		if(final_throw_range == -1)
			final_throw_range = rand(0, 1)
		var/turf/target_turf = get_ranged_target_turf(kid_named_finger, final_throw_dir, final_throw_range)
		INVOKE_ASYNC(kid_named_finger, /atom/movable/proc/throw_at, target_turf, final_throw_range, rand(1,3))
		INVOKE_ASYNC(kid_named_finger, /obj/item/digit/proc/do_knock_out_animation)
	return drop
