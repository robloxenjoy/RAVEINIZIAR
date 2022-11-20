/obj/machinery/computer/information_terminal
	name = "\improper Telescreen"
	desc = "A touchscreen terminal used to handle banking and vital public information."
	icon = 'modular_septic/icons/obj/machinery/information_terminal.dmi'
	icon_state = "atm"
	base_icon_state = "atm"
	icon_screen = "generic"
	icon_keyboard = null
	light_color = "#37D384"
	density = FALSE
	/// Page the UI is currently set to
	var/ui_page = "index"
	/// ID card currently inserted in the ATM
	var/obj/item/card/id/inserted_id
	/// Data disk currently inserted, for naughty purposes
	var/obj/item/computer_hardware/hard_drive/portable/inserted_data
	/**
	 * Why Remis?
	 * Tough love
	 */
	var/withdraw_timer
	/// Cooldown for inserting cash
	var/cash_cooldown_duration = 1.8 SECONDS
	/// Cooldown for inserting coins
	var/coin_cooldown_duration = 0.3 SECONDS

/obj/machinery/computer/information_terminal/Initialize(mapload, obj/item/circuitboard/C)
	. = ..()
	setDir(dir)

/obj/machinery/computer/information_terminal/setDir(newdir)
	. = ..()
	update_appearance(UPDATE_ICON)

/obj/machinery/computer/information_terminal/update_icon(updates)
	. = ..()
	switch(dir)
		if(NORTH)
			plane = ABOVE_FRILL_PLANE
			pixel_y = -8
		if(SOUTH)
			plane = GAME_PLANE_UPPER
			pixel_y = 35
		if(EAST)
			plane = GAME_PLANE_UPPER
			pixel_x = -12
			pixel_y = 10
		if(WEST)
			plane = GAME_PLANE_UPPER
			pixel_x = 12
			pixel_y = 10
		else
			plane = ABOVE_FRILL_PLANE
			pixel_y = -8

/obj/machinery/computer/information_terminal/examine(mob/user)
	. = ..()
	if(inserted_id)
		. += span_notice("[inserted_id] is inserted in the ID card slot.")
	if(inserted_data)
		. += span_notice("[inserted_data] is inserted in the data slot.")

/obj/machinery/computer/information_terminal/attack_hand_secondary(mob/living/user, list/modifiers)
	. = SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	add_fingerprint(user)
	if(inserted_data && user.put_in_hands(inserted_data))
		to_chat(user, span_notice("I pull [inserted_data] from [src]'s data slot."))
		playsound(src, 'modular_septic/sound/machinery/cardreader_desert.wav', 70, FALSE)
		inserted_data = null
		return
	if(inserted_id && user.put_in_hands(inserted_id))
		to_chat(user, span_notice("I pull [inserted_id] from [src]'s data slot."))
		playsound(src, 'modular_septic/sound/machinery/cardreader_desert.wav', 70, FALSE)
		inserted_id = null
		if(ui_page == "banking")
			ui_page = initial(ui_page)
			update_static_data(user)

/obj/machinery/computer/information_terminal/attackby(obj/item/weapon, mob/user, params)
	if(!inserted_id && istype(weapon, /obj/item/card/id) && user.transferItemToLoc(weapon, src))
		add_fingerprint(user)
		to_chat(user, span_notice("I insert [weapon] into [src]'s ID card slot."))
		playsound(src, 'modular_septic/sound/machinery/cardreader_insert.wav', 70, FALSE)
		inserted_id = weapon
		if(ui_page == "banking")
			ui_page = initial(ui_page)
			update_static_data(user)
		return TRUE
	if(!inserted_data && istype(weapon, /obj/item/computer_hardware/hard_drive/portable) && user.transferItemToLoc(weapon, src))
		add_fingerprint(user)
		to_chat(user, span_notice("I insert [weapon] into [src]'s data slot."))
		playsound(src, 'modular_septic/sound/machinery/cardreader_insert.wav', 70, FALSE)
		inserted_data = weapon
		return TRUE
	if(ismoney(weapon))
		add_fingerprint(user)
		insert_money(weapon, user)
		return TRUE
	return ..()

/obj/machinery/computer/information_terminal/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "InformationTerminal")
		ui.set_autoupdate(TRUE)
		ui.open()

/obj/machinery/computer/information_terminal/ui_data(mob/user)
	var/list/data = list()

	data["current_page"] = ui_page
	if(inserted_id?.registered_account)
		data["account_holder"] = inserted_id.registered_account.account_holder
		data["account_id"] = inserted_id.registered_account.account_id
		data["account_balance"] = inserted_id.registered_account.account_balance

	return data

/obj/machinery/computer/information_terminal/ui_static_data(mob/user)
	var/list/data = list()

	if(ui_page == "information")
		var/list/announcements= list()
		for(var/datum/announcement/announcement as anything in reverseList(SSstation.station_announcements))
			var/list/this_announcement = list()

			this_announcement["title"] = announcement.title
			this_announcement["contents"] = announcement.contents

			announcements += list(this_announcement)
		data["announcements"] = announcements
	if(ui_page == "index" && LAZYLEN(GLOB.data_core.birthday_boys))
		data["birthday_boys"] = english_list(GLOB.data_core.birthday_boys)

	return data

