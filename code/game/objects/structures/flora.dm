/obj/structure/flora
	resistance_flags = FLAMMABLE
	max_integrity = 150
	anchored = TRUE

//trees
/obj/structure/flora/tree
	name = "tree"
	desc = "A large tree."
	density = FALSE
	pixel_x = -16
	layer = ABOVE_MOB_LAYER
	plane = ABOVE_GAME_PLANE
	var/log_amount = 10

/obj/structure/flora/tree/attackby(obj/item/W, mob/living/carbon/user, params)
	if(log_amount && (!(flags_1 & NODECONSTRUCT_1)))
		if(W.get_sharpness() && W.force > 0)
			if(!istype(W, /obj/item/shard))
				if(W.hitsound)
					playsound(get_turf(src), W.hitsound, 100, FALSE, FALSE)
				user.visible_message(span_notice("[user] begins to cut down [src] with [W]."),span_notice("You begin to cut down [src] with [W]."), span_hear("You hear the sound of sawing."))
				if(do_after(user, 1000/W.force, target = src)) //5 seconds with 20 force, 8 seconds with a hatchet, 20 seconds with a shard.
					user.visible_message(span_notice("[user] fells [src] with the [W]."),span_notice("You fell [src] with the [W]."), span_hear("You hear the sound of a tree falling."))
					user.changeNext_move(CLICK_CD_MELEE)
					user.adjustFatigueLoss(W.attack_fatigue_cost)
					playsound(get_turf(src), 'sound/effects/meteorimpact.ogg', 100 , FALSE, FALSE)
//					user.log_message("cut down [src] at [AREACOORD(src)]", LOG_ATTACK)
					for(var/i=1 to log_amount)
						new /obj/item/grown/log/tree/evil(get_turf(src))
					var/obj/structure/flora/stump/S = new(loc)
					S.name = "[name] stump"
					qdel(src)
	else
		return ..()

/obj/structure/flora/stump
	name = "stump"
	desc = "This represents our promise to the crew, and the station itself, to cut down as many trees as possible." //running naked through the trees
	icon = 'icons/obj/flora/pinetrees.dmi'
	icon_state = "tree_stump"
	density = FALSE
	pixel_x = -16

/obj/structure/flora/tree/pine
	name = "pine tree"
	desc = "A coniferous pine tree."
	icon = 'icons/obj/flora/pinetrees.dmi'
	icon_state = "pine_1"
	var/list/icon_states = list("pine_1", "pine_2", "pine_3")

/obj/structure/flora/tree/pine/Initialize(mapload)
	. = ..()
	if(islist(icon_states?.len))
		icon_state = pick(icon_states)

/obj/structure/flora/tree/evil
	name = "Cursed Tree"
	desc = "It has become so evil!"
	icon = 'icons/obj/flora/deadtrees.dmi'
	icon_state = "treevil_1"
	density = TRUE
	opacity = TRUE
	log_amount = 3

/obj/structure/flora/tree/evil/Initialize(mapload)
	icon_state = pick("treevil_1", "treevil_2", "treevil_3", "treevil_4")

/obj/structure/flora/tree/veva
	name = "Spirited Tree"
	desc = "Beacon of the Third Creator Veva."
	icon = 'icons/obj/flora/deadtrees.dmi'
	density = TRUE
	opacity = TRUE
	log_amount = 4
	icon_state = "vevatree"

/obj/structure/flora/tree/pine/xmas
	name = "xmas tree"
	desc = "A wondrous decorated Christmas tree."
	icon_state = "pine_c"
	icon_states = null
	flags_1 = NODECONSTRUCT_1 //protected by the christmas spirit

/obj/structure/flora/tree/pine/xmas/presents
	icon_state = "pinepresents"
	desc = "A wondrous decorated Christmas tree. It has presents!"
	var/gift_type = /obj/item/a_gift/anything
	var/unlimited = FALSE
	var/static/list/took_presents //shared between all xmas trees

/obj/structure/flora/tree/pine/xmas/presents/Initialize(mapload)
	. = ..()
	if(!took_presents)
		took_presents = list()

/obj/structure/flora/tree/pine/xmas/presents/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(!user.ckey)
		return

	if(took_presents[user.ckey] && !unlimited)
		to_chat(user, span_warning("There are no presents with your name on."))
		return
	to_chat(user, span_warning("After a bit of rummaging, you locate a gift with your name on it!"))

	if(!unlimited)
		took_presents[user.ckey] = TRUE

	var/obj/item/G = new gift_type(src)
	user.put_in_hands(G)

