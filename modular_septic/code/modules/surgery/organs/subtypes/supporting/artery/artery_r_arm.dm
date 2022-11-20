/obj/item/organ/artery/r_arm
	name = "right brachial artery"
	zone = BODY_ZONE_R_ARM
	blood_flow = ARTERIAL_BLOOD_FLOW * 0.75

/obj/item/organ/artery/r_arm/robot
	name = "cyborg right brachial artery"
	icon_state = "artery-c"
	base_icon_state = "artery-c"
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_SYNTHETIC|ORGAN_LIMB_SUPPORTER|ORGAN_INDESTRUCTIBLE|ORGAN_NO_VIOLENT_DAMAGE
