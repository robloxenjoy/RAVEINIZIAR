// This is synced up to the poster placing animation.
#define PLACE_SPEED 37

// The poster item

/obj/item/poster
	name = "poorly coded poster"
	desc = "You probably shouldn't be holding this."
	icon = 'icons/obj/contraband.dmi'
	force = 0
	resistance_flags = FLAMMABLE
	var/poster_type

/*
/obj/item/poster/Initialize(mapload, obj/structure/sign/poster/new_poster_structure)
	. = ..()
	poster_structure = new_poster_structure
	if(!new_poster_structure && poster_type)
		poster_structure = new poster_type(src)

	// posters store what name and description they would like their
	// rolled up form to take.
	if(poster_structure)
		if(QDELETED(poster_structure))
			stack_trace("A poster was initialized with a qdeleted poster_structure, something's gone wrong")
			return INITIALIZE_HINT_QDEL
		name = poster_structure.poster_item_name
		desc = poster_structure.poster_item_desc
		icon_state = poster_structure.poster_item_icon_state

		name = "[name] - [poster_structure.original_name]"
		//If the poster structure is being deleted something has gone wrong, kill yourself off too
		RegisterSignal(poster_structure, COMSIG_PARENT_QDELETING, .proc/react_to_deletion)

/obj/item/poster/Destroy()
	poster_structure = null
	. = ..()
*/

/obj/item/poster/proc/react_to_deletion()
	SIGNAL_HANDLER
	qdel(src)

// These icon_states may be overridden, but are for mapper's convinence
/obj/item/poster/random_contraband
	name = "random contraband poster"
	poster_type = /obj/structure/sign/poster/contraband/random
	icon_state = "rolled_poster"

/obj/item/poster/random_official
	name = "random official poster"
	poster_type = /obj/structure/sign/poster/official/random
	icon_state = "rolled_legit"

// The poster sign/structure

/obj/structure/sign/poster
	name = "poster"
	var/original_name
	desc = "A large piece of space-resistant printed paper."
	icon = 'icons/obj/contraband.dmi'
	anchored = TRUE
	buildable_sign = FALSE //Cannot be unwrenched from a wall.
	var/ruined = FALSE
	var/random_basetype
	var/never_random = FALSE // used for the 'random' subclasses.
	var/rvat = TRUE

	var/poster_item_name = "hypothetical poster"
	var/poster_item_desc = "This hypothetical poster item should not exist, let's be honest here."
	var/poster_item_icon_state = "rolled_poster"
	var/poster_item_type = /obj/item/poster

/obj/structure/sign/poster/Initialize(mapload)
	. = ..()
	if(random_basetype)
		randomise(random_basetype)
//	if(!ruined)
//		original_name = name // can't use initial because of random posters
//		name = "poster - [name]"
//		desc = "A large piece of space-resistant printed paper. [desc]"

	AddElement(/datum/element/beauty, 300)

/obj/structure/sign/poster/proc/randomise(base_type)
	var/list/poster_types = subtypesof(base_type)
	var/list/approved_types = list()
	for(var/t in poster_types)
		var/obj/structure/sign/poster/T = t
		if(initial(T.icon_state) && !initial(T.never_random))
			approved_types |= T

	var/obj/structure/sign/poster/selected = pick(approved_types)

	name = initial(selected.name)
	desc = initial(selected.desc)
	icon_state = initial(selected.icon_state)
	poster_item_name = initial(selected.poster_item_name)
	poster_item_desc = initial(selected.poster_item_desc)
	poster_item_icon_state = initial(selected.poster_item_icon_state)
	ruined = initial(selected.ruined)


/obj/structure/sign/poster/attackby(obj/item/I, mob/user, params)
	if(I.tool_behaviour == TOOL_WIRECUTTER)
		I.play_tool_sound(src, 100)
		if(ruined)
			to_chat(user, span_notice("You remove the remnants of the poster."))
			qdel(src)
		else
			to_chat(user, span_notice("You carefully remove the poster from the wall."))
			roll_and_drop(user.loc)

/obj/structure/sign/poster/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(ruined)
		return
	if(!rvat)
		return
	visible_message(span_notice("[user] срывает [src] разом!") )
	playsound(src.loc, 'sound/items/poster_ripped.ogg', 100, TRUE)

	var/obj/structure/sign/poster/ripped/R = new(loc)
	R.pixel_y = pixel_y
	R.pixel_x = pixel_x
	R.add_fingerprint(user)
	qdel(src)