/obj/structure/flora/tree/pine/xmas/presents/unlimited
	desc = "A wonderous decorated Christmas tree. It has a seemly endless supply of presents!"
	unlimited = TRUE

/obj/structure/flora/tree/dead
	icon = 'icons/obj/flora/deadtrees.dmi'
	desc = "A dead tree. How it died, you know not."
	icon_state = "tree_1"

/obj/structure/flora/tree/palm
	icon = 'icons/misc/beach2.dmi'
	desc = "A tree straight from the tropics."
	icon_state = "palm1"

/obj/structure/flora/tree/palm/Initialize(mapload)
	. = ..()
	icon_state = pick("palm1","palm2")
	pixel_x = 0

/obj/structure/festivus
	name = "festivus pole"
	icon = 'icons/obj/flora/pinetrees.dmi'
	icon_state = "festivus_pole"
	desc = "During last year's Feats of Strength the Research Director was able to suplex this passing immobile rod into a planter."

/obj/structure/festivus/anchored
	name = "suplexed rod"
	desc = "A true feat of strength, almost as good as last year."
	icon_state = "anchored_rod"
	anchored = TRUE

/obj/structure/flora/tree/dead/Initialize(mapload)
	. = ..()
	icon_state = "tree_[rand(1, 6)]"

/obj/structure/flora/tree/jungle
	name = "tree"
	icon_state = "tree"
	desc = "It's seriously hampering your view of the jungle."
	icon = 'icons/obj/flora/jungletrees.dmi'
	pixel_x = -48
	pixel_y = -20

/obj/structure/flora/tree/jungle/Initialize(mapload)
	. = ..()
	icon_state = "[icon_state][rand(1, 6)]"

/obj/structure/flora/tree/jungle/small
	pixel_y = 0
	pixel_x = -32
	icon = 'icons/obj/flora/jungletreesmall.dmi'

//grass
/obj/structure/flora/grass
	name = "grass"
	desc = "A patch of overgrown grass."
	icon = 'icons/obj/flora/snowflora.dmi'
	gender = PLURAL //"this is grass" not "this is a grass"

/obj/structure/flora/grass/brown
	icon_state = "snowgrass1bb"

/obj/structure/flora/grass/brown/Initialize(mapload)
	. = ..()
	icon_state = "snowgrass[rand(1, 3)]bb"

/obj/structure/flora/grass/green
	icon_state = "snowgrass1gb"

/obj/structure/flora/grass/green/Initialize(mapload)
	. = ..()
	icon_state = "snowgrass[rand(1, 3)]gb"

/obj/structure/flora/grass/both
	icon_state = "snowgrassall1"

/obj/structure/flora/grass/both/Initialize(mapload)
	. = ..()
	icon_state = "snowgrassall[rand(1, 3)]"


//bushes
/obj/structure/flora/bush
	name = "Bush"
	desc = "Some type of shrub."
	icon = 'icons/obj/flora/snowflora.dmi'
	icon_state = "snowbush1"
	anchored = TRUE

/obj/structure/flora/bush/Initialize(mapload)
	. = ..()
	icon_state = "snowbush[rand(1, 6)]"

//newbushes

/obj/structure/flora/ausbushes
	name = "Bush"
	desc = "Some kind of plant."
	icon = 'icons/obj/flora/ausflora.dmi'
	icon_state = "firstbush_1"

/obj/structure/flora/ausbushes/Initialize(mapload)
	. = ..()
	if(icon_state == "firstbush_1")
		icon_state = "firstbush_[rand(1, 4)]"

/obj/structure/flora/ausbushes/crystal
	name = "Overcrystal Bush"
	desc = "A bush that grows over or near the crystal deposits."
	icon = 'icons/obj/flora/ausflora.dmi'
	icon_state = "crystalbush"
	layer = ABOVE_MOB_LAYER
	plane = ABOVE_GAME_PLANE
	resistance_flags = FLAMMABLE
	density = 0
	anchored = 1

