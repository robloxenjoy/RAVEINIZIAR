/datum/component/fraggot
	/// Annoying fullscreen overlay
	var/atom/movable/screen/fullscreen/niqqer/niqqerlay

/datum/component/fraggot/Initialize()
	if(!isliving(parent))
		return COMPONENT_INCOMPATIBLE

/datum/component/fraggot/RegisterWithParent()
	var/mob/living/our_fraggot = parent
	our_fraggot.attributes?.add_diceroll_modifier(/datum/diceroll_modifier/fraggot)
	for(var/mob/living/carbon/human/human in (GLOB.mob_living_list - our_fraggot))
		SEND_SIGNAL(human, COMSIG_ADD_MOOD_EVENT, "[our_fraggot.real_name]", /datum/mood_event/fraggot, our_fraggot)
	RegisterSignal(our_fraggot, COMSIG_PARENT_EXAMINE, .proc/fraggot_examine)
	RegisterSignal(our_fraggot, COMSIG_LIVING_DEATH, .proc/fraggot_died)
	RegisterSignal(our_fraggot, COMSIG_PARENT_PREQDELETED, .proc/fraggot_deleted)
	ADD_TRAIT(our_fraggot, TRAIT_FRAGGOT, "fraggot")
	START_PROCESSING(SSfraggots, src)
	niqqerlay = our_fraggot.overlay_fullscreen("niqqer", /atom/movable/screen/fullscreen/niqqer)

/datum/component/fraggot/UnregisterFromParent()
	var/mob/living/our_fraggot = parent
	STOP_PROCESSING(SSfraggots, src)
	UnregisterSignal(our_fraggot, COMSIG_LIVING_DEATH)
	UnregisterSignal(our_fraggot, COMSIG_PARENT_PREQDELETED)
	UnregisterSignal(our_fraggot, COMSIG_PARENT_EXAMINE)
	REMOVE_TRAIT(our_fraggot, TRAIT_FRAGGOT, "fraggot")
	for(var/mob/living/carbon/human/human in (GLOB.mob_living_list - our_fraggot))
		SEND_SIGNAL(human, COMSIG_CLEAR_MOOD_EVENT, "[our_fraggot.real_name]")
	our_fraggot.clear_fullscreen("niqqer")
	niqqerlay = null

/datum/component/fraggot/proc/fraggot_died(mob/living/our_fraggot)
	if(!QDELETED(our_fraggot))
		our_fraggot.gib()

/datum/component/fraggot/proc/fraggot_deleted(mob/living/our_fraggot)
	for(var/mob/living/carbon/human/human in (GLOB.mob_living_list - our_fraggot))
		SEND_SIGNAL(human, COMSIG_CLEAR_MOOD_EVENT, "[our_fraggot.real_name]")

/datum/component/fraggot/proc/fraggot_examine(mob/living/our_fraggot, mob/user, list/examine_text)
	examine_text += span_flashingdanger("[uppertext(our_fraggot.name)] IS A FRAGGOT! [uppertext(our_fraggot.p_they())] MUST BE KILLED!")
	if(user.client)
		SEND_SOUND(user.client, sound('modular_septic/sound/effects/yomai.ogg', FALSE, CHANNEL_LOBBYMUSIC, 100))

/datum/component/fraggot/process(delta_time)
	var/mob/living/our_fraggot = parent
	if(our_fraggot.client)
		var/static/list/fraggot_lines = list(
			"BIG CHUNGUS LOLOLOLOLLLLOLOLOLO!!!!", \
			"UGANDA KNUCKLES LOLOLOLOL!", \
			"REDDIT!!!!!!", \
			"LGBT!!!", \
			"GAMING!!!!", \
			"NIGGERS!!!!!", \
			"LIFEWEB!!!!", \
			"FAGGOTS!!!", \
			"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAHHHH!!!!!", \
			"GODDAMNIT!!!!", \
			"FUCK!!!!", \
			"Okay, WHO TOOK A SHIT IN MY CUM SOCK? The cum sock and poop sock are CLEARLY LABELED. I should know, because I embroidered them myself after the last incident. If you quinkers could take TWO SECONDS of your time to make sure you have the right sock before dropping a MASSIVE FUDGE DRAGON inside of it, I wouldn't be sitting here jacking off into a pile of SHIT right now. Seriously, this is a mess. I've got squishy chunks oozing out the hole, the fabric is soaking through with juices, my phone is covered in shit, and the smell is god AWFUL. I'm not kidding guys. My mom is gonna be LIVID when she cleans this off my bedsheets. It's everywhere and I'm honestly disgusted. Fess up now and it will be easier for all of us, trust me.", \
			"The black community has suffered more than enough. We, as Funko POP owners, need to stand with them and DEMAND that Funko honors the lives of black victims of police brutality by making a George Floyd Funko POP. We need to tell the world to take a stand against anti-black racism, and there would be no better way to do so than buying a George Floyd Funko POP. Will you take a stand and join me?", \
			"So I ask you: If Mario is way out there, but the position used for floor detection is still in the box, can he still stand? The answer is yes. As far as the game sees it, Mario is in fact above land out here, because the game checks for floor detection back over there. \['There' is the actual course.\] So for all intensive purposes there is land over here! This is known as a parallel universe, or a PU for short.", \
		)
		var/message = pick(fraggot_lines)
		to_chat(our_fraggot, span_horny(span_big(message)))
		var/static/list/fraggot_sounds = list(
			'modular_septic/sound/memeshit/pigdeath.ogg',
			'modular_septic/sound/memeshit/naggers.ogg',
			'modular_septic/sound/memeshit/nigger.ogg',
			'modular_septic/sound/memeshit/niggers.ogg',
			'modular_septic/sound/memeshit/nigger_alarm.ogg',
			'modular_septic/sound/memeshit/augh.ogg',
			'modular_septic/sound/memeshit/loudnigra.ogg',
			'modular_septic/sound/memeshit/socialcreditsdeducted.ogg',
			'modular_septic/sound/memeshit/youstupid.ogg',
		)
		if(DT_PROB(10, delta_time))
			var/sound/annoying = sound(pick(fraggot_sounds), FALSE, 0, CHANNEL_LOBBYMUSIC, 200)
			SEND_SOUND(our_fraggot.client, annoying)
		if(DT_PROB(0.25, delta_time))
			our_fraggot.client.bruh_moment()
	if(DT_PROB(1, delta_time))
		our_fraggot.agony_scream()
	else if(DT_PROB(1, delta_time))
		our_fraggot.death_scream()
	if(ishuman(our_fraggot))
		var/mob/living/carbon/human/human_fraggot = our_fraggot
		if(DT_PROB(5, delta_time))
			human_fraggot.piss(FALSE)
		if(DT_PROB(5, delta_time))
			human_fraggot.shit(FALSE)
		human_fraggot.adjust_lust(250 * delta_time)
