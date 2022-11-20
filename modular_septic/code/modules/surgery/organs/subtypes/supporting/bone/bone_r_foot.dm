/obj/item/organ/bone/r_foot
	name = "right caucaneus"
	desc = "Having a fractured caucaneus significantly impairs movement - But it is better than having no caucaneus."
	icon_state = "right_caucaneus"
	base_icon_state = "right_caucaneus"
	zone = BODY_ZONE_PRECISE_R_FOOT
	joint_name = "right ankle"
	bone_flags = BONE_JOINTED

/obj/item/organ/bone/r_foot/robot
	name = "cyborg right caucaneus"
	icon_state = "right_caucaneus-c"
	base_icon_state = "right_caucaneus-c"
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_SYNTHETIC|ORGAN_NOINFECTION|ORGAN_LIMB_SUPPORTER|ORGAN_INDESTRUCTIBLE|ORGAN_NO_VIOLENT_DAMAGE
