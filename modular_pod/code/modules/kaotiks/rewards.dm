//the rewards themselves
/*
/datum/bobux_reward/become_traitor
	name = "Become A Dream Terrorist"
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
*/

/datum/bobux_reward/stat_str
	name = "+1 СЛ"
	desc = "Увеличить силу."
	buy_message = "<b>Я становлюсь СИЛЬНЕЕ БЛЯТЬ!</span>"
	id = "strboost"
	cost = 50

/datum/bobux_reward/stat_str/can_buy(client/noob, silent, fail_message)
	. = ..()
	if(!noob.mob.attributes)
		return FALSE
	if(. && ishuman(noob.mob) && noob.mob.mind)
		return TRUE

/datum/bobux_reward/stat_str/on_buy(client/noob)
	. = ..()
	var/list/stat_modification = list( \
	STAT_STRENGTH = 1, \
	)
	noob.mob.attributes?.add_or_update_variable_attribute_modifier(/datum/attribute_modifier/kaotik/str, TRUE, stat_modification)

/datum/bobux_reward/stat_end
	name = "+1 СТ"
	desc = "Увеличить здоровье."
	buy_message = "<b>Я становлюсь ЗДОРОВЕЕ БЛЯТЬ!</span>"
	id = "endboost"
	cost = 50

/datum/bobux_reward/stat_end/can_buy(client/noob, silent, fail_message)
	. = ..()
	if(!noob.mob.attributes)
		return FALSE
	if(. && ishuman(noob.mob) && noob.mob.mind)
		return TRUE

/datum/bobux_reward/stat_end/on_buy(client/noob)
	. = ..()
	var/list/stat_modification = list( \
	STAT_ENDURANCE = 1, \
	)
	noob.mob.attributes?.add_or_update_variable_attribute_modifier(/datum/attribute_modifier/kaotik/end, TRUE, stat_modification)

/datum/bobux_reward/stat_dex
	name = "+1 ЛВ"
	desc = "Увеличить ловкость."
	buy_message = "<b>Я становлюсь ЛОВЧЕ БЛЯТЬ!</span>"
	id = "dexboost"
	cost = 50

/datum/bobux_reward/stat_dex/can_buy(client/noob, silent, fail_message)
	. = ..()
	if(!noob.mob.attributes)
		return FALSE
	if(. && ishuman(noob.mob) && noob.mob.mind)
		return TRUE

/datum/bobux_reward/stat_dex/on_buy(client/noob)
	. = ..()
	var/list/stat_modification = list( \
	STAT_DEXTERITY = 1, \
	)
	noob.mob.attributes?.add_or_update_variable_attribute_modifier(/datum/attribute_modifier/kaotik/dex, TRUE, stat_modification)

/datum/bobux_reward/combat_boost
	name = "Улучшить боевой настрой"
	desc = "Увеличивает навыки ближнего боя."
	buy_message = "<b>Я становлюсь лучше в ближнем бою!</span>"
	id = "combatboost"
	cost = 100

/datum/bobux_reward/combat_boost/can_buy(client/noob, silent, fail_message)
	. = ..()
	if(. && ishuman(noob.mob) && noob.mob.mind)
		return TRUE

/datum/bobux_reward/combat_boost/on_buy(client/noob)
	. = ..()
	noob.mob.attributes?.add_sheet(/datum/attribute_holder/sheet/kaotik/melee)

/datum/bobux_reward/range_boost
	name = "Улучшить боевой настрой"
	desc = "Увеличивает навыки дальнего боя."
	buy_message = "<b>Я становлюсь лучше в дальнем бою!</span>"
	id = "rangeboost"
	cost = 100

/datum/bobux_reward/range_boost/can_buy(client/noob, silent, fail_message)
	. = ..()
	if(. && ishuman(noob.mob) && noob.mob.mind)
		return TRUE

/datum/bobux_reward/range_boost/range/on_buy(client/noob)
	. = ..()
	noob.mob.attributes?.add_sheet(/datum/attribute_holder/sheet/kaotik/range)