/obj/machinery/computer/information_terminal/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	switch(action)
		if("switch_page")
			var/new_page = params["new_page"]
			ui_page = new_page
			if(ui)
				ui.close()
			ui_interact(usr)
		if("withdraw")
			var/amount = min(params["amount"], inserted_id?.registered_account?.account_balance)
			if(amount <= 0)
				to_chat(usr, span_warning("[fail_msg()] I'm broke."))
				return
			withdraw_money(amount, usr)

/obj/machinery/computer/information_terminal/proc/insert_money(obj/item/money/money, mob/user)
	if(!can_insert_money(user))
		return
	if(!inserted_id)
		var/insert_amount = money.get_item_credit_value()
		if(insert_amount)
			var/datum/bank_account/master_account = SSeconomy.get_dep_account(ACCOUNT_SEC)
			if(!master_account)
				return
			qdel(money)
			master_account.adjust_money(insert_amount)
			to_chat(user, span_danger("[fail_msg()] I'm fucking stupid!"))
		return
	else if(!inserted_id.registered_account)
		to_chat(user, span_warning("[inserted_id] doesn't have a linked account to deposit [money] into!"))
		return

	var/obj/item/money/money_stack
	var/obj/item/money/real_money = money
	if(money.is_stack)
		money_stack = money
		real_money = money_stack.contents[1]

	var/insert_amount = real_money.get_item_credit_value()
	if(!insert_amount)
		to_chat(user, span_warning("[real_money] isn't worth anything!"))
		return

	if(real_money.is_coin)
		playsound(src, 'modular_septic/sound/machinery/coin_insert.wav', 60, FALSE)
		TIMER_COOLDOWN_START(src, COOLDOWN_MONEY, coin_cooldown_duration)
	else
		playsound(src, 'modular_septic/sound/machinery/cash_insert.wav', 60, FALSE)
		TIMER_COOLDOWN_START(src, COOLDOWN_MONEY, cash_cooldown_duration)
	qdel(real_money)
	if(money_stack && (length(money_stack.contents) <= 1))
		user.dropItemToGround(money_stack)
		for(var/obj/item/money/cash_money in money_stack)
			cash_money.forceMove(loc)
			user.put_in_hands(cash_money)
		qdel(money_stack)

	inserted_id.registered_account.adjust_money(insert_amount)
	to_chat(user, span_notice("I insert [money] into [src], adding $[insert_amount] to the \"[inserted_id.registered_account.account_holder]\" account."))
	log_econ("$[insert_amount] were inserted into [inserted_id] owned by [inserted_id.registered_name]")
	SSblackbox.record_feedback("amount", "credits_inserted", insert_amount)
	if(!QDELETED(money_stack))
		money_stack.update_appearance()

/obj/machinery/computer/information_terminal/proc/can_insert_money(mob/user)
	if(TIMER_COOLDOWN_CHECK(src, COOLDOWN_MONEY))
		return FALSE
	return TRUE

/obj/machinery/computer/information_terminal/proc/withdraw_money(amount, mob/user)
	if(withdraw_timer)
		return
	if(!inserted_id.registered_account.adjust_money(-amount))
		return
	playsound(src, 'modular_septic/sound/machinery/cardreader_read.wav', 70, FALSE)
	to_chat(user, span_notice("I withdraw $[amount] from [src]."))
	withdraw_timer = addtimer(CALLBACK(src, .proc/finalize_withdraw_money, amount, user), 1.25 SECONDS, TIMER_STOPPABLE)

/obj/machinery/computer/information_terminal/proc/finalize_withdraw_money(amount, mob/user)
	if(withdraw_timer)
		deltimer(withdraw_timer)
		withdraw_timer = null
	var/static/list/money_to_value = list(
		/obj/item/money/note/value100 = 100 DOLLARS,
		/obj/item/money/note/value50 = 50 DOLLARS,
		/obj/item/money/note/value20 = 20 DOLLARS,
		/obj/item/money/note/value10 = 10 DOLLARS,
		/obj/item/money/note/value5 = 5 DOLLARS,
		/obj/item/money/coin/dollar = 1 DOLLARS,
		/obj/item/money/coin/quarter = 25 CENTS,
		/obj/item/money/coin/dime = 10 CENTS,
		/obj/item/money/coin/nickel = 5 CENTS,
		/obj/item/money/coin/penny = 1 CENTS,
	)

	var/remaining_amount = amount
	var/list/money_items = list()
	for(var/money_type in money_to_value)
		if(remaining_amount <= 0)
			break
		var/bill_value = money_to_value[money_type]
		var/bills = FLOOR(remaining_amount/bill_value, 1) //amount of bills
		remaining_amount -= (bills * bill_value)
		for(var/i in 1 to bills)
			money_items += new money_type(loc)
	var/money_length = length(money_items)
	if(!money_length)
		return

	var/obj/item/money/final_handout
	if(money_length > 1)
		final_handout = new /obj/item/money/stack(loc)
		for(var/obj/item/money as anything in money_items)
			final_handout.stack_money(money, TRUE)
	else
		final_handout = money_items[1]

	log_econ("$[amount] were removed from [inserted_id] owned by [inserted_id.registered_name]")
	SSblackbox.record_feedback("amount", "credits_removed", amount)
	if(QDELETED(user) || !user.Adjacent(src))
		return
	user.put_in_hands(final_handout)

/obj/machinery/computer/information_terminal/directional/north
	dir = SOUTH
	pixel_y = 28

/obj/machinery/computer/information_terminal/directional/east
	dir = WEST
	pixel_x = 12

/obj/machinery/computer/information_terminal/directional/west
	dir = EAST
	pixel_x = -12
