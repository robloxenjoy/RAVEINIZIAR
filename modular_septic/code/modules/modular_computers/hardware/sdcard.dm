/obj/item/computer_hardware/hard_drive/portable/sdcard
	name = "\improper SD card"
	desc = "An inconspicuous SD card."
	icon = 'modular_septic/icons/obj/items/device.dmi'
	icon_state = "sdcard"
	worn_icon = 'modular_septic/icons/nothing.dmi'
	worn_icon_state = "nothing"
	slot_flags = ITEM_SLOT_EARS|ITEM_SLOT_MASK
	w_class = WEIGHT_CLASS_TINY
	carry_weight = 5 GRAMS
	var/list/starting_files

/obj/item/computer_hardware/hard_drive/portable/sdcard/Initialize(mapload)
	. = ..()
	for(var/file in starting_files)
		if(ispath(file, /datum/computer_file))
			var/datum/computer_file/new_file = new file()
			if(can_store_file(new_file))
				store_file(new_file)
			else
				qdel(new_file)

/obj/item/computer_hardware/hard_drive/portable/sdcard/uplink
	starting_files = list(/datum/computer_file/program/uplink)