/*
/datum/bobux_reward/possess_mob
	name = "Possess Mob"
	desc = "Possess a mindless mob, if you're a ghost."
	buy_message = "<b>My mind seizes control over a creature.</span>"
	id = "possess"
	cost = 100
	infinite_buy = TRUE

/datum/bobux_reward/possess_mob/can_buy(client/noob, silent, fail_message)
	. = ..()
	if(!isobserver(noob.mob))
		return FALSE
	if(. && noob.mob && length(GLOB.mob_living_list))
		return TRUE

/datum/bobux_reward/possess_mob/on_buy(client/noob)
	..()
	var/list/husks = list()
	for(var/mob/living/L in GLOB.mob_living_list)
		if(!L.mind && !L.client && !ismegafauna(L) && !istype(L, /mob/living/simple_animal/hostile/boss))
			husks |= L
	if(!length(husks))
		to_chat(noob, "<span class='bobux'>Хм, не могу.</span>")
		noob.prefs?.adjust_bobux(cost)
		return FALSE
	var/mob/living/choice = input(noob, "Возьму под контроль существо. Какое?", "Контроль", null) as mob in husks
	if(!choice)
//		to_chat(noob, "<span class='bobux'>Kaotiks refunded.</span>")
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
	cost = 50

/datum/bobux_reward/bounty_hunter/can_buy(client/noob, silent, fail_message)
	. = ..()
	if(!isobserver(noob.mob))
		if(is_merc_job(noob.mob.mind.assigned_role))
			return FALSE
	if(GLOB.alive_player_list <= 1)
		return FALSE

/datum/bobux_reward/bounty_hunter/on_buy(client/noob)
	..()
	var/list/possible_targets = list()
	for(var/mob/living/carbon/human/H in GLOB.alive_player_list)
		if(H.mind)
			possible_targets |= H
	if(!LAZYLEN(possible_targets))
//		to_chat(noob, "<span class='bobux'>You are unable to send a subconscious mercenary. Kaotiks refunded.</span>")
		noob.prefs?.adjust_bobux(cost)
		return FALSE
	if(GLOB.mercenary_list <= 0)
//		to_chat(noob, "<span class='bobux'>You are unable to send a subconscious mercenary. Kaotiks refunded.</span>")
		noob.prefs?.adjust_bobux(cost)
		return FALSE
	var/input = tgui_input_list(noob, "I have contracted a subconscious mercenaries. Who is the first victim?", "Who should be killed?", possible_targets)
	if(input)
		for(var/mob/living/carbon/human/H in shuffle(GLOB.player_list - input))
//			var/datum/job/job = SSjob.GetJob(rank)
			if(is_merc_job(H.mind.assigned_role))
//				var/datum/antagonist/traitor/submerc/bounty_hunter = H.mind.add_antag_datum(/datum/antagonist/traitor/submerc)
//				for(var/datum/objective/O in bounty_hunter.objectives)
//					qdel(O)
				var/datum/antagonist/custom/submerc/bounty_hunter = H.mind.has_antag_datum(/datum/antagonist/custom/submerc)
				var/datum/objective/assassinate/submerc/kill_objective = new
				var/victima = input
				kill_objective.owner = H.mind
				kill_objective.target = victima
				bounty_hunter.objectives += kill_objective
				H.mind.announce_objectives()
				to_chat(victima, span_dead("You're being hunted."))
				to_chat(noob, "<span class='bobux'>We have to wait for the creature to be killed. Pray that this dream have really good subconscious mercenaries.</span>")
				return TRUE
	else
//		to_chat(noob, "<span class='bobux'>You are unable to send a subconscious mercenary. Kaotiks refunded.</span>")
		noob.prefs?.adjust_bobux(cost)
		return FALSE
*/

/datum/bobux_reward/market_crash
	name = "Разрушить каотичную систему"
	desc = "А чё бы нет?"
	buy_message = "Я ахуеннен."
	id = "market_crash"
	cost = 700
	single_use = TRUE

