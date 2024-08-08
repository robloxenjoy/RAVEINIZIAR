// all pistols
/obj/item/gun/ballistic/automatic/pistol
	fire_delay = 1
	carry_weight = 1
	carry_weight = 0.8
	safety_off_sound = 'modular_septic/sound/weapons/guns/pistol/pistol_safety.ogg'
	safety_on_sound = 'modular_septic/sound/weapons/guns/pistol/pistol_safety.ogg'
	skill_melee = SKILL_IMPACT_WEAPON
	skill_ranged = SKILL_PISTOL
	suppressed = SUPPRESSED_NONE
	equip_sound = 'modular_septic/sound/weapons/guns/pistol/pistol_holster.ogg'
	drop_sound = 'modular_septic/sound/weapons/guns/drop_lightgun.ogg'
	tetris_width = 64
	tetris_height = 64

// RUGER MKIV
/obj/item/gun/ballistic/automatic/pistol
	name = "\improper Plinker pistol"
	desc = "A small, easily concealable 9mm handgun. Has a threaded barrel for suppressors."
	icon = 'modular_septic/icons/obj/items/guns/pistol.dmi'
	icon_state = "ruger"
	base_icon_state = "ruger"
	pickup_sound = 'modular_septic/sound/weapons/guns/pistol/pistol_draw.ogg'
	lock_back_sound = 'modular_septic/sound/weapons/guns/pistol/pistol_lockback.ogg'
	bolt_drop_sound = 'modular_septic/sound/weapons/guns/pistol/pistol_lockin.ogg'
	eject_sound = 'modular_septic/sound/weapons/guns/pistol/pistol_magout.ogg'
	eject_empty_sound = 'modular_septic/sound/weapons/guns/pistol/pistol_magout.ogg'
	eject_sound_vary = FALSE
	rack_sound_vary = FALSE
	load_sound = 'modular_septic/sound/weapons/guns/pistol/pistol_magin.ogg'
	load_empty_sound = 'modular_septic/sound/weapons/guns/pistol/pistol_magin.ogg'
	rack_sound = 'modular_septic/sound/weapons/guns/pistol/pistol_rack.ogg'
	far_fire_sound = 'mojave/sound/ms13weapons/distant_shots/9mmpistol.ogg'
	gunshot_animation_information = list(
		"pixel_x" = 15, \
		"pixel_y" = 1, \
		"inactive_wben_suppressed" = TRUE, \
	)
	recoil_animation_information = list(
		"recoil_angle_upper" = -15, \
		"recoil_angle_lower" = -30, \
	)
	suppressor_x_offset = 10
	w_class = WEIGHT_CLASS_NORMAL
	carry_weight = 1 KILOGRAMS
	custom_price = 3000

// BERETTA 69R
/obj/item/gun/ballistic/automatic/pistol/aps
	name = "\improper 69R machine pistol"
	desc = "A machine pistol made by some crazy italians, capable of shooting in 3-round bursts. \
		Uses 9mm ammo. Has a threaded barrel for suppressors."
	fire_sound = 'modular_septic/sound/weapons/guns/pistol/aps.ogg'
	suppressed_sound = list(
		'modular_septic/sound/weapons/guns/pistol/glock_suppressed1.ogg', \
		'modular_septic/sound/weapons/guns/pistol/glock_suppressed2.ogg', \
	)
	load_sound = 'modular_septic/sound/weapons/guns/pistol/aps_magin.ogg'
	load_empty_sound = 'modular_septic/sound/weapons/guns/pistol/aps_magin.ogg'
	eject_sound = 'modular_septic/sound/weapons/guns/pistol/aps_magout.ogg'
	eject_empty_sound = 'modular_septic/sound/weapons/guns/pistol/aps_magout.ogg'
	lock_back_sound = 'modular_septic/sound/weapons/guns/pistol/aps_lockback.ogg'
	bolt_drop_sound = 'modular_septic/sound/weapons/guns/pistol/aps_lockin.ogg'
	rack_sound = 'modular_septic/sound/weapons/guns/pistol/aps_rack.ogg'
	far_fire_sound = 'mojave/sound/ms13weapons/distant_shots/9mmpistol.ogg'
	icon = 'modular_septic/icons/obj/items/guns/pistol.dmi'
	icon_state = "b93r"
	base_icon_state = "b93r"
	gunshot_animation_information = list(
		"pixel_x" = 15, \
		"pixel_y" = 2, \
		"inactive_wben_suppressed" = TRUE, \
	)
	recoil_animation_information = list(
		"recoil_angle_upper" = -15, \
		"recoil_angle_lower" = -30, \
		"recoil_burst_speed" = 0.5, \
		"return_burst_speed" = 0.5, \
	)
	burst_size = 3
	suppressor_x_offset = 11
	w_class = WEIGHT_CLASS_NORMAL
	carry_weight = 1.5 KILOGRAMS
	custom_price = 4500
	full_auto = TRUE

