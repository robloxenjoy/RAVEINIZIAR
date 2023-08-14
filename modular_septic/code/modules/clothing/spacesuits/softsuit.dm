// IRL space suits weigh SO MUCH you would not believe, i am going to be kind
/obj/item/clothing/head/helmet/space
	carry_weight = 5 KILOGRAMS

/obj/item/clothing/suit/space
	carry_weight = 20 KILOGRAMS

/obj/item/clothing/suit/space/stray
	name = "PINKER Armor"
	desc = "CRAZY!"
	icon = 'modular_pod/icons/obj/clothing/suits.dmi'
	icon_state = "pinker"
	worn_icon = 'modular_pod/icons/mob/clothing/suit.dmi'
	worn_icon_state = "pinker"
	armor_broken_sound = "heavy"
	armor_damaged_sound = "heavy"
	max_integrity = 500
	integrity_failure = 0.05
	limb_integrity = 420
	repairable_by = /obj/item/stack/ballistic/plate
	body_parts_covered = CHEST|GROIN|LEGS||ARMS|NECK|VITALS
	subarmor = list(SUBARMOR_FLAGS = NONE, \
                EDGE_PROTECTION = 75, \
                CRUSHING = 28, \
                CUTTING = 28, \
                PIERCING = 50, \
                IMPALING = 14, \
                LASER = 1, \
                ENERGY = 0, \
                BOMB = 13, \
                BIO = 100, \
                FIRE = 2, \
                ACID = 2, \
                MAGIC = 0, \
                WOUND = 0, \
                ORGAN = 0)

/obj/item/clothing/suit/space/stray/Initialize(mapload)
	. = ..()
	LoadComponent(/datum/component/shuffling, list(
				'modular_septic/sound/armor/heavygear_stereo1.ogg'=1,
				'modular_septic/sound/armor/heavygear_stereo2.ogg'=1,
				'modular_septic/sound/armor/heavygear_stereo3.ogg'=1), 70, falloff_exponent = 20)

/obj/item/clothing/head/helmet/space/stray
	name = "PINKER Helmet"
	desc = "CRAZY!"
	icon = 'modular_pod/icons/obj/clothing/hats.dmi'
	icon_state = "sploinky"
	worn_icon = 'modular_pod/icons/mob/clothing/head.dmi'
	worn_icon_state = "sploinky"
	armor_broken_sound = "heavy"
	armor_damaged_sound = "heavy"
	max_integrity = 500
	integrity_failure = 0.05
	limb_integrity = 420
	body_parts_covered = FACE|JAW|HEAD|EYES
	repairable_by = /obj/item/stack/ballistic/plate
	subarmor = list(SUBARMOR_FLAGS = NONE, \
                EDGE_PROTECTION = 75, \
                CRUSHING = 28, \
                CUTTING = 28, \
                PIERCING = 50, \
                IMPALING = 14, \
                LASER = 1, \
                ENERGY = 0, \
                BOMB = 13, \
                BIO = 100, \
                FIRE = 2, \
                ACID = 2, \
                MAGIC = 0, \
                WOUND = 0, \
                ORGAN = 0)
