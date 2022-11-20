//BLOOD
/datum/reagent/blood
	taste_description = "something metallic"

/datum/reagent/blood/expose_obj(obj/exposed_obj, reac_volume)
	. = ..()
	if(!.)
		exposed_obj.adjust_germ_level(GERM_PER_UNIT_BLOOD * reac_volume)
		if(istype(exposed_obj, /obj/effect/decal/cleanable/blood))
			var/obj/effect/decal/cleanable/blood/blood = exposed_obj
			blood.blood_state = BLOOD_STATE_HUMAN

/datum/reagent/blood/expose_turf(turf/exposed_turf, reac_volume)//splash the blood all over the place
	. = ..()
	if(!istype(exposed_turf))
		return
	if(reac_volume < 3)
		return

	var/obj/effect/decal/cleanable/blood/bloodsplatter = locate() in exposed_turf //find some blood here
	if(bloodsplatter)
		bloodsplatter.blood_state = BLOOD_STATE_HUMAN

//PISS
/datum/reagent/consumable/piss
	name = "Urine"
	description = "Liquid human waste. Disgusting."
	taste_description = "bad stale beer"
	reagent_state = LIQUID
	color = COLOR_YELLOW_PISS
	liquid_evaporation_rate = 7
	ph = 7.5

/datum/reagent/consumable/piss/expose_turf(turf/exposed_turf, reac_volume)
	. = ..()
	if(!. && isopenturf(exposed_turf))
		exposed_turf.pollute_turf(/datum/pollutant/urine, reac_volume)

/datum/reagent/consumable/piss/expose_atom(atom/exposed_atom, reac_volume)
	. = ..()
	if(!.)
		exposed_atom.adjust_germ_level(GERM_PER_UNIT_PISS * reac_volume)

//SHIT
/datum/reagent/consumable/shit
	data = list("viruses"=null,"blood_DNA"=null,"blood_type"=null,"resistances"=null,"trace_chem"=null,"mind"=null,"ckey"=null,"gender"=null,"real_name"=null,"cloneable"=null,"factions"=null,"quirks"=null)
	name = "Excrement"
	description = "Solid human waste. Disgusting."
	taste_description = "literal shit"
	reagent_state = SOLID
	color = COLOR_BROWN_SHIT
	liquid_evaporation_rate = 3
	ph = 6.6

/datum/reagent/consumable/shit/on_new(list/data)
	if(istype(data))
		SetViruses(src, data)

/datum/reagent/consumable/shit/expose_atom(atom/exposed_atom, reac_volume)
	. = ..()
	if(!.)
		exposed_atom.adjust_germ_level(GERM_PER_UNIT_SHIT * reac_volume)

/datum/reagent/consumable/shit/expose_obj(obj/exposed_obj, reac_volume)
	. = ..()
	if(!.)
		exposed_obj.adjust_germ_level(GERM_PER_UNIT_BLOOD * reac_volume)
		if(istype(exposed_obj, /obj/effect/decal/cleanable/blood))
			var/obj/effect/decal/cleanable/blood/blood = exposed_obj
			blood.blood_state = BLOOD_STATE_SHIT

/datum/reagent/consumable/shit/expose_mob(mob/living/exposed_mob, methods, reac_volume, show_message, touch_protection)
	. = ..()
	if(LAZYACCESS(data, "viruses"))
		for(var/thing in data["viruses"])
			var/datum/disease/strain = thing
			if((strain.spread_flags & DISEASE_SPREAD_SPECIAL) || (strain.spread_flags & DISEASE_SPREAD_NON_CONTAGIOUS))
				continue
			if((methods & (TOUCH|VAPOR)) && (strain.spread_flags & DISEASE_SPREAD_CONTACT_FLUIDS))
				exposed_mob.ContactContractDisease(strain)
			else //ingest, patch or inject
				exposed_mob.ForceContractDisease(strain)

/datum/reagent/consumable/shit/expose_turf(turf/exposed_turf, reac_volume)//splash the blood all over the place
	. = ..()
	if(!istype(exposed_turf))
		return
	if(reac_volume < 3)
		return

	var/obj/effect/decal/cleanable/blood/shitsplatter = locate(/obj/effect/decal/cleanable/blood) in exposed_turf
	if(!shitsplatter)
		shitsplatter = new /obj/effect/decal/cleanable/blood/shit(exposed_turf)
	if(LAZYACCESS(data, "blood_DNA"))
		shitsplatter.add_shit_DNA(list(data["blood_DNA"] = data["blood_type"]))
		shitsplatter.blood_state = BLOOD_STATE_SHIT

