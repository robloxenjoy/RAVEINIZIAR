/obj/machinery/vending/tiktok
	name = "godforsaken machine"
	desc = "A meta-physical line to a Devious, Godforsaken, and Diabolical Corporation. \n\
	<div class='infobox'> \
	Input: 1 cable coil + 1 can of beans - Output = PPK \n\
	Input: 2 cans of beef stew - Output = Bolsa SMG \n\
	Input: 2 PPK Handguns - Output = Th(ump) SMG \n\
	Input: 3 individual batteries - Output = Inverno Genocidio Rifle \n\
	Input: 1 Chunky Battery - Output = Federson bolt-action \n\
	Input: 1 Toobrush - Output = Combat Shotgun \n\
	Input: 1 Head - Output = Frag Master 9mm \n\
	Input 1 Stomach - Output = Touro-5 Faceshield \n\
	Input: 1 (any) computer circuit - Output = Black Pump-action Shotgun \n\
	Input: 8 Carbonylmethamphetamine pills - Output = Abyss Rifle \n\
	Input: 4 HE Shells - Output = Batata grenade launcher \n\
	Input: 1 (any) bottle - Output = Solitario-SD \n\
	Input: 1 Soap Dispenser - Output = Lampiao (SVD) DMR \n\
	Input: 1 Sounding Rod - Output = Bolt ACR \n\
	Input 2 (any) hearts - Output = Industrial Glue Gun \n\
	Input 1 (any) intestines - Output = Bolas 4 Guage Shotgun \n\
	Input 2 (any) kidneys - Output = Aniquilador LE living pistol \n\
	Input: 1 CCP booklet - Output = Heavy Helmet \n\
	Input: 1 Broken LCD - Output = Heavy Vest \n\
	Input: 3 Left legs, 3 Right legs - Output = UltraHeavy Vest \n\
	Input: 1 Crowbar - Output = 1 Slaughter Goggles \n\
	Input: 3 Light Bulbs - Output = 1 Satchel \n\
	Input: 1 Black Gloves - Output = 1 Suppressor \n\
	Input: 1 Chair - Output = 1 Military Rig (belt) \n\
	Input: 1 Syringe + 2 Individual Batteries - Output = Energy Sword \n\
	Input: 1 Left Arm + 1 Right Arm - Output = Kukri \n\
	Input: 1 Wooden Chair - Output = 1 Oxygen Tank \n\
	Input: 4 Glass Shards - Output = 1 Carbonylmethamphetamine \
    </div>"
	density = FALSE
	onstation = FALSE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	slogan_delay = 600
	icon_state = "tiktok"
	base_icon_state = "tiktok"
	icon = 'modular_septic/icons/obj/machinery/vending.dmi'
	product_slogans = "Idiot. FUCKING IDIOT!; Your birth certicificate is an APOLOGY LEGGER from the CLINIC; Shut up, retard.; The King is Coming!!; We are in the last moments of the end of days.; Prophesised to happen before the return of Jesus; The Marshmellow Time was wrong then and it; Salvation from God is a Gift.; The Ultimate sacrifice for all of our sins.; Ultimate Metaphysics: Divine Unity, or the Conjugate Whole"
	products = list(
		/obj/item/clothing/suit/armor/vest/alt/discrete = 1,
	)
	var/list/tiktoklines = list('modular_septic/sound/effects/singer1.wav', 'modular_septic/sound/effects/singer2.wav')
	var/refuse_sound_cooldown_duration = 1 SECONDS
	var/barfsound = 'modular_septic/sound/emotes/vomit.wav'
	var/crushersound = list('modular_septic/sound/effects/crusher1.wav', 'modular_septic/sound/effects/crusher2.wav', 'modular_septic/sound/effects/crusher3.wav')
	COOLDOWN_DECLARE(refuse_cooldown)

/obj/machinery/vending/tiktok/attackby(obj/item/I, mob/living/user, params)
	. = ..()
	if(!GLOB.bartering_inputs[I.type])
		if(COOLDOWN_FINISHED(src, refuse_cooldown))
			sound_hint()
			playsound(src, 'modular_septic/sound/effects/clunk.wav', 60, vary = FALSE)
			COOLDOWN_START(src, refuse_cooldown, refuse_sound_cooldown_duration)
		return
	if(user.transferItemToLoc(I, src))
		sound_hint()
		playsound(src, crushersound, 70, vary = FALSE)
		INVOKE_ASYNC(src, .proc/crushing_animation)
		check_bartering()

