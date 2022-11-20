/obj/item/reagent_containers/hypospray/medipen
	var/stimulator_sound = 'modular_septic/sound/effects/stimulator.wav'

/obj/item/reagent_containers/hypospray/medipen/retractible
	var/needle_out_sound = 'modular_septic/sound/efn/captagon/heroin_out.ogg'
	var/needle_in_sound = 'modular_septic/sound/efn/captagon/heroin_in.ogg'
	var/retracted = TRUE

/obj/item/reagent_containers/hypospray/medipen/retractible/attack_self(mob/user)
	toggle_needle(user)

/obj/item/reagent_containers/hypospray/medipen/retractible/attack(mob/living/affected_mob, mob/user)
	if(retracted)
		to_chat(user, span_warning("The needle on the [src] Isn't out."))
		return
	. = ..()

/obj/item/reagent_containers/hypospray/medipen/retractible/proc/toggle_needle(mob/user)
	if(retracted)
		playsound(src, needle_out_sound, 65, FALSE)
	else
		playsound(src, needle_in_sound, 65, FALSE)
	var/random_adverb = pick("jaggedly", "haphazardly", "weirdly", "oddly", "funnily", "cutely")
	to_chat(user, span_notice("The needle [retracted ? "sticks out [random_adverb]" : "retracts"]"))
	retracted = !retracted

/obj/item/reagent_containers/hypospray/medipen/antibiotic
	name = "Antibiotic medipen"
	desc = "Spaceacillin medipen, used to clear up infections, help with sickness, etc. Contains 4 indevidual uses."
	icon_state = "atropen"
	inhand_icon_state = "atropen"
	base_icon_state = "atropen"
	volume = 20
	amount_per_transfer_from_this = 5
	list_reagents = list(/datum/reagent/medicine/spaceacillin = 20)


/obj/item/reagent_containers/hypospray/medipen/inject(mob/living/affected_mob, mob/user)
	. = ..()
	if(.)
		//reagents.maximum_volume = 0 //Does not make them useless afterwards, fuck you
		reagents.flags = NONE
		playsound(src, stimulator_sound, 65, TRUE)
		update_appearance()
