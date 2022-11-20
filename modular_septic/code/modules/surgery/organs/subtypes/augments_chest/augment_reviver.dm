/obj/item/organ/cyberimp/chest/reviver
	name = "Reviver implant"
	desc = "This implant will attempt to revive and heal you if you lose consciousness. For the faint of heart!"
	icon_state = "chest_implant"
	implant_overlay_color = "#AD0000"
	var/revive_cost = 0
	var/reviving = FALSE
	COOLDOWN_DECLARE(reviver_cooldown)

/obj/item/organ/cyberimp/chest/reviver/on_life(delta_time, times_fired)
	. = ..()
	if(reviving)
		switch(owner.stat)
			if(UNCONSCIOUS, HARD_CRIT)
				addtimer(CALLBACK(src, .proc/heal), 3 SECONDS)
			else
				COOLDOWN_START(src, reviver_cooldown, revive_cost)
				reviving = FALSE
				to_chat(owner, span_notice("Your reviver implant shuts down and starts recharging. It will be ready again in [DisplayTimeText(revive_cost)]."))
		return

	if(!COOLDOWN_FINISHED(src, reviver_cooldown) || owner.suiciding)
		return

	switch(owner.stat)
		if(UNCONSCIOUS, HARD_CRIT)
			revive_cost = 0
			reviving = TRUE
			to_chat(owner, span_notice("You feel a faint buzzing as your reviver implant starts patching your wounds..."))

/obj/item/organ/cyberimp/chest/reviver/proc/heal()
	if(owner.getOxyLoss())
		owner.adjustOxyLoss(-5)
		revive_cost += 5
	if(owner.getBruteLoss())
		owner.adjustBruteLoss(-2)
		revive_cost += 40
	if(owner.getFireLoss())
		owner.adjustFireLoss(-2)
		revive_cost += 40
	if(owner.getToxLoss())
		owner.adjustToxLoss(-1)
		revive_cost += 40

/obj/item/organ/cyberimp/chest/reviver/emp_act(severity)
	. = ..()
	if(!owner || . & EMP_PROTECT_SELF)
		return

	if(reviving)
		revive_cost += 200
	else
		reviver_cooldown += 20 SECONDS

	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		if(H.stat != DEAD && prob(50 / severity) && H.can_heartattack())
			H.set_heartattack(TRUE)
			to_chat(H, span_userdanger("You feel a horrible agony in your chest!"))
			addtimer(CALLBACK(src, .proc/undo_heart_attack), 600 / severity)

/obj/item/organ/cyberimp/chest/reviver/proc/undo_heart_attack()
	var/mob/living/carbon/human/H = owner
	if(!istype(H))
		return
	H.set_heartattack(FALSE)
	if(H.stat == CONSCIOUS)
		to_chat(H, span_notice("You feel your heart beating again!"))
