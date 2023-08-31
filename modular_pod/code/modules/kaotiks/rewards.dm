//the rewards themselves
/datum/bobux_reward/become_traitor
	name = "Become Dream Terrorist"
	desc = "Become a dream terrorist. It's time to parasitize this warlock dream!"
	buy_message = "<b>My ancient instincts activated... I'm a dream terrorist, parasite.</span>"
	id = "become_traitor"
	cost = 150

/datum/bobux_reward/become_traitor/can_buy(client/noob, silent, fail_message)
	. = ..()
	if(. && ishuman(noob.mob) && noob.mob.mind)
		return TRUE

/datum/bobux_reward/become_traitor/on_buy(client/noob)
	. = ..()
	var/mob/living/carbon/human/H = noob.mob
	H.mind.add_antag_datum(new /datum/antagonist/traitor())

/datum/bobux_reward/stat_boost
	name = "Boost Stats"
	desc = "Improve all stats by one point."
	buy_message = "<b>I become more awesome.</span>"
	id = "statboost"
	cost = 80

/datum/bobux_reward/stat_boost/can_buy(client/noob, silent, fail_message)
	. = ..()
	if(!noob.mob.attributes)
		return FALSE
	if(. && ishuman(noob.mob) && noob.mob.mind)
		return TRUE

/datum/bobux_reward/stat_boost/on_buy(client/noob)
	. = ..()
	var/list/stat_modification = list( \
	STAT_STRENGTH = 1, \
	STAT_ENDURANCE = 1, \
	STAT_DEXTERITY = 1, \
	STAT_INTELLIGENCE = 1, \
	STAT_PERCEPTION = 1, \
	STAT_WILL = 1, \
	STAT_LUCK = 1, \
	)
	noob.mob.attributes?.add_or_update_variable_attribute_modifier(/datum/attribute_modifier/kaotik, TRUE, stat_modification)
//	for(var/stat in noob.mob.mind.mob_stats)
//		noob.mob.mind.mob_stats[stat].level += 1

/datum/bobux_reward/combat_boost
	name = "Combat Boost"
	desc = "Improve melee and ranged skills."
	buy_message = "<b>I become better at combat.</span>"
	id = "combatboost"
	cost = 80

/datum/bobux_reward/combat_boost/can_buy(client/noob, silent, fail_message)
	. = ..()
	if(. && ishuman(noob.mob) && noob.mob.mind)
		return TRUE

/datum/bobux_reward/combat_boost/on_buy(client/noob)
	. = ..()
	noob.mob.attributes?.add_sheet(/datum/attribute_holder/sheet/kaotik)

/datum/bobux_reward/possess_mob
	name = "Possess Mob"
	desc = "Possess a mindless mob, if you're a ghost."
	buy_message = "<b>My mind seizes control over a creature.</span>"
	id = "possess"
	cost = 100

/datum/bobux_reward/possess_mob/can_buy(client/noob, silent, fail_message)
	. = ..()
	if(. && noob.mob && (isobserver(noob.mob)) && length(GLOB.mob_living_list))
		return TRUE

/datum/bobux_reward/possess_mob/on_buy(client/noob)
	..()
	var/list/husks = list()
	for(var/mob/living/L in GLOB.mob_living_list)
		if(!L.mind && !L.client && !ismegafauna(L) && !istype(L, /mob/living/simple_animal/hostile/boss))
			husks |= L
	if(!length(husks))
		to_chat(noob, "<span class='bobux'>You are unable to possess any creature. Kaotiks refunded.</span>")
		noob.prefs?.adjust_bobux(cost)
		return FALSE
	var/mob/living/choice = input(noob, "I will take over a creature. Which one?", "Possession", null) as mob in husks
	if(!choice)
		to_chat(noob, "<span class='bobux'>Kaotiks refunded.</span>")
		noob.prefs?.adjust_bobux(cost)
		return FALSE
//	var/datum/mind/mind = choice.mind
	choice.key = noob.key
//	noob.mob.transfer_ckey(choice, TRUE)
//	if(mind)
//		var/datum/mind/our_mind = noob.mob.mind
//		for(var/datum/skills/skill in our_mind.mob_skills)
//			skill.level = mind.mob_skills[skill.type].level
//		for(var/datum/stats/stat in our_mind.mob_stats)
//			stat.level = mind.mob_stats[stat.type].level
	to_chat(noob, "<span class='deadsay'>I have taken over [choice].</span>")

/datum/bobux_reward/bounty_hunter
	name = "Subconscious Mercenary"
	desc = "Sure, you need help of subconscious mercenary."
	buy_message = null
	id = "bounty_hunter"
	cost = 100