/obj/item/gun/ballistic/automatic/pistol/remis

// M1911
/obj/item/gun/ballistic/automatic/pistol/m1911
	name = "\improper M1911"
	desc = "A classical copy of a antique design, even centuries later is efficient for close-quarter combat and self-defence at the cost of magazine capacity."
	icon = 'modular_septic/icons/obj/items/guns/pistol.dmi'
	icon_state = "m1911"
	base_icon_state = "m1911"
	gunshot_animation_information = list(
		"pixel_x" = 16, \
		"pixel_y" = 2, \
		"inactive_wben_suppressed" = TRUE,
	)
	recoil_animation_information = list()
	fire_sound = 'modular_septic/sound/weapons/guns/pistol/colt1.ogg'
	rack_sound = 'modular_septic/sound/weapons/guns/pistol/pistol_rack.ogg'
	far_fire_sound = 'mojave/sound/ms13weapons/distant_shots/45_pistol.ogg'
	force = 10
	w_class = WEIGHT_CLASS_NORMAL
	carry_weight = 1 KILOGRAMS
	custom_price = 3500

// USP
/obj/item/gun/ballistic/automatic/pistol/cortes //corruptable gun
	name = "Cortes"
	desc = "This is used either by bandits or by pros."
	icon = 'modular_septic/icons/obj/items/guns/pistol.dmi'
	icon_state = "USP"
	base_icon_state = "USP"
	gunshot_animation_information = list(
		"pixel_x" = 16, \
		"pixel_y" = 2, \
		"inactive_wben_suppressed" = TRUE,
	)
	recoil_animation_information = list()
	fire_sound = list('modular_septic/sound/weapons/guns/pistol/USP1.ogg', 'modular_septic/sound/weapons/guns/pistol/USP2.ogg')
	rack_sound = 'modular_septic/sound/weapons/guns/pistol/john_rack.ogg'
	lock_back_sound = 'modular_septic/sound/weapons/guns/pistol/john_lockback.ogg'
	bolt_drop_sound = 'modular_septic/sound/weapons/guns/pistol/john_lockin.ogg'
	far_fire_sound = 'mojave/sound/ms13weapons/distant_shots/45_pistol.ogg'
	mag_type = /obj/item/ammo_box/magazine/u45
	can_suppress = FALSE
	force = 15
	w_class = WEIGHT_CLASS_NORMAL
	carry_weight = 1 KILOGRAMS
	var/corrupted = FALSE
	var/corrupted_shot_sound = list('modular_septic/sound/weapons/guns/pistol/USP_corrupt1.ogg', 'modular_septic/sound/weapons/guns/pistol/USP_corrupt2.ogg')
	var/corruption_cooldown_duration = 1 SECONDS
	COOLDOWN_DECLARE(corruption_cooldown)
	custom_price = 3500

/obj/item/gun/ballistic/automatic/pistol/cortes/examine(mob/user)
	. = ..()
	var/mob/living/carbon/human/human_user
	if(ishuman(user))
		human_user = user
	if(HAS_TRAIT(human_user, TRAIT_GAKSTER) && !corrupted)
		. += span_warning("An <span class='boldwarning'>inborn</span> can do something special with this to make it <span class='boldwarning'>more powerful.</span> It'd be <span class='boldwarning'>suicide</span> to be allies with one.")
	if(human_user.dna?.species?.id == SPECIES_INBORN && !corrupted)
		. += span_boldwarning("I can alternatively use this to corrupt it and empower it with Liminal Power.")