/obj/structure/sign/poster/proc/roll_and_drop(loc)
	pixel_x = 0
	pixel_y = 0
	var/obj/item/poster/P = new poster_item_type(loc, src)
	forceMove(P)
	return P

/*
//separated to reduce code duplication. Moved here for ease of reference and to unclutter r_wall/attackby()
/turf/closed/wall/proc/place_poster(obj/item/poster/P, mob/user)
//	if(!P.poster_structure)
//		to_chat(user, span_warning("[P] has no poster... inside it? Inform a coder!"))
//		return

	// Deny placing posters on currently-diagonal walls, although the wall may change in the future.
	if (smoothing_flags & SMOOTH_DIAGONAL_CORNERS)
		for (var/O in overlays)
			var/image/I = O
			if(copytext(I.icon_state, 1, 3) == "d-") //3 == length("d-") + 1
				return

	var/stuff_on_wall = 0
	for(var/obj/O in contents) //Let's see if it already has a poster on it or too much stuff
		if(istype(O, /obj/structure/sign/poster))
			to_chat(user, span_warning("The wall is far too cluttered to place a poster!"))
			return
		stuff_on_wall++
		if(stuff_on_wall == 3)
			to_chat(user, span_warning("The wall is far too cluttered to place a poster!"))
			return

	to_chat(user, span_notice("You start placing the poster on the wall...") )

//	var/obj/structure/sign/poster/D = P.poster_structure

	var/temp_loc = get_turf(user)
	flick("poster_being_set",D)
	D.forceMove(src)
	qdel(P) //delete it now to cut down on sanity checks afterwards. Agouri's code supports rerolling it anyway
	playsound(D.loc, 'sound/items/poster_being_created.ogg', 100, TRUE)

	if(do_after(user, PLACE_SPEED, target=src))
		if(!D || QDELETED(D))
			return

		if(iswallturf(src) && user && user.loc == temp_loc) //Let's check if everything is still there
			to_chat(user, span_notice("You place the poster!"))
			return

	to_chat(user, span_notice("The poster falls down!"))
	D.roll_and_drop(get_turf(user))

*/

// Various possible posters follow

/obj/structure/sign/poster/ripped
	ruined = TRUE
	icon_state = "poster_ripped"
	name = "ripped poster"
	desc = "You can't make out anything from the poster's original print. It's ruined."

/obj/structure/sign/poster/random
	name = "random poster" // could even be ripped
	icon_state = "random_anything"
	never_random = TRUE
	random_basetype = /obj/structure/sign/poster

/obj/structure/sign/poster/contraband
	poster_item_name = "contraband poster"
	poster_item_desc = "This poster comes with its own automatic adhesive mechanism, for easy pinning to any vertical surface. Its vulgar themes have marked it as contraband aboard Nanotrasen space facilities."
	poster_item_icon_state = "rolled_poster"

/obj/structure/sign/poster/contraband/random
	name = "random contraband poster"
	icon_state = "random_contraband"
	never_random = TRUE
	random_basetype = /obj/structure/sign/poster/contraband

/obj/structure/sign/poster/official/here_for_your_safety
	name = "Massacre"
	desc = "Just meat."
	icon_state = "poster1_legit"

/obj/structure/sign/poster/official/nanotrasen_logo
	name = "Spider"
	desc = "Giant creepy spider."
	icon_state = "poster2_legit"

/obj/structure/sign/poster/official/cleanliness
	name = "Eye"
	desc = "Don't do stupid things."
	icon_state = "poster3_legit"

/obj/structure/sign/poster/official/help_others
	name = "Meat"
	desc = "Beautiful."
	icon_state = "poster4_legit"

/obj/structure/sign/poster/official/build
	name = "Coil"
	desc = "The creature swallows its own tail."
	icon_state = "poster5_legit"

/obj/structure/sign/poster/official/bless_this_spess
	name = "Man"
	desc = "Blood."
	icon_state = "poster6_legit"

/obj/structure/sign/poster/official/science
	name = "Mouth"
	desc = "Smile!"
	icon_state = "poster7_legit"

/obj/structure/sign/poster/official/ian
	name = "Corpse"
	desc = "Horror."
	icon_state = "poster8_legit"

/obj/structure/sign/poster/official/obey
	name = "Man"
	desc = "Man with giant insect"
	icon_state = "poster9_legit"

