/obj/item/organ/artery/chest
	name = "thoracic aorta"
	desc = "Shot through the heart, and you're to blame - Darlin', you give love a bad name."
	zone = BODY_ZONE_CHEST
	blood_flow = ARTERIAL_BLOOD_FLOW * 2
	squirt_delay_min_seconds = 1
	squirt_delay_max_seconds = 2

/obj/item/organ/artery/chest/robot
	name = "cyborg thoracic aorta"
	icon_state = "artery-c"
	base_icon_state = "artery-c"
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_SYNTHETIC|ORGAN_LIMB_SUPPORTER|ORGAN_INDESTRUCTIBLE|ORGAN_NO_VIOLENT_DAMAGE
