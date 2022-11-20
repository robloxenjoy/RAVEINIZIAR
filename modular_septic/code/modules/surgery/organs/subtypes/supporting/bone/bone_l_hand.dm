/obj/item/organ/bone/l_hand
	name = "left carpals"
	desc = "For most people, losing the left hand is better than losing the right hand - But by far, losing none is the best option."
	icon_state = "left_carpals"
	base_icon_state = "left_carpals"
	zone = BODY_ZONE_PRECISE_L_HAND
	joint_name = "left wrist"
	bone_flags = BONE_JOINTED
	gender = PLURAL

/obj/item/organ/bone/l_hand/robot
	name = "cyborg left carpals"
	icon_state = "left_carpals-c"
	base_icon_state = "left_carpals-c"
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_SYNTHETIC|ORGAN_NOINFECTION|ORGAN_LIMB_SUPPORTER|ORGAN_INDESTRUCTIBLE|ORGAN_NO_VIOLENT_DAMAGE
