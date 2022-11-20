#define BALLOON_TEXT_WIDTH 200
#define BALLOON_TEXT_SPAWN_TIME (0.2 SECONDS)
#define BALLOON_TEXT_FADE_TIME (0.1 SECONDS)
#define BALLOON_TEXT_FULLY_VISIBLE_TIME (0.7 SECONDS)
#define BALLOON_TEXT_TOTAL_LIFETIME(mult) (BALLOON_TEXT_SPAWN_TIME + BALLOON_TEXT_FULLY_VISIBLE_TIME*mult + BALLOON_TEXT_FADE_TIME)
/// The increase in duration per character in seconds
#define BALLOON_TEXT_CHAR_LIFETIME_INCREASE_MULT (0.05)
/// The amount of characters needed before this increase takes into effect
#define BALLOON_TEXT_CHAR_LIFETIME_INCREASE_MIN 10

/atom/balloon_alert_perform(mob/viewer, text)
	var/client/viewer_client = viewer.client
	if(!viewer_client)
		return

	var/bound_width = world.icon_size
	if(ismovable(src))
		var/atom/movable/movable_source = src
		bound_width = movable_source.bound_width

	var/image/balloon_alert = image(loc = get_atom_on_turf(src), layer = ABOVE_MOB_LAYER)
	balloon_alert.plane = BALLOON_CHAT_PLANE
	balloon_alert.alpha = 0
	balloon_alert.appearance_flags = RESET_ALPHA|RESET_COLOR|RESET_TRANSFORM
	var/balloon_color = viewer.chat_color
	if(!balloon_color)
		balloon_color = COLOR_WHITE
	balloon_alert.maptext = MAPTEXT("<span style='text-align: center; -dm-text-outline: 1px #0005;color: [balloon_color];'>[capitalize(text)]</span>")
	balloon_alert.maptext_x = (BALLOON_TEXT_WIDTH - bound_width) * -0.5
	balloon_alert.maptext_height = WXH_TO_HEIGHT(viewer_client?.MeasureText(text, null, BALLOON_TEXT_WIDTH))
	balloon_alert.maptext_width = BALLOON_TEXT_WIDTH

	viewer_client?.images += balloon_alert

	var/duration_mult = 1
	var/duration_length = length(text) - BALLOON_TEXT_CHAR_LIFETIME_INCREASE_MIN

	if(duration_length > 0)
		duration_mult += duration_length*BALLOON_TEXT_CHAR_LIFETIME_INCREASE_MULT

	animate(
		balloon_alert,
		pixel_y = world.icon_size * 1.2,
		time = BALLOON_TEXT_TOTAL_LIFETIME(1),
		easing = SINE_EASING | EASE_OUT,
	)

	animate(
		alpha = 255,
		time = BALLOON_TEXT_SPAWN_TIME,
		easing = CUBIC_EASING | EASE_OUT,
		flags = ANIMATION_PARALLEL,
	)

	animate(
		alpha = 0,
		time = BALLOON_TEXT_FULLY_VISIBLE_TIME*duration_mult,
		easing = CUBIC_EASING | EASE_IN,
	)

	addtimer(CALLBACK(GLOBAL_PROC, .proc/remove_image_from_client, balloon_alert, viewer_client), BALLOON_TEXT_TOTAL_LIFETIME(duration_mult))

#undef BALLOON_TEXT_CHAR_LIFETIME_INCREASE_MIN
#undef BALLOON_TEXT_CHAR_LIFETIME_INCREASE_MULT
#undef BALLOON_TEXT_FADE_TIME
#undef BALLOON_TEXT_FULLY_VISIBLE_TIME
#undef BALLOON_TEXT_SPAWN_TIME
#undef BALLOON_TEXT_TOTAL_LIFETIME
#undef BALLOON_TEXT_WIDTH
