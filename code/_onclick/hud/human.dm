/atom/movable/screen/human
	icon = 'icons/hud/screen_midnight.dmi'

/atom/movable/screen/human/toggle
	name = "toggle"
	icon_state = "toggle"

/atom/movable/screen/human/toggle/Click()

	var/mob/targetmob = usr

	if(isobserver(usr))
		if(ishuman(usr.client.eye) && (usr.client.eye != usr))
			var/mob/M = usr.client.eye
			targetmob = M

	if(usr.hud_used.inventory_shown && targetmob.hud_used)
		usr.hud_used.inventory_shown = FALSE
		usr.client.screen -= targetmob.hud_used.toggleable_inventory
	else
		usr.hud_used.inventory_shown = TRUE
		usr.client.screen += targetmob.hud_used.toggleable_inventory

	targetmob.hud_used.hidden_inventory_update(usr)

/atom/movable/screen/human/equip
	name = "equip"
	icon_state = "act_equip"

/atom/movable/screen/human/equip/Click()
	if(ismecha(usr.loc)) // stops inventory actions in a mech
		return TRUE
	var/mob/living/carbon/human/H = usr
	H.quick_equip()

/atom/movable/screen/ling
	icon = 'icons/hud/screen_changeling.dmi'
	invisibility = INVISIBILITY_ABSTRACT

/atom/movable/screen/ling/sting
	name = "current sting"
	screen_loc = ui_lingstingdisplay

/atom/movable/screen/ling/sting/Click()
	if(isobserver(usr))
		return
	var/mob/living/carbon/U = usr
	U.unset_sting()

/atom/movable/screen/ling/chems
	name = "chemical storage"
	icon_state = "power_display"
	screen_loc = ui_lingchemdisplay

