/obj/item/money
	name = "money"
	desc = "We don't live in a cashless society."
	icon = 'modular_septic/icons/obj/items/money.dmi'
	w_class = WEIGHT_CLASS_TINY
	carry_weight = 50 GRAMS
	/// World icon we should use
	var/world_icon = 'modular_septic/icons/obj/items/money_world.dmi'
	/// If this is a coin, it shows at the bottom right when stacking
	var/is_coin = FALSE
	/// Stack of money, we can't stack and create another stack that is stupid
	var/is_stack = FALSE
	/// How many dollars this is worth
	var/worth = 1 CENTS

/obj/item/money/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/world_icon, .proc/update_icon_world)

/obj/item/money/examine(mob/user)
	. = ..()
	var/value_examine = value_examine(user)
	if(value_examine)
		. += value_examine
	if(!LAZYLEN(contents))
		return
	var/list/money_counter = list()
	for(var/obj/item/money/money in src)
		if(money_counter[money.name])
			money_counter[money.name] += 1
		else
			money_counter[money.name] = 1
	for(var/money_name in money_counter)
		var/amount = money_counter[money_name]
		. += span_info("- [money_name][amount > 1 ? " x[amount]" : ""]")

/obj/item/money/attackby(obj/item/attacking_item, mob/living/user, params)
	. = ..()
	if(!ismoney(attacking_item))
		return
	var/obj/item/money/money = stack_money(attacking_item)
	if(money)
		money.forceMove(user.loc)
		user.put_in_hands(money)

/obj/item/money/attack_self(mob/user, modifiers)
	. = ..()
	if(!is_stack)
		return
	for(var/obj/item/money/money in src)
		if(user.transferItemToLoc(money, drop_location()))
			if(!(locate(/obj/item/money) in src))
				qdel(src)
			user.put_in_hands(money)
			break
	update_appearance()

/obj/item/money/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	if(!is_stack)
		return
	for(var/obj/item/money/money in src)
		money.forceMove(loc)
		money.undo_messy()
		money.do_messy(duration = 2)
	qdel(src)

/obj/item/money/get_item_credit_value()
	return worth

/obj/item/money/update_icon(updates)
	icon = initial(icon)
	cut_overlays()
	return ..()

/obj/item/money/update_icon_state()
	. = ..()
	icon_state = base_icon_state

/obj/item/money/proc/get_visible_value(mob/user)
	return get_item_credit_value()

/obj/item/money/proc/value_examine(mob/user)
	var/value = get_visible_value(user)
	var/dollar_value = round(value/(1 DOLLARS), 1)
	var/cent_value = round(value/(1 CENTS) - round(value/(1 CENTS), (1 DOLLARS)/(1 CENTS)), 1)
	var/value_string = ""
	if(dollar_value && cent_value)
		value_string = "$[dollar_value] and ¢[cent_value]"
	else if(dollar_value)
		value_string = "$[dollar_value]"
	else if(cent_value)
		value_string = "¢[cent_value]"
	else
		value_string = "nothing"
	return "[p_they(TRUE)] [p_are()] worth [value_string]."

/obj/item/money/proc/stack_money(obj/item/money/money, silent = FALSE)
	var/obj/item/money/stack/real_stack
	if(!is_stack)
		if(!money.is_stack)
			real_stack = new(loc)
			money.forceMove(real_stack)
			forceMove(real_stack)
		else
			real_stack = money
			forceMove(real_stack)
	else
		if(!money.is_stack)
			real_stack = src
			money.forceMove(real_stack)
		else
			real_stack = src
			for(var/obj/item/money/cash_money in money)
				cash_money.forceMove(real_stack)
			qdel(money)
	if(!real_stack)
		return
	var/has_coin = FALSE
	var/has_note = FALSE
	for(var/obj/item/money/cash in real_stack)
		if(cash.is_coin)
			has_coin = TRUE
		else
			has_note = TRUE
		if(has_coin && has_note)
			break
	if(has_coin && has_note)
		real_stack.drop_sound = 'modular_septic/sound/items/money_and_coin_drop.wav'
	else if(has_coin)
		real_stack.drop_sound = 'modular_septic/sound/items/coin_drop.wav'
	else
		real_stack.drop_sound = 'modular_septic/sound/items/money_drop.wav'
	if(!silent)
		if(has_coin && has_note)
			playsound(real_stack, 'modular_septic/sound/items/money_and_coin_stack.wav', 60)
		else if(has_coin)
			playsound(real_stack, 'modular_septic/sound/items/coin_stack.wav', 60)
		else
			playsound(real_stack, 'modular_septic/sound/items/money_stack.wav', 60)
	real_stack.update_appearance()
	return real_stack

/obj/item/money/proc/update_icon_world()
	icon = world_icon
	icon_state = base_icon_state
	return UPDATE_ICON_STATE | UPDATE_OVERLAYS