/obj/structure/sign/poster/official/walk
	name = "Sun"
	desc = "Too late."
	icon_state = "poster10_legit"

/obj/structure/sign/poster/official/state_laws
	name = "Sex"
	desc = "Womans."
	icon_state = "poster11_legit"

/obj/structure/sign/poster/official/love_ian
	name = "Space"
	desc = "Strange things in space."
	icon_state = "poster12_legit"

/obj/structure/sign/poster/official/space_cops
	name = "Mouth."
	desc = "Smile!"
	icon_state = "poster13_legit"

/obj/structure/sign/poster/official/ue_no
	name = "Man"
	desc = "Black figure, looks like a man."
	icon_state = "poster14_legit"

/obj/structure/sign/poster/official/get_your_legs
	name = "Moon"
	desc = "Beautiful."
	icon_state = "poster15_legit"

/obj/structure/sign/poster/official/do_not_question
	name = "Church"
	desc = "What?"
	icon_state = "poster16_legit"

/obj/structure/sign/poster/official/work_for_a_future
	name = "Church"
	desc = " Horror."
	icon_state = "poster17_legit"

/obj/structure/sign/poster/official/soft_cap_pop_art
	name = "Wizard"
	desc = "Purple wizard."
	icon_state = "poster18_legit"

/obj/structure/sign/poster/official/safety_internals
	name = "Creature"
	desc = "Love is a dog from hell."
	icon_state = "poster19_legit"

/obj/structure/sign/poster/official/safety_eye_protection
	name = "Human"
	desc = "What?"
	icon_state = "poster20_legit"

/obj/structure/sign/poster/official/safety_report
	name = "Man"
	desc = "What?"
	icon_state = "poster21_legit"

/obj/structure/sign/poster/official/report_crimes
	name = "Man"
	desc = "Black and white."
	icon_state = "poster22_legit"

/obj/structure/sign/poster/official/ion_rifle
	name = "Space"
	desc = "Black and white."
	icon_state = "poster23_legit"

/obj/structure/sign/poster/official/foam_force_ad
	name = "Skull"
	desc = "Skull in the darkness."
	icon_state = "poster24_legit"

/obj/structure/sign/poster/official/cohiba_robusto_ad
	name = "Strange"
	desc = "Something strange."
	icon_state = "poster25_legit"

/obj/structure/sign/poster/official/anniversary_vintage_reprint
	name = "Sky"
	desc = "Sun and the Moon. Love."
	icon_state = "poster26_legit"

/obj/structure/sign/poster/official/fruit_bowl
	name = "Eyes"
	desc = "His eyes."
	icon_state = "poster27_legit"

/obj/structure/sign/poster/official/pda_ad
	name = "Rabbit"
	desc = "Big fatty and funny rabbit!"
	icon_state = "poster28_legit"

/obj/structure/sign/poster/official/enlist
	name = "What?" // but I thought deathsquad was never acknowledged
	desc = "What is this?"
	icon_state = "poster29_legit"

/obj/structure/sign/poster/official/nanomichi_ad
	name = "Skull"
	desc = "White skull."
	icon_state = "poster30_legit"

/obj/structure/sign/poster/official/twelve_gauge
	name = "Chaos"
	desc = "Chaosphere."
	icon_state = "poster31_legit"

/obj/structure/sign/poster/official/high_class_martini
	name = "Woman"
	desc = "Just woman."
	icon_state = "poster32_legit"

/obj/structure/sign/poster/official/the_owl
	name = "Hammer"
	desc = "Just hammer."
	icon_state = "poster33_legit"

/obj/structure/sign/poster/official/no_erp
	name = "Man"
	desc = "Strange green man."
	icon_state = "poster34_legit"

/obj/structure/sign/poster/official/wtf_is_co2
	name = "Opium"
	desc = "A man who smokes opium."
	icon_state = "poster35_legit"

/obj/structure/sign/poster/official/dick_gum
	name = "Negative"
	desc = "Green Shit."
	icon_state = "poster36_legit"

/obj/structure/sign/poster/official/process
	name = "Poster"
	desc = "The Process."
	icon_state = "poster48_legit"

/obj/structure/sign/poster/official/podozl
	name = "Poster"
	desc = "Oh!"
	icon_state = "poster1"

/obj/structure/sign/poster/official/random
	name = "random official poster"
	random_basetype = /obj/structure/sign/poster/official
	icon_state = "random_official"
	never_random = TRUE

#undef PLACE_SPEED
