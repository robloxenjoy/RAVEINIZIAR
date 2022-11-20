/obj/item/clothing/suit/armor/denominator
	name = "\"Loucura\" type IV armored denominator suit"
	desc = "A type IV full body armored suit for protection against unknown forces, fire, and high-powered energy firearms."
	icon = 'modular_septic/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_septic/icons/mob/clothing/suit.dmi'
	lefthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_lefthand.dmi'
	righthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_righthand.dmi'
	icon_state = "deno"
	worn_icon_state = "deno"
	armor_broken_sound = "heavy"
	armor_damaged_sound = "heavy"
	max_integrity = 600
	integrity_failure = 0.05
	limb_integrity = 500
	repairable_by = /obj/item/stack/ballistic
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
	carry_weight = 8 KILOGRAMS
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|VITALS

/obj/item/clothing/suit/armor/denominator/shotgunner
	name = "\"Loucura\" type IV armored shotgunner denominator suit"
	desc = "A type IV full body armored suit for protection against unknown forces, fire, and high-powered energy firearms. This belongs to the shotgunner squad."
	icon_state = "deno_shotgunner"
	worn_icon_state = "deno_shotgunner"