/obj/machinery/vending/tiktok/MouseDrop(atom/over, src_location, over_location, src_control, over_control, params)
	. = ..()
	if(!isliving(usr) || !usr.Adjacent(src) || usr.incapacitated())
		return
	if(over == loc)
		vomit_items()

/obj/machinery/vending/tiktok/process(delta_time)
	if(machine_stat & BROKEN | NOPOWER)
		return PROCESS_KILL
	if(!active)
		return

	if(seconds_electrified > MACHINE_NOT_ELECTRIFIED)
		seconds_electrified--

	//Pitch to the people! Really sell it!
	if((last_slogan + slogan_delay <= world.time) && (LAZYLEN(slogan_list) > 0) && !shut_up && DT_PROB(2.5, delta_time))
		var/slogan = pick(slogan_list)
		flick("[base_icon_state]-speak", src)
		playsound(src, tiktoklines, 70, vary = FALSE)
		speak(slogan)
		last_slogan = world.time

/obj/machinery/vending/tiktok/proc/crushing_animation()
	add_overlay("[base_icon_state]-eat")
	sleep(11)
	cut_overlay("[base_icon_state]-eat")

/obj/machinery/vending/tiktok/proc/check_bartering()
	var/datum/bartering_recipe/bartering_recipe
	//loop through every bartering recipe and attempt to execute it
	for(var/recipe_type as anything in GLOB.bartering_recipes)
		bartering_recipe = GLOB.bartering_recipes[recipe_type]
		//associated list, every item we end up needing to use in the recipe and the associated input path type
		var/list/valid_inputs = list()
		//associated list, every input path type associated with the amount we have
		var/list/input_counter = list()
		var/recipe_failed = FALSE
		for(var/input_type in bartering_recipe.inputs)
			var/amount_needed = bartering_recipe.inputs[input_type]
			for(var/obj/item/thing_inside_us in contents)
				if(input_counter[input_type] >= amount_needed)
					break
				if(istype(thing_inside_us, input_type))
					//stack shitcode very cool
					valid_inputs[thing_inside_us] = input_type
					if(!input_counter[input_type])
						input_counter[input_type] = 0
					if(isstack(thing_inside_us))
						var/obj/item/stack/stack_item = thing_inside_us
						input_counter[input_type] = min(amount_needed, input_counter[input_type] + stack_item.amount)
					else
						input_counter[input_type] = input_counter[input_type] + 1
			if(input_counter[input_type] < amount_needed)
				recipe_failed = TRUE
				break
		if(recipe_failed)
			continue
		for(var/obj/item/input as anything in valid_inputs)
			var/input_type = valid_inputs[input]
			var/amount_yoink = input_counter[input_type]
			if(isstack(input))
				var/obj/item/stack/stack_input = input
				var/amount_yoinked = min(stack_input.amount, amount_yoink)
				stack_input.use(amount_yoinked)
				input_counter[input_type] -= amount_yoinked
			else
				input_counter[input_type] -= 1
				qdel(input)
		for(var/output in bartering_recipe.outputs)
			var/output_amount = bartering_recipe.outputs[output]
			for(var/i in 1 to output_amount)
				new output(loc)
		playsound(src, 'modular_septic/sound/effects/ring.wav', 90, TRUE)
		speak("Take from me.")

/obj/machinery/vending/tiktok/proc/vomit_items()
	//remis please add a vomiting blorf sound right below this comment
	playsound(src, barfsound, 65, FALSE)
	for(var/obj/item/vomited in src)
		vomited.forceMove(loc)

//	remove_overlay("[base_icon_state]-eat")
/obj/machinery/vending/tiktok/directional/north
	dir = SOUTH
	pixel_y = 32

/obj/machinery/vending/tiktok/directional/south
	dir = NORTH
	pixel_y = -32

/obj/machinery/vending/tiktok/directional/east
	dir = WEST
	pixel_x = 32

/obj/machinery/vending/tiktok/directional/west
	dir = EAST
	pixel_x = -32