//CUM
/datum/reagent/consumable/cum
	name = "Semen"
	description = "Baby batter..."
	taste_description = "something salty"
	data = list("viruses"=null,"blood_DNA"=null,"blood_type"=null,"resistances"=null,"trace_chem"=null,"mind"=null,"ckey"=null,"gender"=null,"real_name"=null,"cloneable"=null,"factions"=null,"quirks"=null)
	reagent_state = LIQUID
	color = COLOR_WHITE_CUM
	liquid_evaporation_rate = 3
	ph = 7.2

/datum/reagent/consumable/cum/on_new(list/data)
	if(istype(data))
		SetViruses(src, data)

/datum/reagent/consumable/cum/expose_obj(obj/exposed_obj, reac_volume)
	. = ..()
	if(!.)
		exposed_obj.adjust_germ_level(GERM_PER_UNIT_SHIT * reac_volume)
		exposed_obj.add_cum_DNA(list(data["blood_DNA"] = data["blood_type"]))

/datum/reagent/consumable/cum/expose_mob(mob/living/exposed_mob, methods, reac_volume, show_message, touch_protection)
	. = ..()
	if(LAZYACCESS(data, "viruses"))
		for(var/thing in data["viruses"])
			var/datum/disease/strain = thing
			if((strain.spread_flags & DISEASE_SPREAD_SPECIAL) || (strain.spread_flags & DISEASE_SPREAD_NON_CONTAGIOUS))
				continue
			if((methods & (TOUCH|VAPOR)) && (strain.spread_flags & DISEASE_SPREAD_CONTACT_FLUIDS))
				exposed_mob.ContactContractDisease(strain)
			else //ingest, patch or inject
				exposed_mob.ForceContractDisease(strain)

/datum/reagent/consumable/cum/expose_turf(turf/exposed_turf, reac_volume)//splash the blood all over the place
	. = ..()
	if(!istype(exposed_turf))
		return
	if(reac_volume < 3)
		return

	var/obj/effect/decal/cleanable/blood/cumsplatter = locate(/obj/effect/decal/cleanable/blood) in exposed_turf
	exposed_turf.pollute_turf(/datum/pollutant/cum, reac_volume)
	if(!cumsplatter)
		cumsplatter = new /obj/effect/decal/cleanable/blood/cum(exposed_turf)
	if(LAZYACCESS(data, "blood_DNA"))
		cumsplatter.add_cum_DNA(list(data["blood_DNA"] = data["blood_type"]))

//FEMCUM
/datum/reagent/consumable/femcum
	name = "Squirt"
	description = "I can't believe it's not urine!"
	taste_description = "something slightly sweet"
	data = list("viruses"=null,"blood_DNA"=null,"blood_type"=null,"resistances"=null,"trace_chem"=null,"mind"=null,"ckey"=null,"gender"=null,"real_name"=null,"cloneable"=null,"factions"=null,"quirks"=null)
	taste_mult = 0.5
	reagent_state = LIQUID
	color = COLOR_WHITE_FEMCUM
	liquid_evaporation_rate = 3
	ph = 7.2

/datum/reagent/consumable/femcum/on_new(list/data)
	if(istype(data))
		SetViruses(src, data)

/datum/reagent/consumable/femcum/expose_obj(obj/exposed_obj, reac_volume)
	. = ..()
	if(!.)
		exposed_obj.adjust_germ_level(GERM_PER_UNIT_SHIT * reac_volume)
		exposed_obj.add_femcum_DNA(list(data["blood_DNA"] = data["blood_type"]))

/datum/reagent/consumable/femcum/expose_mob(mob/living/exposed_mob, methods, reac_volume, show_message, touch_protection)
	. = ..()
	if(LAZYACCESS(data, "viruses"))
		for(var/thing in data["viruses"])
			var/datum/disease/strain = thing
			if((strain.spread_flags & DISEASE_SPREAD_SPECIAL) || (strain.spread_flags & DISEASE_SPREAD_NON_CONTAGIOUS))
				continue
			if((methods & (TOUCH|VAPOR)) && (strain.spread_flags & DISEASE_SPREAD_CONTACT_FLUIDS))
				exposed_mob.ContactContractDisease(strain)
			else //ingest, patch or inject
				exposed_mob.ForceContractDisease(strain)

/datum/reagent/consumable/femcum/expose_turf(turf/exposed_turf, reac_volume)//splash the blood all over the place
	. = ..()
	if(!istype(exposed_turf))
		return
	if(reac_volume < 3)
		return

	var/obj/effect/decal/cleanable/blood/femcumsplatter = locate(/obj/effect/decal/cleanable/blood) in exposed_turf
	if(!femcumsplatter)
		femcumsplatter = new /obj/effect/decal/cleanable/blood/femcum(exposed_turf)
	if(LAZYACCESS(data, "blood_DNA"))
		femcumsplatter.add_femcum_DNA(list(data["blood_DNA"] = data["blood_type"]))
