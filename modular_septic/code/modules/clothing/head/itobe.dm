/obj/item/clothing/head/welding/itobe
	name = "engineering mask and helmet"
	desc = "A dual-layered ballistic mask made of plasteel and titanium. Its uniquely shaped yellow visor provides engineering readouts and other useful data. Not entirely useless for ballistic protection."
	icon = 'modular_septic/icons/obj/clothing/masks.dmi'
	icon_state = "engineer"
	worn_icon = 'modular_septic/icons/mob/clothing/mask.dmi'
	worn_icon_state = "engineer"
	lefthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_lefthand.dmi'
	righthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_righthand.dmi'
	inhand_icon_state = "engineermask"
	tint = null
	body_parts_covered = FACE|JAW|HEAD|EYES
	subarmor = list(SUBARMOR_FLAGS = NONE, \
                EDGE_PROTECTION = 21, \
                CRUSHING = 10, \
                CUTTING = 10, \
                PIERCING = 25, \
                IMPALING = 5, \
                LASER = 1, \
                ENERGY = 0, \
                BOMB = 30, \
                BIO = 0, \
                FIRE = 2, \
                ACID = 2, \
                MAGIC = 0, \
                WOUND = 0, \
                ORGAN = 0)

/obj/item/clothing/head/helmet/kelzad
	name = "\"Kelzad\" type V heavy tactical assault helmet"
	desc = "A legendary helmet inspired off of the helmet used by a mentally ill mistake of nature, the wonder child of even more degenerate scientist."
	icon = 'modular_septic/icons/obj/clothing/itobe.dmi'
	base_icon_state = "khelmet0"
	icon_state = "khelmet0"
	worn_icon = 'modular_septic/icons/mob/clothing/head.dmi'
	worn_icon_state = "khelmet"
	lefthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_lefthand.dmi'
	righthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_righthand.dmi'
	inhand_icon_state = "khelmet0"
	var/basestate = "khhelmet"
	var/on = TRUE
	max_integrity = 500
	integrity_failure = 0.04
	limb_integrity = 450
	actions_types = list(/datum/action/item_action/toggle_helmet_light)
	body_parts_covered = FACE|JAW|HEAD|EYES|NECK
	subarmor = list(SUBARMOR_FLAGS = NONE, \
                EDGE_PROTECTION = 75, \
                CRUSHING = 30, \
                CUTTING = 30, \
                PIERCING = 60, \
                IMPALING = 30, \
                LASER = 1, \
                ENERGY = 0, \
                BOMB = 60, \
                BIO = 0, \
                FIRE = 2, \
                ACID = 2, \
                MAGIC = 0, \
                WOUND = 0, \
                ORGAN = 0)
	carry_weight = 7 KILOGRAMS

/obj/item/clothing/head/helmet/kelzad/attack_self(mob/user)
	on = !on
	icon_state = "[basestate][1]"
	user.update_inv_head()

	update_action_buttons()
