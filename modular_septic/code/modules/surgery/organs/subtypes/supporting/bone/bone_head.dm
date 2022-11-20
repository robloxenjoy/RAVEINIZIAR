/obj/item/organ/bone/head
	name = "skull"
	desc = "To be or not to be: That is the question."
	icon_state = "skull"
	base_icon_state = "skull"
	zone = BODY_ZONE_HEAD
	joint_name = "sutures" // that is the actual name i kid you not
	bone_flags = BONE_ENCASING // if you dislocate a skull - well, that's pretty much death...
	wound_resistance = 10

/obj/item/organ/bone/head/robot
	name = "cyborg skull"
	icon_state = "skull-c"
	base_icon_state = "skull-c"
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_SYNTHETIC|ORGAN_NOINFECTION|ORGAN_LIMB_SUPPORTER|ORGAN_INDESTRUCTIBLE|ORGAN_NO_VIOLENT_DAMAGE
