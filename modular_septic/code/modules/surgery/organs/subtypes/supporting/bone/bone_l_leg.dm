/obj/item/organ/bone/l_leg
	name = "left femur"
	desc = "A femur fracture is said to be painful enough to attract the attention of demons - That is no longer a problem."
	icon_state = "left_femur"
	base_icon_state = "left_femur"
	zone = BODY_ZONE_L_LEG
	joint_name = "left knee"
	bone_flags = BONE_JOINTED

/obj/item/organ/bone/l_leg/robot
	name = "cyborg left femur"
	icon_state = "left_femur-c"
	base_icon_state = "left_femur-c"
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_SYNTHETIC|ORGAN_NOINFECTION|ORGAN_LIMB_SUPPORTER|ORGAN_INDESTRUCTIBLE|ORGAN_NO_VIOLENT_DAMAGE