/obj/structure/flora/ausbushes/crystal/Initialize(mapload)
	. = ..()
	update_appearance()
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = .proc/shag,
	)
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/structure/flora/ausbushes/crystal/proc/shag(datum/source, atom/movable/AM)
	SIGNAL_HANDLER

	if(!isturf(loc) || !isliving(AM))
		return
	playsound(loc,'sound/effects/shelest.ogg', 60, TRUE)

/obj/structure/flora/ausbushes/root
	name = "Tree Root"
	desc = "Root of the tree."
	icon = 'icons/obj/flora/ausflora.dmi'
	icon_state = "root_1"
	resistance_flags = FLAMMABLE
	density = 0
	anchored = 1

/obj/structure/flora/ausbushes/root/Initialize(mapload)
	. = ..()
	update_appearance()
	icon_state = "root_[rand(1, 3)]"

/obj/structure/flora/ausbushes/root/ComponentInitialize()
	. = ..()
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = .proc/shag,
	)
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/structure/flora/ausbushes/root/proc/shag(datum/source, mob/living/arrived)
	SIGNAL_HANDLER

	if(!isturf(loc) || !istype(arrived))
		return
	if(prob(50))
		arrived.visible_message(span_warning("[arrived] stumbles on the root."), \
								span_warning("I stumble on the root."))
		sound_hint()
		var/diceroll = arrived.diceroll(GET_MOB_ATTRIBUTE_VALUE(user, STAT_DEXTERITY), context = DICE_CONTEXT_MENTAL)
		if(diceroll <= DICE_FAILURE)
			arrived.Stumble(3 SECONDS)

/obj/structure/flora/ausbushes/crystal/dark
	name = "Blackness Bush"
	desc = "Bush of blackness. This bush is chaotic."
	icon = 'icons/obj/flora/ausflora.dmi'
	icon_state = "blacknessbush"
	layer = ABOVE_MOB_LAYER
	plane = ABOVE_GAME_PLANE
	density = 0
	anchored = 1
	opacity = 0
	var/berry_type = null
	var/berries = 0

/obj/structure/flora/ausbushes/crystal/dark/Initialize()
	. = ..()
	berry_type = pick("red", "blue", "redd", "bluee", "purple")
	grow_berries()

/obj/structure/flora/ausbushes/crystal/dark/proc/grow_berries()
	if(QDELETED(src) || !berry_type || (berries > 0))
		return
	update_appearance()
	berries++

/obj/structure/flora/ausbushes/crystal/dark/update_overlays()
	. = ..()
	if(berry_type && (berries > 0))
		. += "[berry_type]_berries"

/obj/structure/flora/ausbushes/crystal/dark/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(user.a_intent != INTENT_GRAB)
		return

	user.visible_message(span_notice("<b>[user]</b> begins to search for berries."), \
						span_notice("I begin to search for berries."), \
						span_hear("I hear the sound of shag."))
	user.changeNext_move(CLICK_CD_MELEE)
	playsound(loc,'sound/effects/shelest.ogg', 30, TRUE)
	if(!do_after(user, 70, target = src))
		to_chat(user, span_danger(xbox_rage_msg()))
		return
	if(!berries)
		to_chat(user, span_notice("No berries."))
		user.Immobilize(1 SECONDS)
		user.changeNext_move(CLICK_CD_MELEE)
		playsound(src,'sound/effects/shelest.ogg', 60, TRUE)
		return
	to_chat(user, span_notice("You pick berry."))
	user.changeNext_move(CLICK_CD_MELEE)
	user.Immobilize(1 SECONDS)
	playsound(src,'sound/effects/shelest.ogg', 60, TRUE)
	var/obj/item/berry
	switch(berry_type)
		if("red")
			berry = new /obj/item/food/berries/redcherrie(loc)
		if("blue")
			berry = new /obj/item/food/grown/bluecherries(loc)
		if("redd")
			berry = new /obj/item/food/berries/redcherrie/lie(loc)
		if("bluee")
			berry = new /obj/item/food/grown/bluecherries/lie(loc)
		if("purple")
			berry = new /obj/item/food/berries/leancherrie(loc)
	user.put_in_active_hand(berry)
	berries--
	addtimer(CALLBACK(src, .proc/grow_berries), 130 SECONDS)

/obj/structure/flora/ausbushes/zarosli/sliz
	name = "Slime Thickets"
	desc = "Nature is beautiful."
	icon = 'icons/obj/flora/ausflora.dmi'
	icon_state = "zaroslisliz"
	layer = ABOVE_MOB_LAYER
	plane = ABOVE_GAME_PLANE
	resistance_flags = FLAMMABLE
	density = 0
	anchored = TRUE
	opacity = TRUE

