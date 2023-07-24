/obj/item/reagent_containers/food/drinks/soda_cans
	drop_sound = 'modular_septic/sound/effects/soda.ogg'

/obj/item/reagent_containers/food/drinks/mug/tea/Initialize()
	. = ..()
	AddComponent(/datum/component/temporary_pollution_emission, /datum/pollutant/food/tea, 5, 3 MINUTES)

/obj/item/reagent_containers/food/drinks/mug/coco/Initialize()
	. = ..()
	AddComponent(/datum/component/temporary_pollution_emission, /datum/pollutant/food/chocolate, 5, 3 MINUTES)

/obj/item/reagent_containers/food/drinks/soda_cans/coke
	name = "Cock Cola"
	desc = "Nothing like drinking a can of big, black cock!\n\
			<span class='warning'>WARNING: Do not shake!</span>"
	icon = 'modular_septic/icons/obj/items/soder.dmi'
	icon_state = "coke"
	list_reagents = list(/datum/reagent/consumable/coke = 30)
	foodtype = SUGAR

/obj/item/reagent_containers/food/drinks/soda_cans/coke/open_soda(mob/user)
	. = ..()
	AddComponent(/datum/component/temporary_pollution_emission, /datum/pollutant/cum, 5, 3 MINUTES)

/obj/item/reagent_containers/food/drinks/soda_cans/pepsi
	name = "Penis Cola"
	desc = "Penis Cola - Bigger and harder than the competition!"
	icon = 'modular_septic/icons/obj/items/soder.dmi'
	icon_state = "pepsi"
	list_reagents = list(/datum/reagent/consumable/pepsi = 30)
	foodtype = SUGAR

/obj/item/reagent_containers/food/drinks/soda_cans/pepsi/open_soda(mob/user)
	. = ..()
	AddComponent(/datum/component/temporary_pollution_emission, /datum/pollutant/cum, 5, 3 MINUTES)

/obj/item/reagent_containers/food/drinks/soda_cans/pepsi/diet
	name = "Diet Penis Cola"
	desc = "Replacing the sugar in the original drink with a concentrated \"Baphomet\" essence.\n\
			<span class='dead'>WARNING: Excessive consumption of this product is linked with:\n\
			Depression, anhedonia, autism, gynecomastia, tumor growth around the pubic region, erectile dysfunction, \
			premature ejaculation, retrograde ejaculation, wet dreams, infertility, elevated libido, compulsive sexual behavior, \
			post-coital tristesse, dyspareunia, vaginismus, vulvodynia, vulvar vestibulitis, peyronie's disease, priapism, \
			pelvic floor dysfunctions, urinary incontinence, pelvic organ prolapse, menopause, male periods.</span>"
	icon = 'modular_septic/icons/obj/items/soder.dmi'
	icon_state = "pepsi_diet"
	list_reagents = list(/datum/reagent/consumable/pepsi/diet = 30)
	foodtype = MEAT

/obj/item/reagent_containers/food/drinks/soda_cans/mug
	name = "Mug Root Beer"
	desc = "DUDE, THAT'S FUCKING HELLA MUG MOMENT DUDE!"
	icon = 'modular_septic/icons/obj/items/soder.dmi'
	icon_state = "mug"
	list_reagents = list(/datum/reagent/consumable/mug = 30)
	foodtype = SUGAR

/obj/item/reagent_containers/food/drinks/soda_cans/lean
	name = "Lean"
	desc = "w"
	icon = 'modular_septic/icons/obj/items/soder.dmi'
	icon_state = "lean"
	list_reagents = list(/datum/reagent/drug/lean = 30)
	foodtype = ALCOHOL