/obj/item/gun/ballistic/automatic/pistol/cortes/alt_click_secondary(mob/user)
	var/mob/living/carbon/human/human_user
	if(ishuman(user))
		human_user = user
	if(COOLDOWN_FINISHED(src, corruption_cooldown) && human_user.dna?.species?.id == SPECIES_INBORN && !corrupted)
		var/corruption_chance = GET_MOB_ATTRIBUTE_VALUE(human_user, STAT_INTELLIGENCE)*4.20 // :3
		human_user.audible_message(span_boldwarning("[human_user] whispers a secret into [src]'s ear."))
		playsound(human_user, 'modular_septic/sound/effects/whispers.ogg', 35, TRUE)
		corrupt(corruption_chance, user)
		COOLDOWN_START(src, corruption_cooldown, corruption_cooldown_duration)

/obj/item/gun/ballistic/automatic/pistol/cortes/proc/corrupt(chance = 0, mob/inborn)
	if(corrupted)
		return
	if(prob(chance))
		visible_message(span_warning("[src] grumbles."))
		corrupted = TRUE
		sleep(rand(1 SECONDS, 1.5 SECONDS))
		visible_message(span_warning("[src] <span class='boldwarning'>CORRUPTS!</span>"))
		to_chat(inborn, span_notice("I have corrupted the [src]."))
//		playsound(src, 'modular_septic/sound/heart/inborn_combatcocktail.ogg', 80, FALSE)
		name = "\improper Cortraxx .45"
		desc = "A lavish pistol for a lavish life. <span class='boldwarning'>It has been corrupted.</span>"
		icon_state = "USP_corrupted"
		base_icon_state = "USP_corrupted"
		update_appearance(UPDATE_ICON)
	else
		say(pick("No...", "It can't be...", "Stop..."))

/obj/item/gun/ballistic/automatic/pistol/cortes/shoot_live_shot(mob/living/user, pointblank = FALSE, atom/target, message = TRUE)
	. = ..()
	if(corrupted)
		playsound(user, corrupted_shot_sound, 70, FALSE)

// STI 2011 COMBAT MASTER
/obj/item/gun/ballistic/automatic/pistol/remis/combatmaster
	name = "\improper Frag Master 2511"
	desc = "An expensive, reliable handgun with a large magazine capacity. \
			Very similar to the Cold 1911, but chambered in 9mm and made with modern materials such as a polymer handle and titanium frame."
	icon = 'modular_septic/icons/obj/items/guns/pistol.dmi'
	icon_state = "combatmaster"
	base_icon_state = "combatmaster"
	fire_sound = list('modular_septic/sound/weapons/guns/pistol/combatmaster1.ogg', 'modular_septic/sound/weapons/guns/pistol/combatmaster2.ogg')
	suppressed_sound = 'modular_septic/sound/weapons/guns/pistol/combatmaster_silenced.ogg'
	far_fire_sound = 'mojave/sound/ms13weapons/distant_shots/9mmpistol.ogg'
	gunshot_animation_information = list(
		"pixel_x" = 15, \
		"pixel_y" = 1, \
		"inactive_wben_suppressed" = TRUE, \
	)
	recoil_animation_information = list(
		"recoil_angle_upper" = -15, \
		"recoil_angle_lower" = -30,
	)
	force = 10
	suppressor_x_offset = 12
	mag_type = /obj/item/ammo_box/magazine/combatmaster9mm
	w_class = WEIGHT_CLASS_NORMAL
	carry_weight = 1 KILOGRAMS
	custom_price = 4500

