/*
	These are simple defaults for your project.
 */

/world
	fps = 25		// 25 frames per second
	icon_size = 32	// 32x32 icon size by default
	view = 5		// show up to 6 tiles outward from center (13x13 view)

//Actual important code
/client/verb/turfconverter()
	set name = "Convert Turfs"
	set desc = "Convert them up nice."
	set category = "Converter"

	var/inputfile = input(usr, "Select an icon to butcher.", "Slaughterhouse", null) as file|null
	if(isnull(inputfile))
		return

	var/static/list/index_to_blenders = list(
		"-0" = list("1-i", "2-i", "3-i", "4-i"),
		"-1" = list("1-n", "2-n", "3-i", "4-i"),
		"-2" = list("1-i", "2-i", "3-s", "4-s"),
		"-3" = list("1-n", "2-n", "3-s", "4-s"),
		"-4" = list("1-i", "2-e", "3-i", "4-e"),
		"-5" = list("1-n", "2-ne", "3-i", "4-e"),
		"-6" = list("1-i", "2-e", "3-s", "4-se"),
		"-7" = list("1-n", "2-ne", "3-s", "4-se"),
		"-8" = list("1-w", "2-i", "3-w", "4-i"),
		"-9" = list("1-nw", "2-n", "3-w", "4-i"),
		"-10" = list("1-w", "2-i", "3-sw", "4-s"),
		"-11" = list("1-nw", "2-n", "3-sw", "4-s"),
		"-12" = list("1-w", "2-e", "3-w", "4-e"),
		"-13" = list("1-nw", "2-ne", "3-w", "4-e"),
		"-14" = list("1-w", "2-e", "3-sw", "4-se"),
		"-15" = list("1-nw", "2-ne", "3-sw", "4-se"),
		"-21" = list("1-n", "2-f", "3-i", "4-e"),
		"-23" = list("1-n", "2-f", "3-s", "4-se"),
		"-29" = list("1-nw", "2-f", "3-w", "4-e"),
		"-31" = list("1-nw", "2-f", "3-sw", "4-se"),
		"-38" = list("1-i", "2-e", "3-s", "4-f"),
		"-39" = list("1-n", "2-ne", "3-s", "4-f"),
		"-46" = list("1-w", "2-e", "3-sw", "4-f"),
		"-47" = list("1-nw", "2-ne", "3-sw", "4-f"),
		"-55" = list("1-n", "2-f", "3-s", "4-f"),
		"-63" = list("1-nw", "2-f", "3-sw", "4-f"),
		"-74" = list("1-w", "2-i", "3-f", "4-s"),
		"-75" = list("1-nw", "2-n", "3-f", "4-s"),
		"-78" = list("1-w", "2-e", "3-f", "4-se"),
		"-79" = list("1-nw", "2-ne", "3-f", "4-se"),
		"-95" = list("1-nw", "2-f", "3-f", "4-se"),
		"-110" = list("1-w", "2-e", "3-f", "4-f"),
		"-111" = list("1-nw", "2-ne", "3-f", "4-f"),
		"-127" = list("1-nw", "2-f", "3-f", "4-f"),
		"-137" = list("1-f", "2-n", "3-w", "4-i"),
		"-139" = list("1-f", "2-n", "3-sw", "4-s"),
		"-141" = list("1-f", "2-ne", "3-w", "4-e"),
		"-143" = list("1-f", "2-ne", "3-sw", "4-se"),
		"-157" = list("1-f", "2-f", "3-w", "4-e"),
		"-159" = list("1-f", "2-f", "3-sw", "4-se"),
		"-175" = list("1-f", "2-ne", "3-sw", "4-f"),
		"-191" = list("1-f", "2-f", "3-sw", "4-f"),
		"-203" = list("1-f", "2-n", "3-f", "4-s"),
		"-207" = list("1-f", "2-ne", "3-f", "4-se"),
		"-223" = list("1-f", "2-f", "3-f", "4-se"),
		"-239" = list("1-f", "2-ne", "3-f", "4-f"),
		"-255" = list("1-f", "2-f", "3-f", "4-f"),
	)
	var/icon/input = icon(inputfile)
	var/icon/template = icon('icons/states.dmi')
	var/icon/output = new()
	var/input_height = input.Height()
	var/input_width = input.Width()

	var/list/input_states = input.IconStates()
	var/list/template_states = template.IconStates()
	var/replacer_string = input_states[length(input_states)]
	for(var/state in template_states)
		var/nulled_state = replacetext(state, "REPLACEME", "")
		usr << "nulled_state: [nulled_state]"
		var/replaced_state = replacetext(state, "REPLACEME", replacer_string)
		usr << "replaced_state: [replaced_state]"
		var/icon/state_icon = icon('icons/32x32.dmi', replaced_state, SOUTH)
		state_icon.Scale(input_width, input_height)
		for(var/blend in index_to_blenders[nulled_state])
			usr << "index_to_blenders: [blend]"
			state_icon.Blend(icon(input, blend, SOUTH), ICON_OVERLAY)
		if(!index_to_blenders[nulled_state])
			state_icon.Blend(icon(input, replacer_string, SOUTH), ICON_OVERLAY)
		output.Insert(state_icon, replaced_state)
	//Give the output
	usr << ftp(output, "[inputfile]")

