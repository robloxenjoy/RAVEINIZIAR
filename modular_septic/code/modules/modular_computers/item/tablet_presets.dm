/obj/item/modular_computer/tablet/preset/cheap/Initialize(mapload)
	. = ..()
	install_component(new /obj/item/computer_hardware/card_slot)
