/obj/machinery/vending/dinnerware
	name = "\improper Plasteel Chef's Dinnerware Vendor"
	desc = "A kitchen and restaurant equipment vendor."
	product_ads = "Mm, food stuffs!;Food and food accessories.;Get your plates!;You like forks?;I like forks.;Woo, utensils.;You don't really need these..."
	icon_state = "dinnerware"
	panel_type = "panel4"
	products = list(
		/obj/item/storage/bag/tray = 8,
		/obj/item/reagent_containers/glass/bowl = 20,
		/obj/item/kitchen/fork = 6,
		/obj/item/kitchen/spoon = 6,
		/obj/item/reagent_containers/food/drinks/drinkingglass = 8,
		/obj/item/reagent_containers/food/condiment/pack/ketchup = 5,
		/obj/item/reagent_containers/food/condiment/pack/hotsauce = 5,
		/obj/item/reagent_containers/food/condiment/pack/astrotame = 5,
		/obj/item/reagent_containers/food/condiment/saltshaker = 5,
		/obj/item/reagent_containers/food/condiment/peppermill = 5,
		/obj/item/clothing/suit/apron/chef = 2,
		/obj/item/kitchen/rollingpin = 2,
		/obj/item/knife/kitchen = 2,
		/obj/item/book/granter/crafting_recipe/cooking_sweets_101 = 2,
		/obj/item/plate = 10
	)
	contraband = list(
		/obj/item/kitchen/rollingpin = 2,
		/obj/item/knife/butcher = 2,
	)
	refill_canister = /obj/item/vending_refill/dinnerware
	default_price = PAYCHECK_ASSISTANT * 0.8
	extra_price = PAYCHECK_HARD
	payment_department = ACCOUNT_SRV
	light_mask = "dinnerware-light-mask"

/obj/item/vending_refill/dinnerware
	machine_name = "Plasteel Chef's Dinnerware Vendor"
	icon_state = "refill_smoke"

/obj/machinery/vending/stone_eater
	name = "\improper Stone Eater"
	desc = "STONE PORRIDGE...."
	product_ads = "Mm, food stuffs!;Food and food accessories.;Get your plates!;You like forks?;MEDICINE!.;Hmmm, pickaxes.;Do you need ammo?"
	icon = 'modular_pod/icons/obj/machinery/vending.dmi'
	icon_state = "stone_eater"
	products = list(
		/obj/item/food/canned/beef = 100,
		/obj/item/reagent_containers/food/drinks/waterbottle = 100,
		/obj/item/melee/hehe/pickaxe/iron = 50,
		/obj/item/stack/medical/gauze = 30,
		/obj/item/reagent_containers/food/drinks/bottle/beer = 50,
		/obj/item/torch = 50
	)
	premium = list(
		/obj/item/storage/box/a38/less = 1
	)
	default_price = PAYCHECK_ASSISTANT * 0.7
	extra_price = PAYCHECK_MEDIUM
	var/obj/item/coin/stoneporridge/coin
