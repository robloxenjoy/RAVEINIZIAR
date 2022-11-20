/obj/machinery/vending/soder
	name = "\improper Mug Root Beer"
	desc = "Mug Moment."
	icon = 'modular_septic/icons/obj/machinery/vending.dmi'
	icon_state = "mug"
	panel_type = "panel2"
	product_slogans = "OOOOOOOOUUUUU... SO REFRESHING..."
	product_ads = "Only a matter of time until the refreshing, delicia taste of Mug Root Beer runs out!; We only have so much!; Top 10 Soda's that haven't publicly used child slavery!; I LOVE MY MUG!"
	products = list(
		/obj/item/reagent_containers/food/drinks/soda_cans/coke = 10,
		/obj/item/reagent_containers/food/drinks/soda_cans/pepsi = 10,
		/obj/item/reagent_containers/food/drinks/soda_cans/pepsi/diet = 10,
		/obj/item/reagent_containers/food/drinks/soda_cans/mug = 10,
	)
	refill_canister = /obj/item/vending_refill/cola
	default_price = PAYCHECK_ASSISTANT * 0.7
	extra_price = PAYCHECK_MEDIUM
	payment_department = ACCOUNT_SRV
	var/mugvoice = 'modular_septic/sound/effects/mug.ogg'

/obj/machinery/vending/soder/process(delta_time, volume = 70)
	if(machine_stat & (BROKEN|NOPOWER))
		return PROCESS_KILL
	if(!active)
		return

	if(seconds_electrified > MACHINE_NOT_ELECTRIFIED)
		seconds_electrified--

	if(last_slogan + slogan_delay <= world.time && slogan_list.len > 0 && !shut_up && DT_PROB(2.5, delta_time))
		var/slogan = pick(slogan_list)
		playsound(src, mugvoice,  volume, TRUE, vary = FALSE)
		speak(slogan)
		last_slogan = world.time
