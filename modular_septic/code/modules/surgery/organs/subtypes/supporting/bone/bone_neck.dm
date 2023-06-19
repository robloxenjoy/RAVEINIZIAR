/obj/item/organ/bone/neck
	name = "cervical spine"
	desc = "Woe to the spineless bastard that lost this."
	icon_state = "spine"
	base_icon_state = "spine"
	zone = BODY_ZONE_PRECISE_NECK
	joint_name = "cervical spine"
	bone_flags = BONE_JOINTED

/obj/item/organ/bone/neck/robot
	name = "cyborg spine"
	icon_state = "spine-c"
	base_icon_state = "spine-c"
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_SYNTHETIC|ORGAN_NOINFECTION|ORGAN_LIMB_SUPPORTER|ORGAN_INDESTRUCTIBLE|ORGAN_NO_VIOLENT_DAMAGE

/obj/item/organ/bone/neck/halber
	wound_resistance = 15
	maxHealth = 120
	high_threshold = 110
	medium_threshold = 100
	low_threshold = 90