/datum/reagent/toxin/plasma
	accelerant_quality = 10

//oof ouch
/datum/reagent/toxin/piranha_solution
	name = "Piranha Solution"
	description = "A very acidic, very dangerous substance. Do not swallow."
	color = "#5dffae6c"
	creation_purity = REAGENT_STANDARD_PURITY
	purity = REAGENT_STANDARD_PURITY
	toxpwr = 1
	taste_description = "searing pain"
	taste_mult = 2
	ph = 1
	accelerant_quality = 0
	chemical_flags = REAGENT_DEAD_PROCESS | REAGENT_DONOTSPLIT

/datum/reagent/toxin/piranha_solution/expose_mob(mob/living/exposed_mob, methods, reac_volume, show_message, touch_protection)
	. = ..()
	if(methods & TOUCH)
		exposed_mob.take_bodypart_damage(0, reac_volume)

/datum/reagent/toxin/piranha_solution/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	. = ..()
	M.take_bodypart_damage(0, 2.5 * delta_time)

/datum/reagent/toxin/piranha_solution/on_mob_dead(mob/living/carbon/C, delta_time)
	. = ..()
	C.take_bodypart_damage(0, 2.5 * delta_time)

//armor oil real
/datum/reagent/toxin/armor_oil
	name = "Armor Oil"
	description = "Oil widely used in the production of various types of armors. \
				Despite conspiracy theories, it is not safe for human consumption."
	color = "#180600"
	creation_purity = REAGENT_STANDARD_PURITY
	purity = REAGENT_STANDARD_PURITY
	toxpwr = 2
	//the forbidden guloseima
	taste_description = "thick soy sauce"
	taste_mult = 2
	ph = 8
	accelerant_quality = 10

/datum/reagent/toxin/armor_oil/expose_obj(obj/exposed_obj, reac_volume)
	. = ..()
	if(istype(exposed_obj, /obj/item/stack/medical/suture) && !istype(exposed_obj, /obj/item/stack/medical/suture/ballistic))
		var/obj/item/stack/medical/suture/not_black_tar = exposed_obj
		var/amount = min(not_black_tar.amount, FLOOR(reac_volume/10, 1))
		if(amount >= 1)
			new /obj/item/stack/medical/suture/ballistic(not_black_tar.loc, amount)
			not_black_tar.use(amount)

/datum/reagent/toxin/armor_oil/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	. = ..()
	M.adjustOrganLoss(ORGAN_SLOT_STOMACH, rand(1, 2) * REM * normalise_creation_purity() * delta_time)