/datum/hud/human/New(mob/living/carbon/human/owner)
	..()

	var/atom/movable/screen/using
	var/atom/movable/screen/inventory/inv_box

	using = new/atom/movable/screen/language_menu
	using.icon = ui_style
	using.hud = src
	static_inventory += using

	using = new/atom/movable/screen/skills
	using.icon = ui_style
	using.hud = src
	static_inventory += using

	using = new /atom/movable/screen/area_creator
	using.icon = ui_style
	using.hud = src
	static_inventory += using

	/* SEPTIC EDIT REMOVAL
	action_intent = new /atom/movable/screen/combattoggle/flashy()
	*/
	//SEPTIC EDIT BEGIN
	action_intent = new /atom/movable/screen/combattoggle()
	action_intent.icon_state = owner?.combat_mode ? "combat_on" : "combat"
	//SEPTIC EDIT END
	action_intent.hud = src
	action_intent.icon = ui_style
	action_intent.screen_loc = ui_combat_toggle
	static_inventory += action_intent

	//SEPTIC EDIT BEGIN
	intent_select = new /atom/movable/screen/intent_select/segmented
	intent_select.icon_state = owner?.a_intent
	intent_select.hud = src
	intent_select.icon = ui_style
	intent_select.screen_loc = ui_intents
	static_inventory += intent_select

	mov_intent = new /atom/movable/screen/mov_intent
	mov_intent.icon = ui_style
	mov_intent.icon_state = (mymob.m_intent == MOVE_INTENT_RUN ? "jogging" : "walking")
	mov_intent.screen_loc = ui_movi
	mov_intent.hud = src
	static_inventory += mov_intent
	//SEPTIC EDIT END
	/* SEPTIC EDIT REMOVAL
	using = new /atom/movable/screen/mov_intent
	using.icon = ui_style
	using.icon_state = (mymob.m_intent == MOVE_INTENT_RUN ? "running" : "walking")
	using.screen_loc = ui_movi
	using.hud = src
	static_inventory += using
	*/
	//SEPTIC EDIT BEGIN
	sprint = new /atom/movable/screen/sprint()
	sprint.icon = ui_style
	sprint.icon_state = ((owner.combat_flags & COMBAT_FLAG_SPRINT_ACTIVE) ? "act_sprint_on" : "act_sprint")
	sprint.screen_loc = ui_sprint
	sprint.hud = src
	static_inventory += sprint

	wield = new /atom/movable/screen/wield()
	wield.icon = ui_style
	wield.screen_loc = ui_wield
	wield.hud = src
	static_inventory += wield

	equip = new /atom/movable/screen/human/equip()
	equip.screen_loc = ui_equip_position(mymob)
	equip.hud = src
	static_inventory += equip

	swap_hand = new /atom/movable/screen/swap_hand()
	swap_hand.screen_loc = ui_swaphand_position(owner,1)
	swap_hand.hud = src
	static_inventory += swap_hand

	info_button = new /atom/movable/screen/info()
	info_button.screen_loc = ui_swaphand_position(owner,2)
	info_button.hud = src
	static_inventory += info_button

	combat_style = new /atom/movable/screen/combat_style()
	combat_style.icon_state = owner?.combat_style
	combat_style.screen_loc = ui_combat_style
	combat_style.hud = src
	static_inventory += combat_style

	dodge_parry = new /atom/movable/screen/dodge_parry()
	dodge_parry.icon = ui_style
	dodge_parry.icon_state = owner?.dodge_parry
	dodge_parry.screen_loc = ui_dodge_parry
	dodge_parry.hud = src
	static_inventory += dodge_parry

	special_attack = new /atom/movable/screen/special_attack()
	special_attack.icon = ui_style
	special_attack.screen_loc = ui_specialattack
	special_attack.hud = src
	static_inventory += special_attack
	if(owner?.client?.prefs && !owner.client.prefs.read_preference(/datum/preference/toggle/widescreen))
		special_attack.screen_loc = ui_boxspecialattack

	sleeping = new /atom/movable/screen/sleeping()
	sleeping.icon = ui_style
	sleeping.screen_loc = ui_sleep
	sleeping.hud = src
	static_inventory += sleeping

	teach = new /atom/movable/screen/teach()
	teach.icon = ui_style
	teach.screen_loc = ui_teach
	teach.hud = src
	static_inventory += teach
	//SEPTIC EDIT END

	using = new /atom/movable/screen/drop()
	using.icon = ui_style
	/* SEPTIC EDIT REMOVAL
	using.screen_loc = ui_drop_throw
	*/
	//SEPTIC EDIT BEGIN
	using.screen_loc = ui_drop
	//SEPTIC EDIT END
	using.hud = src
	static_inventory += using

	inv_box = new /atom/movable/screen/inventory()
	/* SEPTIC EDIT REMOVAL
	inv_box.name = "i_clothing"
	*/
	//SEPTIC EDIT BEGIN
	inv_box.name = "uniform"
	//SEPTIC EDIT END
	inv_box.icon = ui_style
	inv_box.slot_id = ITEM_SLOT_ICLOTHING
	inv_box.icon_state = "uniform"
	inv_box.screen_loc = ui_iclothing
	inv_box.hud = src
	toggleable_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	/* SEPTIC EDIT REMOVAL
	inv_box.name = "o_clothing"
	*/
	//SEPTIC EDIT BEGIN
	inv_box.name = "suit"
	//SEPTIC EDIT END
	inv_box.icon = ui_style
	inv_box.slot_id = ITEM_SLOT_OCLOTHING
	inv_box.icon_state = "suit"
	inv_box.screen_loc = ui_oclothing
	inv_box.hud = src
	toggleable_inventory += inv_box

	build_hand_slots()
	/* SEPTIC EDIT REMOVAL
	using = new /atom/movable/screen/swap_hand()
	using.icon = ui_style
	using.icon_state = "swap_1"
	using.screen_loc = ui_swaphand_position(owner,1)
	using.hud = src
	static_inventory += using

	using = new /atom/movable/screen/swap_hand()
	using.icon = ui_style
	using.icon_state = "swap_2"
	using.screen_loc = ui_swaphand_position(owner,2)
	using.hud = src
	static_inventory += using
	*/
	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "id"
	inv_box.icon = ui_style
	inv_box.icon_state = "id"
	inv_box.screen_loc = ui_id
	inv_box.slot_id = ITEM_SLOT_ID
	inv_box.hud = src
	static_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "mask"
	inv_box.icon = ui_style
	inv_box.icon_state = "mask"
	inv_box.screen_loc = ui_mask
	inv_box.slot_id = ITEM_SLOT_MASK
	inv_box.hud = src
	toggleable_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "neck"
	inv_box.icon = ui_style
	inv_box.icon_state = "neck"
	inv_box.screen_loc = ui_neck
	inv_box.slot_id = ITEM_SLOT_NECK
	inv_box.hud = src
	/* SEPTIC EDIT REMOVAL
	toggleable_inventory += inv_box
	*/
	//SEPTIC EDIT BEGIN
	upper_inventory += inv_box
	if(owner?.client?.prefs && !owner.client.prefs.read_preference(/datum/preference/toggle/widescreen))
		inv_box.screen_loc = ui_boxneck
	//SEPTIC EDIT END

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "back"
	inv_box.icon = ui_style
	inv_box.icon_state = "back"
	inv_box.screen_loc = ui_back
	inv_box.slot_id = ITEM_SLOT_BACK
	inv_box.hud = src
	static_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	/* SEPTIC EDIT REMOVAL
	inv_box.name = "storage1"
	*/
	//SEPTIC EDIT BEGIN
	inv_box.name = "left pocket"
	//SEPTIC EDIT END
	inv_box.icon = ui_style
	inv_box.icon_state = "pocket"
	inv_box.screen_loc = ui_storage1
	inv_box.slot_id = ITEM_SLOT_LPOCKET
	inv_box.hud = src
	static_inventory += inv_box
	//SEPTIC EDIT BEGIN
	if(owner?.client?.prefs && !owner.client.prefs.read_preference(/datum/preference/toggle/widescreen))
		static_inventory -= inv_box
		upper_inventory += inv_box
		inv_box.screen_loc = ui_boxstorage1
	//SEPTIC EDIT END

	inv_box = new /atom/movable/screen/inventory()
	/* SEPTIC EDIT REMOVAL
	inv_box.name = "storage2"
	*/
	//SEPTIC EDIT BEGIN
	inv_box.name = "right pocket"
	//SEPTIC EDIT END
	inv_box.icon = ui_style
	inv_box.icon_state = "pocket"
	inv_box.screen_loc = ui_storage2
	inv_box.slot_id = ITEM_SLOT_RPOCKET
	inv_box.hud = src
	static_inventory += inv_box
	//SEPTIC EDIT BEGIN
	if(owner?.client?.prefs && !owner.client.prefs.read_preference(/datum/preference/toggle/widescreen))
		static_inventory -= inv_box
		upper_inventory += inv_box
		inv_box.screen_loc = ui_boxstorage2
	//SEPTIC EDIT END

	inv_box = new /atom/movable/screen/inventory()
	/* SEPTIC EDIT REMOVAL
	inv_box.name = "suit storage"
	*/
	//SEPTIC EDIT BEGIN
	inv_box.name = "back 2"
	//SEPTIC EDIT END
	inv_box.icon = ui_style
	/* SEPTIC EDIT REMOVAL
	inv_box.icon_state = "suit_storage"
	*/
	//SEPTIC EDIT BEGIN
	inv_box.icon_state = "back2"
	//SEPTIC EDIT END
	inv_box.screen_loc = ui_sstore1
	inv_box.slot_id = ITEM_SLOT_SUITSTORE
	inv_box.hud = src
	//static_inventory += inv_box SEPTIC EDIT REMOVAL
	//SEPTIC EDIT BEGIN
	toggleable_inventory += inv_box
	//SEPTIC EDIT END

	using = new /atom/movable/screen/resist()
	using.icon = ui_style
	/* SEPTIC EDIT REMOVAL
	using.screen_loc = ui_above_intent
	*/
	//SEPTIC EDIT
	using.screen_loc = ui_resist
	//SEPTIC EDIT END
	using.hud = src
	hotkeybuttons += using
	/* SEPTIC EDIT REMOVAL
	using = new /atom/movable/screen/human/toggle()
	using.icon = ui_style
	using.screen_loc = ui_inventory
	using.hud = src
	static_inventory += using

	using = new /atom/movable/screen/human/equip()
	using.icon = ui_style
	using.screen_loc = ui_equip_position(mymob)
	using.hud = src
	static_inventory += using
	*/
	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "gloves"
	inv_box.icon = ui_style
	inv_box.icon_state = "gloves"
	inv_box.screen_loc = ui_gloves
	inv_box.slot_id = ITEM_SLOT_GLOVES
	inv_box.hud = src
	toggleable_inventory += inv_box
	//SEPTIC EDIT BEGIN
	if(owner?.client?.prefs && !owner.client.prefs.read_preference(/datum/preference/toggle/widescreen))
		toggleable_inventory -= inv_box
		upper_inventory += inv_box
		inv_box.screen_loc = ui_boxgloves
	//SEPTIC EDIT END

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "eyes"
	inv_box.icon = ui_style
	inv_box.icon_state = "glasses"
	inv_box.screen_loc = ui_glasses
	inv_box.slot_id = ITEM_SLOT_EYES
	inv_box.hud = src
	/* SEPTIC EDIT REMOVAL
	toggleable_inventory += inv_box
	*/
	//SEPTIC EDIT BEGIN
	upper_inventory += inv_box
	if(owner?.client?.prefs && !owner.client.prefs.read_preference(/datum/preference/toggle/widescreen))
		upper_inventory -= inv_box
		upper_inventory += inv_box
		inv_box.screen_loc = ui_boxglasses
	//SEPTIC EDIT END

	/* SEPTIC EDIT REMOVAL
	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "ears"
	inv_box.icon = ui_style
	inv_box.icon_state = "ears"
	inv_box.screen_loc = ui_ears
	inv_box.slot_id = ITEM_SLOT_EARS
	inv_box.hud = src
	toggleable_inventory += inv_box
	*/

	//SEPTIC EDIT BEGIN
	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "left ear"
	inv_box.icon = ui_style
	inv_box.icon_state = "ears"
	inv_box.screen_loc = ui_ears
	inv_box.slot_id = ITEM_SLOT_LEAR
	inv_box.hud = src
	upper_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "right ear"
	inv_box.icon = ui_style
	inv_box.icon_state = "ears_extra"
	inv_box.screen_loc = ui_ears_extra
	inv_box.slot_id = ITEM_SLOT_REAR
	inv_box.hud = src
	upper_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "wrists"
	inv_box.icon = ui_style
	inv_box.icon_state = "wrists"
	inv_box.screen_loc = ui_wrists
	inv_box.slot_id = ITEM_SLOT_WRISTS
	inv_box.hud = src
	upper_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "pants"
	inv_box.icon = ui_style
	inv_box.icon_state = "pants"
	inv_box.screen_loc = ui_pants
	inv_box.slot_id = ITEM_SLOT_PANTS
	inv_box.hud = src
	upper_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "oversuit"
	inv_box.icon = ui_style
	inv_box.icon_state = "oversuit"
	inv_box.screen_loc = ui_oversuit
	inv_box.slot_id = ITEM_SLOT_OVERSUIT
	inv_box.hud = src
	upper_inventory += inv_box

	//SEPTIC EDIT END

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "head"
	inv_box.icon = ui_style
	inv_box.icon_state = "head"
	inv_box.screen_loc = ui_head
	inv_box.slot_id = ITEM_SLOT_HEAD
	inv_box.hud = src
	toggleable_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "shoes"
	inv_box.icon = ui_style
	inv_box.icon_state = "shoes"
	inv_box.screen_loc = ui_shoes
	inv_box.slot_id = ITEM_SLOT_FEET
	inv_box.hud = src
	toggleable_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "belt"
	inv_box.icon = ui_style
	inv_box.icon_state = "belt"
