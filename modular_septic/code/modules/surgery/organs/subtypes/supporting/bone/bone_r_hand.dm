/obj/item/organ/bone/r_hand
	name = "right carpals"
	desc = "Carpal tunnel syndrome can't happen if you have no carpal bones."
	icon_state = "right_carpals"
	base_icon_state = "right_carpals"
	zone = BODY_ZONE_PRECISE_R_HAND
	joint_name = "right wrist"
	bone_flags = BONE_JOINTED
	gender = PLURAL

/obj/item/organ/bone/r_hand/robot
	name = "cyborg right carpals"
	icon_state = "right_carpals-c"
	base_icon_state = "right_carpals-c"
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_SYNTHETIC|ORGAN_NOINFECTION|ORGAN_LIMB_SUPPORTER|ORGAN_INDESTRUCTIBLE|ORGAN_NO_VIOLENT_DAMAGE
