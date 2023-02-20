/turf/open/floor/plating/polovich
	name = "Violet Floor"
	desc = "This is cool."
	icon_state = "leaner"
	icon = 'modular_pod/icons/turf/floors.dmi'
	attachment_holes = FALSE
	footstep = FOOTSTEP_METAL
	barefootstep = FOOTSTEP_METAL
	clawfootstep = FOOTSTEP_METAL
	heavyfootstep = FOOTSTEP_METAL

/*
/turf/open/floor/plating/polovich/setup_broken_states()
	return list("damaged1", "damaged2", "damaged3", "damaged4", "damaged5")

/turf/open/floor/plating/polovich/setup_burnt_states()
	return list("floorscorched1", "floorscorched2")
*/

/turf/open/floor/plating/polovich/burn_tile()
	return

/turf/open/floor/plating/polovich/break_tile()
	return

/turf/open/floor/attack_hand(mob/living/carbon/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(user.a_intent == INTENT_HELP)
		user.visible_message(span_notice("[user] touches the [src]."),span_notice("You touch the [src]."), span_hear("You hear the sound of touching."))
//		user.visible_message("<span class='notice'>\[user] touches the [src].</span>")
		user.changeNext_move(CLICK_CD_WRENCH)
	if(user.a_intent == INTENT_HARM)
		user.visible_message(span_notice("[user] beats the [src] with hand."),span_notice("You beat the [src] with hand."), span_hear("You hear the sound of beating the floor."))
//		user.visible_message("<span class='notice'>\[user] beats the [src].</span>")
		user.changeNext_move(CLICK_CD_MELEE)
		user.adjustFatigueLoss(5)
		playsound(get_turf(src), 'sound/effects/beatfloorhand.ogg', 80 , FALSE, FALSE)
		sound_hint()

/turf/open/floor/attack_hand_secondary(mob/living/carbon/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(user.a_intent == INTENT_HELP)
		user.visible_message(span_notice("[user] touches the [src]."),span_notice("You touch the [src]."), span_hear("You hear the sound of touching."))
//		user.visible_message("<span class='notice'>\[user] touches the [src].</span>")
		user.changeNext_move(CLICK_CD_WRENCH)
	if(user.a_intent == INTENT_HARM)
		user.visible_message(span_notice("[user] beats the [src] with hand."),span_notice("You beat the [src] with hand."), span_hear("You hear the sound of beating the floor."))
//		user.visible_message("<span class='notice'>\[user] beats the [src].</span>")
		user.changeNext_move(CLICK_CD_MELEE)
		user.adjustFatigueLoss(5)
		playsound(get_turf(src), 'sound/effects/beatfloorhand.ogg', 80 , FALSE, FALSE)
		sound_hint()

/turf/open/floor/attackby(obj/item/W, mob/living/carbon/user, params)
	. = ..()
	if(.)
		return
	if(user.a_intent == INTENT_HELP)
//		user.visible_message("<span class='notice'>\[user] touches the [src] with [W].</span>")
		user.visible_message(span_notice("[user] touches the [src] with [W]."),span_notice("You touch the [src] with [W]."), span_hear("You hear the sound of touching."))
		user.changeNext_move(CLICK_CD_WRENCH)
	if(user.a_intent == INTENT_HARM)
//		user.visible_message("<span class='notice'>\[user] beats the [src] with [W].</span>")
		user.visible_message(span_notice("[user] beats the [src] with [W]."),span_notice("You beat the [src] with [W]."), span_hear("You hear the sound of beating the floor."))
		user.changeNext_move(W.attack_delay)
		user.adjustFatigueLoss(W.attack_fatigue_cost)
		W.damageItem("SOFT")
		playsound(get_turf(src), 'sound/effects/slamflooritem.ogg', 90 , FALSE, FALSE)
		sound_hint()
		if(istype(src, /turf/open/floor/plating/polovich/dirt/dark/bright))
			if(prob(W.force))
				var/turf/open/floor/plating/polovich/dirt/dark/bright/firefloor = src
				new /atom/movable/fire(firefloor, 21)

/turf/open/floor/attack_jaw(mob/living/carbon/human/user, list/modifiers)
	. = ..()
	if(.)
		return
	user.visible_message(span_notice("[user] bites the [src]."),span_notice("You bite the [src]."), span_hear("You hear the sound of biting."))
	user.changeNext_move(CLICK_CD_BITE)
	user.adjustFatigueLoss(5)
	playsound(get_turf(src), 'sound/weapons/bite.ogg', 80 , FALSE, FALSE)
	sound_hint()

/turf/open/floor/attack_foot(mob/living/carbon/human/user, list/modifiers)
	. = ..()
	if(.)
		return
	user.visible_message(span_notice("[user] kicks the [src]."),span_notice("You kick the [src]."), span_hear("You hear the sound of kicking."))
	user.changeNext_move(CLICK_CD_MELEE)
	user.adjustFatigueLoss(10)
	playsound(get_turf(src), 'sound/effects/beatfloorhand.ogg', 80 , FALSE, FALSE)
	sound_hint()

/turf/open/floor/plating/polovich/get_projectile_hitsound(obj/projectile/projectile)
	return "modular_septic/sound/bullet/projectile_impact/ric_ground[rand(1,5)].wav"

/turf/open/floor/plating/polovich/red
	name = "Red Floor"
	desc = "This is cool."
	icon_state = "racalka"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/yellow
	name = "Yellow Floor"
	desc = "This is cool."
	icon_state = "interesno"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/yelloww
	name = "Yellow Floor"
	desc = "This is cool."
	icon_state = "krutonavernoe"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/kruto
	name = "Purple Floor"
	desc = "This is cool."
	icon_state = "kruto"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/typaya
	name = "Greenish Floor"
	desc = "This is cool."
	icon_state = "typaya"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/durackaya
	name = "Greenish Floor"
	desc = "This is cool."
	icon_state = "durackaya"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE
/*
/turf/open/floor/plating/polovich/temno
	name = "Dark Floor"
	desc = "This is cool."
	icon_state = "temno"
	icon = 'modular_pod/icons/turf/floors.dmi'
*/
/turf/open/floor/plating/polovich/temnoo
	name = "Asphalt"
	desc = "This is cool."
	icon_state = "asfalt"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/temnoo/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/temnoo/two
	name = "Asphalt"
	desc = "This is cool."
	icon_state = "asfalt2"
	icon = 'modular_pod/icons/turf/floors.dmi'

/turf/open/floor/plating/polovich/temnoo/two/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/temnoo/three
	name = "Asphalt"
	desc = "This is cool."
	icon_state = "asfalt3"
	icon = 'modular_pod/icons/turf/floors.dmi'

/turf/open/floor/plating/polovich/temnoo/four
	name = "Asphalt"
	desc = "This is cool."
	icon_state = "asfalt4"
	icon = 'modular_pod/icons/turf/floors.dmi'

/turf/open/floor/plating/polovich/temnoo/five
	name = "Asphalt"
	desc = "This is cool."
	icon_state = "asfalt5"
	icon = 'modular_pod/icons/turf/floors.dmi'

/turf/open/floor/plating/polovich/temnoo/six
	name = "Asphalt"
	desc = "This is cool."
	icon_state = "asfalt6"
	icon = 'modular_pod/icons/turf/floors.dmi'

/turf/open/floor/plating/polovich/temnoo/seven
	name = "Asphalt"
	desc = "This is cool."
	icon_state = "asfalt7"
	icon = 'modular_pod/icons/turf/floors.dmi'

/turf/open/floor/plating/polovich/temnoo/eight
	name = "Asphalt"
	desc = "This is cool."
	icon_state = "asfalt8"
	icon = 'modular_pod/icons/turf/floors.dmi'

/turf/open/floor/plating/polovich/temnoo/nine
	name = "Asphalt"
	desc = "This is cool."
	icon_state = "asfalt9"
	icon = 'modular_pod/icons/turf/floors.dmi'

/turf/open/floor/plating/polovich/temnoo/ten
	name = "Asphalt"
	desc = "This is cool."
	icon_state = "asfalt10"
	icon = 'modular_pod/icons/turf/floors.dmi'

/turf/open/floor/plating/polovich/kapec
	name = "Strange Floor"
	desc = "This is cool."
	icon_state = "kapec"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/kapec/two
	name = "Strange Floor"
	desc = "This is cool."
	icon_state = "brickstrange"
	icon = 'modular_pod/icons/turf/floors.dmi'

/turf/open/floor/plating/polovich/kapec/three
	name = "Strange Floor"
	desc = "This is cool."
	icon_state = "brickstrange2"
	icon = 'modular_pod/icons/turf/floors.dmi'

/turf/open/floor/plating/polovich/kapec/four
	name = "Strange Floor"
	desc = "This is cool."
	icon_state = "brickstrange3"
	icon = 'modular_pod/icons/turf/floors.dmi'

/turf/open/floor/plating/polovich/kapec/five
	name = "Strange Floor"
	desc = "This is cool."
	icon_state = "brickstrange4"
	icon = 'modular_pod/icons/turf/floors.dmi'

/turf/open/floor/plating/polovich/kapec/siv
	name = "Strange Floor"
	desc = "This is cool."
	icon_state = "brickstrange5"
	icon = 'modular_pod/icons/turf/floors.dmi'

/turf/open/floor/plating/polovich/kapec/ss
	name = "Strange Floor"
	desc = "This is cool."
	icon_state = "brickstrange6"
	icon = 'modular_pod/icons/turf/floors.dmi'

/turf/open/floor/plating/polovich/kapec/vv
	name = "Strange Floor"
	desc = "This is cool."
	icon_state = "brickstrange7"
	icon = 'modular_pod/icons/turf/floors.dmi'

/turf/open/floor/plating/polovich/kapec/ba
	name = "Strange Floor"
	desc = "This is cool."
	icon_state = "brickstrange8"
	icon = 'modular_pod/icons/turf/floors.dmi'

/turf/open/floor/plating/polovich/kapec/xy
	name = "Strange Floor"
	desc = "This is cool."
	icon_state = "brickstrange9"
	icon = 'modular_pod/icons/turf/floors.dmi'

/turf/open/floor/plating/polovich/strangeflesh
	name = "Strange Flesh"
	desc = "This is bad."
	icon_state = "strangeflesh"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_MEAT
	mood_turf_mes = "<span class='bloody'>Is this floor alive?!</span>\n"
	mood_bonus_turf = -1
	slowdown = 2
	barefootstep = FOOTSTEP_MEAT
	clawfootstep = FOOTSTEP_MEAT
	heavyfootstep = FOOTSTEP_MEAT

/turf/open/floor/plating/polovich/strangeflesh/two
	name = "Strange Flesh"
	desc = "This is sticky and bad."
	icon_state = "redsticky"
	icon = 'modular_pod/icons/turf/floors.dmi'
	mood_turf_mes = "<span class='bloody'>Is this floor alive?!</span>\n"
	mood_bonus_turf = -1
	slowdown = 1

/turf/open/floor/plating/polovich/bluee
	name = "Blue Floor"
	desc = "This is cool."
	icon_state = "bluefloor"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_PLATING

/turf/open/floor/light/colour_cycle/polovich
	name = "Dancefloor"
	desc = "This is funny."
	icon = 'modular_pod/icons/turf/floors.dmi'
	icon_state = "dancefloor_on-11"
	light_color = COLOR_RED
	can_modify_colour = FALSE
	cycle = TRUE

/turf/open/floor/plating/polovich/purplefantast
	name = "Purple Floor"
	desc = "This is amazing."
	icon_state = "purplefantast"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_PLATING

/turf/open/floor/plating/polovich/purplefantast/two
	name = "Purple Floor"
	desc = "This is amazing."
	icon_state = "purplefantast2"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_PLATING

/turf/open/floor/plating/polovich/dirt
	name = "White Dirt"
	desc = "This is sticky."
	icon_state = "gryazwhite"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_SAND
	slowdown = 1
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_SAND

/turf/open/floor/plating/polovich/dirt/soft
	name = "Soft Dirt"
	desc = "Annoying to stand on it"
	icon_state = "dirtvillage"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_SAND
	slowdown = 1
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_SAND

/turf/open/floor/plating/polovich/dirt/soft/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/dirt/blue
	name = "Blue Dirt"
	desc = "This is good!"
	icon_state = "gryazblue"
	icon = 'modular_pod/icons/turf/floors.dmi'
	slowdown = -1

/turf/open/floor/plating/polovich/dirt/dark/gryazka
	name = "Black Dirt"
	desc = "This is darkly."
	icon_state = "blackgryaz"
	icon = 'modular_pod/icons/turf/floors.dmi'
	slowdown = 1
	var/cooldown = 80

/turf/open/floor/plating/polovich/dirt/dark/gryazka/Initialize(mapload)
	. = ..()
	dir = rand(0,4)
/*
	if(prob(65))
		if(istype(src.loc, /mob/living/carbon/human))
			try_eat()

/turf/open/floor/plating/polovich/dirt/dark/gryazka/Initialize()
	. = ..()
	if(prob(65))
		if(locate(/mob/living/carbon/human) in src)
			try_eat()

/turf/open/floor/plating/polovich/dirt/dark/gryazka/proc/try_eat()
//	var/open/floor/plating/polovich/dirt/dark/T = get_turf(src)
	var/mob/living/carbon/human/eat_human = locate() in src
	if(eat_human.stat != DEAD)
		return
	if(eat_human.body_position == LYING_DOWN)
		if(cooldown <= world.time)
			visible_message(span_notice("Dirt swallows the corpse."))
			eat_human.unequip_everything()
			qdel(eat_human)
			cooldown = world.time + 80 //.... 8800

*/

/turf/open/floor/plating/polovich/dirt/dark/bright
	name = "Funny Dirt"
	desc = "This is funny."
	icon_state = "blackgryaz2"
	icon = 'modular_pod/icons/turf/floors.dmi'
	slowdown = 1

/turf/open/floor/plating/polovich/dirt/dark/bright/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/dirt/dark/animated
	name = "Black Dirt"
	desc = "This is darkly."
	icon_state = "blackgryaz3"
	icon = 'modular_pod/icons/turf/floors.dmi'

/turf/open/floor/plating/polovich/dirt/dark/animated/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/bonefloor
	name = "Bone Floor"
	desc = "This is brutal and interesting."
	icon_state = "bonefloor"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_CRUMBLE
	barefootstep = FOOTSTEP_CRUMBLE
	clawfootstep = FOOTSTEP_CRUMBLE
	heavyfootstep = FOOTSTEP_CRUMBLE

/turf/open/floor/plating/polovich/gristle
	name = "Gristle Floor"
	desc = "This is brutal and interesting. Throbbing Gristle."
	icon_state = "gristle"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_CRUMBLE
	barefootstep = FOOTSTEP_CRUMBLE
	clawfootstep = FOOTSTEP_CRUMBLE
	heavyfootstep = FOOTSTEP_CRUMBLE

/turf/open/floor/plating/polovich/krutoplitka
	name = "Strange Floor"
	desc = "This is interesting."
	icon_state = "krutoplitka"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_PLATING

/turf/open/floor/plating/polovich/krutoplitka/plitkabluered
	name = "Strange Floor"
	desc = "This is interesting."
	icon_state = "plitkabluered"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_PLATING

/turf/open/floor/plating/polovich/krutoplitka/plitkapinkred
	name = "Strange Floor"
	desc = "This is interesting."
	icon_state = "plitrapinkred"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_PLATING

/turf/open/floor/plating/polovich/krutoplitka/krutoplitka2
	name = "Strange Floor"
	desc = "This is interesting."
	icon_state = "krutoplitka2"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/greenstone
	name = "Evil Floor"
	desc = "This is interesting and vicious."
	icon_state = "greenstone"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/greengryaz
	name = "Evil Dirt"
	desc = "This is interesting and vicious."
	icon_state = "evilzemlya"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_GRASS
	barefootstep = FOOTSTEP_GRASS
	clawfootstep = FOOTSTEP_GRASS
	heavyfootstep = FOOTSTEP_GRASS
	slowdown = 1

/turf/open/floor/plating/polovich/greengryaz/Initialize(mapload)
	. = ..()
	dir = rand(0,8)

/turf/open/floor/plating/polovich/greengryaz/bigfire
	turf_fire = /atom/movable/fire/inferno/magical
//	air.temperature == T0C+10

//	new /atom/movable/fire(src, power)

/turf/open/floor/plating/polovich/bluedirty
	name = "Blue Dirt"
	desc = "This is interesting."
	icon_state = "bluedirt"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_GRASS
	barefootstep = FOOTSTEP_GRASS
	clawfootstep = FOOTSTEP_GRASS
	heavyfootstep = FOOTSTEP_GRASS
	slowdown = 1

/turf/open/floor/plating/polovich/bluedirty/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/greendirtevil
	name = "Green Dirt"
	desc = "This is evil."
	icon_state = "zemlyay"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_GRASS
	barefootstep = FOOTSTEP_GRASS
	clawfootstep = FOOTSTEP_GRASS
	heavyfootstep = FOOTSTEP_GRASS
	slowdown = 1

/turf/open/floor/plating/polovich/greendirtevil/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/lightblue
	name = "Blue Dirt"
	desc = "This is evil and interesting."
	icon_state = "evilzemlyaslight"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_GRASS
	barefootstep = FOOTSTEP_GRASS
	clawfootstep = FOOTSTEP_GRASS
	heavyfootstep = FOOTSTEP_GRASS
	slowdown = 1

/turf/open/floor/plating/polovich/lightblue/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/woodennewblue
	name = "Wooden Floor"
	desc = "This is neutral."
	icon_state = "doskiblue"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_WOOD
	barefootstep = FOOTSTEP_WOOD_BAREFOOT
	clawfootstep = FOOTSTEP_WOOD_CLAW
	heavyfootstep = FOOTSTEP_WOOD
	resistance_flags = FLAMMABLE

/turf/open/floor/plating/polovich/woodennewblue/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/woodennewdarr
	name = "Wooden Floor"
	desc = "This is neutral and dark."
	icon_state = "wooddark"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_WOOD
	barefootstep = FOOTSTEP_WOOD_BAREFOOT
	clawfootstep = FOOTSTEP_WOOD_CLAW
	heavyfootstep = FOOTSTEP_WOOD
	resistance_flags = FLAMMABLE

/turf/open/floor/plating/polovich/greenishe
	name = "Wooden Floor"
	desc = "This is green and dark."
	icon_state = "woodgreen"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_WOOD
	barefootstep = FOOTSTEP_WOOD_BAREFOOT
	clawfootstep = FOOTSTEP_WOOD_CLAW
	heavyfootstep = FOOTSTEP_WOOD
	resistance_flags = FLAMMABLE

/turf/open/floor/plating/polovich/roots
	name = "Roots"
	desc = "Don't stumble!"
	icon_state = "roots"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_WOOD
	barefootstep = FOOTSTEP_WOOD_BAREFOOT
	clawfootstep = FOOTSTEP_WOOD_CLAW
	heavyfootstep = FOOTSTEP_WOOD
	resistance_flags = FLAMMABLE

/turf/open/floor/plating/polovich/roots/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/roots/Entered(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	. = ..()
	if(.)
		return
	if(isliving(arrived))
		if(prob(50))
			var/mob/living/stumbleguy = arrived
			stumbleguy.visible_message(span_warning("[stumbleguy] stumbles on the root."), \
						span_warning("I stumble on the root."))
			sound_hint()
			var/diceroll = stumbleguy.diceroll(GET_MOB_ATTRIBUTE_VALUE(stumbleguy, STAT_DEXTERITY), context = DICE_CONTEXT_MENTAL)
			if(diceroll <= DICE_FAILURE)
				stumbleguy.Stumble(3 SECONDS)
				stumbleguy.visible_message(span_warning("The roots are grasping [stumbleguy]!"), \
										span_warning("The roots are grasping me!"))

/turf/open/floor/plating/polovich/logsgreen
	name = "Wooden Floor"
	desc = "This is green. Cursed."
	icon_state = "logsgreen"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_WOOD
	barefootstep = FOOTSTEP_WOOD_BAREFOOT
	clawfootstep = FOOTSTEP_WOOD_CLAW
	heavyfootstep = FOOTSTEP_WOOD
	resistance_flags = FLAMMABLE

/turf/open/openspace/attackby(obj/item/C, mob/user, params)
	. = ..()
	if(!CanBuildHere())
		return
	if(istype(C, /obj/item/stack/grown/log/tree/evil/logg))
		var/obj/item/stack/grown/log/tree/evil/logg/R = C
		if(R.amount == 4)
			to_chat(user, span_notice("You construct a floor."))
			playsound(src, 'sound/weapons/genhit.ogg', 50, TRUE)
			new /turf/open/floor/plating/polovich/logsgreen(src)
			qdel(src)
		else
			to_chat(user, span_warning("You need four logs to build a floor!"))
		return

/turf/open/floor/plating/polovich/logsgreen/two
	name = "Wooden Floor"
	desc = "This is green. Cursed."
	icon_state = "logsgreen_2"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_WOOD
	barefootstep = FOOTSTEP_WOOD_BAREFOOT
	clawfootstep = FOOTSTEP_WOOD_CLAW
	heavyfootstep = FOOTSTEP_WOOD
	resistance_flags = FLAMMABLE

/turf/open/floor/plating/polovich/logsgreen/three
	name = "Wooden Floor"
	desc = "This is green. Cursed."
	icon_state = "logsgreen_3"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_WOOD
	barefootstep = FOOTSTEP_WOOD_BAREFOOT
	clawfootstep = FOOTSTEP_WOOD_CLAW
	heavyfootstep = FOOTSTEP_WOOD
	resistance_flags = FLAMMABLE

/turf/open/floor/plating/polovich/greenishe2
	name = "Wooden Floor"
	desc = "This is green and dark."
	icon_state = "woodgreen2"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_WOOD
	barefootstep = FOOTSTEP_WOOD_BAREFOOT
	clawfootstep = FOOTSTEP_WOOD_CLAW
	heavyfootstep = FOOTSTEP_WOOD
	resistance_flags = FLAMMABLE

/turf/open/floor/plating/polovich/woodennew
	name = "Wooden Floor"
	desc = "This is good."
	icon_state = "woodennew"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_WOOD
	barefootstep = FOOTSTEP_WOOD_BAREFOOT
	clawfootstep = FOOTSTEP_WOOD_CLAW
	heavyfootstep = FOOTSTEP_WOOD
	resistance_flags = FLAMMABLE

/turf/open/floor/plating/polovich/woodens
	name = "Wooden Planks"
	desc = "This is good."
	icon_state = "planks"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_WOOD
	barefootstep = FOOTSTEP_WOOD_BAREFOOT
	clawfootstep = FOOTSTEP_WOOD_CLAW
	heavyfootstep = FOOTSTEP_WOOD
	resistance_flags = FLAMMABLE

/turf/open/floor/plating/polovich/woodenss
	name = "Wooden Planks"
	desc = "This is good."
	icon_state = "woodenfloor"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_WOOD
	barefootstep = FOOTSTEP_WOOD_BAREFOOT
	clawfootstep = FOOTSTEP_WOOD_CLAW
	heavyfootstep = FOOTSTEP_WOOD
	resistance_flags = FLAMMABLE

/turf/open/floor/plating/polovich/newstoneawesome
	name = "Stone Floor"
	desc = "Helps to move."
	icon_state = "stonefloornew"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/newstoneawesome/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/newstoneawesome/dirty
	name = "Stone Floor"
	desc = "Helps to move."
	icon_state = "stonefloordirty"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/newstoneawesome/big
	name = "Stone Floor"
	desc = "Helps to move."
	icon_state = "stonefloorsecond"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/newstoneawesome/big/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/newstoneawesome/big/shining
	name = "Stone Floor"
	desc = "Helps to move. What is this red glow?"
	icon_state = "stonefloorsecond_light"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/newstoneawesome/big/shining/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/gre
	name = "Stone Floor"
	desc = "This is probably boring."
	icon_state = "stoneone"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/pinkbrick
	name = "Pink Floor"
	desc = "This is interesting and good."
	icon_state = "pinkbrick"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/metalfloor
	name = "Steel Floor"
	desc = "This is brutal."
	icon_state = "metalnew"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_METAL
	barefootstep = FOOTSTEP_METAL
	clawfootstep = FOOTSTEP_METAL
	heavyfootstep = FOOTSTEP_METAL

/turf/open/floor/plating/polovich/metallicfloor
	name = "Metallic Floor"
	desc = "This is brutal."
	icon_state = "metallicfloor"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_METAL
	barefootstep = FOOTSTEP_METAL
	clawfootstep = FOOTSTEP_METAL
	heavyfootstep = FOOTSTEP_METAL

/turf/open/floor/plating/polovich/metallicfloor/second
	name = "Metallic Floor"
	desc = "This is brutal."
	icon_state = "metallicfloor2"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_METAL
	barefootstep = FOOTSTEP_METAL
	clawfootstep = FOOTSTEP_METAL
	heavyfootstep = FOOTSTEP_METAL

/turf/open/floor/plating/polovich/magicsteel
	name = "Magic Floor"
	desc = "This is magically and steel."
	icon_state = "steelmagic"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_METAL
	barefootstep = FOOTSTEP_METAL
	clawfootstep = FOOTSTEP_METAL
	heavyfootstep = FOOTSTEP_METAL

/turf/open/floor/plating/polovich/kollo
	name = "Magic Floor"
	desc = "This is magically."
	icon_state = "kollo"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_METAL
	barefootstep = FOOTSTEP_METAL
	clawfootstep = FOOTSTEP_METAL
	heavyfootstep = FOOTSTEP_METAL

/turf/open/floor/plating/polovich/bronzefloor
	name = "Bronze Floor"
	desc = "This is expensive."
	icon_state = "bronzecool"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_METAL
	barefootstep = FOOTSTEP_METAL
	clawfootstep = FOOTSTEP_METAL
	heavyfootstep = FOOTSTEP_METAL

/turf/open/floor/plating/polovich/stonestone
	name = "Old Floor"
	desc = "This is brutal and ancient."
	icon_state = "rockfloor"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/warlocksticky
	name = "Evil Floor"
	desc = "This is evil and sticky."
	icon_state = "warlocksticky"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_MEAT
	barefootstep = FOOTSTEP_MEAT
	clawfootstep = FOOTSTEP_MEAT
	heavyfootstep = FOOTSTEP_MEAT
	slowdown = 2

/turf/open/floor/plating/polovich/warlocksticky/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/sea/gelatinea
	name = "Mesopelagic Gelatine"
	desc = "So pleasing to the eye."
	icon_state = "gelatinea"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_MEAT
	barefootstep = FOOTSTEP_MEAT
	clawfootstep = FOOTSTEP_MEAT
	heavyfootstep = FOOTSTEP_MEAT
	slowdown = 1

/turf/open/floor/plating/polovich/sea/gelatinea/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/slush
	name = "Slush Floor"
	desc = "This is so sad."
	icon_state = "muddymud"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_MEAT
	barefootstep = FOOTSTEP_MEAT
	clawfootstep = FOOTSTEP_MEAT
	heavyfootstep = FOOTSTEP_MEAT
	slowdown = 3

/turf/open/floor/plating/polovich/slush/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/slush/mud
	name = "Slush Floor"
	desc = "This is so sad."
	icon_state = "muddymudd"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_MEAT
	barefootstep = FOOTSTEP_MEAT
	clawfootstep = FOOTSTEP_MEAT
	heavyfootstep = FOOTSTEP_MEAT
	slowdown = 3

/turf/open/floor/plating/polovich/slush/mud/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/slush/mudd
	name = "Slush Floor"
	desc = "This is so sad."
	icon_state = "muddymuddd"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_MEAT
	barefootstep = FOOTSTEP_MEAT
	clawfootstep = FOOTSTEP_MEAT
	heavyfootstep = FOOTSTEP_MEAT
	slowdown = 3

/turf/open/floor/plating/polovich/slush/mudd/Initialize(mapload)
	. = ..()
	dir = rand(0,8)

/turf/open/floor/plating/polovich/evilevil
	name = "Evil Floor"
	desc = "This is evil and sticky."
	icon_state = "hryaz"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_MEAT
	barefootstep = FOOTSTEP_MEAT
	clawfootstep = FOOTSTEP_MEAT
	heavyfootstep = FOOTSTEP_MEAT
	slowdown = 2

/turf/open/floor/plating/polovich/evilevil/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/rockydarkness
	name = "Stone Floor"
	desc = "This is interesting and neutral."
	icon_state = "rockydarkness"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/rockyhorrr
	name = "Stone Floor"
	desc = "This is interesting and neutral."
	icon_state = "rockhorror"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/rockedar
	name = "Stone Floor"
	desc = "This is interesting and neutral."
	icon_state = "rockhorror2"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/rockedar/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/rockedarr
	name = "Stone Floor"
	desc = "This is interesting and neutral."
	icon_state = "rockydarkness2"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/rockedarr/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/rockedarrr
	name = "Stone Floor"
	desc = "This is interesting and neutral."
	icon_state = "rockydarkness3"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/rockedarrr/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/*
	mood_turf_mes = "<span class='bloody'>Is this floor - EVIL!</span>\n"
	mood_bonus_turf = -2
	slowdown = 1

/turf/open/floor/plating/polovich/stonestonestone
	name = "Stone Floor"
	desc = "This is interesting and good."
	icon_state = "pinkstonee"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE
*/
/turf/open/floor/plating/polovich/stonestonestone/two
	name = "Stone Floor"
	desc = "This is good."
	icon_state = "verycoolstone"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/stonestonestone/two/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/stonestonestone/three
	name = "Stone Floor"
	desc = "This is evil."
	icon_state = "evilstoneyy"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/stonestonestone/three/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/tilefloor
	name = "Blue Floor"
	desc = "Interesting..."
	icon_state = "tilefloor"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/stonestonestone/evilstoney
	name = "Stone Floor"
	desc = "This is evil."
	icon_state = "evilstoney"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/stonestonestone/evilstoney/Initialize(mapload)
	. = ..()
	dir = rand(0,8)

/turf/open/floor/plating/polovich/metalnoble
	name = "Metallic Floor"
	desc = "This is expensive."
	icon_state = "metalnoble1"
	icon = 'modular_pod/icons/turf/floors.dmi'
	attachment_holes = FALSE
	footstep = FOOTSTEP_METAL
	barefootstep = FOOTSTEP_METAL
	clawfootstep = FOOTSTEP_METAL
	heavyfootstep = FOOTSTEP_METAL

/turf/open/floor/plating/polovich/metalnoble/second
	name = "Metallic Floor"
	desc = "This is expensive."
	icon_state = "metalnoble2"
	icon = 'modular_pod/icons/turf/floors.dmi'
	attachment_holes = FALSE
	footstep = FOOTSTEP_METAL
	barefootstep = FOOTSTEP_METAL
	clawfootstep = FOOTSTEP_METAL
	heavyfootstep = FOOTSTEP_METAL

/turf/open/floor/plating/polovich/temnoo/experimental
	name = "Tendance Stone"
	icon_state = "verycoolstone"
	icon = 'modular_pod/icons/turf/floors.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE
//	var/flickering_floor = 0
	var/min_r = 0
	var/min_g = 0
	var/min_b = 0
	var/max_r = 255
	var/max_g = 255
	var/max_b = 255

/turf/open/floor/plating/polovich/temnoo/experimental/Initialize(mapload)
	color = rgb(rand(min_r, max_r), rand(min_g, max_g), rand(min_b, max_b))
/*
/turf/open/floor/plating/polovich/experimental/New()
	if(flickering_floor)
		var/list/col_filter_twothird = list(1,0,0,0, 0,0.68,0,0, 0,0,1,0, 0,0,0,1, 0,0,0,0)
		var/list/col_filter_light = list(1,0,0,0, 0,1,0,0, 0,0,1,0, 0,0,0,1, 0.1,0.2,0.2,0)
		var/list/col_filter_lightt = list(1,0,0,0, 0,1,0,0, 0,0,1,0, 0,0,0,1, 0.3,0.1,0.1,0)
		var/list/col_filter_half = list(1,0,0,0, 0,0.42,0,0, 0,0,1,0, 0,0,0,1, 0,0,0,0)
		var/list/col_filter_empty = list(1,0,0,0, 0,0,0,0, 0,0,1,0, 0,0,0,1, 0,0,0,0)
		add_filter("turfcolor", 10, color_matrix_filter(col_filter_twothird, FILTER_COLOR_HCY))
		add_filter("turflightness", 10, color_matrix_lightness(col_filter_light, 0.3))

	for(var/filter in src.get_filters("turfcolor"))
		animate(filter, loop = -1, color = col_filter_twothird, time = 4 SECONDS, easing = QUAD_EASING | EASE_IN, flags = ANIMATION_PARALLEL)
		animate(color = col_filter_twothird, time = 6 SECONDS, easing = QUAD_EASING | EASE_IN)
		animate(color = col_filter_half, time = 3 SECONDS, easing = QUAD_EASING | EASE_IN)
		animate(color = col_filter_empty, time = 2 SECONDS, easing = QUAD_EASING | EASE_IN)
		animate(color = col_filter_half, time = 24 SECONDS, easing = QUAD_EASING | EASE_IN)
		animate(color = col_filter_twothird, time = 12 SECONDS, easing = QUAD_EASING | EASE_IN)
	for(var/filter in src.get_filters("turflightness"))
		animate(filter, loop = -1, color = col_filter_light, time = 4 SECONDS, easing = QUAD_EASING | EASE_IN, flags = ANIMATION_PARALLEL)
		animate(color = col_filter_light, time = 6 SECONDS, easing = QUAD_EASING | EASE_IN)
		animate(color = col_filter_lightt, time = 3 SECONDS, easing = QUAD_EASING | EASE_IN)
		animate(color = col_filter_light, time = 13 SECONDS, easing = QUAD_EASING | EASE_IN)
*/
/*
			spawn while(1)
				set_light(3)
				sleep(3)
				set_light(2)
				sleep(3)
				set_light(3)
				sleep(3)
				set_light(2)
				sleep(3)
				set_light(3)
				sleep(3)
				set_light(4)
				sleep(3)
				set_light(2)
				sleep(3)
				set_light(3)
				sleep(3)
*/