/obj/structure/flora/ausbushes/zarosli/midnight
	name = "Midnightberry Thickets"
	desc = "Nature is beautiful."
	icon = 'icons/obj/flora/ausflora.dmi'
	icon_state = "zarosliya"
	layer = ABOVE_MOB_LAYER
	plane = ABOVE_GAME_PLANE
	resistance_flags = FLAMMABLE
	density = 0
	anchored = TRUE
	opacity = TRUE

/obj/structure/flora/ausbushes/zarosli/Initialize(mapload)
	. = ..()
	update_appearance()

/obj/structure/flora/ausbushes/zarosli/ComponentInitialize()
	. = ..()
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = .proc/shag,
	)
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/structure/flora/ausbushes/zarosli/proc/shag(datum/source, atom/movable/AM)
	SIGNAL_HANDLER
	if(!isliving(AM))
		return
	playsound(src,'sound/effects/shelest.ogg', 60, TRUE)

/obj/structure/flora/ausbushes/zarosli/midnight/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(user.a_intent != INTENT_GRAB)
		return
	if(!do_after(user, 10 SECONDS, target = src))
		to_chat(user, span_danger(xbox_rage_msg()))
		return
	to_chat(user, span_notice("You pick pesky midnightberry."))
	user.changeNext_move(CLICK_CD_MELEE)
	user.Immobilize(1 SECONDS)
	playsound(src,'sound/effects/shelest.ogg', 60, TRUE)
	user.put_in_active_hand(new /obj/item/food/grown/bluecherries(loc))

/obj/structure/flora/ausbushes/reedbush
	icon_state = "reedbush_1"

/obj/structure/flora/ausbushes/reedbush/Initialize(mapload)
	. = ..()
	icon_state = "reedbush_[rand(1, 4)]"

/obj/structure/flora/ausbushes/leafybush
	icon_state = "leafybush_1"

/obj/structure/flora/ausbushes/leafybush/Initialize(mapload)
	. = ..()
	icon_state = "leafybush_[rand(1, 3)]"

/obj/structure/flora/ausbushes/palebush
	icon_state = "palebush_1"

/obj/structure/flora/ausbushes/palebush/Initialize(mapload)
	. = ..()
	icon_state = "palebush_[rand(1, 4)]"

/obj/structure/flora/ausbushes/stalkybush
	icon_state = "stalkybush_1"

/obj/structure/flora/ausbushes/stalkybush/Initialize(mapload)
	. = ..()
	icon_state = "stalkybush_[rand(1, 3)]"

/obj/structure/flora/ausbushes/grassybush
	icon_state = "grassybush_1"

/obj/structure/flora/ausbushes/grassybush/Initialize(mapload)
	. = ..()
	icon_state = "grassybush_[rand(1, 4)]"

/obj/structure/flora/ausbushes/fernybush
	icon_state = "fernybush_1"

/obj/structure/flora/ausbushes/fernybush/Initialize(mapload)
	. = ..()
	icon_state = "fernybush_[rand(1, 3)]"

/obj/structure/flora/ausbushes/sunnybush
	icon_state = "sunnybush_1"

/obj/structure/flora/ausbushes/sunnybush/Initialize(mapload)
	. = ..()
	icon_state = "sunnybush_[rand(1, 3)]"

/obj/structure/flora/ausbushes/genericbush
	icon_state = "genericbush_1"

/obj/structure/flora/ausbushes/genericbush/Initialize(mapload)
	. = ..()
	icon_state = "genericbush_[rand(1, 4)]"

/obj/structure/flora/ausbushes/pointybush
	icon_state = "pointybush_1"

/obj/structure/flora/ausbushes/pointybush/Initialize(mapload)
	. = ..()
	icon_state = "pointybush_[rand(1, 4)]"

/obj/structure/flora/ausbushes/lavendergrass
	icon_state = "lavendergrass_1"

/obj/structure/flora/ausbushes/lavendergrass/Initialize(mapload)
	. = ..()
	icon_state = "lavendergrass_[rand(1, 4)]"

/obj/structure/flora/ausbushes/ywflowers
	icon_state = "ywflowers_1"

