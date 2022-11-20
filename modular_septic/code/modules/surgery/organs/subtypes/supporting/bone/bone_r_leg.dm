/obj/item/organ/bone/r_leg
	name = "right femur"
	desc = "The femur is the largest, strongest bone of the human body. Until you lose it."
	icon_state = "right_femur"
	base_icon_state = "right_femur"
	zone = BODY_ZONE_R_LEG
	joint_name = "right knee"
	bone_flags = BONE_JOINTED

/obj/item/organ/bone/r_leg/robot
	name = "cyborg right femur"
	icon_state = "right_femur-c"
	base_icon_state = "right_femur-c"
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_SYNTHETIC|ORGAN_NOINFECTION|ORGAN_LIMB_SUPPORTER|ORGAN_INDESTRUCTIBLE|ORGAN_NO_VIOLENT_DAMAGE