// GLOCK-17
/obj/item/gun/ballistic/automatic/pistol/remis/glock17
	name = "\improper Gosma-17 9mm pistol"
	desc = "A chunky pistol often accompanied with the screams of thugs."
	icon = 'modular_septic/icons/obj/items/guns/pistol.dmi'
	icon_state = "glock"
	base_icon_state = "glock"
	fire_sound = list('modular_septic/sound/weapons/guns/pistol/glock1.ogg', \
					'modular_septic/sound/weapons/guns/pistol/glock2.ogg')
	suppressed_sound = list('modular_septic/sound/weapons/guns/pistol/glock_suppressed1.ogg', \
					'modular_septic/sound/weapons/guns/pistol/glock_suppressed2.ogg')
	far_fire_sound = 'mojave/sound/ms13weapons/distant_shots/9mmpistol.ogg'
	gunshot_animation_information = list(
		"pixel_x" = 15, \
		"pixel_y" = 5, \
	)
	recoil_animation_information = list(
		"recoil_angle_upper" = -20, \
		"recoil_angle_lower" = -35, \
	)
	force = 10
	mag_type = /obj/item/ammo_box/magazine/glock9mm
	mag_display = TRUE
	can_suppress = TRUE
	w_class = WEIGHT_CLASS_NORMAL
	carry_weight = 1 KILOGRAMS
	custom_price = 2500
	suppressor_x_offset = 10

// WALTHER PPK
/obj/item/gun/ballistic/automatic/pistol/remis/ppk
	name = "\improper Bombeiro 22lr pistol"
	desc = "The Walter Bomberio pistol is a reliable, easily concealable 22lr pistol. \
			Doesn't pack too much of a punch, but was famously used by a british secret agent."
	icon = 'modular_septic/icons/obj/items/guns/pistol.dmi'
	icon_state = "ppk"
	base_icon_state = "ppk"
	fire_sound = list('modular_septic/sound/weapons/guns/pistol/walter1.ogg',
					'modular_septic/sound/weapons/guns/pistol/walter2.ogg')
	suppressed_sound = 'modular_septic/sound/weapons/guns/pistol/walter_silenced.ogg'
	safety_on_sound = 'modular_septic/sound/weapons/guns/pistol/walter_safety.ogg'
	safety_off_sound = 'modular_septic/sound/weapons/guns/pistol/walter_safety.ogg'
	far_fire_sound = 'mojave/sound/ms13weapons/distant_shots/22_smg.ogg'
	gunshot_animation_information = list(
		"pixel_x" = 11, \
		"pixel_y" = 1, \
		"inactive_wben_suppressed" = TRUE, \
	)
	recoil_animation_information = list(
		"recoil_angle_upper" = -10, \
		"recoil_angle_lower" = -20, \
	)
	client_recoil_animation_information = list(
		"strength" = 0.35,
		"duration" = 2,
	)
	mag_type = /obj/item/ammo_box/magazine/ppk22lr
	mag_display = TRUE
	can_suppress = TRUE
	w_class = WEIGHT_CLASS_SMALL
	carry_weight = 500 GRAMS
	suppressor_x_offset = 8
	custom_price = 900

/obj/item/gun/ballistic/automatic/pistol/remis/ppk/empty
	spawnwithmagazine = FALSE

// "DEAGLE"
/obj/item/gun/ballistic/automatic/pistol/remis/aniquilador
	name = "\improper Aniquilador .50 LE Anti-Personnel Firearm"
	desc = "A very rare firearm that can be found within experimental military bases, comes loaded with .50 LE, Living Exterminator rounds. \
		Feeling the gun in your hand, he never stops nervously shaking and vibrating until you aim down the sights at a living being."
	icon = 'modular_septic/icons/obj/items/guns/pistol.dmi'
	lefthand_file = 'modular_septic/icons/obj/items/guns/inhands/pistol_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/guns/inhands/pistol_righthand.dmi'
	inhand_icon_state = "one"
	icon_state = "aniquilador"
	base_icon_state = "aniquilador"
	gunshot_animation_information = list(
		"pixel_x" = 16, \
		"pixel_y" = 2, \
	)
	recoil_animation_information = list()
	fire_sound = 'modular_septic/sound/weapons/guns/pistol/one.ogg'
	far_fire_sound = 'mojave/sound/ms13weapons/distant_shots/amr.ogg'
	rack_sound = 'modular_septic/sound/weapons/guns/pistol/one_rack.ogg'
	lock_back_sound = 'modular_septic/sound/weapons/guns/pistol/one_lockback.ogg'
	bolt_drop_sound = 'modular_septic/sound/weapons/guns/pistol/one_lockin.ogg'
	aim_stress_sound = list('modular_septic/sound/weapons/guns/pistol/voice_anaquilador/anaquilador_getout.ogg',
						'modular_septic/sound/weapons/guns/pistol/voice_anaquilador/anaquilador_noescape.ogg')
	aim_spare_sound = 'modular_septic/sound/weapons/guns/rifle/voice_steyr/spare.ogg'
	force = 10
	fire_delay = 8
	mag_type = /obj/item/ammo_box/magazine/aniquilador
	w_class = WEIGHT_CLASS_NORMAL
	can_unsuppress = FALSE
	verb_say = "ravishes"
	carry_weight = 2 KILOGRAMS
	custom_price = 5500

