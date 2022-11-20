/obj/item/sim_card_program
	name = "sim card program"
	var/health = 10
	var/maxhealth = 60
	var/defence_chance = 20
	var/max_defence_chance = 50
	var/corrupted = FALSE
	var/illegal = FALSE
	var/obj/item/sim_card/host

/obj/item/sim_card_program/proc/execute(mob/user, modifiers)
	if(isnull(host.owner_phone))
		return
	if(corrupted)
		to_chat(user, span_danger("[icon2html(host.owner_phone, user)]The program was corrupted!"))
		host.infect_with_virus()
		playsound(host.owner_phone, host.owner_phone.firewall_noise, 65, FALSE)
		return

/obj/item/sim_card_program/vantablack
	name = "VANTABLACK SOFTWARE"
	health = 100
	maxhealth = 100
	defence_chance = 50
	max_defence_chance = 100
	illegal = TRUE
	var/mob/living/carbon/human/hackerman

/obj/item/sim_card_program/vantablack/execute(mob/living/user, modifiers)
	. = ..()
	if(!hackerman)
		var/cock = pick("DICK", "COCK", "PENIS", "KNOB")
		hackerman = user
		to_chat(user, span_notice("[icon2html(host.owner_phone, user)][cock] SCANNED AND SAVED. WELCOME, [hackerman.real_name]."))
		playsound(host.owner_phone, host.owner_phone.subtlealert_noise, 65, FALSE)
		return
	if(user != hackerman)
		to_chat(user, span_notice("[icon2html(host.owner_phone, user)]ACCESS DENIED!"))
		playsound(host.owner_phone, host.owner_phone.firewall_noise, 65, FALSE)
		return
	playsound(host?.owner_phone, host.owner_phone.phone_press, 65, FALSE)
	to_chat(user, span_notice("[icon2html(host?.owner_phone, user)] MY FIREWALL IS [host.infection_resistance ? "ON" : "OFF"] \nMY CALLING VIRUS IS [host.virus.infectious ? "ON" : "OFF"] \nMY BINARY INTEGRITY IS [health]%"))
	var/title = "FLSEHWORM.GAKSTER"
	var/list/options = list("DDOS", "TOGGLE CALL VIRUS", "TOGGLE FIREWALL")
	var/input = input(user, "SHOW THEM WHAT IT MEANS TO SPEND THIS MUCH TIME JAILBREAKING PHONES", title, "") as null|anything in options
	if(!input)
		return
	if(input == "DDOS")
		var/ddos_title = "DDOS N%%$$$AS"
		var/list/ddos_options = GLOB.public_phone_list.Copy()
		ddos_options -= host.name
		var/ddos_input = input(user, "Who would you like to fuck up?", ddos_title, "") as null|anything in ddos_options
		if(!ddos_input)
			return
		var/obj/item/cellular_phone/friend_phone
		friend_phone = GLOB.public_phone_list[ddos_input]
		if(friend_phone.stalling)
			to_chat(user, span_notice("[icon2html(host.owner_phone, user)]THEIR PHONE IS ALREADY STALLING."))
			return
		if(friend_phone.sim_card.number == host.number)
			to_chat(user, span_notice("[icon2html(host.owner_phone, user)]I DON'T THINK I WANT TO DDOS MYSELF"))
			return
		friend_phone.stall()
		to_chat(user, span_notice("[icon2html(host.owner_phone, user)]SUCCESSFUL DDOS."))
		playsound(host.owner_phone, host.owner_phone.subtlealert_noise, 65, FALSE)
		return
	if(input == "TOGGLE CALL VIRUS")
		host?.virus.infectious = !host.virus.infectious
		to_chat(user, span_danger("[icon2html(host?.owner_phone, user)]INFECTIVITY TOGGLED [host.virus.infectious ? "ON" : "OFF"]"))
		playsound(host.owner_phone, host.owner_phone.subtlealert_noise, 65, FALSE)
		return
	if(input == "TOGGLE FIREWALL")
		host.infection_resistance = !host.infection_resistance
		to_chat(user, span_danger("[icon2html(host?.owner_phone, user)]FIREWALL TOGGLED [host.infection_resistance ? "ON" : "OFF"]"))
		playsound(host.owner_phone, host.owner_phone.firewall_noise, 65, FALSE)
		return
