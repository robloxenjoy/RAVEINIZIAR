/obj/item/organ/artery/neck
	name = "carotid artery"
	zone = BODY_ZONE_PRECISE_NECK
	blood_flow = ARTERIAL_BLOOD_FLOW * 4
	squirt_delay_min_seconds = 1
	squirt_delay_max_seconds = 3

/obj/item/organ/artery/neck/robot
	name = "cyborg carotid artery"
	icon_state = "artery-c"
	base_icon_state = "artery-c"
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_SYNTHETIC|ORGAN_LIMB_SUPPORTER|ORGAN_INDESTRUCTIBLE|ORGAN_NO_VIOLENT_DAMAGE