/obj/item/gun/ballistic/automatic/pistol/remis/aniquilador/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_GUNPOINT_GUN_AIM_STRESS_SOUNDED, PROC_REF(aimed_sounding))

/obj/item/gun/ballistic/automatic/pistol/remis/aniquilador/Destroy()
	UnregisterSignal(src, COMSIG_GUNPOINT_GUN_AIM_STRESS_SOUNDED)
	return ..()

/obj/item/gun/ballistic/automatic/pistol/remis/aniquilador/proc/aimed_sounding(datum/component/gunpoint/gunpoint, sounding)
	var/voice_line = "FUCK!"
	switch(sounding)
		if('modular_septic/sound/weapons/guns/pistol/voice_anaquilador/anaquilador_getout.ogg')
			voice_line = "GET OUT FREAK."
		if('modular_septic/sound/weapons/guns/pistol/voice_anaquilador/anaquilador_noescape.ogg')
			voice_line = "THERE IS NO ESCAPE."
	if(voice_line)
		say(voice_line)
	INVOKE_ASYNC(src, .proc/we_do_a_little_shaking)

/obj/item/gun/ballistic/automatic/pistol/remis/aniquilador/proc/we_do_a_little_shaking(intensity = 4, time_in = 2, time_out = 2, loops = 3)
	for(var/i in 1 to loops)
		animate(src, pixel_x = pixel_x + intensity, time = time_in)
		sleep(time_in)
		animate(src, pixel_x = pixel_x - intensity, time = time_out)
		sleep(time_out)

/obj/item/gun/ballistic/automatic/pistol/remis/john
	name = "\improper John .50 AE Pistol"
	desc = "Who's that? Oh It's just John, don't worry. It's a plinking pistol."
	icon = 'modular_septic/icons/obj/items/guns/pistol.dmi'
	lefthand_file = 'modular_septic/icons/obj/items/guns/inhands/pistol_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/guns/inhands/pistol_righthand.dmi'
	inhand_icon_state = "five7"
	icon_state = "glockl"
	base_icon_state = "glockl"
	gunshot_animation_information = list(
		"pixel_x" = 16, \
		"pixel_y" = 2, \
	)
	recoil_animation_information = list()
	fire_sound = list('modular_septic/sound/weapons/guns/pistol/john1.ogg', 'modular_septic/sound/weapons/guns/pistol/john2.ogg')
	far_fire_sound = 'mojave/sound/ms13weapons/distant_shots/amr.ogg'
	rack_sound = 'modular_septic/sound/weapons/guns/pistol/john_rack.ogg'
	lock_back_sound = 'modular_septic/sound/weapons/guns/pistol/john_lockback.ogg'
	bolt_drop_sound = 'modular_septic/sound/weapons/guns/pistol/john_lockin.ogg'
	force = 15
	fire_delay = 2
	mag_type = /obj/item/ammo_box/magazine/john
	w_class = WEIGHT_CLASS_NORMAL
	can_unsuppress = FALSE
	carry_weight = 2 KILOGRAMS
	custom_price = 5500

