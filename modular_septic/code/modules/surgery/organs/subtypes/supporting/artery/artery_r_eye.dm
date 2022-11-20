/obj/item/organ/artery/r_eye
	name = "right central retinal artery"
	zone = BODY_ZONE_PRECISE_R_EYE
	blood_flow = ARTERIAL_BLOOD_FLOW * 0.35

/obj/item/organ/artery/r_eye/robot
	name = "cyborg right central retinal artery"
	icon_state = "artery-c"
	base_icon_state = "artery-c"
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_SYNTHETIC|ORGAN_LIMB_SUPPORTER|ORGAN_INDESTRUCTIBLE|ORGAN_NO_VIOLENT_DAMAGE
