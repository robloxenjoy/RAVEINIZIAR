//Force mob to rest, does NOT do stamina damage.
//It's really not recommended to use this proc to give feedback, hence why silent is defaulting to true.
/mob/living/carbon/KnockToFloor(knockdown_amt = 1, ignore_canknockdown = FALSE, silent = TRUE)
	if(!silent && (body_position != LYING_DOWN))
		to_chat(src, span_warning("I am knocked to the floor!"))
	Knockdown(knockdown_amt, ignore_canknockdown)

/mob/living/carbon/CombatKnockdown(stamina_damage, knockdown_amount, paralyze_amount, disarm = FALSE, ignore_canknockdown = FALSE)
	if(!stamina_damage && !knockdown_amount && !paralyze_amount)
		return
	if(!ignore_canknockdown && !(status_flags & CANKNOCKDOWN))
		return FALSE
	if(istype(buckled, /obj/vehicle/ridden)) //this is dumb...
		buckled.unbuckle_mob(src)
	if(isnull(knockdown_amount))
		knockdown_amount = stamina_damage
	KnockToFloor(max(1, knockdown_amount), ignore_canknockdown)
	adjustStaminaLoss(stamina_damage)
	if(disarm)
		drop_all_held_items()
	if(paralyze_amount)
		Paralyze(paralyze_amount)
