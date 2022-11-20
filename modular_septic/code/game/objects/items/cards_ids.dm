/obj/item/card/id/AltClick(mob/living/user)
	if(!can_interact(user))
		return FALSE
	if(SEND_SIGNAL(src, COMSIG_CLICK_ALT, user) & COMPONENT_CANCEL_CLICK_ALT)
		return
	var/turf/T = get_turf(src)
	if(T && (isturf(loc) || isturf(src)) && user.TurfAdjacent(T))
		user.listed_turf = T
		user.client << output("[url_encode(json_encode(T.name))];", "statbrowser:create_listedturf")
	if(unique_reskin && !current_skin && user.canUseTopic(src, BE_CLOSE, NO_DEXTERITY))
		reskin_obj(user)

/obj/item/card/id/examine_more(mob/user)
	var/list/msg = list(span_notice("<i>I examine [src] closer, and note the following...</i>"), "<br><hr class='infohr'>")

	if(registered_age)
		msg += "The card indicates that the holder is [registered_age] years old. [(registered_age < AGE_MINOR) ? "There's a holographic stripe that reads <b>[span_danger("'MINOR: DO NOT SERVE ALCOHOL OR TOBACCO'")]</b> along the bottom of the card." : ""]"
	if(mining_points)
		msg += "There's [mining_points] mining equipment redemption point\s loaded onto this card."
	if(registered_account)
		msg += "The account linked to the ID belongs to '[registered_account.account_holder]' and reports a balance of [registered_account.account_balance] cr."
		if(registered_account.account_job)
			var/datum/bank_account/D = SSeconomy.get_dep_account(registered_account.account_job.paycheck_department)
			if(D)
				msg += "The [D.account_holder] reports a balance of [D.account_balance] cr."
		if(registered_account.civilian_bounty)
			msg += "<span class='info'><b>There is an active civilian bounty.</b>"
			msg += span_info("<i>[registered_account.bounty_text()]</i>")
			msg += span_info("Quantity: [registered_account.bounty_num()]")
			msg += span_info("Reward: [registered_account.bounty_value()]")
		if(registered_account.account_holder == user.real_name)
			msg += span_boldnotice("If you lose this ID card, you can reclaim your account by Alt-Clicking a blank ID card while holding it and entering your account ID number.")
	else
		msg += span_info("There is no registered account linked to this card. Alt-Click to add one.")

	. = msg
	if(on_examined_check(user, TRUE))
		user.on_examine_atom(src, TRUE)