/datum/bobux_reward/market_crash/on_buy(client/noob)
	. = ..()
	to_chat(world, "<span class='userdanger'><span class='big bold'>Каотичная Система была разрушена [noob.key]!</span></span>")
	SSbobux.working = FALSE
/*
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
*/

/*
/datum/bobux_reward/cum_shower
	name = "Chungus Prank"
	desc = "Make everyone cum."
	buy_message = "I'M COOOOOOOOOOOOOMING"
	id = "coom"
	cost = 100
	single_use = TRUE
	infinite_buy = TRUE

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
	name = "Пранк Чангуса"
	desc = "Заставит всех ООПБ!"
	buy_message = "Я сын чангуса!"
	id = "fart"
	cost = 200
//	single_use = TRUE
	infinite_buy = TRUE

/datum/bobux_reward/farto/on_buy(client/noob)
	. = ..()
//	if(noob.key == "Subaruuuuu")
//		to_chat(noob, "<span class='bobux'>fuck you lol!!!!!</span>")
//		message_admins("[noob] tried to make everyone coom, too bad!")
//		return FALSE
	message_admins("[noob] has made everyone PPFV.")
	log_admin("[noob] has made everyone PPFV.")
	to_chat(world, "<span class='reallybig hypnophrase'>[noob.key] заставляет всех ООПБ - обоссаться, обосраться, пердануть и блевануть!</span>")
//	var/cumsound = pick('modular_pod/sound/eff/coom.ogg','modular_pod/sound/eff/bobcoomer.ogg')
//	SEND_SOUND(world, sound(cumsound, volume = 50))
	to_chat(world, "<span class='reallybig hypnophrase'>Я ООПБ!!!!</span>")
	for(var/mob/living/carbon/human/coomer in GLOB.mob_living_list)
		if(coomer.mind)
			coomer.emote("fart")
			coomer.shit(FALSE)
			coomer.piss(FALSE)
			coomer.vomit(lost_nutrition = 100, blood = FALSE, stun = TRUE, distance = rand(1,2), message = TRUE, vomit_type = VOMIT_TOXIC, harm = TRUE, force = FALSE, purge_ratio = 0.1)
//		coomer.moan()
//		coomer.cum()
//		coomer.handle_user_climax()

/datum/bobux_reward/goodmood
	name = "Весёлый день"
	desc = "Сделай всех счастливее!"
	buy_message = "<b>А я хорош!</span>"
	id = "funnyday"
	cost = 100
	infinite_buy = TRUE

/datum/bobux_reward/goodmood/on_buy(client/noob)
	..()
	message_admins("[noob] has made everyone happier.")
	log_admin("[noob] has made everyone happier.")
	to_chat(world, "<span class='reallybig hypnophrase'>[noob.key] делает всех счастливее! Заебись!</span>")
	for(var/mob/living/carbon/human/coomer in GLOB.mob_living_list)
		if(coomer.mind)
			SEND_SIGNAL(coomer, COMSIG_ADD_MOOD_EVENT, "funnyday", /datum/mood_event/koatik)

/datum/bobux_reward/blackout
	name = "Блэкаут"
	desc = "Жалкая имитация, но всё ещё страшная!"
	buy_message = "<b>Пизда!</span>"
	id = "blackout"
	cost = 500
	infinite_buy = TRUE

/datum/bobux_reward/blackout/can_buy(client/noob, silent, fail_message)
	. = ..()
	for(var/area/maintenance/polovich/forest/A in world)
		if(A.static_lighting)
			return

/datum/bobux_reward/blackout/on_buy(client/noob)
	..()
	to_chat(world, "<span class='reallybig hypnophrase'>[noob.key] обрушивает Блэкаут!</span>")
	for(var/area/maintenance/polovich/forest/A in world)
		if(!A.lighting_out)
			continue
		A.set_base_lighting(new_alpha = 1)
		A.static_lighting = TRUE
		A.create_area_lighting_objects()

/datum/bobux_reward/lightout
	name = "Лайтаут"
	desc = "Вернуть свет!"
	buy_message = "<b>Отлично-отлично!</span>"
	id = "lightout"
	cost = 200
	infinite_buy = TRUE

/datum/bobux_reward/lightout/can_buy(client/noob, silent, fail_message)
	. = ..()
	for(var/area/maintenance/polovich/forest/A in world)
		if(!A.static_lighting)
			return

/datum/bobux_reward/lightout/on_buy(client/noob)
	..()
	to_chat(world, "<span class='reallybig hypnophrase'>[noob.key] вызывает Лайтаут!</span>")
	for(var/area/maintenance/polovich/forest/A in world)
		if(!A.lighting_out)
			continue
		A.static_lighting = FALSE
		A.set_base_lighting(new_alpha = 255)
		A.remove_area_lighting_objects()

/datum/bobux_reward/activate_muzon
	name = "Врубить Музон"
	desc = "Надо послушать!"
	buy_message = "<b>Пизда!</span>"
	id = "muzon"
	cost = 400
	infinite_buy = TRUE

/datum/bobux_reward/activate_muzon/can_buy(client/noob, silent, fail_message)
	. = ..()
	for(var/area/maintenance/polovich/forest/A in world)
		if(A.droning_sound == DRONING_MUZON)
			return

/datum/bobux_reward/activate_muzon/on_buy(client/noob)
	..()
	to_chat(world, "<span class='reallybig hypnophrase'>[noob.key] вызывает Музон!</span>")
	for(var/area/maintenance/polovich/forest/A in world)
		if(A.ino)
			continue
		if(A.droning_sound != DRONING_MUZON)
			A.droning_sound = DRONING_MUZON

/datum/bobux_reward/remove_muzon
	name = "Убрать Музон"
	desc = "Пора всё по-нормальному сделать!"
	buy_message = "<b>Отлично-отлично!</span>"
	id = "removemuzon"
	cost = 200
	infinite_buy = TRUE

/datum/bobux_reward/remove_muzon/can_buy(client/noob, silent, fail_message)
	. = ..()
	for(var/area/maintenance/polovich/forest/A in world)
		if(A.droning_sound != DRONING_MUZON)
			return

/datum/bobux_reward/remove_muzon/on_buy(client/noob)
	..()
	to_chat(world, "<span class='reallybig hypnophrase'>[noob.key] убирает Музон!</span>")
	for(var/area/maintenance/polovich/forest/A in world)
		if(A.ino)
			continue
		if(A.droning_sound == DRONING_MUZON)
			A.droning_sound = initial(A.droning_sound)

/datum/bobux_reward/changename
	name = "Сменить Имя"
	desc = "Пора бы."
	buy_message = "<b>Новое имя! Мудрый выбор!</span>"
	id = "changename"
	cost = 30
	infinite_buy = TRUE

/datum/bobux_reward/changename/can_buy(client/noob, silent, fail_message)
	. = ..()
	if(. && ishuman(noob.mob) && noob.mob.mind)
		return TRUE

/datum/bobux_reward/changename/on_buy(client/noob)
	. = ..()
	var/rolevich = input("Какое имя?", "") as text
	noob.mob.real_name = rolevich
	noob.mob.name = rolevich

/*
/datum/bobux_reward/respawn
	name = "Respawn"
	desc = "Just forget all about it."
	buy_message = "<b>I AM NEW!</span>"
	id = "respawn"
	cost = 100

/datum/bobux_reward/respawn/can_buy(client/noob, silent, fail_message)
	. = ..()
	if(!isobserver(noob.mob))
		return FALSE

/datum/bobux_reward/respawn/on_buy(client/noob)
	. = ..()
	SSdroning.kill_droning(noob)
//	noob.stop_sound_channel(CHANNEL_HEARTBEAT)
	var/mob/dead/new_player/M = new /mob/dead/new_player()
	M.ckey = noob.ckey
*/
