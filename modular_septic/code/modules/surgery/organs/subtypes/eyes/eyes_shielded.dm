// Welding shield implant
/obj/item/organ/eyes/robotic/shield
	name = "shielded robotic eye"
	desc = "These reactive micro-shields will protect you from welders and flashes without obscuring your vision."
	flash_protect = FLASH_PROTECTION_WELDER

/obj/item/organ/eyes/robotic/shield/l
	zone = BODY_ZONE_PRECISE_L_EYE

/obj/item/organ/eyes/robotic/shield/emp_act(severity)
	return