/obj/item/gun/ballistic/automatic/pistol/remis/pm9
	name = "\improper PM9 Evil Gun"
	desc = "This is a strown together pack of metal that has just enough things touching eachother in the certain way to not burst in your hands when you fire. \
	A unholy abomination, a devious, godforsaken handgun. Use it with care."
	icon = 'modular_septic/icons/obj/items/guns/pistol.dmi'
	lefthand_file = 'modular_septic/icons/obj/items/guns/inhands/pistol_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/guns/inhands/pistol_righthand.dmi'
	inhand_icon_state = "pm9"
	icon_state = "pm9"
	base_icon_state = "pm9"
	gunshot_animation_information = list(
		"pixel_x" = 16, \
		"pixel_y" = 2, \
	)
	client_recoil_animation_information = list(
		"strength" = 1,
		"duration" = 2,
	)
	fire_sound = 'modular_septic/sound/weapons/guns/pistol/pm9.ogg'
	far_fire_sound = 'mojave/sound/ms13weapons/distant_shots/9mmpistol.ogg'
	suppressed_sound = 'modular_septic/sound/weapons/guns/pistol/pm9_suppressed.ogg'
	rack_sound = 'modular_septic/sound/weapons/guns/pistol/pm9_rack.ogg'
	lock_back_sound = 'modular_septic/sound/weapons/guns/pistol/pm9_lockback.ogg'
	bolt_drop_sound = 'modular_septic/sound/weapons/guns/pistol/pm9_lockin.ogg'
	load_sound = 'modular_septic/sound/weapons/guns/pistol/pm9_magin.ogg'
	load_empty_sound = 'modular_septic/sound/weapons/guns/pistol/pm9_magin.ogg'
	eject_sound = 'modular_septic/sound/weapons/guns/pistol/pm9_magout.ogg'
	eject_empty_sound = 'modular_septic/sound/weapons/guns/pistol/pm9_magout.ogg'
	force = 15
	fire_delay = 2
	mag_type = /obj/item/ammo_box/magazine/pm9
	bolt_type = BOLT_TYPE_LOCKING
	w_class = WEIGHT_CLASS_NORMAL
	suppressor_x_offset = 9
	carry_weight = 2
	custom_price = 5500

/obj/item/gun/ballistic/automatic/pistol/remis/pm9/desc_chaser(mob/user)
	. = list()
	var/image_src = image2html('modular_septic/images/pm9.gif', user, format = "gif", sourceonly = TRUE)
	. += "<img src='[image_src]' width=128 height=96>"
	. += ..()

/obj/item/gun/ballistic/automatic/pistol/remis/pm9/attackby(obj/item/A, mob/user, params)
	if(istype(A, /obj/item/suppressor))
		return
	. = ..()
	if(istype(A, /obj/item/reagent_containers/food/drinks/soda_cans/mug))
		var/obj/item/reagent_containers/food/drinks/soda_cans/mug/mug = A
		if(!can_suppress)
			to_chat(user, span_warning("I can't figure out how to fit the complex device on [src]!"))
			return
		if(!user.is_holding(src))
			to_chat(user, span_warning("I need be holding [src] to fit the complex device to it!"))
			return
		if(suppressed)
			to_chat(user, span_warning("[src] already has a suppressor!"))
			return
		if(user.transferItemToLoc(mug, src))
			install_suppressor(mug)
			playsound(user, 'modular_septic/sound/weapons/guns/silencer_start.ogg', 60, TRUE)
			to_chat(user, span_warning("I start screwing the fucking mug can on."))
			if(!do_after(user, 3 SECONDS, src))
				user.put_in_hands(mug)
				playsound(user, 'modular_septic/sound/weapons/guns/silencer_fumble.ogg', 25, TRUE)
				clear_suppressor()
				return
			to_chat(user, span_warning("I screw the mug can onto [src]. Are you happy now?"))
			playsound(user, 'modular_septic/sound/weapons/guns/silencer_on.ogg', 75, TRUE)
			return
