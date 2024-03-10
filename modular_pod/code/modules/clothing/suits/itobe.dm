// ОДЁЖКА ВСЯКАЯ

/obj/item/clothing/under/codec/purp
	name = "Одёжка"
	desc = "Хорошего качества."
	icon = 'modular_pod/icons/obj/clothing/under/under.dmi'
	icon_state = "pur"
	worn_icon = 'modular_pod/icons/mob/clothing/under/under.dmi'
	worn_icon_state = "pur"
	lefthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_lefthand.dmi'
	righthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_righthand.dmi'
	inhand_icon_state = "soldat"
	armor_broken_sound = "light"
	armor_damaged_sound = "light"
	armor = list(MELEE = 2, BULLET = 3, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 5, ACID = 5, WOUND = 2)
	carry_weight = 300 GRAMS
	can_adjust = FALSE
	body_parts_covered = CHEST|VITALS|ARMS

// ШТАНИШКИ

/obj/item/clothing/pants/codec/purp
	name = "Штаны"
	desc = "Ну ведь, хорошее качество!"
	icon = 'modular_pod/icons/obj/clothing/pants.dmi'
	icon_state = "pur_pants"
	worn_icon = 'modular_pod/icons/mob/clothing/pants.dmi'
	worn_icon_state = "pur_pants"
	armor_broken_sound = "light"
	armor_damaged_sound = "light"
	max_integrity = 100
	integrity_failure = 0.1
	limb_integrity = 90
	repairable_by = /obj/item/stack/ballistic
	carry_weight = 400 GRAMS
	armor = list(MELEE = 3, BULLET = 3, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 5, ACID = 5, WOUND = 2)