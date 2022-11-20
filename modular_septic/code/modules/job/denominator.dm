/datum/job/denominator
	title = ROLE_DENOMINATOR

/datum/job/denominator/shotgunner
	title = ROLE_DENOMINATOR_SHOTGUNNER

/datum/outfit/denominator
	name = "Denominator uniform"

	uniform = /obj/item/clothing/under/denomination
	suit = /obj/item/clothing/suit/armor/denominator
	backpack_contents = list(
		/obj/item/keycard/red = 1,
		/obj/item/melee/truncheon/black = 1,
		)
	l_pocket = /obj/item/simcard
	r_pocket = /obj/item/ammo_box/magazine/hksmg380
	id = /obj/item/cellphone
	head = /obj/item/clothing/head/denominator
	gloves = /obj/item/clothing/gloves/color/black
	shoes = /obj/item/clothing/shoes/jackboots

	suit_store = /obj/item/gun/ballistic/automatic/remis/smg/solitario/suppressed
	back = /obj/item/storage/backpack/satchel/itobe

/datum/outfit/denominator/shotgunner
	suit = /obj/item/clothing/suit/armor/denominator/shotgunner
	head = /obj/item/clothing/head/denominator/shotgunner
	suit_store = /obj/item/gun/ballistic/shotgun/denominator
	r_pocket = /obj/item/ammo_box/magazine/ammo_stack/shotgun/buckshot/loaded