/*
// USP
/obj/item/gun/ballistic/automatic/pistol/cortes //corruptable gun
	name = "\improper Cortes .45"
	desc = "A lavish pistol for a lavish life."
	icon = 'modular_septic/icons/obj/items/guns/pistol.dmi'
	icon_state = "USP"
	base_icon_state = "USP"
	gunshot_animation_information = list(
		"pixel_x" = 16, \
		"pixel_y" = 2, \
		"inactive_wben_suppressed" = TRUE,
	)
	recoil_animation_information = list()
	fire_sound = list('modular_septic/sound/weapons/guns/pistol/USP1.ogg', 'modular_septic/sound/weapons/guns/pistol/USP2.ogg')
	rack_sound = 'modular_septic/sound/weapons/guns/pistol/john_rack.ogg'
	lock_back_sound = 'modular_septic/sound/weapons/guns/pistol/john_lockback.ogg'
	bolt_drop_sound = 'modular_septic/sound/weapons/guns/pistol/john_lockin.ogg'
	mag_type = /obj/item/ammo_box/magazine/u45
	can_suppress = FALSE
	force = 15
	w_class = WEIGHT_CLASS_NORMAL
	carry_weight = 1 KILOGRAMS
	var/corrupted = FALSE
	var/corrupted_shot_sound = list('modular_septic/sound/weapons/guns/pistol/USP_corrupt1.ogg', 'modular_septic/sound/weapons/guns/pistol/USP_corrupt2.ogg')
	var/corruption_cooldown_duration = 1 SECONDS
	COOLDOWN_DECLARE(corruption_cooldown)
	custom_price = 3500

/obj/item/gun/ballistic/automatic/pistol/cortes/examine(mob/user)
	. = ..()
	var/mob/living/carbon/human/human_user
	if(ishuman(user))
		human_user = user
	if(HAS_TRAIT(human_user, TRAIT_GAKSTER) && !corrupted)
		. += span_warning("An <span class='boldwarning'>inborn</span> can do something special with this to make it <span class='boldwarning'>more powerful.</span> It'd be <span class='boldwarning'>suicide</span> to be allies with one.")
	if(human_user.dna?.species?.id == SPECIES_INBORN && !corrupted)
		. += span_boldwarning("I can alternatively use this to corrupt it and empower it with Liminal Power.")

/obj/item/gun/ballistic/automatic/pistol/cortes/alt_click_secondary(mob/user)
	var/mob/living/carbon/human/human_user
	if(ishuman(user))
		human_user = user
	if(COOLDOWN_FINISHED(src, corruption_cooldown) && human_user.dna?.species?.id == SPECIES_INBORN && !corrupted)
		var/corruption_chance = GET_MOB_ATTRIBUTE_VALUE(human_user, STAT_INTELLIGENCE)*4.20 // :3
		human_user.audible_message(span_boldwarning("[human_user] whispers a secret into [src]'s ear."))
		playsound(human_user, 'modular_septic/sound/effects/whispers.ogg', 35, TRUE)
		corrupt(corruption_chance, user)
		COOLDOWN_START(src, corruption_cooldown, corruption_cooldown_duration)

/obj/item/gun/ballistic/automatic/pistol/cortes/proc/corrupt(chance = 0, mob/inborn)
	if(corrupted)
		return
	if(prob(chance))
		visible_message(span_warning("[src] grumbles."))
		corrupted = TRUE
		sleep(rand(1 SECONDS, 1.5 SECONDS))
		visible_message(span_warning("[src] <span class='boldwarning'>CORRUPTS!</span>"))
		to_chat(inborn, span_notice("I have corrupted the [src]."))
		playsound(src, 'modular_septic/sound/heart/inborn_combatcocktail.ogg', 80, FALSE)
		name = "\improper Cortraxx .45"
		desc = "A lavish pistol for a lavish life. <span class='boldwarning'>It has been corrupted.</span>"
		icon_state = "USP_corrupted"
		base_icon_state = "USP_corrupted"
		update_appearance(UPDATE_ICON)
	else
		say(pick("No...", "It can't be...", "Stop..."))

/obj/item/gun/ballistic/automatic/pistol/cortes/shoot_live_shot(mob/living/user, pointblank = FALSE, atom/target, message = TRUE)
	. = ..()
	if(corrupted)
		playsound(user, corrupted_shot_sound, 70, FALSE)
*/