// inv_box.icon_full = "template_small"
	inv_box.screen_loc = ui_belt
	inv_box.slot_id = ITEM_SLOT_BELT
	inv_box.hud = src
	static_inventory += inv_box

	throw_icon = new /atom/movable/screen/throw_catch()
	throw_icon.icon = ui_style
	/* SEPTIC EDIT REMOVAL
	throw_icon.screen_loc = ui_drop_throw
	*/
	//SEPTIC EDIT BEGIN
	throw_icon.screen_loc = ui_throw
	//SEPTIC EDIT END
	throw_icon.hud = src
	hotkeybuttons += throw_icon

	rest_icon = new /atom/movable/screen/rest()
	rest_icon.icon = ui_style
	/* SEPTIC EDIT REMOVAL
	rest_icon.screen_loc = ui_above_movement
	*/
	//SEPTIC EDIT BEGIN
	rest_icon.screen_loc = ui_rest
	//SEPTIC EDIT END
	rest_icon.hud = src
	static_inventory += rest_icon

	internals = new /atom/movable/screen/internals()
	internals.hud = src
	infodisplay += internals

	//SEPTIC EDIT BEGIN
	pressure = new /atom/movable/screen/pressure
	pressure.hud = src
	pressure.screen_loc = ui_pressure
	infodisplay += pressure
	//SEPTIC EDIT END

	spacesuit = new /atom/movable/screen/spacesuit
	spacesuit.hud = src
	infodisplay += spacesuit

	//SEPTIC EDIT BEGIN
	stat_viewer = new /atom/movable/screen/stats
	stat_viewer.screen_loc = ui_stats
	stat_viewer.hud = src
	infodisplay += stat_viewer

	lookup = new /atom/movable/screen/lookup
	lookup.icon = ui_style
	lookup.screen_loc = ui_lookup
	lookup.hud = src
	infodisplay += lookup

	lookdown = new /atom/movable/screen/lookdown
	lookdown.icon = ui_style
	lookdown.screen_loc = ui_lookdown
	lookdown.hud = src
	infodisplay += lookdown

	surrender = new /atom/movable/screen/surrender
	surrender.icon = ui_style
	surrender.screen_loc = ui_surrender
	surrender.hud = src
	infodisplay += surrender

	nutrition = new /atom/movable/screen/nutrition()
	nutrition.icon = ui_style
	nutrition.screen_loc = ui_nutrition
	nutrition.hud = src
	infodisplay += nutrition

	hydration = new /atom/movable/screen/hydration()
	hydration.icon = ui_style
	hydration.screen_loc = ui_hydration
	hydration.hud = src
	infodisplay += hydration

	temperature = new /atom/movable/screen/temperature()
	temperature.icon = ui_style
	temperature.screen_loc = ui_temperature
	temperature.hud = src
	infodisplay += temperature

	bodytemperature = new /atom/movable/screen/bodytemperature()
	bodytemperature.icon = ui_style
	bodytemperature.screen_loc = ui_bodytemperature
	bodytemperature.hud = src
	infodisplay += bodytemperature

	fatigue = new /atom/movable/screen/fatigue
	fatigue.icon = ui_style
	fatigue.screen_loc = ui_fatigue
	fatigue.hud = src
	infodisplay += fatigue

	pain_guy = new /atom/movable/screen/human/pain()
	pain_guy.icon = ui_style
	pain_guy.screen_loc = ui_pain
	pain_guy.hud = src
	infodisplay += pain_guy

	breath = new /atom/movable/screen/breath()
	breath.icon = ui_style
	breath.screen_loc = ui_breath
	breath.hud = src
	infodisplay += breath
	//SEPTIC EDIT END

	healths = new /atom/movable/screen/healths()
	healths.hud = src
	infodisplay += healths
	/* SEPTIC EDIT REMOVAL
	healthdoll = new /atom/movable/screen/healthdoll()
	healthdoll.hud = src
	infodisplay += healthdoll
	*/
	pull_icon = new /atom/movable/screen/pull()
	pull_icon.icon = ui_style
	pull_icon.update_appearance()
	/* SEPTIC EDIT REMOVAL
	pull_icon.screen_loc = ui_above_intent
	*/
	//SEPTIC EDIT BEGIN
	pull_icon.screen_loc = ui_pull
	//SEPTIC EDIT END
	pull_icon.hud = src
	static_inventory += pull_icon

	//SEPTIC EDIT BEGIN
	bookmark = new /atom/movable/screen/bookmark()
	bookmark.icon = ui_style
	bookmark.screen_loc = ui_bookmark_off
	bookmark.hud = src
	static_inventory += bookmark
	//SEPTIC EDIT END

	lingchemdisplay = new /atom/movable/screen/ling/chems()
	lingchemdisplay.hud = src
	infodisplay += lingchemdisplay

	lingstingdisplay = new /atom/movable/screen/ling/sting()
	lingstingdisplay.hud = src
	infodisplay += lingstingdisplay
	/* SEPTIC EDIT REMOVAL
	zone_select = new /atom/movable/screen/zone_sel()
	zone_select.icon = ui_style
	*/
	//SEPTIC EDIT BEGIN
	zone_select = new /atom/movable/screen/zone_sel/big()
	//SEPTIC EDIT END
	zone_select.hud = src
	zone_select.update_appearance()
	static_inventory += zone_select

	//SEPTIC EDIT BEGIN
	enhanced_sel = new /atom/movable/screen/enhanced_sel()
	enhanced_sel.hud = src
	enhanced_sel.update_appearance()
	static_inventory += enhanced_sel
	//SEPTIC EDIT END

	combo_display = new /atom/movable/screen/combo()
	infodisplay += combo_display

	/* SEPTIC EDIT REMOVAL
	for(var/atom/movable/screen/inventory/inv in (static_inventory + toggleable_inventory))
	*/
	//SEPTIC EDIT BEGIN
	for(var/atom/movable/screen/inventory/inv in (static_inventory + toggleable_inventory + upper_inventory))
	//SEPTIC EDIT END
		if(inv.slot_id)
			inv.hud = src
			inv_slots[TOBITSHIFT(inv.slot_id) + 1] = inv
			inv.update_appearance()

	update_locked_slots()
	//SEPTIC EDIT BEGIN
	inventory_shown = TRUE
	if(mymob)
		hidden_inventory_update(mymob)
	//SEPTIC EDIT END