/obj/structure/flora/ausbushes/ywflowers/Initialize(mapload)
	. = ..()
	icon_state = "ywflowers_[rand(1, 3)]"

/obj/structure/flora/ausbushes/brflowers
	icon_state = "brflowers_1"

/obj/structure/flora/ausbushes/brflowers/Initialize(mapload)
	. = ..()
	icon_state = "brflowers_[rand(1, 3)]"

/obj/structure/flora/ausbushes/ppflowers
	icon_state = "ppflowers_1"

/obj/structure/flora/ausbushes/ppflowers/Initialize(mapload)
	. = ..()
	icon_state = "ppflowers_[rand(1, 3)]"

/obj/structure/flora/ausbushes/sparsegrass
	icon_state = "sparsegrass_1"

/obj/structure/flora/ausbushes/sparsegrass/Initialize(mapload)
	. = ..()
	icon_state = "sparsegrass_[rand(1, 3)]"

/obj/structure/flora/ausbushes/fullgrass
	icon_state = "fullgrass_1"

/obj/structure/flora/ausbushes/fullgrass/Initialize(mapload)
	. = ..()
	icon_state = "fullgrass_[rand(1, 3)]"

/obj/item/kirbyplants
	name = "potted plant"
	icon = 'icons/obj/flora/plants.dmi'
	icon_state = "plant-01"
	desc = "A little bit of nature contained in a pot."
	plane = GAME_PLANE_UPPER
	layer = ABOVE_MOB_LAYER
	w_class = WEIGHT_CLASS_HUGE
	force = 10
	throwforce = 13
	throw_speed = 2
	throw_range = 4
	item_flags = NO_PIXEL_RANDOM_DROP

	/// Can this plant be trimmed by someone with TRAIT_BONSAI
	var/trimmable = TRUE
	var/list/static/random_plant_states

/obj/item/kirbyplants/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/tactical)
	AddComponent(/datum/component/two_handed, require_twohands=TRUE, force_unwielded=10, force_wielded=10)
	AddElement(/datum/element/beauty, 500)

/obj/item/kirbyplants/attackby(obj/item/I, mob/living/user, params)
	. = ..()
	if(trimmable && HAS_TRAIT(user,TRAIT_BONSAI) && isturf(loc) && I.get_sharpness())
		to_chat(user,span_notice("You start trimming [src]."))
		if(do_after(user,3 SECONDS,target=src))
			to_chat(user,span_notice("You finish trimming [src]."))
			change_visual()

/// Cycle basic plant visuals
/obj/item/kirbyplants/proc/change_visual()
	if(!random_plant_states)
		generate_states()
	var/current = random_plant_states.Find(icon_state)
	var/next = WRAP(current+1,1,length(random_plant_states))
	icon_state = random_plant_states[next]

/obj/item/kirbyplants/random
	icon = 'icons/obj/flora/_flora.dmi'
	icon_state = "random_plant"

/obj/item/kirbyplants/random/Initialize(mapload)
	. = ..()
	icon = 'icons/obj/flora/plants.dmi'
	if(!random_plant_states)
		generate_states()
	icon_state = pick(random_plant_states)

/obj/item/kirbyplants/proc/generate_states()
	random_plant_states = list()
	for(var/i in 1 to 25)
		var/number
		if(i < 10)
			number = "0[i]"
		else
			number = "[i]"
		random_plant_states += "plant-[number]"
	random_plant_states += "applebush"


/obj/item/kirbyplants/dead
	name = "RD's potted plant"
	desc = "A gift from the botanical staff, presented after the RD's reassignment. There's a tag on it that says \"Y'all come back now, y'hear?\"\nIt doesn't look very healthy..."
	icon_state = "plant-25"
	trimmable = FALSE

/obj/item/kirbyplants/photosynthetic
	name = "photosynthetic potted plant"
	desc = "A bioluminescent plant."
	icon_state = "plant-09"
	light_color = COLOR_BRIGHT_BLUE
	light_range = 3

/obj/item/kirbyplants/fullysynthetic
	name = "plastic potted plant"
	desc = "A fake, cheap looking, plastic tree. Perfect for people who kill every plant they touch."
	icon_state = "plant-26"
	custom_materials = (list(/datum/material/plastic = 8000))
	trimmable = FALSE

/obj/item/kirbyplants/fullysynthetic/Initialize(mapload)
	. = ..()
	icon_state = "plant-[rand(26, 29)]"

