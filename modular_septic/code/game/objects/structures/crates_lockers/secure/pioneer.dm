/obj/structure/closet/secure_closet/pioneer
	name = "pioneer's equipment"
	icon_state = "mining"
	req_access = list(ACCESS_MINING)

/obj/structure/closet/secure_closet/pioneer/PopulateContents()
	new /obj/item/stack/sheet/mineral/sandbags(src, 5)
	new /obj/item/storage/box/emptysandbags(src)
	new /obj/item/shovel(src)
	new /obj/item/pickaxe(src)
	new /obj/item/pickaxe/mini(src)
	new /obj/item/radio/headset/headset_eng(src)
	new /obj/item/flashlight/seclite(src)
	new /obj/item/storage/bag/plants(src)
	new /obj/item/storage/bag/ore(src)
	new /obj/item/t_scanner/adv_mining_scanner/lesser(src)
	new /obj/item/clothing/glasses/meson(src)
	new /obj/item/gun/energy/kinetic_accelerator(src)
	new /obj/item/storage/belt/military/army/pioneer(src)
