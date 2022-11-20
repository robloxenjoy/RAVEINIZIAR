/obj/item/organ/tendon/neck
	name = "vocal cords"
	gender = PLURAL
	desc = "Well... Some smoker must have gotten a tracheotomy."
	icon_state = "vocal-cords"
	base_icon_state = "vocal-cords"
	zone = BODY_ZONE_PRECISE_NECK
	organ_efficiency = list(ORGAN_SLOT_TENDON = 100, ORGAN_SLOT_VOICE = 100)

/obj/item/organ/tendon/neck/robot
	name = "cyborg vocal cords"
	icon_state = "vocal-cords-c"
	base_icon_state = "vocal-cords-c"
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_SYNTHETIC|ORGAN_LIMB_SUPPORTER|ORGAN_INDESTRUCTIBLE|ORGAN_NO_VIOLENT_DAMAGE