/obj/item/kirbyplants/potty
	name = "Potty the Potted Plant"
	desc = "A secret agent staffed in the station's bar to protect the mystical cakehat."
	icon_state = "potty"
	trimmable = FALSE

/obj/item/kirbyplants/fern
	name = "neglected fern"
	desc = "An old botanical research sample collected on a long forgotten jungle planet."
	icon_state = "fern"
	trimmable = FALSE

/obj/item/kirbyplants/fern/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_ALGAE, CELL_VIRUS_TABLE_GENERIC, rand(2,4), 5)

//a rock is flora according to where the icon file is
//and now these defines

/obj/structure/flora/rock
	icon_state = "basalt"
	desc = "A volcanic rock. Pioneers used to ride these babies for miles."
	icon = 'icons/obj/flora/rocks.dmi'
	resistance_flags = FIRE_PROOF
	density = TRUE
	/// Itemstack that is dropped when a rock is mined with a pickaxe
	var/obj/item/stack/mineResult = /obj/item/stack/ore/glass/basalt
	/// Amount of the itemstack to drop
	var/mineAmount = 20

/obj/structure/flora/rock/Initialize(mapload)
	. = ..()
	icon_state = "[icon_state][rand(1,3)]"

/obj/structure/flora/rock/attackby(obj/item/W, mob/user, params)
	if(!mineResult || W.tool_behaviour != TOOL_MINING)
		return ..()
	if(flags_1 & NODECONSTRUCT_1)
		return ..()
	to_chat(user, span_notice("You start mining..."))
	if(W.use_tool(src, user, 40, volume=50))
		to_chat(user, span_notice("You finish mining the rock."))
		if(mineResult && mineAmount)
			new mineResult(loc, mineAmount)
		SSblackbox.record_feedback("tally", "pick_used_mining", 1, W.type)
		qdel(src)

/obj/structure/flora/rock/pile
	icon_state = "lavarocks"
	desc = "A pile of rocks."

/obj/structure/barricade/flora/crystal/green
	icon_state = "greencrystal"
	name = "Green Crystal"
	desc = "Green сrystal."
	icon = 'icons/obj/flora/rocks.dmi'
	resistance_flags = FIRE_PROOF
	max_integrity = 50
//	proj_pass_rate = 20
//	pass_flags_self = LETPASSTHROW
	density = TRUE
	anchored = TRUE
	light_range = 2
	light_power = 4
	light_color = "#00dd78"
/*
/obj/structure/barricade/flora/crystal/green/make_debris()
	new /obj/item/shard/crystal/green(get_turf(src), 5)
*/
/obj/structure/barricade/flora/crystal/red
	icon_state = "redcrystal"
	name = "Red Crystal"
	desc = "Red сrystal."
	icon = 'icons/obj/flora/rocks.dmi'
	resistance_flags = FIRE_PROOF
	max_integrity = 50
//	proj_pass_rate = 20
//	pass_flags_self = LETPASSTHROW
	density = TRUE
	anchored = TRUE
	light_range = 2
	light_power = 4
	light_color = "#ff460e"
/*
/obj/structure/barricade/flora/crystal/red/make_debris()
	new /obj/item/shard/crystal/red(get_turf(src), 5)
*/
/obj/structure/barricade/flora/crystal/blue
	icon_state = "bluecrystal"
	name = "Blue Crystal"
	desc = "Blue сrystal."
	icon = 'icons/obj/flora/rocks.dmi'
	resistance_flags = FIRE_PROOF
	max_integrity = 50
//	proj_pass_rate = 20
//	pass_flags_self = LETPASSTHROW
	density = TRUE
	anchored = TRUE
	light_range = 2
	light_power = 4
	light_color = "#008eff"
/*
/obj/structure/barricade/flora/crystal/blue/make_debris()
	new /obj/item/shard/crystal/blue(get_turf(src), 5)
*/
/obj/structure/barricade/flora/crystal/purple
	icon_state = "purplecrystal"
	name = "Purple Crystal"
	desc = "Purple сrystal."
	icon = 'icons/obj/flora/rocks.dmi'
	resistance_flags = FIRE_PROOF
	max_integrity = 50
//	proj_pass_rate = 20
//	pass_flags_self = LETPASSTHROW
	density = TRUE
	anchored = TRUE
	light_range = 2
	light_power = 4
	light_color = "#e252ea"