/datum/hud/human/update_locked_slots()
	if(!mymob)
		return
	var/mob/living/carbon/human/H = mymob
	if(!istype(H) || !H.dna.species)
		return
	var/datum/species/S = H.dna.species
	/* SEPTIC EDIT REMOVAL
	for(var/atom/movable/screen/inventory/inv in (static_inventory + toggleable_inventory))
		if(inv.slot_id)
			if(inv.slot_id in S.no_equip)
				inv.alpha = 128
			else
				inv.alpha = initial(inv.alpha)
	*/
	//SEPTIC EDIT BEGIN
	for(var/atom/movable/screen/inventory/inv in (static_inventory + toggleable_inventory + upper_inventory))
		if(inv.slot_id)
			if(inv.slot_id in S.no_equip)
				//makes it a purple-ish tone
				inv.color = list(1,0.5,0,0, 0,0,0,0, 0,0,0.5,0, 0,0,0,1, 0,0,0,0)
			else
				inv.alpha = initial(inv.alpha)
	//SEPTIC EDIT END

/datum/hud/human/hidden_inventory_update(mob/viewer)
	if(!mymob)
		return
	var/mob/living/carbon/human/H = mymob

	var/mob/screenmob = viewer || H

	//SEPTIC EDIT BEGIN
	screenmob = viewer
	if(!istype(screenmob))
		screenmob = H
	if(!screenmob.hud_used)
		return
	//SEPTIC EDIT END
	if(screenmob.hud_used.inventory_shown && screenmob.hud_used.hud_shown)
		//SEPTIC EDIT BEGIN
		if(screenmob.hud_used.upper_inventory_shown)
			if(H.wear_neck)
				H.wear_neck.screen_loc = ui_neck
				screenmob.client.screen += H.wear_neck
			if(H.glasses)
				H.glasses.screen_loc = ui_glasses
				screenmob.client.screen += H.glasses
			if(H.ears)
				H.ears.screen_loc = ui_ears
				screenmob.client.screen += H.ears
			if(H.ears_extra)
				H.ears_extra.screen_loc = ui_ears_extra
				screenmob.client.screen += H.ears_extra
			if(H.wrists)
				H.wrists.screen_loc = ui_wrists
				screenmob.client.screen += H.wrists
		else
			if(H.wear_neck)
				screenmob.client.screen -= H.wear_neck
			if(H.glasses)
				screenmob.client.screen -= H.glasses
			if(H.ears)
				screenmob.client.screen -= H.ears
			if(H.ears_extra)
				screenmob.client.screen -= H.ears_extra
			if(H.wrists)
				screenmob.client.screen -= H.wrists
		//SEPTIC EDIT END
		if(H.shoes)
			H.shoes.screen_loc = ui_shoes
			screenmob.client.screen += H.shoes
		if(H.gloves)
			H.gloves.screen_loc = ui_gloves
			screenmob.client.screen += H.gloves
		if(H.pants)
			H.pants.screen_loc = ui_pants
			screenmob.client.screen += H.pants
		if(H.oversuit)
			H.oversuit.screen_loc = ui_oversuit
			screenmob.client.screen += H.oversuit
		/* SEPTIC EDIT REMOVAL
		if(H.ears)
			H.ears.screen_loc = ui_ears
			screenmob.client.screen += H.ears
		if(H.glasses)
			H.glasses.screen_loc = ui_glasses
			screenmob.client.screen += H.glasses
		*/
		if(H.w_uniform)
			H.w_uniform.screen_loc = ui_iclothing
			screenmob.client.screen += H.w_uniform
		if(H.wear_suit)
			H.wear_suit.screen_loc = ui_oclothing
			screenmob.client.screen += H.wear_suit
		/* SEPTIC EDIT REMOVAL
		if(H.wear_mask)
			H.wear_mask.screen_loc = ui_mask
			screenmob.client.screen += H.wear_mask
		if(H.wear_neck)
			H.wear_neck.screen_loc = ui_neck
			screenmob.client.screen += H.wear_neck
		*/
		if(H.head)
			H.head.screen_loc = ui_head
			screenmob.client.screen += H.head
	else
		//SEPTIC EDIT BEGIN
		if(H.wear_neck)
			screenmob.client.screen -= H.wear_neck
		if(H.glasses)
			screenmob.client.screen -= H.glasses
		if(H.ears)
			screenmob.client.screen -= H.ears
		if(H.ears_extra)
			screenmob.client.screen -= H.ears_extra
		if(H.wrists)
			screenmob.client.screen -= H.wrists
		//SEPTIC EDIT END
		if(H.shoes) screenmob.client.screen -= H.shoes
		if(H.gloves) screenmob.client.screen -= H.gloves
		if(H.pants) screenmob.client.screen -= H.pants
		if(H.oversuit) screenmob.client.screen -= H.oversuit
		/* SEPTIC EDIT REMOVAL
		if(H.ears) screenmob.client.screen -= H.ears
		if(H.glasses) screenmob.client.screen -= H.glasses
		*/
		if(H.w_uniform) screenmob.client.screen -= H.w_uniform
		if(H.wear_suit) screenmob.client.screen -= H.wear_suit
		/* SEPTIC EDIT REMOVAL
		if(H.wear_mask) screenmob.client.screen -= H.wear_mask
		if(H.wear_neck) screenmob.client.screen -= H.wear_neck
		*/
		if(H.head) screenmob.client.screen -= H.head


