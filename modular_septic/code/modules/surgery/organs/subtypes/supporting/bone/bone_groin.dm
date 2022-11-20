/obj/item/organ/bone/groin
	name = "pelvis"
	desc = "How do women get a fetus to fit through this?"
	icon_state = "pelvis"
	base_icon_state = "pelvis"
	zone = BODY_ZONE_PRECISE_GROIN
	joint_name = "hip"
	bone_flags = BONE_JOINTED
	wound_resistance = 5

/obj/item/organ/bone/groin/robot
	name = "cyborg pelvis"
	icon_state = "pelvis-c"
	base_icon_state = "pelvis-c"
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_SYNTHETIC|ORGAN_NOINFECTION|ORGAN_LIMB_SUPPORTER|ORGAN_INDESTRUCTIBLE|ORGAN_NO_VIOLENT_DAMAGE
