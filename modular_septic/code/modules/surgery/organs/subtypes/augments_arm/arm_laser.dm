/obj/item/organ/cyberimp/arm/gun/laser
	name = "arm-mounted laser implant"
	desc = "A variant of the arm cannon implant that fires lethal laser beams. The cannon emerges from the subject's arm and remains inside when not in use."
	icon_state = "arm_laser"
	contents = newlist(/obj/item/gun/energy/laser/mounted)

/obj/item/organ/cyberimp/arm/gun/laser/Initialize()
	. = ..()
	var/obj/item/organ/cyberimp/arm/gun/laser/laserphasergun = locate(/obj/item/gun/energy/laser/mounted) in contents
	laserphasergun.icon = icon //No invisible laser guns kthx
	laserphasergun.icon_state = icon_state

/obj/item/organ/cyberimp/arm/gun/laser/l
	zone = BODY_ZONE_L_ARM