/datum/hud/human/persistent_inventory_update(mob/viewer)
	if(!mymob)
		return
	..()
	var/mob/living/carbon/human/H = mymob

	var/mob/screenmob = viewer || H

	if(screenmob.hud_used)
		if(screenmob.hud_used.hud_shown)
			if(H.s_store)
				H.s_store.screen_loc = ui_sstore1
				screenmob.client.screen += H.s_store
			if(H.wear_id)
				H.wear_id.screen_loc = ui_id
				screenmob.client.screen += H.wear_id
			if(H.belt)
				H.belt.screen_loc = ui_belt
				screenmob.client.screen += H.belt
			if(H.back)
				H.back.screen_loc = ui_back
				screenmob.client.screen += H.back
			if(H.l_store)
				H.l_store.screen_loc = ui_storage1
				screenmob.client.screen += H.l_store
			if(H.r_store)
				H.r_store.screen_loc = ui_storage2
				screenmob.client.screen += H.r_store
		else
			if(H.s_store)
				screenmob.client.screen -= H.s_store
			if(H.wear_id)
				screenmob.client.screen -= H.wear_id
			if(H.belt)
				screenmob.client.screen -= H.belt
			if(H.back)
				screenmob.client.screen -= H.back
			if(H.l_store)
				screenmob.client.screen -= H.l_store
			if(H.r_store)
				screenmob.client.screen -= H.r_store

	if(hud_version != HUD_STYLE_NOHUD)
		for(var/obj/item/I in H.held_items)
			I.screen_loc = ui_hand_position(H.get_held_index_of_item(I))
			screenmob.client.screen += I
	else
		for(var/obj/item/I in H.held_items)
			I.screen_loc = null
			screenmob.client.screen -= I


/mob/living/carbon/human/verb/toggle_hotkey_verbs()
	set category = null
	set name = "Toggle hotkey buttons"
	set desc = "This disables or enables the user interface buttons which can be used with hotkeys."

	if(hud_used.hotkey_ui_hidden)
		client.screen += hud_used.hotkeybuttons
		hud_used.hotkey_ui_hidden = FALSE
	else
		client.screen -= hud_used.hotkeybuttons
		hud_used.hotkey_ui_hidden = TRUE
