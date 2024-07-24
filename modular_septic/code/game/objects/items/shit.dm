/obj/item/shit
	name = "Shit"
	desc = "Disgusting."
	icon = 'modular_septic/icons/obj/items/shit.dmi'
	icon_state = "poo1"
	base_icon_state = "poo"
	germ_level = GERM_LEVEL_MAXIMUM
	//crewmates be putting out massive turds
	carry_weight = 85 GRAMS
	var/static/list/crossed_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_entered),
	)

/obj/item/shit/Initialize()
	. = ..()
	icon_state = "[base_icon_state][rand(1, 6)]"
	AddComponent(/datum/component/edible, \
		initial_reagents = list(/datum/reagent/consumable/shit = 15), \
		foodtypes = TOXIC|GROSS|SEWAGE, \
		volume = 115, \
		after_eat = CALLBACK(src, PROC_REF(on_eat_from)))
	AddElement(/datum/element/connect_loc, crossed_connections)
	AddElement(/datum/element/pollution_emitter, /datum/pollutant/shit, 30)

/obj/item/shit/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	if(reagents.total_volume >= 3)
		var/modifier = min(10/reagents.total_volume, 1)
		reagents.expose(hit_atom, TOUCH, modifier)
		if(isturf(hit_atom))
			for(var/obj/shitted in hit_atom)
				reagents.expose(shitted, TOUCH, modifier)
		reagents.remove_any(modifier*reagents.total_volume)

/obj/item/shit/proc/on_eat_from(mob/living/carbon/eater, mob/living/feeder)
	//contract bad
/*
	var/datum/disease/advance/random/random_dysentery = new()
	var/static/list/funny_names
	if(!funny_names)
		funny_names = list("Ligma", "Sugma", "Colon Cancer", "Dysentery", "Hemorrhoids", "Taeniasis", "Anal Prolapse", "Megacolon", "Acidic Reflux", "Constipation", "Anal Fistula", "Spastic Colon", "Indigestion", "Peptic Ulcers", "Gastritis")
	random_dysentery.name = pick(funny_names)
	random_dysentery.form = "Parasitic Infection"
	random_dysentery.agent = "Parasites"
	random_dysentery.spread_text = "Human Waste"
	random_dysentery.hopelessness = "Considerable"
	random_dysentery.severity = DISEASE_SEVERITY_HARMFUL
	random_dysentery.try_infect(eater)
*/
	//shit on face, yum
	if(ishuman(eater))
		eater.AddComponent(/datum/component/creamed/shit)
		eater.client?.prefs.adjust_bobux(2, "<span class='bobux'>I took a bite of shit! +2 Kaotiks!</span>")
		eater.flash_kaosgain()
		if(prob(5))
			eater.gain_extra_effort(1, FALSE)

/obj/item/shit/proc/on_entered(datum/source, atom/movable/movable)
	SIGNAL_HANDLER

	var/turf/shitted_on = get_turf(src)
	if(!movable.has_gravity(shitted_on))
		return
	var/obj/effect/decal/cleanable/blood/shitty_decal = locate(/obj/effect/decal/cleanable/blood) in shitted_on
	if(shitty_decal?.blood_state == BLOOD_STATE_SHIT)
		playsound(src, 'modular_septic/sound/effects/step_on_shit.ogg',  60, 0, 0)
		return
	if(reagents.total_volume < 2)
		return
	var/modifier = min(10/reagents.total_volume, 1)
	reagents.expose(shitted_on, TOUCH, modifier)
	for(var/obj/shitted_item in get_turf(src))
		reagents.expose(shitted_item, TOUCH, modifier)
	reagents.remove_any(modifier*reagents.total_volume)
	playsound(src, 'modular_septic/sound/effects/step_on_shit.ogg',  60, 0, 0)
	for(var/obj/effect/decal/cleanable/blood/splatter in shitted_on)
		splatter.on_entered(splatter, movable)

/obj/item/halyabegg
	name = "Halyab Egg"
	desc = "So beautiful!"
	icon = 'icons/obj/food/food.dmi'
	icon_state = "halyabegg"
	carry_weight = 700 GRAMS

/obj/item/halyabegg/attack_self(mob/living/carbon/user, modifiers)
	. = ..()
	if(!istype(user, /mob/living/carbon/human/species/weakwillet))
		return
	user.visible_message(span_notice("[user] starts swallow [src]!"),span_notice("You begin to swallow [src]!"), span_hear("You hear the sound of swallow."))
	if(do_after(user, 5 SECONDS, target = src))
		to_chat(user, span_notice("You finish swallowing [src]."))
		user.client?.prefs?.adjust_bobux(50, "<span class='bobux'>HALYAB EGG! +50 ультр!</span>")
		playsound(get_turf(src), 'modular_pod/sound/eff/eat.ogg', 100 , FALSE, FALSE)
		SSdroning.kill_droning(user.client)
		user.stop_sound_channel(CHANNEL_HEARTBEAT)
		var/mob/dead/new_player/M = new /mob/dead/new_player()
		M.ckey = user.ckey
		qdel(src)

/obj/item/halyabegg/attack_jaw(mob/living/carbon/user, modifiers)
	. = ..()
	if(!istype(user, /mob/living/carbon/human/species/weakwillet))
		return
	var/obj/item/bodypart/check_jaw = user.get_bodypart(BODY_ZONE_PRECISE_MOUTH)
	if(!check_jaw)
		to_chat(user, span_notice("А, у меня же нет челюсти..."))
		return
	if(check_jaw?.bodypart_disabled)
		to_chat(user, span_warning("Моя [check_jaw.name] не в состоянии быть использована."))
		return
	user.visible_message(span_notice("[user] начинать проглатывать [src]!"),span_notice("Я начинаю проглатывать [src]!"), span_hear("Я слышу звук проглатывания."))
	if(do_after(user, 5 SECONDS, target = src))
		to_chat(user, span_notice("You finish swallowing [src]."))
		user.client?.prefs?.adjust_bobux(50, "<span class='bobux'>HALYAB EGG! +50 ультр!</span>")
		playsound(get_turf(src), 'modular_pod/sound/eff/eat.ogg', 100 , FALSE, FALSE)
		SSdroning.kill_droning(user.client)
		user.stop_sound_channel(CHANNEL_HEARTBEAT)
		var/mob/dead/new_player/M = new /mob/dead/new_player()
		M.ckey = user.ckey
		qdel(src)

/*
/obj/item/halyabegg/Initialize()
	. = ..()
	AddComponent(/datum/component/edible, \
		initial_reagents = list(/datum/reagent/consumable/shit = 10), \
		foodtypes = BREAKFAST, \
		volume = 10, \
		after_eat = CALLBACK(src, .proc/on_eat_fromm))

/obj/item/halyabegg/proc/on_eat_fromm(mob/living/carbon/eater, mob/living/feeder)
	if(!istype(eater, /mob/living/carbon/human/species/weakwillet))
		return
	if(eater.can_heartattack())
		eater.set_heartattack(TRUE)
//		eater.send_naxyu()
		SSdroning.kill_droning(eater.client)
		eater.stop_sound_channel(CHANNEL_HEARTBEAT)
		var/mob/dead/new_player/M = new /mob/dead/new_player()
		M.ckey = eater.ckey
*/
