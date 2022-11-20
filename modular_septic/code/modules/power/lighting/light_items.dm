/obj/item/light
	icon = 'modular_septic/icons/obj/items/lighting.dmi'

/obj/item/light/on_entered(datum/source, mob/living/entered)
	if(!istype(entered) || (entered.movement_type & FLYING|FLOATING) || entered.buckled)
		return

	playsound(src, pick('modular_septic/sound/effects/glass1.wav', 'modular_septic/sound/effects/glass2.wav'), HAS_TRAIT(entered, TRAIT_LIGHT_STEP) ? 30 : 50, TRUE)
	if((status == LIGHT_BURNED) || (status == LIGHT_OK))
		shatter()

/obj/item/light/tube
	icon_state = "tube"
	base_icon_state = "tube"

/obj/item/light/bulb
	icon_state = "bulb"
	base_icon_state = "bulb"
