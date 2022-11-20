/obj/item/organ/bone/mouth
	name = "mandible"
	desc = "Just how deep do you believe? Will you bite the hand that feeds?"
	icon_state = "mandible"
	base_icon_state = "mandible"
	zone = BODY_ZONE_PRECISE_MOUTH
	joint_name = "mandible"
	bone_flags = BONE_JOINTED

/obj/item/organ/bone/mouth/robot
	name = "cyborg mandible"
	icon_state = "mandible-c"
	base_icon_state = "mandible-c"
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_SYNTHETIC|ORGAN_NOINFECTION|ORGAN_LIMB_SUPPORTER|ORGAN_INDESTRUCTIBLE|ORGAN_NO_VIOLENT_DAMAGE
