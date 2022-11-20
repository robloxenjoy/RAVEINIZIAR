#define BLACKTAR_RETRACTED 1
#define BLACKTAR_RETRACTING 2
#define BLACKTAR_EXTENDED 3
#define BLACKTAR_EXTENDING 4

/obj/item/reagent_containers/hypospray/medipen/retractible/blacktar
	name = "Captagon medipen"
	desc = "Black Tar Heroin, highly dangerous on overdose. Injects using the left vial."
	icon = 'modular_septic/icons/obj/items/syringe.dmi'
	icon_state = "captagon"
	base_icon_state = "captagon"
	fill_icon_state = "captagon_vial1_"
	var/fill_icon_state_left = "captagon_vial2_"
	inhand_icon_state = "tbpen"
	volume = 75
	amount_per_transfer_from_this = 75
	possible_transfer_amounts = 75
	fill_icon_thresholds = list(10)
	stimulator_sound = 'modular_septic/sound/efn/captagon/heroin_injection.ogg'
	var/state = BLACKTAR_RETRACTED
	var/datum/reagents/reagent_holder_left
	var/datum/reagents/reagent_holder_right
	reagent_flags = OPENCONTAINER | TRANSPARENT
	list_reagents = list(/datum/reagent/medicine/blacktar = 50, /datum/reagent/medicine/c2/helbital = 25)
	var/list/list_reagents_left = list(/datum/reagent/medicine/blacktar = 50, /datum/reagent/medicine/c2/helbital = 25)

/obj/item/reagent_containers/hypospray/medipen/retractible/blacktar/Initialize(mapload, vol)
	. = ..()
	reagent_holder_right = reagents
	reagent_holder_left = new()
	reagent_holder_left.maximum_volume = reagent_holder_right.maximum_volume
	reagent_holder_left.flags = reagent_holder_right.flags

	reagent_holder_left.add_reagent_list(list_reagents_left)

/obj/item/reagent_containers/hypospray/medipen/retractible/blacktar/update_overlays()
	. = ..()
	if(!fill_icon_thresholds)
		return
	var/datum/reagents/inactive_reagents = reagent_holder_left
	if(reagents == reagent_holder_left)
		inactive_reagents = reagent_holder_right
	if(!inactive_reagents?.total_volume)
		return

	var/fill_name = fill_icon_state_left? fill_icon_state_left : icon_state
	var/mutable_appearance/filling = mutable_appearance('modular_septic/icons/obj/reagentfillings.dmi', "[fill_name][fill_icon_thresholds[1]]")

	var/percent = round((inactive_reagents.total_volume / volume) * 100)
	for(var/i in 1 to fill_icon_thresholds.len)
		var/threshold = fill_icon_thresholds[i]
		var/threshold_end = (i == fill_icon_thresholds.len)? INFINITY : fill_icon_thresholds[i+1]
		if(threshold <= percent && percent < threshold_end)
			filling.icon_state = "[fill_name][fill_icon_thresholds[i]]"

	filling.color = mix_color_from_reagents(inactive_reagents.reagent_list)
	. += filling

/obj/item/reagent_containers/hypospray/medipen/retractible/blacktar/update_icon_state()
	. = ..()
	icon_state = base_icon_state

/obj/item/reagent_containers/hypospray/medipen/retractible/blacktar/Destroy()
	QDEL_NULL(reagent_holder_left)
	QDEL_NULL(reagent_holder_right)
	. = ..()

/obj/item/reagent_containers/hypospray/medipen/retractible/blacktar/AltClick(mob/user)
	. = ..()
	if(reagent_holder_left != reagents)
		reagents = reagent_holder_left
	else
		reagents = reagent_holder_right
	to_chat(user, span_notice("Switched. I'm now using the [reagent_holder_left == reagents ? "left" : "right"] captagon vial."))
	playsound(src, 'modular_septic/sound/efn/captagon/heroin_switch.ogg', 65, FALSE)
	update_appearance(UPDATE_ICON)

/obj/item/reagent_containers/hypospray/medipen/retractible/blacktar/update_overlays()
	. = ..()
	switch(state)
		if(BLACKTAR_EXTENDED)
			. += "[base_icon_state]_needle"
		if(BLACKTAR_EXTENDING)
			. += "[base_icon_state]_needle_out"
		if(BLACKTAR_RETRACTING)
			. += "[base_icon_state]_needle_in"

/obj/item/reagent_containers/hypospray/medipen/retractible/blacktar/toggle_needle(mob/user)
	if(state == BLACKTAR_EXTENDING || state == BLACKTAR_RETRACTING)
		to_chat(user, span_notice("[fail_msg()]"))
		return
	if(state == BLACKTAR_RETRACTED)
		playsound(src, needle_out_sound, 65, FALSE)
		INVOKE_ASYNC(src, .proc/extend)
	else
		playsound(src, needle_in_sound, 65, FALSE)
		INVOKE_ASYNC(src, .proc/retract)

/obj/item/reagent_containers/hypospray/medipen/retractible/blacktar/proc/extend()
	state = BLACKTAR_EXTENDING
	update_appearance(UPDATE_ICON)
	sleep(3)
	state = BLACKTAR_EXTENDED
	retracted = FALSE
	update_appearance(UPDATE_ICON)

/obj/item/reagent_containers/hypospray/medipen/retractible/blacktar/proc/retract()
	state = BLACKTAR_RETRACTING
	update_appearance(UPDATE_ICON)
	sleep(3)
	state = BLACKTAR_RETRACTED
	retracted = TRUE
	update_appearance(UPDATE_ICON)

#undef BLACKTAR_RETRACTED
#undef BLACKTAR_RETRACTING
#undef BLACKTAR_EXTENDED
#undef BLACKTAR_EXTENDING
