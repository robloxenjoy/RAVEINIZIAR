/obj/item/organ/bone/chest
	name = "ribcage"
	desc = "Despite all my rage, i'm just a rib in a cage."
	icon_state = "ribcage"
	base_icon_state = "ribcage"
	zone = BODY_ZONE_CHEST
	joint_name = "ribs"
	bone_flags = BONE_JOINTED|BONE_ENCASING
	wound_resistance = 10

/obj/item/organ/bone/chest/robot
	name = "cyborg ribcage"
	icon_state = "ribcage-c"
	base_icon_state = "ribcage-c"
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_SYNTHETIC|ORGAN_NOINFECTION|ORGAN_LIMB_SUPPORTER|ORGAN_INDESTRUCTIBLE|ORGAN_NO_VIOLENT_DAMAGE

/obj/item/organ/bone/chest/halber
	wound_resistance = 20
	maxHealth = 120
	high_threshold = 110
	medium_threshold = 100
	low_threshold = 90