/*
/obj/structure/barricade/flora/crystal/purple/make_debris()
	new /obj/item/shard/crystal/purple(get_turf(src), 5)
*/
/obj/structure/barricade/flora/crystal/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/climbable)

/obj/structure/barricade/flora/crystal/purple/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		new /obj/item/shard/crystal/purple(get_turf(src))
		new /obj/item/shard/crystal/purple(get_turf(src))
		new /obj/item/shard/crystal/purple(get_turf(src))
		new /obj/item/shard/crystal/purple(get_turf(src))
		new /obj/item/shard/crystal/purple(get_turf(src))
		playsound(src, "shatter", 70, TRUE)
	qdel(src)

/obj/structure/barricade/flora/crystal/green/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		new /obj/item/shard/crystal/green(get_turf(src))
		new /obj/item/shard/crystal/green(get_turf(src))
		new /obj/item/shard/crystal/green(get_turf(src))
		new /obj/item/shard/crystal/green(get_turf(src))
		new /obj/item/shard/crystal/green(get_turf(src))
		playsound(src, "shatter", 70, TRUE)
	qdel(src)

/obj/structure/barricade/flora/crystal/red/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		new /obj/item/shard/crystal/red(get_turf(src))
		new /obj/item/shard/crystal/red(get_turf(src))
		new /obj/item/shard/crystal/red(get_turf(src))
		new /obj/item/shard/crystal/red(get_turf(src))
		new /obj/item/shard/crystal/red(get_turf(src))
		playsound(src, "shatter", 70, TRUE)
	qdel(src)

/obj/structure/barricade/flora/crystal/blue/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		new /obj/item/shard/crystal/blue(get_turf(src))
		new /obj/item/shard/crystal/blue(get_turf(src))
		new /obj/item/shard/crystal/blue(get_turf(src))
		new /obj/item/shard/crystal/blue(get_turf(src))
		new /obj/item/shard/crystal/blue(get_turf(src))
		playsound(src, "shatter", 70, TRUE)
	qdel(src)

/*
	if(!(flags_1 & NODECONSTRUCT_1))
		if(!disassembled)
			playsound(src, "shatter", 70, TRUE)
			qdel(src)
			make_debris()
	else
		qdel(src)
		make_debris()
*/

//Jungle grass

/obj/structure/flora/grass/jungle
	name = "jungle grass"
	desc = "Thick alien flora."
	icon = 'icons/obj/flora/jungleflora.dmi'
	icon_state = "grassa"


/obj/structure/flora/grass/jungle/Initialize(mapload)
	icon_state = "[icon_state][rand(1, 5)]"
	. = ..()

/obj/structure/flora/grass/jungle/b
	icon_state = "grassb"

//Jungle rocks

/obj/structure/flora/rock/jungle
	icon_state = "rock"
	desc = "A pile of rocks."
	icon = 'icons/obj/flora/jungleflora.dmi'
	density = FALSE

/obj/structure/flora/rock/jungle/Initialize(mapload)
	. = ..()
	icon_state = "[initial(icon_state)][rand(1,5)]"


//Jungle bushes

/obj/structure/flora/junglebush
	name = "bush"
	desc = "A wild plant that is found in jungles."
	icon = 'icons/obj/flora/jungleflora.dmi'
	icon_state = "busha"

/obj/structure/flora/junglebush/Initialize(mapload)
	icon_state = "[icon_state][rand(1, 3)]"
	. = ..()

/obj/structure/flora/junglebush/b
	icon_state = "bushb"

/obj/structure/flora/junglebush/c
	icon_state = "bushc"

/obj/structure/flora/junglebush/large
	icon_state = "bush"
	icon = 'icons/obj/flora/largejungleflora.dmi'
	pixel_x = -16
	pixel_y = -12
	layer = ABOVE_ALL_MOB_LAYER
	plane = ABOVE_GAME_PLANE

/obj/structure/flora/rock/pile/largejungle
	name = "rocks"
	icon_state = "rocks"
	icon = 'icons/obj/flora/largejungleflora.dmi'
	density = FALSE
	pixel_x = -16
	pixel_y = -16

/obj/structure/flora/rock/pile/largejungle/Initialize(mapload)
	. = ..()
	icon_state = "[initial(icon_state)][rand(1,3)]"