/client/verb/turfconverter()
	set name = "Convert Turfs"
	set desc = "Convert them up nice."
	set category = "Converter"

	var/inputfile = input(usr, "Select an icon to butcher. Cancel for default icon.", "Slaughterhouse", null) as file|null
	if(isnull(inputfile))
		return

	var/static/list/index_to_blenders = list(
		"-0" = list("1-i", "2-i", "3-i", "4-i"),
		"-1" = list("1-n", "2-n", "3-i", "4-i"),
		"-2" = list("1-i", "2-i", "3-s", "4-s"),
		"-3" = list("1-n", "2-n", "3-s", "4-s"),
		"-4" = list("1-i", "2-e", "3-i", "4-e"),
		"-5" = list("1-n", "2-ne", "3-i", "4-e"),
		"-6" = list("1-i", "2-e", "3-s", "4-se"),
		"-7" = list("1-n", "2-ne", "3-s", "4-se"),
		"-8" = list("1-w", "2-i", "3-w", "4-i"),
		"-9" = list("1-nw", "2-n", "3-w", "4-i"),
		"-10" = list("1-w", "2-i", "3-sw", "4-s"),
		"-11" = list("1-nw", "2-n", "3-sw", "4-s"),
		"-12" = list("1-w", "2-e", "3-w", "4-e"),
		"-13" = list("1-nw", "2-ne", "3-w", "4-e"),
		"-14" = list("1-w", "2-e", "3-sw", "4-se"),
		"-15" = list("1-nw", "2-ne", "3-sw", "4-se"),
		"-21" = list("1-n", "2-f", "3-i", "4-e"),
		"-23" = list("1-n", "2-f", "3-s", "4-se"),
		"-29" = list("1-nw", "2-f", "3-w", "4-e"),
		"-31" = list("1-nw", "2-f", "3-sw", "4-se"),
		"-38" = list("1-i", "2-e", "3-s", "4-f"),
		"-39" = list("1-n", "2-ne", "3-s", "4-f"),
		"-46" = list("1-w", "2-e", "3-sw", "4-f"),
		"-47" = list("1-nw", "2-ne", "3-sw", "4-f"),
		"-55" = list("1-n", "2-f", "3-s", "4-f"),
		"-63" = list("1-nw", "2-f", "3-sw", "4-f"),
		"-74" = list("1-w", "2-i", "3-f", "4-s"),
		"-75" = list("1-nw", "2-n", "3-f", "4-s"),
		"-78" = list("1-w", "2-e", "3-f", "4-se"),
		"-79" = list("1-nw", "2-ne", "3-f", "4-se"),
		"-95" = list("1-nw", "2-f", "3-f", "4-se"),
		"-110" = list("1-w", "2-e", "3-f", "4-f"),
		"-111" = list("1-nw", "2-ne", "3-f", "4-f"),
		"-127" = list("1-nw", "2-f", "3-f", "4-f"),
		"-137" = list("1-f", "2-n", "3-w", "4-i"),
		"-139" = list("1-f", "2-n", "3-sw", "4-s"),
		"-141" = list("1-f", "2-ne", "3-w", "4-e"),
		"-143" = list("1-f", "2-ne", "3-sw", "4-se"),
		"-157" = list("1-f", "2-f", "3-w", "4-e"),
		"-159" = list("1-f", "2-f", "3-sw", "4-se"),
		"-175" = list("1-f", "2-ne", "3-sw", "4-f"),
		"-191" = list("1-f", "2-f", "3-sw", "4-f"),
		"-203" = list("1-f", "2-n", "3-f", "4-s"),
		"-207" = list("1-f", "2-ne", "3-f", "4-se"),
		"-223" = list("1-f", "2-f", "3-f", "4-se"),
		"-239" = list("1-f", "2-ne", "3-f", "4-f"),
		"-255" = list("1-f", "2-f", "3-f", "4-f"),
	)
	var/icon/input = icon(inputfile)
	var/icon/template = icon('icons/states.dmi')
	var/icon/output = new()
	var/input_height = input.Height()
	var/input_width = input.Width()

	var/list/input_states = input.IconStates()
	var/list/template_states = template.IconStates()
	var/replacer_string = input_states[length(input_states)]
	for(var/state in template_states)
		var/nulled_state = replacetext(state, "REPLACEME", "")
		usr << "nulled_state: [nulled_state]"
		var/replaced_state = replacetext(state, "REPLACEME", replacer_string)
		usr << "replaced_state: [replaced_state]"
		var/icon/state_icon = icon('icons/32x32.dmi', replaced_state, SOUTH)
		state_icon.Scale(input_width, input_height)
		for(var/blend in index_to_blenders[nulled_state])
			usr << "index_to_blenders: [blend]"
			state_icon.Blend(icon(input, blend, SOUTH), ICON_OVERLAY)
		if(!index_to_blenders[nulled_state])
			state_icon.Blend(icon(input, replacer_string, SOUTH), ICON_OVERLAY)
		output.Insert(state_icon, replaced_state)
	//Give the output
	usr << ftp(output, "[inputfile]")
