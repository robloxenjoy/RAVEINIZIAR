/obj/item/match
	carry_weight = 50 GRAMS

/obj/item/match/matchignite()
	if(lit || burnt)
		return

	playsound(src, 'sound/items/match_strike.ogg', 15, TRUE)
	lit = TRUE
	var/turf/my_turf = get_turf(src)
	if(istype(my_turf))
		my_turf.pollute_turf(/datum/pollutant/sulphur, 5)
	icon_state = "match_lit"
	damtype = BURN
	force = 3
	hitsound = 'sound/items/welder.ogg'
	inhand_icon_state = "cigon"
	name = "lit [initial(name)]"
	desc = "A [initial(name)]. This one is lit."
	attack_verb_continuous = string_list(list("burns", "singes"))
	attack_verb_simple = string_list(list("burn", "singe"))
	START_PROCESSING(SSobj, src)
	update_appearance()

/obj/item/clothing/mask/cigarette
	name = "cancer stick"
	desc = "Now with 99% less asbestos. Still not very safe for human consumption."
	lung_harm = 0
	carry_weight = 50 GRAMS
	/// What type of pollution does this produce on smoking, changed to weed pollution sometimes
	var/pollution_type = /datum/pollutant/smoke

/obj/item/clothing/mask/cigarette/light(flavor_text = null)
	if(lit)
		return
	if(!(flags_1 & INITIALIZED_1))
		icon_state = icon_on
		inhand_icon_state = icon_on
		return

	lit = TRUE
	name = "lit [name]"
	attack_verb_continuous = string_list(list("burns", "singes"))
	attack_verb_simple = string_list(list("burn", "singe"))
	hitsound = 'sound/items/welder.ogg'
	damtype = BURN
	force = 4
	if(reagents.get_reagent_amount(/datum/reagent/toxin/plasma)) // the plasma explodes when exposed to fire
		var/datum/effect_system/reagents_explosion/e = new()
		e.set_up(round(reagents.get_reagent_amount(/datum/reagent/toxin/plasma) / 2.5, 1), get_turf(src), 0, 0)
		e.start()
		qdel(src)
		return
	if(reagents.get_reagent_amount(/datum/reagent/fuel)) // the fuel explodes, too, but much less violently
		var/datum/effect_system/reagents_explosion/e = new()
		e.set_up(round(reagents.get_reagent_amount(/datum/reagent/fuel) / 5, 1), get_turf(src), 0, 0)
		e.start()
		qdel(src)
		return
	// Setting the puffed pollutant to cannabis if we're smoking the space drugs reagent(obtained from cannabis)
	if(reagents.has_reagent(/datum/reagent/drug/space_drugs))
		pollution_type = /datum/pollutant/smoke/cannabis
	// allowing reagents to react after being lit
	reagents.flags &= ~(NO_REACT)
	reagents.handle_reactions()
	icon_state = icon_on
	inhand_icon_state = icon_on
	if(flavor_text)
		var/turf/T = get_turf(src)
		T.visible_message(flavor_text)
	START_PROCESSING(SSobj, src)

	//can't think of any other way to update the overlays :<
	if(ismob(loc))
		var/mob/M = loc
		M.update_inv_wear_mask()
		M.update_inv_hands()

/obj/item/clothing/mask/cigarette/process(delta_time)
	var/turf/location = get_turf(src)
	var/mob/living/M = loc
	if(isliving(loc))
		M.IgniteMob()
	if(!reagents.has_reagent(/datum/reagent/oxygen)) //cigarettes need oxygen
		var/datum/gas_mixture/air = return_air()
		if(!air || !air.has_gas(/datum/gas/oxygen, 1)) //or oxygen on a tile to burn
			extinguish()
			return
	if(pollution_type)
		location.pollute_turf(pollution_type, 10)
	smoketime -= delta_time * (1 SECONDS)
	if(smoketime <= 0)
		new type_butt(location)
		if(ismob(loc))
			to_chat(M, span_notice("Your [name] goes out."))
		qdel(src)
		return

	open_flame(heat)
	if((reagents?.total_volume) && COOLDOWN_FINISHED(src, drag_cooldown))
		COOLDOWN_START(src, drag_cooldown, dragtime)
		handle_reagents()

/obj/item/clothing/mask/cigarette/space_cigarette
	name = "asbestos stick"
	desc = "A very low quality cigarette. Smoking this can't do you any good."
	lung_harm = 1

/obj/item/clothing/mask/cigarette/rollie
	name = "cancer roll"
	desc = "A roll of dried plant matter wrapped in thin paper. About as cancerous as the factory-made stuff."

/obj/item/clothing/mask/cigarette/candy
	name = "\improper little Timmy's first carcinoma"

/obj/item/clothing/mask/cigarette/cigar
	name = "cancer cylinder"
	lung_harm = 0

/obj/item/clothing/mask/cigarette/cigar/cohiba
	name = "\improper Cohiba Robusto cancer cylinder"

/obj/item/clothing/mask/cigarette/cigar/havana
	name = "premium Havanian carcinoma"

/obj/item/clothing/mask/vape/process(delta_time)
	var/mob/living/M = loc

	if(isliving(loc))
		M.IgniteMob()

	if(!reagents.total_volume)
		if(ismob(loc))
			to_chat(M, span_warning("[src] is empty!"))
			STOP_PROCESSING(SSobj, src)
			//it's reusable so it won't unequip when empty
		return

	if(!COOLDOWN_FINISHED(src, drag_cooldown))
		return

	//Time to start puffing those fat vapes, yo.
	var/turf/my_turf = get_turf(src)
	if(istype(my_turf))
		my_turf.pollute_turf(/datum/pollutant/smoke/vape, 10)
	COOLDOWN_START(src, drag_cooldown, dragtime)
	if(obj_flags & EMAGGED)
		var/datum/effect_system/smoke_spread/chem/smoke_machine/s = new
		s.set_up(reagents, 4, 24, loc)
		s.start()
		if(prob(5)) //small chance for the vape to break and deal damage if it's emagged
			playsound(get_turf(src), 'sound/effects/pop_expl.ogg', 50, FALSE)
			M.apply_damage(20, BURN, BODY_ZONE_HEAD)
			M.Paralyze(300)
			var/datum/effect_system/spark_spread/sp = new /datum/effect_system/spark_spread
			sp.set_up(5, 1, src)
			sp.start()
			to_chat(M, span_userdanger("[src] suddenly explodes in your mouth!"))
			qdel(src)
			return
	else if(super)
		var/datum/effect_system/smoke_spread/chem/smoke_machine/s = new
		s.set_up(reagents, 1, 24, loc)
		s.start()

	handle_reagents()