/datum/bobux_reward/bounty_hunter/on_buy(client/noob)
	..()
	var/list/possible_targets = list()
	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(H.mind)
			possible_targets |= H
	if(!length(possible_targets))
		to_chat(noob, "<span class='bobux'>You are unable to send a subconscious mercenary. Kaotiks refunded.</span>")
		noob.prefs?.adjust_bobux(cost)
		return FALSE
	var/mob/living/carbon/human/input = input(noob, "I have contracted a subconscious mercenary. Who is the first victim?", "Subconscious Mercenary", null) as mob in possible_targets
	if(!input)
		to_chat(noob, "<span class='bobux'>You are unable to send a subconscious mercenary. Kaotiks refunded.</span>")
		noob.prefs?.adjust_bobux(cost)
		return FALSE
	else
		for(var/mob/living/carbon/human/H in shuffle(GLOB.player_list - input))
			var/datum/antagonist/traitor/bounty_hunter = H.mind.add_antag_datum(/datum/antagonist/traitor)
			for(var/datum/objective/O in bounty_hunter.objectives)
				qdel(O)
			var/datum/objective/assassinate/kill_objective = new
			kill_objective.owner = H.mind
			kill_objective.target = input.mind
			bounty_hunter.objectives += kill_objective
			H.mind.announce_objectives()
			to_chat(input.mind, span_dead("Someone's hunting you."))
			return TRUE

/datum/bobux_reward/market_crash
	name = "Market Crash"
	desc = "Destroy the kaotik system."
	buy_message = "You're a big guy."
	id = "market_crash"
	cost = 300
	single_use = TRUE

/datum/bobux_reward/market_crash/on_buy(client/noob)
	. = ..()
	to_chat(world, "<span class='userdanger'><span class='big bold'>The kaotik system was destroyed by [noob.key]!</span></span>")
//	SEND_SOUND(world, sound('modular_skyrat/sound/misc/dumpit.ogg', volume = 50))
	message_admins("[noob] has destroyed the kaotik system!")
	log_admin("[noob] has destroyed the kaotik system!")
	var/list/bogged = flist("data/player_saves/")
	for(var/fuck in bogged)
		if(copytext(fuck, -1) != "/")
			continue
		var/list/bogged_again = flist("data/player_saves/[fuck]")
		for(var/fucked in bogged_again)
			if(copytext(fucked, -1) != "/")
				continue
			var/savefile/S = new /savefile("data/player_saves/[fuck][fucked]preferences.sav")
			if(!S)
				continue
			S.cd = "/"
			WRITE_FILE(S["bobux_amount"], 0)
	for(var/client/C in GLOB.clients)
		C.prefs?.adjust_bobux(-C.prefs.bobux_amount)
	for(var/datum/preferences/prefs in world)
		prefs.load_preferences()
/*
/datum/bobux_reward/cum_shower
	name = "Chungus Prank"
	desc = "Make everyone cum."
	buy_message = "I'M COOOOOOOOOOOOOMING"
	id = "coom"
	cost = 100
	single_use = TRUE

/datum/bobux_reward/cum_shower/on_buy(client/noob)
	. = ..()
//	if(noob.key == "Subaruuuuu")
//		to_chat(noob, "<span class='bobux'>fuck you lol!!!!!</span>")
//		message_admins("[noob] tried to make everyone coom, too bad!")
//		return FALSE
	message_admins("[noob] has made everyone COOM.")
	log_admin("[noob] has made everyone COOM.")
	to_chat(world, "<span class='reallybig hypnophrase'>[noob.key] has made everyone cum!</span>")
	var/cumsound = pick('modular_pod/sound/eff/coom.ogg','modular_pod/sound/eff/bobcoomer.ogg')
	SEND_SOUND(world, sound(cumsound, volume = 50))
	to_chat(world, "<span class='reallybig hypnophrase'>I'M COOMING!!!</span>")
	for(var/mob/living/carbon/human/coomer in GLOB.mob_living_list)
//		coomer.moan()
//		coomer.cum()
		coomer.handle_user_climax()
*/

/datum/bobux_reward/farto
	name = "Chungus Prank"
	desc = "Make everyone fart."
	buy_message = "I'M FAAARTING!"
	id = "fart"
	cost = 100
	single_use = TRUE

/datum/bobux_reward/farto/on_buy(client/noob)
	. = ..()
//	if(noob.key == "Subaruuuuu")
//		to_chat(noob, "<span class='bobux'>fuck you lol!!!!!</span>")
//		message_admins("[noob] tried to make everyone coom, too bad!")
//		return FALSE
	message_admins("[noob] has made everyone FART.")
	log_admin("[noob] has made everyone FART.")
	to_chat(world, "<span class='reallybig hypnophrase'>[noob.key] has made everyone fart!</span>")
//	var/cumsound = pick('modular_pod/sound/eff/coom.ogg','modular_pod/sound/eff/bobcoomer.ogg')
//	SEND_SOUND(world, sound(cumsound, volume = 50))
	to_chat(world, "<span class='reallybig hypnophrase'>I'M FARTING!!!!</span>")
	for(var/mob/living/carbon/human/coomer in GLOB.mob_living_list)
//		coomer.moan()
//		coomer.cum()
//		coomer.handle_user_climax()
		coomer.emote("fart")