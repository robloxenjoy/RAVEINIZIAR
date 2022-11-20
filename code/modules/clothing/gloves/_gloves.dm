/obj/item/clothing/gloves
	name = "gloves"
	gender = PLURAL //Carn: for grammarically correct text-parsing
	w_class = WEIGHT_CLASS_SMALL
	icon = 'icons/obj/clothing/gloves.dmi'
	siemens_coefficient = 0.5
	body_parts_covered = HANDS
	slot_flags = ITEM_SLOT_GLOVES
	attack_verb_continuous = list("challenges")
	attack_verb_simple = list("challenge")
	var/transfer_prints = FALSE
	strip_delay = 20
	equip_delay_other = 40
	// Path variable. If defined, will produced the type through interaction with wirecutters.
	var/cut_type = null
	/// Used for handling bloody gloves leaving behind bloodstains on objects. Will be decremented whenever a bloodstain is left behind, and be incremented when the gloves become bloody.
	var/transfer_blood = 0

/obj/item/clothing/gloves/wash(clean_types)
	. = ..()
	if(clean_types & CLEAN_TYPE_BLOOD)
		transfer_blood = 0
		transfer_shit = 0
		transfer_cum = 0
		transfer_femcum = 0
		return TRUE

/obj/item/clothing/gloves/suicide_act(mob/living/carbon/user)
	user.visible_message(span_suicide("\the [src] are forcing [user]'s hands around [user.p_their()] neck! It looks like the gloves are possessed!"))
	return OXYLOSS

/obj/item/clothing/gloves/worn_overlays(mutable_appearance/standing, isinhands = FALSE)
	. = ..()
	if(isinhands)
		return

	/* SEPTIC EDIT REMOVAL
	if(damaged_clothes)
		. += mutable_appearance('icons/effects/item_damage.dmi', "damagedgloves")
	if(HAS_BLOOD_DNA(src))
		. += mutable_appearance('icons/effects/blood.dmi', "bloodyhands")
	*/
	//SEPTIC EDIT BEGIN
	if(damaged_clothes)
		var/mutable_appearance/damage_appearance = mutable_appearance('modular_septic/icons/effects/item_damage.dmi', "damagedgloves")
		damage_appearance.color = "#000000"
		. += damage_appearance
	if(HAS_BLOOD_DNA(src))
		var/mutable_appearance/blood_appearance = mutable_appearance('modular_septic/icons/effects/blood.dmi', "bloodyhands")
		. += blood_appearance
	if(HAS_SHIT_DNA(src))
		var/mutable_appearance/shit_appearance = mutable_appearance('modular_septic/icons/effects/shit.dmi', "shittyhands")
		shit_appearance.color = COLOR_BROWN_SHIT
		. += shit_appearance
	if(HAS_CUM_DNA(src))
		var/mutable_appearance/cum_appearance = mutable_appearance('modular_septic/icons/effects/cum.dmi', "cummyhands")
		cum_appearance.color = COLOR_WHITE_CUM
		. += cum_appearance
	if(HAS_FEMCUM_DNA(src))
		var/mutable_appearance/femcum_appearance = mutable_appearance('modular_septic/icons/effects/femcum.dmi', "femcummyhands")
		femcum_appearance.color = COLOR_WHITE_FEMCUM
		. += femcum_appearance
	//SEPTIC EDIT END

/obj/item/clothing/gloves/update_clothes_damaged_state(damaged_state = CLOTHING_DAMAGED)
	..()
	if(ismob(loc))
		var/mob/M = loc
		M.update_inv_gloves()

// Called just before an attack_hand(), in mob/UnarmedAttack()
/obj/item/clothing/gloves/proc/Touch(atom/A, proximity, mouseparams)
	return FALSE // return 1 to cancel attack_hand()

/obj/item/clothing/gloves/wirecutter_act(mob/living/user, obj/item/I)
	. = ..()
	if(!cut_type)
		return
	if(icon_state != initial(icon_state))
		return // We don't want to cut dyed gloves.
	new cut_type(drop_location())
	qdel(src)
	return TRUE

/obj/item/clothing/gloves/wrist/wrist_r
	name = "Wrist"
	gender = PLURAL
	w_class = WEIGHT_CLASS_SMALL
	icon = 'icons/obj/clothing/gloves.dmi'
	siemens_coefficient = 0.5
	body_parts_covered = HAND_RIGHT
	slot_flags = ITEM_SLOT_RWRIST|ITEM_SLOT_LWRIST
	attack_verb_continuous = list("challenges")
	attack_verb_simple = list("challenge")
//	var/transfer_prints = FALSE
	strip_delay = 20
	equip_delay_other = 40

/obj/item/clothing/gloves/wrist/wrist_l
	name = "Cool"

/obj/item/clothing/gloves/wrist/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_ITEM_EQUIPPED, .proc/on_glove_equip)

/obj/item/clothing/gloves/wrist/proc/on_glove_equip(datum/source, mob/equipper, slot)
	SIGNAL_HANDLER

	if(slot == ITEM_SLOT_RWRIST)
		body_parts_covered = HAND_RIGHT
	else
		body_parts_covered = HAND_LEFT
