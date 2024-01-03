/obj/item/bodypart
	name = "limb"
	desc = "Why is it detached..."
	force = 5
	throwforce = 5
	w_class = WEIGHT_CLASS_SMALL
	icon = DEFAULT_BODYPART_ICON
	icon_state = ""

	/// So it isn't hidden behind objects when on the floor
	layer = BELOW_MOB_LAYER

	/// Robotic bodyparts produce other fun reagents, but this is for organic bodyparts
	grind_results = list(/datum/reagent/bone_dust = 10, \
						/datum/reagent/liquidgibs = 10)
	juice_results = list(/datum/reagent/blood = 20)

	/// Germ level is treated as the infection level of a limb, we start at 0 and only increase when appropriate
	germ_level = 0

	/// Minimum decay factor when rotting
	var/min_decay_factor = MIN_BODYPART_DECAY_INFECTION
	/// Maximum decay factor when rotting
	var/max_decay_factor = MAX_BODYPART_DECAY_INFECTION

	/// Mob we are currently attached to
	var/mob/living/carbon/owner = null
	/// The first mob we ever got attached to
	var/datum/weakref/original_owner = null

	/// Organic or robotic
	var/status = BODYPART_ORGANIC
	/// General bodypart flags, such as - is it necrotic, does it leave stumps behind, etc
	var/limb_flags = BODYPART_EDIBLE|BODYPART_HAS_BONE|BODYPART_HAS_TENDON|BODYPART_HAS_NERVE|BODYPART_HAS_ARTERY
	/// How efficient this limb is at performing... whatever it performs
	var/limb_efficiency = 100
	/// Needs to get processed on next life() tick
	var/needs_processing = FALSE

	/// BODY_ZONE_CHEST, BODY_ZONE_L_ARM, etc - Identifying string
	var/body_zone
	/// Bitflag used to check which clothes cover this bodypart
	var/body_part
	/// Body zone we get attached to - A hand gets attached to an arm, an arm gets attached to the chest, etc
	var/parent_body_zone
	/// Body zones that treat us as a parent body zone
	var/list/children_zones

	/// For limbs that don't really exist, eg chainsaw hand
	var/is_pseudopart = FALSE
	/// Used for alternate digitigrade legs, useless elsewhere
	var/use_digitigrade = NOT_DIGITIGRADE

	/// Are we a grasping limb? if so, which one?
	var/held_index = 0
	/// Are we a stance limb? if so, which one?
	var/stance_index = 0

	/// If disabled, limb is as good as missing.
	var/bodypart_disabled = FALSE
	/// Controls whether bodypart_disabled makes sense or not for this limb.
	var/can_be_disabled = TRUE
	/// Multiplied by max_damage it returns the threshold which defines a limb being disabled or not. From 0 to 1. 0 means no disable through damage, 1 means only max_damage.
	var/disable_threshold = 0

	/// Used to calculate the mob damage overlays
	var/brutestate = 0
	/// Used to calculate the mob damage overlays
	var/burnstate = 0
	/// Amount of brute damage this limb has accumulated
	var/brute_dam = 0
	/// Subtracted to brute damage taken
	var/brute_reduction = 0
	/// Multiplier for incoming brute damage
	var/incoming_brute_mult = 1
	/// Amount of burn damage this limb has accumulated
	var/burn_dam = 0
	/// Subtracted to burn damage taken
	var/burn_reduction = 0
	/// Multiplier for incoming burn damage
	var/incoming_burn_mult = 1
	/// Maximum amount of (brute+burn) damage this limb can get
	var/max_damage = 0
	/// Amount of stamina damage this limb has accumulated
	var/stamina_dam = 0
	/// Subtracted to stamina damage taken
	var/stamina_reduction = 0
	/// Multiplier for incoming staminaloss
	var/incoming_stam_mult = 1
	/// Amount of stamina damage we heal per on_life() tick
	var/stam_heal_tick = 1
	/// How much we multiply stam_heal_tick by if the owner is lying down
	var/stam_heal_rest_multiplier = 2
	/// Maximum amount of stamina damage this limb can get
	var/max_stamina_damage = 0
	/// How much pain this limb is feeling
	var/pain_dam = 0
	/// Subtracted to pain the limb feels
	var/pain_reduction = 0
	/// Multiplier for incoming pain damage
	var/incoming_pain_mult = 1
	/// Amount of pain damage we heal per on_life() tick
	var/pain_heal_tick = 1
	/// How much we multiply pain_heal_tick by if the owner is lying down
	var/pain_heal_rest_multiplier = 3
	/// Point at which the limb is disabled due to pain
	var/pain_disability_threshold
	/// Maximum amount of pain this limb can feel at once
	var/max_pain_damage

	/// Multiplier of the limb's brute/burn damage that gets applied to the mob (this is dumb why is this a thing)
	var/body_damage_coeff = 1
	/// Multiplier of the limb's stamina damage that gets applied to the mob (this is dumb why is this a thing)
	var/stam_damage_coeff = 1
	/// Multiplier of the limb's pain damage that gets applied to the mob
	var/pain_damage_coeff = 1

	/// Amount of "integrity" this limb has - At 0, limb is amputated or destroyed
	var/limb_integrity = 0
	/// We multiply incoming limb integrity reduction by this
	var/incoming_integrity_mult = 1
	/// Maximum limb integrity the limb can have
	var/max_limb_integrity

	/// How damaged the limb needs to be to start taking internal organ damage
	var/organ_damage_requirement
	/// How much damage an attack needs to do, at the very least, to damage internal organs
	var/organ_damage_hit_minimum

	/// Pain threshold at which a limb gets temporarily crippled
	var/crippling_threshold
	/// Timer for resetting crippling
	var/cripple_timer

	/// Used to handle rejection from incompatible owner - Rejection level
	var/rejection_stage = 0
	/// Is the limb even functional at all?
	var/functional = TRUE

	/// For nonhuman bodyparts (e.g. monkey)
	var/animal_origin

	// Variables that should be gutted in favor of limb flags
	/// Whether it can be amputated or not
	var/dismemberable = TRUE
	/// A hat won't cover your face, but a shirt covering your chest will cover your... you know, chest
	var/scars_covered_by_clothes = TRUE

	var/px_x = 0
	var/px_y = 0

	/// Flags that we inherit from the owner, i guess
	var/species_flags_list

	// Damage messages used by help_shake_act()
	var/light_brute_msg = DEFAULT_LIGHT_BRUTE_MSG
	var/medium_brute_msg = DEFAULT_MEDIUM_BRUTE_MSG
	var/heavy_brute_msg = DEFAULT_HEAVY_BRUTE_MSG

	var/light_burn_msg = DEFAULT_LIGHT_BURN_MSG
	var/medium_burn_msg = DEFAULT_MEDIUM_BURN_MSG
	var/heavy_burn_msg = DEFAULT_HEAVY_BURN_MSG

	var/light_pain_msg = DEFAULT_LIGHT_PAIN_MSG
	var/medium_pain_msg = DEFAULT_MEDIUM_PAIN_MSG
	var/heavy_pain_msg = DEFAULT_HEAVY_PAIN_MSG

	// Descriptive strings
	/// descriptive string used in cavity implant surgery (e.g thoracic)
	var/cavity_name = "cavity"
	/// descriptive string used in amputation (e.g spine, hips, wrist)
	var/amputation_point_name = ""

	// ~base organs
	/// bone organ base type
	var/bone_type = /obj/item/organ/bone
	/// artery organ base type
	var/artery_type = /obj/item/organ/artery
	/// tendon organ base type
	var/tendon_type = /obj/item/organ/tendon
	/// nerve organ base type
	var/nerve_type = /obj/item/organ/nerve

	/// If someone has written something stupid on us
	var/etching = ""

	// Cavity item + organ stuff
	/// Maximum item size to be inserted in the cavity
	var/max_cavity_item_size = WEIGHT_CLASS_SMALL
	/// Maximum combined volume of organs and cavity items (item volume is w_class)
	var/max_cavity_volume = 2.5

	/// Specific dismemberment sounds, if any
	var/list/dismemberment_sounds = list(
		'modular_septic/sound/gore/gib1.ogg',
		'modular_septic/sound/gore/gib2.ogg',
		'modular_septic/sound/gore/gib3.ogg',
		'modular_septic/sound/gore/gib4.ogg',
		'modular_septic/sound/gore/gib5.ogg',
	)
	var/dismemberment_volume = 80

	/// Paths of that are already inside this limb on spawn - could be organs or limbs
	var/list/starting_children
	/// Non-organ and non-limb items currently inserted inside this limb
	var/list/obj/item/cavity_items
	/// Items currently embedded superficially on the limb
	var/list/obj/item/embedded_objects
	/// If something is currently grasping this bodypart (grab system)
	var/list/obj/item/grab/grasped_by
	/// If we have a gauze wrapping currently applied to this limb
	var/obj/item/stack/current_gauze
	/// If we have a splint currently applied to this limb
	var/obj/item/stack/current_splint

	/// A brain, if for some reason one inhabits the limb
	var/obj/item/organ/brain/brain
	/// If this limb houses a brain, this is the brain mob it houses
	var/mob/living/brain/brainmob

	/// The (TG-style) wound datums currently afflicting this body part
	var/list/datum/wound/wounds
	/// The (Bay-style) wound datums currently afflicting this bodypart
	var/list/datum/injury/injuries
	/// The last injury to have afflicted this bodypart
	var/datum/injury/last_injury
	/// The scars currently afflicting this body part
	var/list/datum/scar/scars

	/// Our current stored wound damage multiplier
	var/damage_multiplier = 1
	/// This number is subtracted from all wound rolls on this bodypart, higher numbers mean more defense, negative means easier to wound
	var/wound_resistance = 0
	/// When this bodypart hits max damage, this number is added to all wound rolls. Obviously only relevant for bodyparts that have damage caps.
	var/maxdam_wound_penalty = 15
	/// So we know if we need to scream if this limb gets disabled
	var/last_maxed = FALSE

	/// How many generic bleedstacks we have on this bodypart, used for bleeding without injuries
	var/generic_bleedstacks = 0
	/// How many injuries we have in this bodypart - NOT always equal to the length of injuries list!
	var/number_injuries = 0

	/// Diceroll modifier for hitting at all in melee combat
	var/melee_hit_modifier = 0
	/// Diceroll modifier for hitting this limb in specific in melee combat
	var/melee_hit_zone_modifier = 0
	/// Diceroll modifier for hitting at all in grabbing combat
	var/grabbing_hit_modifier = 0
	/// Diceroll modifier for hitting this limb in specific in grabbing combat
	var/grabbing_hit_zone_modifier = 0
	/// Diceroll modifier for hitting at all in thrown combat
	var/thrown_hit_modifier = 0
	/// Diceroll modifier for hitting this limb in specific in thrown combat
	var/thrown_hit_zone_modifier = 0
	/// Diceroll modifier for hitting at all in ranged combat
	var/ranged_hit_modifier = 0
	/// Diceroll modifier for hitting this limb in specific in ranged combat
	var/ranged_hit_zone_modifier = 0

	/// Zone we can deflect to, if hit_deflect_chance isn't 0
	var/deflect_zone
	/// Chance to deflect damage to another limb
	var/deflect_chance = 0

	/// Food reagents when the limb is bitten, if it is organic
	var/list/food_reagents_organic = list(
		/datum/reagent/consumable/nutriment/protein = 5, \
		/datum/reagent/consumable/nutriment/organ_tissue = 10, \
	)
	/// Food reagents when the limb is bitten, if it is robotic
	var/list/food_reagents_robotic = null
	/// The size of the reagent container for food_reagents
	var/reagent_vol = 20

	/// This stupid variable is used by two game mechanics - Brain spilling, gut spilling
	var/spilled = FALSE
	/// Represents the icon we use when spilled == TRUE
	var/spilled_overlay = "brain_busted"

/obj/item/bodypart/Initialize(mapload)
	. = ..()
	create_base_organs()
	create_starting_children()
	if(isnull(pain_disability_threshold))
		pain_disability_threshold = (max_damage * 0.8)
	if(isnull(crippling_threshold))
		crippling_threshold = max_damage * 0.5
	if(isnull(max_pain_damage))
		max_pain_damage = max_damage * 1.5
	if(isnull(organ_damage_requirement))
		organ_damage_requirement = max_damage * 0.2
	if(isnull(organ_damage_hit_minimum))
		organ_damage_hit_minimum = ORGAN_MINIMUM_DAMAGE
	if(isnull(max_limb_integrity))
		max_limb_integrity = max_damage
	limb_integrity = max_limb_integrity
	if(can_be_disabled)
		RegisterSignal(src, SIGNAL_ADDTRAIT(TRAIT_PARALYSIS), .proc/on_paralysis_trait_gain)
		RegisterSignal(src, SIGNAL_REMOVETRAIT(TRAIT_PARALYSIS), .proc/on_paralysis_trait_loss)
	RegisterSignal(src, SIGNAL_ADDTRAIT(TRAIT_ROTTEN), .proc/on_rotten_trait_gain)
	RegisterSignal(src, SIGNAL_REMOVETRAIT(TRAIT_ROTTEN), .proc/on_rotten_trait_loss)
	if(is_robotic_limb())
		grind_results = list(/datum/reagent/iron = 20)
		juice_results = list(/datum/reagent/toxin/acid = 20)
	if(CHECK_BITFIELD(limb_flags, BODYPART_EDIBLE))
		if(is_organic_limb() && LAZYLEN(food_reagents_organic))
			AddComponent(/datum/component/edible, \
				initial_reagents = food_reagents_organic, \
				foodtypes = RAW | MEAT | GROSS,\
				volume = reagent_vol, \
				after_eat = CALLBACK(src, .proc/on_eat_from))
		else if(is_robotic_limb() && LAZYLEN(food_reagents_robotic))
			AddComponent(/datum/component/edible, \
				initial_reagents = food_reagents_robotic, \
				foodtypes = RAW | MEAT | GROSS,\
				volume = reagent_vol, \
				after_eat = CALLBACK(src, .proc/on_eat_from))
	/// Runs decay when outside of a person AND ONLY WHEN OUTSIDE (i.e. long obj).
	START_PROCESSING(SSobj, src)

/obj/item/bodypart/Destroy(force)
	QDEL_NULL(brain)
	QDEL_NULL(brainmob)
	QDEL_NULL(teeth_object)
	QDEL_NULL(teeth_mod)
	if(owner)
		// The special flag is important, because otherwise mobs can die while undergoing transformation into different mobs.
		drop_limb(FALSE, FALSE, FALSE, FALSE)
	original_owner = null
	for(var/digit_type in digits)
		remove_digit(digits[digit_type], FALSE)
	if(LAZYLEN(digits))
		stack_trace("[type] qdeleted with [LAZYLEN(digits)] uncleared digits!")
		digits.Cut()
	for(var/cavity_item in cavity_items)
		cavity_items -= cavity_item
		qdel(cavity_item)
	if(LAZYLEN(cavity_items))
		stack_trace("[type] qdeleted with [LAZYLEN(cavity_items)] uncleared cavity items!")
		cavity_items.Cut()
	for(var/embedded_object in embedded_objects)
		embedded_objects -= embedded_object
		qdel(embedded_object)
	if(LAZYLEN(embedded_objects))
		stack_trace("[type] qdeleted with [LAZYLEN(cavity_items)] uncleared embedded objects!")
		embedded_objects.Cut()
	for(var/injury in injuries)
		qdel(injury) // injuries is a lazylist, and each injury removes itself from it on deletion.
	if(LAZYLEN(injuries))
		stack_trace("[type] qdeleted with [LAZYLEN(injuries)] uncleared injuries!")
		injuries.Cut()
	if(last_injury)
		stack_trace("[type] qdeleted with uncleared last_injury!")
		last_injury = null
	for(var/wound in wounds)
		qdel(wound) // wounds is a lazylist, and each wound removes itself from it on deletion.
	if(LAZYLEN(wounds))
		stack_trace("[type] qdeleted with [LAZYLEN(wounds)] uncleared wounds!")
		wounds.Cut()
	for(var/scar in scars)
		qdel(scar) // wounds is a lazylist, and each wound removes itself from it on deletion.
	if(LAZYLEN(scars))
		stack_trace("[type] qdeleted with [LAZYLEN(scars)] uncleared scars!")
		scars.Cut()
	if(LAZYLEN(body_markings))
		body_markings.Cut()
	if(LAZYLEN(starting_children))
		starting_children.Cut()
	if(LAZYLEN(starting_digits))
		starting_digits.Cut()
	if(LAZYLEN(children_zones))
		children_zones.Cut()
	return ..()

/obj/item/bodypart/deconstruct(disassembled = TRUE)
	drop_organs()
	qdel(src)

/obj/item/bodypart/handle_atom_del(atom/deleting_atom)
	if(deleting_atom == brainmob)
		brainmob = null
	if(deleting_atom == brain)
		brain = null
		update_icon_dropped()
		if(!QDELETED(brainmob)) //this shouldn't happen without badminnery, but what if it does?
			message_admins("Brainmob: ([ADMIN_LOOKUPFLW(brainmob)]) was left stranded in [src] at [ADMIN_VERBOSEJMP(src)] without a brain!")
			log_game("Brainmob: ([key_name(brainmob)]) was left stranded in [src] at [AREACOORD(src)] without a brain!")
	if(deleting_atom == teeth_object)
		teeth_object = null
	if(deleting_atom in cavity_items)
		LAZYREMOVE(cavity_items, deleting_atom)
	if(deleting_atom in embedded_objects)
		LAZYREMOVE(embedded_objects, deleting_atom)
	return ..()

/obj/item/bodypart/proc/create_starting_children()
	for(var/child_path in starting_children)
		var/obj/item/item = new child_path(src)
		if(isbodypart(item))
			var/obj/item/bodypart/bodypart = item
			bodypart.transfer_to_limb(src)
		else if(isorgan(item))
			var/obj/item/organ/organ = item
			organ.transfer_to_limb(src)

/obj/item/bodypart/proc/create_base_organs()
	if(CHECK_BITFIELD(limb_flags, BODYPART_HAS_BONE))
		create_bone()
	if(CHECK_BITFIELD(limb_flags, BODYPART_HAS_TENDON))
		create_tendon()
	if(CHECK_BITFIELD(limb_flags, BODYPART_HAS_NERVE))
		create_nerve()
	if(CHECK_BITFIELD(limb_flags, BODYPART_HAS_ARTERY))
		create_artery()
	if(max_teeth)
		fill_teeth()
	if(length(starting_digits))
		fill_digits()

/obj/item/bodypart/proc/create_bone()
	if(ispath(bone_type))
		var/obj/item/organ/bone = new bone_type(src)
		if(owner)
			bone.Insert(owner)

/obj/item/bodypart/proc/create_tendon()
	if(ispath(tendon_type))
		var/obj/item/organ/tendon = new tendon_type(src)
		if(owner)
			tendon.Insert(owner)

/obj/item/bodypart/proc/create_nerve()
	if(ispath(nerve_type))
		var/obj/item/organ/nerve = new nerve_type(src)
		if(owner)
			nerve.Insert(owner)

/obj/item/bodypart/proc/create_artery()
	if(ispath(artery_type))
		var/obj/item/organ/artery = new artery_type(src)
		if(owner)
			artery.Insert(owner)

/obj/item/bodypart/proc/on_eat_from(eater, feeder)
	functional = FALSE //You can't use it anymore after eating it you spaztic
	receive_damage(brute = 25, sharpness = SHARP_EDGED)
	//drop all organs inside us
	var/turf/drop_location = drop_location()
	if(istype(drop_location))
		drop_organs()
	update_limb_efficiency()

/// Can this bodypart rot or get infected?
/obj/item/bodypart/proc/can_decay()
	check_cold()
	if(CHECK_BITFIELD(limb_flags, BODYPART_FROZEN|BODYPART_DEAD|BODYPART_SYNTHETIC|BODYPART_NO_INFECTION))
		return FALSE
	else if(reagents?.has_reagent(/datum/reagent/toxin/formaldehyde, 0.5) || reagents?.has_reagent(/datum/reagent/cryostylane, 0.5))
		return FALSE
	else if((owner?.stat >= DEAD) && (owner?.reagents?.has_reagent(/datum/reagent/toxin/formaldehyde, 0.5) || owner?.reagents?.has_reagent(/datum/reagent/cryostylane, 0.5)))
		return FALSE
	return TRUE

/// Processing outside the body
/obj/item/bodypart/process(delta_time)
	return on_death(delta_time)

/// Things that process when the limb is well, rotting
/obj/item/bodypart/proc/on_death(delta_time, times_fired)
	if(can_decay())
		decay(delta_time, times_fired)
	else if(!owner)
		return PROCESS_KILL

/// Rotting away over time
/obj/item/bodypart/proc/decay(delta_time, times_fired)
	adjust_germ_level(rand(min_decay_factor,max_decay_factor) * delta_time)
	update_limb(FALSE)
	update_icon_dropped()

/// Checks to see if the bodypart is frozen from temperature
/obj/item/bodypart/proc/check_cold()
	if(istype(loc, /obj))//Freezer of some kind, I hope.
		if(is_type_in_typecache(loc, GLOB.freezing_objects))
			if(!CHECK_BITFIELD(limb_flags, BODYPART_FROZEN)) //Incase someone puts them in when cold, but they warm up inside of the thing. (i.e. they have the flag, the thing turns it off, this rights it.)
				limb_flags |= BODYPART_FROZEN
			return TRUE
		return CHECK_BITFIELD(limb_flags, BODYPART_FROZEN) //Incase something else toggles it

	var/local_temp
	if(!owner)
		if(istype(loc, /turf))//Only concern is adding an organ to a freezer when the area around it is cold.
			var/turf/turf_loc = loc
			var/datum/gas_mixture/enviro = turf_loc.return_air()
			local_temp = enviro.temperature
		else if(!owner && ismob(loc))
			var/mob/mob_loc = loc
			if(is_type_in_typecache(mob_loc.loc, GLOB.freezing_objects))
				if(!CHECK_BITFIELD(limb_flags, BODYPART_FROZEN))
					limb_flags |= BODYPART_FROZEN
				return TRUE
			var/turf/turf_loc = mob_loc.loc
			var/datum/gas_mixture/enviro = turf_loc.return_air()
			local_temp = enviro.temperature
	else
		// Don't interfere with bodies frozen by structures.
		if(is_type_in_typecache(owner.loc, GLOB.freezing_objects))
			if(!CHECK_BITFIELD(limb_flags, BODYPART_FROZEN))
				limb_flags |= BODYPART_FROZEN
			return TRUE
		local_temp = owner.bodytemperature

	if(!local_temp) // Shouldn't happen but in case
		return
	if(local_temp <= 154) // I have a pretty shaky citation that states -120 allows indefinite cyrostorage
		limb_flags |= BODYPART_FROZEN
		return TRUE

	limb_flags &= ~BODYPART_FROZEN
	return FALSE

/// Adding/removing germs
/obj/item/bodypart/adjust_germ_level(add_germs, minimum_germs = 0, maximum_germs = GERM_LEVEL_MAXIMUM)
	. = ..()
	if(germ_level >= INFECTION_LEVEL_THREE && !CHECK_BITFIELD(limb_flags, BODYPART_DEAD))
		kill_limb()
		if(owner && owner.stat < DEAD)
			to_chat(owner, span_userdanger("I can't feel my [name] anymore..."))
	consider_processing()

/// General handling of infections
/obj/item/bodypart/proc/update_germs(delta_time, times_fired)
	//Cryo stops germs from moving and doing their bad stuffs
	if(owner.bodytemperature <= TCRYO)
		return
	handle_germ_sync(delta_time, times_fired)
	handle_germ_effects(delta_time, times_fired)
	handle_antibiotics(delta_time, times_fired)

/// Try to sync wound/inuries etc with our germ level
/obj/item/bodypart/proc/handle_germ_sync(delta_time, times_fired)
	// If we have no wounds, nor injuries, nor germ level, no point in trying to update
	if(!length(wounds) && !length(injuries) && (germ_level <= 0))
		return

	var/turf/open/floor/open_turf = get_turf(owner)
	var/owner_germ_level = 2*owner.germ_level
	for(var/obj/item/embeddies in embedded_objects)
		if(!embeddies.isEmbedHarmless())
			owner_germ_level += (embeddies.germ_level/5)

	// Open injuries can become infected, regardless of antibiotics
	if(istype(open_turf))
		for(var/datum/injury/injury as anything in injuries)
			if(injury.infection_check(delta_time, times_fired) && (max(open_turf.germ_level, owner_germ_level) > injury.germ_level))
				injury.adjust_germ_level(injury.infection_rate * (0.5 * delta_time))

	// If we have sufficient antibiotics, then skip over this stuff, the infection is going away
	var/antibiotics = owner.get_antibiotics()
	if(antibiotics >= 10)
		return

	for(var/datum/injury/injury as anything in injuries)
		//Infected injuries raise the bodypart's germ level
		if(injury.germ_level > germ_level || DT_PROB(CEILING(min(injury.germ_level/5, 40)/2, 1), delta_time))
			adjust_germ_level(injury.infection_rate * (0.5 * delta_time))
			break	//limit increase to a maximum of one injury infection increase per 2 seconds

/// Handle infection effects
/obj/item/bodypart/proc/handle_germ_effects(delta_time, times_fired)
	var/immunity = owner.virus_immunity()
	var/immunity_weakness = owner.immunity_weakness()
	var/antibiotics = owner.get_antibiotics()
	var/arterial_efficiency = getorganslotefficiency(ORGAN_SLOT_ARTERY)

	// Being properly oxygenated
	if(!artery_needed() || (arterial_efficiency >= ORGAN_FAILING_EFFICIENCY))
		if(germ_level > 0 && (germ_level < INFECTION_LEVEL_ONE/2) && DT_PROB(immunity*0.3, delta_time))
			adjust_germ_level(-1 * (0.5 * delta_time))
			return
	// Gangrene
	else
		adjust_germ_level(1 * (0.5 * delta_time))

	if(germ_level >= INFECTION_LEVEL_ONE/2)
		//Warn the user that they're a bit fucked
		if(germ_level <= INFECTION_LEVEL_ONE && (owner.stat < DEAD) && DT_PROB(2, delta_time))
			owner.custom_pain("My [src.name] feels a bit warm and swollen...", 6, FALSE, src)
		//Aiming for germ level to go from ambient to INFECTION_LEVEL_TWO in an average of 15 minutes, when immunity is full.
		if(antibiotics < 5 && DT_PROB(FLOOR(germ_level/6 * immunity_weakness * 0.005, 1), delta_time))
			if(immunity > 0)
				//Immunity starts at 100. This doubles infection rate at 50% immunity. Rounded to nearest whole.
				adjust_germ_level(clamp(FLOOR(1/immunity, 1), 1, 10) * (0.5 * delta_time))
			else
				//Will only trigger if immunity has hit zero. Once it does, 10x infection rate.
				adjust_germ_level(10 * (0.5 * delta_time))

	if(germ_level >= INFECTION_LEVEL_ONE && (antibiotics < 20))
		if(DT_PROB(3, delta_time) && (owner.stat < DEAD) && germ_level <= INFECTION_LEVEL_TWO)
			owner.custom_pain("My [src.name] feels hotter than normal...", 12, FALSE, src)
		var/fever_temperature = (BODYTEMP_HEAT_DAMAGE_LIMIT - BODYTEMP_NORMAL - 5) * min(germ_level/INFECTION_LEVEL_TWO, 1) + BODYTEMP_NORMAL
		owner.adjust_bodytemperature(clamp((fever_temperature - T20C)/BODYTEMP_COLD_DIVISOR + 1, 0, fever_temperature - owner.bodytemperature), use_insulation = FALSE)

	// Spread the infection to internal organs, child and parent bodyparts
	if(germ_level >= INFECTION_LEVEL_TWO && antibiotics < 25)
		// Chance to cause pain, while also informing the owner
		if(owner && (owner.stat < DEAD) && DT_PROB(4, delta_time))
			owner.custom_pain("My [src.name] starts leaking some pus...", 16, FALSE, src)

		// Make internal organs become infected one at a time instead of all at once
		var/obj/item/organ/target_organ
		var/obj/item/organ/organ
		var/list/candidate_organs = list()
		for(var/thing in get_organs())
			organ = thing
			if(organ.germ_level <= germ_level)
				candidate_organs |= organ
		if(length(candidate_organs))
			target_organ = pick(candidate_organs)

		// Infect the target organ
		if(target_organ)
			target_organ.adjust_germ_level(1 * (0.5 * delta_time))

		// Spread the infection to child and parent organs
		var/zones = list()
		zones |= parent_body_zone
		zones |= children_zones
		if(LAZYLEN(zones))
			for(var/zone in zones)
				var/obj/item/bodypart/bodypart = owner.get_bodypart(zone)
				if(bodypart && (bodypart.germ_level < germ_level))
					if(bodypart.germ_level < INFECTION_LEVEL_TWO || DT_PROB(15, delta_time))
						bodypart.adjust_germ_level(1 * (0.5 * delta_time))

/// Handle the antibiotic chem effect
/obj/item/bodypart/proc/handle_antibiotics(delta_time, times_fired)
	if(!owner || (owner.stat >= DEAD) || (germ_level <= 0))
		return

	var/antibiotics = owner.get_antibiotics()
	if(antibiotics <= 0)
		return

	if((germ_level < INFECTION_LEVEL_ONE) && (antibiotics >= 20))
		if(getorganslotefficiency(ORGAN_SLOT_ARTERY) >= ORGAN_FAILING_EFFICIENCY)
			set_germ_level(0) //cure instantly
	else
		adjust_germ_level(-antibiotics * SANITIZATION_ANTIBIOTIC * (0.5 * delta_time))	//at germ_level == 500 and 50 antibiotic, this should cure the infection in 5 minutes
		if(owner?.body_position == LYING_DOWN)
			adjust_germ_level(-SANITIZATION_LYING * (0.5 * delta_time))

/// Rejection for incompatible limbs
/obj/item/bodypart/proc/handle_rejection(delta_time, times_fired)
	if(CHECK_BITFIELD(limb_flags, BODYPART_SYNTHETIC))
		rejection_stage = 0
		return

	// Process unsuitable transplants. TODO: consider some kind of
	// immunosuppressant that changes transplant data to make it match.
	var/antibiotics = owner.get_antibiotics()
	if(antibiotics >= 50) //for now just having antibiotics will do
		original_owner = WEAKREF(owner)
		rejection_stage = 0
		return

	var/mob/living/carbon/og_owner = original_owner?.resolve()
	if(og_owner?.dna?.blood_type)
		var/datum/dna/original_dna = og_owner.dna
		if(!rejection_stage)
			if(!(owner.dna.blood_type in get_safe_blood(original_dna?.blood_type)))
				rejection_stage = REJECTION_LEVEL_1
		else
			rejection_stage += (0.5 * delta_time) //Rejection severity increases over time.
			if(!(rejection_stage % 10)) //Only fire every ten rejection ticks.
				switch(rejection_stage)
					if(REJECTION_LEVEL_1 to REJECTION_LEVEL_2)
						adjust_germ_level(1 * (0.5 * delta_time))
					if(REJECTION_LEVEL_2 to REJECTION_LEVEL_3)
						adjust_germ_level(rand(1,2) * (0.5 * delta_time))
					if(REJECTION_LEVEL_3 to REJECTION_LEVEL_4)
						adjust_germ_level(rand(2,3) * (0.5 * delta_time))
					if(REJECTION_LEVEL_4 to INFINITY)
						adjust_germ_level(rand(3,5) * (0.5 * delta_time))
						owner.reagents.add_reagent(/datum/reagent/toxin, rand(1,2))
		return
	original_owner = WEAKREF(owner)
	rejection_stage = 0

/// Since organs aren't actually stored in the bodypart themselves while attached to a person, we have to query the owner for what we should have
/obj/item/bodypart/proc/get_organs()
	if(!owner)
		. = list()
		for(var/thing in contents)
			if(isorgan(thing))
				. |= thing
		return

	return LAZYACCESS(owner.organs_by_zone, body_zone)

/// Empties the bodypart from its organs and other things inside it
/obj/item/bodypart/proc/drop_organs(violent_removal = FALSE)
	var/turf/drop_location = drop_location()
	if(!istype(drop_location))
		drop_location = null
	if(current_gauze)
		remove_gauze(drop_gauze = FALSE)
	if(brain)
		if(brainmob)
			brainmob.container = null
			brainmob.forceMove(brain)
			brain.brainmob = brainmob
			brainmob = null
		if(istype(drop_location))
			brain.forceMove(drop_location)
		else
			qdel(brain)
		brain = null
	for(var/obj/item/organ/drop_organ as anything in get_organs())
		drop_organ.transfer_to_limb(src, owner)
	for(var/obj/item/item in src)
		if(istype(item, /obj/item/reagent_containers/pill))
			for(var/datum/action/item_action/hands_free/activate_pill/pill_action in item.actions)
				qdel(pill_action)
		else if(isbodypart(item))
			var/obj/item/bodypart/child_part = item
			child_part.update_limb(TRUE)
			child_part.update_icon_dropped()
		else if(isorgan(item))
			var/obj/item/organ/organ = item
			organ.organ_flags |= ORGAN_CUT_AWAY
		if(drop_location)
			item.forceMove(drop_location)
		else
			qdel(item)
	cavity_items = null
	embedded_objects = null
	if(violent_removal && (status == BODYPART_ORGANIC))
		playsound(src, 'sound/misc/splort.ogg', 50, TRUE, -1)
	update_limb(TRUE)
	update_icon_dropped()

/// Empties the bodypart of bodyparts inside it
/obj/item/bodypart/proc/drop_bodyparts(mob/living/carbon/was_owner)
	var/turf/drop_location = drop_location()
	if(!istype(drop_location))
		drop_location = null
	for(var/obj/item/bodypart/bodypart in src)
		if(drop_location)
			bodypart.forceMove(drop_location)
			if(istype(was_owner))
				var/direction = pick(GLOB.alldirs)
				var/range = rand(1, 3)
				var/turf/target_turf = get_ranged_target_turf(was_owner, direction, range)
				var/old_throwforce = bodypart.throwforce
				bodypart.throwforce = 0
				bodypart.throw_at(target_turf, throw_range, throw_speed, callback = CALLBACK(src, /obj/item/bodypart/proc/dismember_done, old_throwforce))
		else
			qdel(bodypart)

/// Returns the volume of organs and cavity items for the organ storage component to use
/obj/item/bodypart/proc/get_cavity_volume()
	. = 0
	for(var/obj/item/organ/organ as anything in get_organs())
		. += organ.organ_volume
	for(var/obj/item/item as anything in cavity_items)
		. += item.w_class

/// This is an unsafe proc, don't use it without any checks
/obj/item/bodypart/proc/add_cavity_item(obj/item/cavity_item)
	cavity_item.forceMove(src)
	LAZYADD(cavity_items, cavity_item)

/obj/item/bodypart/proc/remove_cavity_item(obj/item/cavity_item)
	if(owner)
		cavity_item.forceMove(get_turf(owner))
	else
		cavity_item.forceMove(get_turf(src))
	LAZYREMOVE(cavity_items, cavity_item)

/// Check if we need to run on_life()
/obj/item/bodypart/proc/consider_processing()
	. = FALSE
	if(stamina_dam >= DAMAGE_PRECISION)
		. = TRUE
	//else if.. else if.. so on.
	else if(pain_dam >= DAMAGE_PRECISION)
		. = TRUE
	else if(number_injuries)
		. = TRUE
	else if(rejection_stage)
		. = TRUE
	else if(can_decay() && germ_level)
		. = TRUE
	else if(getorganslotefficiency(ORGAN_SLOT_ARTERY) < ORGAN_FAILING_EFFICIENCY)
		. = TRUE
	needs_processing = .

/// Return TRUE to get whatever mob this is in to update health.
/obj/item/bodypart/proc/on_life(delta_time, times_fired, stam_regen)
	//DO NOT update health here, it'll be done in the carbon's life.
	if(stam_regen && stam_heal_tick && stamina_dam >= DAMAGE_PRECISION)
		//Pain makes you regenerate stamina slower.
		//At maximum pain, you barely regenerate stamina on the limb.
		var/multiplier = round(max(0.1, 1 - get_shock(TRUE, TRUE)/max_pain_damage), DAMAGE_PRECISION)
		if(!can_feel_pain())
			multiplier = 1
		if(bodypart_disabled)
			multiplier *= 1.5
		if(owner.body_position == LYING_DOWN)
			multiplier *= stam_heal_rest_multiplier
		if(heal_damage(stamina = (stam_heal_tick * multiplier * (0.5 * delta_time)), updating_health = FALSE))
			. |= BODYPART_LIFE_UPDATE_HEALTH
	if(pain_heal_tick && (pain_dam >= DAMAGE_PRECISION))
		var/multiplier = 1
		if(owner.body_position == LYING_DOWN)
			multiplier *= pain_heal_rest_multiplier
		if(remove_pain(amount = (pain_heal_tick * multiplier * (0.5 * delta_time)), updating_health = FALSE))
			. |= BODYPART_LIFE_UPDATE_HEALTH
	if(can_decay())
		if(rejection_stage)
			handle_rejection(delta_time, times_fired)
			. |= BODYPART_LIFE_UPDATE_HEALTH
		if(germ_level || (getorganslotefficiency(ORGAN_SLOT_ARTERY) < ORGAN_FAILING_EFFICIENCY))
			update_germs(delta_time, times_fired)
			. |= BODYPART_LIFE_UPDATE_HEALTH
	if(number_injuries)
		update_injuries(delta_time, times_fired)
		. |= BODYPART_LIFE_UPDATE_HEALTH

/// Deal with injury healing and other updates
/obj/item/bodypart/proc/update_injuries(delta_time, times_fired)
	var/toxins = 0
	if(owner)
		toxins = owner.get_chem_effect(CE_TOXIN)
		//the dylovenal is mightier than the cyanide
		if(owner?.get_chem_effect(CE_ANTITOX) >= 10)
			toxins = 0
		//broken heart
		if(owner?.getorganslotefficiency(ORGAN_SLOT_HEART) < ORGAN_FAILING_EFFICIENCY)
			toxins = max(toxins, 1)
	for(var/datum/injury/injury as anything in injuries)
		if(injury.damage <= 0)
			qdel(injury)
			continue

		// Slow healing
		var/heal_amt = 0

		if(!toxins && injury.can_autoheal())
			heal_amt += (GET_MOB_ATTRIBUTE_VALUE(owner, STAT_ENDURANCE) * 0.01)
			// sleepy niggas heal triple
			if(owner?.IsSleeping() && HAS_TRAIT(owner, TRAIT_TRYINGTOSLEEP))
				heal_amt *= 4

		if(heal_amt)
			injury.heal_damage(heal_amt * (0.5 * delta_time))

		// Bleeding
		if(owner)
			injury.bleed_timer = max(0, injury.bleed_timer - (0.5 * delta_time))

	// Sync the limb's damage with its injuries
	update_damages()
	// Also update efficiency
	update_limb_efficiency()
	owner.update_damage_overlays()

/// Returns whether or not the bodypart can feel pain
/obj/item/bodypart/proc/can_feel_pain()
	. = FALSE
	if(CHECK_BITFIELD(limb_flags, BODYPART_CUT_AWAY|BODYPART_DEAD))
		return
	if(HAS_TRAIT(src, TRAIT_NOPAIN))
		return
	return owner?.can_feel_pain()

/// Add pain_dam to a bodypart
/obj/item/bodypart/proc/add_pain(amount = 0, updating_health = TRUE, required_status = null)
	if(required_status && (status != required_status))
		return
	if(!can_feel_pain())
		return
	var/can_inflict = max_pain_damage - pain_dam
	amount *= CONFIG_GET(number/damage_multiplier)
	amount -= owner.get_chem_effect(CE_PAINKILLER)/PAINKILLER_DIVISOR
	amount = min(can_inflict, amount)
	pain_dam = round(pain_dam + max(amount, 0), DAMAGE_PRECISION)
	if(updating_health)
		owner.update_shock()
	if(can_be_disabled)
		update_disabled()
	return TRUE

/// Remove pain_dam from a bodypart
/obj/item/bodypart/proc/remove_pain(amount = 0, updating_health = TRUE, required_status = null)
	if(required_status && (status != required_status))
		return
	if(amount > pain_dam)
		amount = pain_dam
	pain_dam = FLOOR(pain_dam - max(abs(amount), 0), DAMAGE_PRECISION)
	if(updating_health)
		owner?.update_shock()
	if(can_be_disabled)
		update_disabled()
	return TRUE

/// Make total pain equal amount
/obj/item/bodypart/proc/set_pain(amount = 0, updating_health = TRUE, required_status = null)
	if(required_status && (status != required_status))
		return
	var/diff = amount - pain_dam
	if(diff >= 0)
		return add_pain(abs(diff), updating_health, required_status)
	else
		return remove_pain(abs(diff), updating_health, required_status)

/// Returns how much pain we are dealing with right now, taking other damage types into account
/obj/item/bodypart/proc/get_shock(painkiller_included = FALSE, nerve_included = TRUE)
	if(!can_feel_pain())
		return 0
	//Multiply our total pain damage by this
	var/multiplier = 1
	if(LAZYLEN(grasped_by))
		//Being grasped lowers the pain just a bit
		multiplier *= 0.75
	if(nerve_included && CHECK_BITFIELD(limb_flags, BODYPART_HAS_NERVE))
		//Nerves heavily affect pain
		multiplier *= (getorganslotefficiency(ORGAN_SLOT_NERVE)/ORGAN_OPTIMAL_EFFICIENCY)
	if(multiplier <= 0)
		return 0
	var/constant_pain = 0
	constant_pain += SHOCK_MOD_BRUTE * brute_dam
	constant_pain += SHOCK_MOD_BURN * burn_dam
	var/datum/wound/wound
	for(var/thing in wounds)
		wound = thing
		constant_pain += wound.pain_amount
	var/obj/item/organ/organ
	for(var/thing in get_organs())
		organ = thing
		constant_pain += organ.get_shock(FALSE)
	var/obj/item/item
	for(var/thing in embedded_objects)
		item = thing
		if(!item.isEmbedHarmless())
			constant_pain += 3 * item.w_class
	if(is_stump())
		constant_pain += 35
	if(painkiller_included)
		constant_pain -= owner.get_chem_effect(CE_PAINKILLER)/PAINKILLER_DIVISOR
	return clamp(FLOOR((pain_dam + constant_pain) * multiplier, DAMAGE_PRECISION), 0, max_pain_damage)

//Applies brute and burn damage to the organ. Returns 1 if the damage-icon states changed at all.
//Damage will not exceed max_damage using this proc
//Cannot apply negative damage
/obj/item/bodypart/proc/receive_damage(brute = 0, \
									burn = 0, \
									stamina = 0, \
									blocked = 0, \
									updating_health = TRUE, \
									required_status = null, \
									wound_bonus = 0, \
									bare_wound_bonus = 0, \
									dismember_bouns = 0, \
									sharpness = NONE, \
									organ_bonus = 0, \
									bare_organ_bonus = 0, \
									reduced = 0, \
									edge_protection = 0, \
									subarmor_flags = NONE, \
									attack_direction = null, \
									wound_messages = TRUE)
	var/hit_percent = (100-blocked)/100
	if((!brute && !burn && !stamina) || hit_percent <= 0)
		return FALSE

	if(owner && (owner.status_flags & GODMODE))
		return FALSE //godmode

	if(required_status && (status != required_status))
		return FALSE

	if(deflect_zone && prob(deflect_chance))
		var/obj/item/bodypart/deflected_part = owner?.get_bodypart(deflect_zone)
		if(deflected_part)
			return deflected_part.receive_damage(brute, burn, stamina, blocked, updating_health, required_status, wound_bonus, bare_wound_bonus, sharpness)

	var/dmg_mlt = CONFIG_GET(number/damage_multiplier)
	var/burn_brutemod = 1 + (0.35 * burn_dam/max_damage)
	brute = round(max(brute * dmg_mlt * burn_brutemod * damage_multiplier * incoming_brute_mult, 0), DAMAGE_PRECISION)
	burn = round(max(burn * dmg_mlt * damage_multiplier * incoming_burn_mult, 0), DAMAGE_PRECISION)
	stamina = round(max(stamina * dmg_mlt, 0), DAMAGE_PRECISION)
	brute =  max(0, brute - brute_reduction)
	burn =  max(0, burn - burn_reduction)

	var/initial_brute = brute
	var/initial_burn = burn
	var/actually_reduced_brute = min(brute, reduced)
	brute = max(0, brute - (brute >= burn ? reduced : 0))
	burn = max(0, burn - (burn > brute ? reduced : 0))
	if(subarmor_flags & SUBARMOR_FLEXIBLE)
		brute += FLOOR(actually_reduced_brute*0.1, 1)

	if(!brute && !burn && !stamina)
		if(wound_messages && reduced && (initial_brute || initial_burn))
			SEND_SIGNAL(owner, COMSIG_CARBON_ADD_TO_WOUND_MESSAGE, span_lowpain(" Damage is <b>stopped</b> by armor!"))
		return FALSE

	/*
	// START WOUND HANDLING
	*/

	// what kind of wounds we're gonna roll for, take the greater between brute and burn, then if it's brute, we subdivide based on sharpness
	var/wounding_type = WOUND_NONE
	if(brute || burn)
		wounding_type = (brute >= burn ? WOUND_BLUNT : WOUND_BURN)
	var/wounding_dmg = brute + burn
	var/mangled_state = get_mangled_state()
	var/bio_state = owner?.get_biological_state()
	var/easy_dismember = (owner && HAS_TRAIT(owner, TRAIT_EASYDISMEMBER)) // if we have easydismember, we don't reduce damage when redirecting damage to different types (slashing weapons on mangled/skinless limbs attack at 100% instead of 50%)

	if(sharpness && (wounding_type == WOUND_BLUNT) && (wounding_dmg > edge_protection))
		if(sharpness & SHARP_EDGED)
			wounding_type = WOUND_SLASH
		else if (sharpness & SHARP_POINTY)
			wounding_type = WOUND_PIERCE

	// Use this later to dismember proper
	var/initial_wounding_type = wounding_type
	var/initial_wounding_dmg = wounding_dmg

	// Now we have our wounding_type and are ready to carry on with dealing damage and then wounds
	var/owner_endurance = GET_MOB_ATTRIBUTE_VALUE(owner, STAT_ENDURANCE)

	// We get the pain values before we scale damage down
	// Pain does not care about your feelings, nor if your limb was already damaged
	// to it's maximum
	var/painkiller_mod = owner?.get_chem_effect(CE_PAINKILLER)/PAINKILLER_DIVISOR
	var/pain = min((SHOCK_MOD_BRUTE * brute) + (SHOCK_MOD_BURN * burn) - painkiller_mod, max_pain_damage-pain_dam)

	// Sparking on robotic limbs
	if((status == BODYPART_ROBOTIC) && owner && (initial_wounding_dmg >= 5) && prob(20+brute+burn))
		do_sparks(3,GLOB.alldirs,owner)

	// Total damage used to calculate the can_inflicts
	var/total_damage = brute + burn

	// How much we are actuallly allowed to inflict
	var/can_inflict = max_damage - get_damage()
	var/can_inflict_brute = max(0, (brute/max(1, burn)) * can_inflict)
	var/can_inflict_burn = max(0, (burn/max(1, brute)) * can_inflict)
	var/can_inflict_stamina = max(0, max_stamina_damage - stamina_dam)

	// We save these values to add to shock if necessary
	var/extrabrute = max(0, brute - can_inflict_brute)
	var/extraburn = max(0, burn - can_inflict_burn)
	if(total_damage > can_inflict)
		brute = can_inflict_brute
		burn = can_inflict_burn
	if(stamina > can_inflict_stamina)
		stamina = can_inflict_stamina
	if(extrabrute || extraburn)
		if(pain_dam < max_pain_damage)
			pain = min(pain+extrabrute+extraburn, max_pain_damage-pain_dam)
		else if(owner)
			var/oof_ouch = max(0, (extrabrute + extraburn - painkiller_mod) * (owner_endurance/ATTRIBUTE_MIDDLING))
			owner.adjustShockStage(oof_ouch)

	// Now we add pain proper
	if(owner && pain && add_pain(pain, FALSE))
		if(prob(pain*0.5))
			owner.agony_scream()
		owner.flash_pain(pain)
		var/shock_penalty = min(SHOCK_PENALTY_CAP, FLOOR(pain/owner_endurance, 1))
		if(shock_penalty)
			owner.update_shock_penalty(shock_penalty)
		var/final_crippling_threshold = CEILING((owner_endurance/ATTRIBUTE_MIDDLING) * crippling_threshold, 1)
//		if(get_damage() > limb_integrity/2)
		if(pain >= final_crippling_threshold)
			owner.major_wound_effects(pain, body_zone, wound_messages)
			update_cripple()

	// Damage our injuries before we create new ones
	for(var/datum/injury/iter_injury as anything in injuries)
		iter_injury.receive_damage(initial_wounding_dmg, pain, initial_wounding_type)

	// Procs below will deal with creating the injury datums and updating values
	if(burn)
		var/datum/injury/injury = create_injury(wounding_type, burn)
		// Debug stuff
		if(!istype(injury))
			stack_trace("Failed to create injury with [burn] burn damage and [wounding_type] wounding type!")
		// Chance to try to ignite the mob on burn damage
		if(owner && prob(burn * 2))
			owner.IgniteMob()
	if(brute)
		var/datum/injury/injury = create_injury(wounding_type, brute)
		// Debug stuff
		if(!istype(injury))
			stack_trace("Failed to create injury with [brute] brute damage and [wounding_type] wounding type!")
	if(wound_messages && (reduced || (sharpness && (initial_wounding_type == WOUND_BLUNT))) )
		if(reduced)
			SEND_SIGNAL(owner, COMSIG_CARBON_ADD_TO_WOUND_MESSAGE, span_lowpain(" Damage is softened by armor!"))
		else
			SEND_SIGNAL(owner, COMSIG_CARBON_ADD_TO_WOUND_MESSAGE, span_lowestpain(" Damage is <i>barely</i> softened by armor!"))

	// We've dealt the physical damages, if there's room lets apply the stamina damage.
	if(stamina)
		set_stamina_dam(stamina_dam + round(clamp(stamina, 0, max_stamina_damage - stamina_dam), DAMAGE_PRECISION))

	// Update damages based on injuries
	update_damages()

	// Handling for bone only/flesh only/flesh and bone targets
	switch(bio_state)
		// if we're flesh only, all blunt attacks become slashing
		if(BIO_JUST_FLESH)
			if(wounding_type == WOUND_BLUNT)
				wounding_type = WOUND_SLASH
				wounding_dmg *= (easy_dismember ? 1 : 0.75)
			else if(wounding_type == WOUND_PIERCE)
				wounding_dmg *= (easy_dismember ? 1.5 : 1.25) // it's easy to puncture into plain flesh
		// if we're bone only, all cutting attacks go straight to the bone
		if(BIO_JUST_BONE)
			if(wounding_type == WOUND_SLASH)
				wounding_type = WOUND_BLUNT
				wounding_dmg *= (easy_dismember ? 1 : 0.75)
			else if(wounding_type == WOUND_PIERCE)
				wounding_type = WOUND_BLUNT
				wounding_dmg *= (easy_dismember ? 1 : 0.85)
		// note that there's no handling for BIO_JUST_FLESH since we don't have any that are that right now (slimepeople maybe someday)
		// standard humanoids
		if(BIO_FLESH_BONE)
			// if we've already mangled the skin (critical slash or piercing wound), then the bone is exposed, and we can damage it with sharp weapons at a reduced rate
			// So a big sharp weapon is still all you need to destroy a limb
			var/static/list/conversion_types = list(WOUND_SLASH, WOUND_PIERCE)
			if((mangled_state == BODYPART_MANGLED_FLESH || mangled_state == BODYPART_MANGLED_BOTH) && (wounding_type in conversion_types) && sharpness)
				if(wounding_type == WOUND_SLASH && !easy_dismember)
					wounding_dmg *= 0.75 // edged weapons pass along 60% of their wounding damage to the bone since the power is spread out over a larger area
				if(wounding_type == WOUND_PIERCE && !easy_dismember)
					wounding_dmg *= 0.85 // piercing weapons pass along 80% of their wounding damage to the bone since it's more concentrated
				wounding_type = WOUND_BLUNT

	// also, deal with damaging wounds before we create new ones
	for(var/datum/wound/iter_wound as anything in wounds)
		iter_wound.receive_damage(wounding_type, wounding_dmg, wound_bonus)

	// now we have our wounding_type and are ready to carry on with wounds
	if(owner && (wound_bonus != CANT_WOUND))
		if((initial_wounding_type in list(WOUND_BLUNT, WOUND_PIERCE)) && (initial_wounding_dmg >= TEETH_MINIMUM_DAMAGE))
			check_wounding(WOUND_TEETH, initial_wounding_dmg * (initial_wounding_type != WOUND_BLUNT ? 0.65 : 1), wound_bonus, bare_wound_bonus)
		if((initial_wounding_type in list(WOUND_SLASH, WOUND_PIERCE)) && (initial_wounding_dmg >= DIGITS_MINIMUM_DAMAGE))
			check_wounding(WOUND_DIGITS, initial_wounding_dmg * (initial_wounding_type != WOUND_SLASH ? 0.75 : 1), wound_bonus, bare_wound_bonus)
		if(wounding_dmg >= WOUND_MINIMUM_DAMAGE)
			check_wounding(wounding_type, wounding_dmg, wound_bonus, bare_wound_bonus)
		//may have been dismembered
		if(!owner)
			return
		if((initial_wounding_type in list(WOUND_SLASH, WOUND_PIERCE)) && (initial_wounding_dmg >= ARTERY_MINIMUM_DAMAGE))
			check_wounding(WOUND_ARTERY, initial_wounding_dmg * (initial_wounding_type == WOUND_PIERCE ? 0.75 : 1), wound_bonus, bare_wound_bonus)
		if((initial_wounding_type in list(WOUND_BLUNT, WOUND_SLASH, WOUND_PIERCE)) && (initial_wounding_dmg >= TENDON_MINIMUM_DAMAGE))
			check_wounding(WOUND_TENDON, initial_wounding_dmg * (initial_wounding_type == WOUND_BLUNT ? 0.5 : (initial_wounding_type == WOUND_PIERCE ? 0.75 : 1)), wound_bonus, bare_wound_bonus)
		if((initial_wounding_type in list(WOUND_BLUNT, WOUND_SLASH, WOUND_PIERCE)) && (initial_wounding_dmg >= NERVE_MINIMUM_DAMAGE))
			check_wounding(WOUND_NERVE, initial_wounding_dmg * (initial_wounding_type == WOUND_BLUNT ? 0.65 : (initial_wounding_type == WOUND_PIERCE ? 0.5 : 1)), wound_bonus, bare_wound_bonus)
		if(initial_wounding_dmg >= SPILL_MINIMUM_DAMAGE)
			check_wounding(WOUND_SPILL, initial_wounding_dmg * (initial_wounding_type == WOUND_PIERCE ? 0.5 : 1), wound_bonus, bare_wound_bonus)

	/*
	// END WOUND HANDLING
	*/

	// We damage the organs, if possible
	if(owner)
		if(organ_bonus != CANT_ORGAN)
			damage_internal_organs(initial_wounding_type, initial_wounding_dmg, organ_bonus, bare_organ_bonus, wound_messages = wound_messages)
		// Jostle broken bones too just for shits n giggles
		for(var/obj/item/organ/bone/bone in shuffle(getorganslotlist(ORGAN_SLOT_BONE)))
			if(!bone.can_jostle(owner))
				continue
			bone.jostle(owner)

	// Try to damage gauze/splint, if possible
	if(current_gauze)
		seep_gauze(initial_wounding_dmg)
	if(current_splint)
		seep_splint(initial_wounding_dmg)

	// Handle dismemberment if appropriate, everything is done
	if(wound_bonus != CANT_WOUND)
		if(mangled_state == BODYPART_MANGLED_BOTH)
			damage_integrity(initial_wounding_type, wounding_dmg, wound_bonus, bare_wound_bonus)

		if(try_dismember(initial_wounding_type, wounding_dmg, wound_bonus, bare_wound_bonus))
			return

	if(owner)
		if(!(owner.status_flags & BUILDING_ORGANS))
			update_limb_efficiency()
		if(updating_health)
			owner.updatehealth()
			if(stamina_dam >= DAMAGE_PRECISION)
				owner.update_stamina()
				owner.stam_regen_start_time = world.time + STAMINA_REGEN_BLOCK_TIME
				. = TRUE
			if(get_shock(FALSE, TRUE) >= DAMAGE_PRECISION)
				owner.update_shock()
				. = TRUE
		consider_processing()
	return update_bodypart_damage_state() || .

/// Updates brute_damn and burn_damn from injuries
/obj/item/bodypart/proc/update_damages()
	number_injuries = 0
	brute_dam = 0
	burn_dam = 0
	for(var/datum/injury/injury as anything in injuries)
		if(injury.damage <= 0)
			continue

		if(injury.damage_type == WOUND_BURN)
			burn_dam += injury.damage
		else
			brute_dam += injury.damage

		number_injuries += injury.amount

/// Proc for damaging organs inside a limb based on damage values
/obj/item/bodypart/proc/damage_internal_organs(wounding_type = WOUND_BLUNT, amount = 0, organ_bonus = 0, bare_organ_bonus = 0, forced = FALSE, wound_messages = TRUE)
	. = FALSE
	if(organ_bonus == CANT_ORGAN)
		return
	var/list/internal_organs = list()
	internal_organs |= get_organs()
	//damaging face organs = also damaging head organs
	var/list/extra_parts = list()
	if(body_zone == BODY_ZONE_PRECISE_FACE)
		extra_parts |= owner.get_bodypart(parent_body_zone)
		if(parent_body_zone == BODY_ZONE_HEAD)
			extra_parts |= owner.get_bodypart(BODY_ZONE_PRECISE_L_EYE)
			extra_parts |= owner.get_bodypart(BODY_ZONE_PRECISE_R_EYE)
	for(var/obj/item/bodypart/extra_part in extra_parts)
		internal_organs |= extra_part.get_organs()
	for(var/obj/item/organ/organ as anything in internal_organs)
		internal_organs -= organ
		if(!istype(organ))
			continue
		if(organ.damage < organ.maxHealth && \
			(organ.organ_volume * 10 >= 1) && \
			!CHECK_BITFIELD(organ.organ_flags, ORGAN_NO_VIOLENT_DAMAGE))
			// Multiply by 10 because pickweight doesn't play nice with decimals
			internal_organs[organ] = CEILING(organ.organ_volume * 10, 1)
	if(!LAZYLEN(internal_organs))
		return

	if(ishuman(owner) && bare_organ_bonus)
		var/mob/living/carbon/human/human_owner = owner
		for(var/obj/item/clothing/clothes_check as anything in human_owner.clothingonpart(src))
			if(clothes_check.armor.getRating(WOUND))
				bare_organ_bonus = 0
				break

	var/cur_damage = brute_dam+burn_dam
	var/damage_amt = amount+organ_bonus+bare_organ_bonus
	var/organ_damage_minimum = organ_damage_hit_minimum
	var/organ_damaged_required = organ_damage_requirement
	switch(wounding_type)
		// Piercing damage is more likely to damage internal organs
		if(WOUND_PIERCE)
			organ_damage_minimum *= 0.5
		// Slashing damage is *slightly* more likely to damage internal organs
		if(WOUND_SLASH)
			organ_damage_minimum *= 0.75
		// Burn damage is unlikely to damage organs
		if(WOUND_BURN)
			organ_damage_minimum *= 1.5
		// Organ damage minimum is assumed to be the case for blunt anyway
		else
			organ_damage_hit_minimum *= 1

	// Wounds can alter our odds of harming organs
	for(var/datum/wound/oof as anything in wounds)
		damage_amt += oof.organ_damage_increase
		organ_damage_minimum = max(1, organ_damage_minimum - oof.organ_minimum_reduction)
		organ_damaged_required = max(1, organ_damaged_required - oof.organ_required_reduction)

	// Set this to the maximum considered amount if we exceed it
	damage_amt = min(MAX_CONSIDERED_ORGAN_DAMAGE_ROLL, CEILING(damage_amt, 1))
	organ_damaged_required = CEILING(organ_damaged_required, 1)
	organ_damage_minimum = CEILING(organ_damage_minimum, 1)
	// We haven't hit one or more of the tresholds
	if(!forced && (!(cur_damage >= organ_damaged_required) || !(damage_amt >= organ_damage_minimum)))
		return FALSE

	var/organ_hit_chance = 30 * (damage_amt/organ_damage_minimum)
	// Bones getting in the way aaaaah
	var/modifier = 1
	var/list/bones = list()
	bones |= getorganslotlist(ORGAN_SLOT_BONE)
	if(LAZYLEN(extra_parts))
		var/obj/item/bodypart/shoeonhead = extra_parts[1]
		bones |= shoeonhead.getorganslotlist(ORGAN_SLOT_BONE)
	for(var/obj/item/organ/bone/bone as anything in bones)
		if((bone.damage >= bone.medium_threshold) || !(bone.bone_flags & BONE_ENCASING))
			continue
		modifier *= (ORGAN_OPTIMAL_EFFICIENCY/max(50, bone.get_slot_efficiency(ORGAN_SLOT_BONE)))

	organ_hit_chance *= modifier
	organ_hit_chance = clamp(CEILING(organ_hit_chance, 1), 0, 100)
	if(!prob(organ_hit_chance) && !forced)
		return FALSE

	var/obj/item/organ/victim = pick_weight(internal_organs)
	damage_amt = max(0, CEILING((damage_amt * victim.internal_damage_modifier) - victim.internal_damage_reduction, 1))
	if(damage_amt >= 1)
		victim.applyOrganDamage(damage_amt, silent = (damage_amt >= 15))
	if(owner)
		if(damage_amt >= 15)
			owner.custom_pain("<b>MY [uppertext(victim.name)] HURTS!</b>", rand(25, 35), affecting = src, nopainloss = TRUE)
		if(wound_messages)
			SEND_SIGNAL(owner, COMSIG_CARBON_ADD_TO_WOUND_MESSAGE, span_danger(" <b>An organ is damaged!</b>"))
	return TRUE

/// Creates an injury on the bodypart
/obj/item/bodypart/proc/create_injury(injury_type = WOUND_BLUNT, damage = 0, surgical = FALSE, wound_messages = TRUE)
	. = FALSE
	if(!surgical)
		var/can_inflict = max_damage - get_damage()
		damage = min(can_inflict, damage)

	if(damage <= 0)
		return

	// First check whether we can widen an existing wound
	if(damage >= 5 && !surgical && length(injuries) && prob(clamp(50 + (number_injuries-1 * 10), 50, 90)))
		// Piercing injuries cannot "open" into one
		// Small ass damage should create a new wound entirely
		var/list/compatible_injuries = list()
		for(var/thing in injuries)
			var/datum/injury/candidate_for_widening = thing
			if(candidate_for_widening.can_worsen(injury_type, damage))
				compatible_injuries |= candidate_for_widening
		if(length(compatible_injuries))
			var/datum/injury/compatible_injury = pick(compatible_injuries)
			compatible_injury.open_injury(damage)
			if(owner && wound_messages && prob(25 + damage))
				SEND_SIGNAL(owner, COMSIG_CARBON_ADD_TO_WOUND_MESSAGE, span_warning(" \The [compatible_injury.get_desc()] on [src] worsens!"))
			last_injury = compatible_injury
			. = compatible_injury

	// Creating NEW injury
	if(!.)
		var/new_injury_type = get_injury_type(injury_type, damage)
		if(new_injury_type)
			var/datum/injury/new_injury = new new_injury_type()
			// Check whether we can add the wound to an existing wound
			if(surgical)
				new_injury.autoheal_cutoff = 0
				new_injury.injury_flags |= INJURY_SURGICAL
			else
				for(var/datum/injury/other in injuries)
					if(other.can_merge(new_injury))
						other.merge_injury(new_injury)
						return other
			// Apply the injury
			new_injury.apply_injury(damage, src)
			last_injury = new_injury
			. = new_injury

/// Allows us to roll for and apply a wound without actually dealing damage. Used for aggregate wounding power with pellet clouds
/obj/item/bodypart/proc/painless_wound_roll(wounding_type, phantom_wounding_dmg, wound_bonus, bare_wound_bonus, sharpness=NONE)
	if(!owner || (phantom_wounding_dmg <= WOUND_MINIMUM_DAMAGE) || (wound_bonus == CANT_WOUND))
		return

	var/initial_wounding_type = wounding_type
	var/mangled_state = get_mangled_state()
	var/bio_state = owner.get_biological_state()
	var/easy_dismember = HAS_TRAIT(owner, TRAIT_EASYDISMEMBER) // if we have easydismember, we don't reduce damage when redirecting damage to different types (slashing weapons on mangled/skinless limbs attack at 100% instead of 50%)

	if(wounding_type == WOUND_BLUNT && sharpness)
		if(sharpness & SHARP_EDGED)
			wounding_type = WOUND_SLASH
		else if(sharpness & SHARP_POINTY)
			wounding_type = WOUND_PIERCE

	//Handling for bone only/flesh only/flesh and bone targets
	switch(bio_state)
		// if we're flesh only, all blunt attacks become slashing
		if(BIO_JUST_FLESH)
			if(wounding_type == WOUND_BLUNT)
				wounding_type = WOUND_SLASH
				phantom_wounding_dmg *= (easy_dismember ? 1 : 0.5)
			else if(wounding_type == WOUND_PIERCE)
				phantom_wounding_dmg *= 1.35 // it's easy to puncture into plain flesh
		// if we're bone only, all cutting attacks go straight to the bone
		if(BIO_JUST_BONE)
			if(wounding_type == WOUND_SLASH)
				wounding_type = WOUND_BLUNT
				phantom_wounding_dmg *= (easy_dismember ? 1 : 0.6)
			else if(wounding_type == WOUND_PIERCE)
				wounding_type = WOUND_BLUNT
				phantom_wounding_dmg *= (easy_dismember ? 1 : 0.75)
		// note that there's no handling for BIO_JUST_FLESH since we don't have any that are that right now (slimepeople maybe someday)
		// standard humanoids
		if(BIO_FLESH_BONE)
			// if we've already mangled the skin (critical slash or piercing wound), then the bone is exposed, and we can damage it with sharp weapons at a reduced rate
			// So a big sharp weapon is still all you need to destroy a limb
			if(mangled_state == BODYPART_MANGLED_FLESH && sharpness)
				if(wounding_type == WOUND_SLASH && !easy_dismember)
					phantom_wounding_dmg *= 0.6 // edged weapons pass along 60% of their wounding damage to the bone since the power is spread out over a larger area
				if(wounding_type == WOUND_PIERCE && !easy_dismember)
					phantom_wounding_dmg *= 0.8 // piercing weapons pass along 75% of their wounding damage to the bone since it's more concentrated
				wounding_type = WOUND_BLUNT

	check_wounding(wounding_type, phantom_wounding_dmg, wound_bonus, bare_wound_bonus)
	// Handle dismemberment if appropriate, everything is done
	switch(bio_state)
		if(BIO_JUST_FLESH)
			if(mangled_state == BODYPART_MANGLED_FLESH)
				damage_integrity(initial_wounding_type, phantom_wounding_dmg, wound_bonus, bare_wound_bonus)
		if(BIO_JUST_BONE)
			if(mangled_state == BODYPART_MANGLED_BONE)
				damage_integrity(initial_wounding_type, phantom_wounding_dmg, wound_bonus, bare_wound_bonus)
		if(BIO_FLESH_BONE)
			if(mangled_state == BODYPART_MANGLED_BOTH)
				damage_integrity(initial_wounding_type, phantom_wounding_dmg, wound_bonus, bare_wound_bonus)

/obj/item/bodypart/proc/get_wound_weakness(wounding_type = WOUND_BLUNT)
	. = -wound_resistance
	var/mangled_state = get_mangled_state()
	var/static/list/mangled_flesh_states = list(BODYPART_MANGLED_FLESH, BODYPART_MANGLED_BOTH)
	if((mangled_state in mangled_flesh_states) && \
		(wounding_type in BODYPART_MANGLED_FLESH_AFFECTED_WOUNDS))
		. += BODYPART_MANGLED_FLESH_MODIFIER
	if(is_flesh_pulped())
		. += BODYPART_PULPED_FLESH_MODIFIER

/**
 * check_wounding() is where we handle rolling for, selecting, and applying a wound if we meet the criteria
 *
 * We generate a "score" for how woundable the attack was based on the damage and other factors discussed in [/obj/item/bodypart/proc/check_woundings_mods], then go down the list from most severe to least severe wounds in that category.
 * We can promote a wound from a lesser to a higher severity this way, but we give up if we have a wound of the given type and fail to roll a higher severity, so no sidegrades/downgrades
 *
 * Arguments:
 * * woundtype- Either WOUND_BLUNT, WOUND_SLASH, WOUND_PIERCE, or WOUND_BURN based on the attack type.
 * * damage- How much damage is tied to this attack, since wounding potential scales with damage in an attack (see: WOUND_DAMAGE_EXPONENT)
 * * wound_bonus- The wound_bonus of an attack
 * * bare_wound_bonus- The bare_wound_bonus of an attack
 */
/obj/item/bodypart/proc/check_wounding(woundtype, damage, wound_bonus, bare_wound_bonus)
	if(!owner)
		return

	if(HAS_TRAIT(owner, TRAIT_NEVER_WOUNDED) || HAS_TRAIT(src, TRAIT_NEVER_WOUNDED))
		return

	// note that these are fed into an exponent, so these are magnified
	if(HAS_TRAIT(owner, TRAIT_EASILY_WOUNDED) || HAS_TRAIT(src, TRAIT_EASILY_WOUNDED))
		damage *= 1.2

	if(HAS_TRAIT(owner, TRAIT_HARDLY_WOUNDED) || HAS_TRAIT(src, TRAIT_HARDLY_WOUNDED))
		damage *= 0.8


	damage = min(damage, WOUND_MAX_CONSIDERED_DAMAGE)

	var/list/wounds_checking = LAZYACCESS(GLOB.global_wound_types, woundtype)
	var/endurance_modifier = 1
	if(owner)
		var/endurance = max(1, GET_MOB_ATTRIBUTE_VALUE(owner, STAT_ENDURANCE))
		if(endurance >= ATTRIBUTE_MIDDLING)
			endurance_modifier = ATTRIBUTE_MIDDLING/endurance
		else
			endurance_modifier = endurance/ATTRIBUTE_MIDDLING
	var/final_damage = damage * endurance_modifier
	var/base_roll = rand(1, final_damage ** WOUND_DAMAGE_EXPONENT)
	var/wound_roll = base_roll
	wound_roll += check_woundings_mods(woundtype, damage, wound_bonus, bare_wound_bonus)
	wound_roll = round_to_nearest(wound_roll, 1)

	var/static/list/dismemberment_wound_types = list(
		WOUND_BLUNT,
		WOUND_SLASH,
		WOUND_PIERCE,
		WOUND_BURN,
	)
	if((wound_roll >= WOUND_DISMEMBER_OUTRIGHT_THRESH) && (woundtype in dismemberment_wound_types))
		apply_dismember(woundtype, TRUE, TRUE)
		return

	//cycle through the wounds of the relevant category from the most severe down
	var/datum/wound/new_wound
	for(var/datum/wound/possible_wound as anything in wounds_checking)
		var/datum/wound/replaced_wound
		for(var/datum/wound/existing_wound as anything in wounds)
			if(existing_wound.type in wounds_checking)
				if(existing_wound.severity >= initial(possible_wound.severity))
					return
				else
					replaced_wound = existing_wound

		if(initial(possible_wound.threshold_minimum) < wound_roll)
			if(replaced_wound)
				new_wound = replaced_wound.replace_wound(possible_wound)
			else
				new_wound = new possible_wound()
				new_wound.apply_wound(src, TRUE, add_descriptive = TRUE)
			// dismembering wounds are logged in the apply_wound() for loss wounds since they delete themselves immediately, these will be immediately returned
			log_wound(owner, new_wound, damage, wound_bonus, bare_wound_bonus, base_roll)
			return new_wound

// try forcing a specific wound, but only if there isn't already a wound of that severity or greater for that type on this bodypart
/obj/item/bodypart/proc/force_wound_upwards(specific_woundtype, smited = FALSE)
	var/datum/wound/potential_wound = specific_woundtype
	for(var/datum/wound/existing_wound as anything in wounds)
		if(existing_wound.wound_type == initial(potential_wound.wound_type))
			if(existing_wound.severity < initial(potential_wound.severity)) // we only try if the existing one is inferior to the one we're trying to force
				existing_wound.replace_wound(potential_wound, smited)
			return

	var/datum/wound/new_wound = new potential_wound
	new_wound.apply_wound(src, smited = smited)

/**
 * check_woundings_mods() is where we handle the various modifiers of a wound roll
 *
 * A short list of things we consider: any armor a human target may be wearing, and if they have no wound armor on the limb, if we have a bare_wound_bonus to apply, plus the plain wound_bonus
 * We also flick through all of the wounds we currently have on this limb and add their threshold penalties, so that having lots of bad wounds makes you more liable to get hurt worse
 * Lastly, we add the inherent wound_resistance variable the bodypart has (heads and chests are slightly harder to wound), and a small bonus if the limb is already disabled
 *
 * Arguments:
 * * It's the same ones on [/obj/item/bodypart/proc/receive_damage]
 */
/obj/item/bodypart/proc/check_woundings_mods(wounding_type, damage, wound_bonus, bare_wound_bonus)
	var/armor_ablation = 0
	var/injury_mod = 0

	if(owner && ishuman(owner))
		var/mob/living/carbon/human/humie_owner = owner
		var/list/clothing = humie_owner.clothingonpart(src)
		for(var/obj/item/clothes as anything in clothing)
			// unlike normal armor checks, we tabluate these piece-by-piece manually so we can also pass on appropriate damage the clothing's limbs if necessary
			armor_ablation += clothes.armor.getRating(WOUND)
			armor_ablation += clothes.subarmor.getRating(WOUND)
		if(!armor_ablation)
			injury_mod += bare_wound_bonus

	injury_mod -= armor_ablation
	injury_mod += wound_bonus

	for(var/datum/wound/wound as anything in wounds)
		injury_mod += wound.threshold_penalty

	for(var/datum/injury/injury as anything in injuries)
		injury_mod += injury.threshold_penalty

	injury_mod += get_wound_weakness(wounding_type)
	for(var/obj/item/organ/organ as anything in get_organs())
		injury_mod += organ.get_wound_weakness(wounding_type)
	if(get_damage(FALSE, FALSE) >= max_damage)
		injury_mod += maxdam_wound_penalty

	return injury_mod

//Heals brute and burn damage for the organ. Returns 1 if the damage-icon states changed at all.
//Damage cannot go below zero.
//Cannot remove negative damage (i.e. apply damage)
/obj/item/bodypart/proc/heal_damage(brute, burn, stamina, required_status, updating_health = TRUE)
	if(required_status && status != required_status) //So we can only heal certain kinds of limbs, ie robotic vs organic.
		return

	limb_integrity = clamp(limb_integrity + ((brute + burn) * incoming_integrity_mult), 0, max_limb_integrity)
	for(var/thing in injuries)
		if((brute <= 0) && (burn <= 0))
			break
		var/datum/injury/injury = thing
		if(injury.damage_type in list(WOUND_SLASH, WOUND_PIERCE, WOUND_BLUNT))
			brute = injury.heal_damage(brute)
		else
			burn = injury.heal_damage(burn)

	if(stamina)
		set_stamina_dam(round(max(stamina_dam - stamina, 0), DAMAGE_PRECISION))

	update_damages()
	if(owner)
		update_limb_efficiency()
		if(updating_health)
			owner.updatehealth()
			if(stamina_dam >= DAMAGE_PRECISION)
				owner.update_stamina()
				. = TRUE
			if(get_shock(FALSE, TRUE) >= DAMAGE_PRECISION)
				owner.update_shock()
				. = TRUE
		consider_processing()
	return update_bodypart_damage_state()

/// Temporarily cripples the bodypart for a certain duration
/obj/item/bodypart/proc/update_cripple(duration = 4 SECONDS)
	if(!duration)
		return
	if(cripple_timer)
		deltimer(cripple_timer)
		cripple_timer = null
	ADD_TRAIT(src, TRAIT_PARALYSIS, BODYPART_TRAIT)
	cripple_timer = addtimer(CALLBACK(src, .proc/remove_cripple), duration, TIMER_STOPPABLE)

/obj/item/bodypart/proc/remove_cripple()
	REMOVE_TRAIT(src, TRAIT_PARALYSIS, BODYPART_TRAIT)
	cripple_timer = null

// UNSAFE PROC! DO NOT USE.
///Proc to hook behavior associated to the change of the brute_dam variable's value.
/obj/item/bodypart/proc/set_brute_dam(new_value)
	if(brute_dam == new_value)
		return
	. = brute_dam
	brute_dam = new_value

// UNSAFE PROC! DO NOT USE.
///Proc to hook behavior associated to the change of the burn_dam variable's value.
/obj/item/bodypart/proc/set_burn_dam(new_value)
	if(burn_dam == new_value)
		return
	. = burn_dam
	burn_dam = new_value

///Proc to hook behavior associated to the change of the stamina_dam variable's value.
/obj/item/bodypart/proc/set_stamina_dam(new_value)
	if(stamina_dam == new_value)
		return
	. = stamina_dam
	stamina_dam = new_value

//Returns total damage.
/obj/item/bodypart/proc/get_damage(include_stamina = FALSE, include_shock = FALSE)
	var/total = brute_dam + burn_dam
	if(include_stamina)
		total = max(total, stamina_dam)
	if(include_shock)
		total = max(total, get_shock(FALSE, TRUE))
	return total

//Updates limb efficiency based on tendons, nerves and arteries
/obj/item/bodypart/proc/update_limb_efficiency()
	var/divisor = 0
	limb_efficiency = 0
	if(CHECK_BITFIELD(limb_flags, BODYPART_HAS_TENDON))
		divisor += 1
		limb_efficiency += getorganslotefficiency(ORGAN_SLOT_TENDON)
	if(CHECK_BITFIELD(limb_flags, BODYPART_HAS_NERVE))
		divisor += 1
		limb_efficiency += getorganslotefficiency(ORGAN_SLOT_NERVE)
	if(divisor)
		limb_efficiency /= divisor
	// no tendon, nerve nor artery!
	else
		limb_efficiency = 100
	// wounds decrease limb efficiency
	for(var/datum/wound/hurty as anything in wounds)
		limb_efficiency -= hurty.limb_efficiency_reduction
	// rotten limbs most of the time are useless
	if(CHECK_BITFIELD(limb_flags, BODYPART_DEAD))
		limb_efficiency -= LIMB_EFFICIENCY_OPTIMAL
	// if we have teeth, amount of teeth impacts efficiency
	if(max_teeth)
		limb_efficiency -= ((LIMB_EFFICIENCY_OPTIMAL/2) * (1 - get_teeth_amount()/max_teeth))
	// if we have digits, amount of digits impacts efficiency
	var/max_digits = get_max_digits()
	if(max_digits)
		limb_efficiency -= (LIMB_EFFICIENCY_OPTIMAL * (1 - get_digits_amount()/max_digits))
	// splint checks
	var/splint_factor = 0
	if(current_splint)
		splint_factor = (1 - current_splint.splint_factor)
	var/broken_factor = 0
	if(CHECK_BITFIELD(limb_flags, BODYPART_HAS_BONE))
		for(var/obj/item/organ/bone/bone as anything in getorganslotlist(ORGAN_SLOT_BONE))
			broken_factor = max(broken_factor, bone.damage/bone.maxHealth)
	// passing any of these checks means we are absolutely worthless
	if(!functional || is_cut_away() || bone_missing() || tendon_missing() || nerve_missing() || artery_missing())
		limb_efficiency = 0
	else if((broken_factor > 0.75) || (broken_factor - splint_factor > 0))
		limb_efficiency = 0
	limb_efficiency = max(0, CEILING(limb_efficiency, 1))
	if(owner)
		if(can_be_disabled)
			update_disabled()
		if(owner.get_active_hand() == src)
			owner.update_handedness(held_index)
			owner.add_or_update_variable_actionspeed_modifier(/datum/actionspeed_modifier/limb_efficiency, TRUE, multiplicative_slowdown = (1 - (limb_efficiency/LIMB_EFFICIENCY_OPTIMAL)) * LIMB_EFFICIENCY_ACTIONSPEED_MULTIPLIER)
		if(stance_index)
			owner.update_basic_speed_modifier()

//Checks disabled status thresholds
/obj/item/bodypart/proc/update_disabled()
	if(!owner)
		return

	if(!can_be_disabled)
		set_disabled(FALSE)
		CRASH("update_disabled called with can_be_disabled false")

	if(HAS_TRAIT(src, TRAIT_PARALYSIS) || (limb_efficiency < LIMB_EFFICIENCY_DISABLING))
		set_disabled(TRUE)
		return

	if(parent_body_zone && !(parent_body_zone in list(BODY_ZONE_HEAD, BODY_ZONE_PRECISE_NECK, BODY_ZONE_CHEST, BODY_ZONE_PRECISE_VITALS)))
		var/obj/item/bodypart/parent
		parent = owner?.get_bodypart(parent_body_zone)
		if(parent?.bodypart_disabled)
			set_disabled(TRUE)
			return

	var/total_damage = max(brute_dam + burn_dam, stamina_dam)

	// check if pain is disabling the limb
	if(pain_disability_threshold && (get_shock(TRUE, TRUE) >= pain_disability_threshold))
		if(!last_maxed && (owner.stat < UNCONSCIOUS))
			INVOKE_ASYNC(owner, /mob/living.proc/agony_scream)
		last_maxed = TRUE
		set_disabled(TRUE)
		return

	// this block of checks is for limbs that can be disabled, but not through pure damage
	if(!disable_threshold)
		last_maxed = FALSE
		set_disabled(FALSE)
		return

	// we're now dealing with limbs that can be disabled through pure damage
	if(total_damage >= (max_damage * disable_threshold))
		last_maxed = TRUE
		set_disabled(TRUE)
		return

	// reenable the limb when appropriate
	if(bodypart_disabled && (total_damage <= max_damage * min(disable_threshold, 0.5)))
		last_maxed = FALSE
		set_disabled(FALSE)
		return

///Proc to change the value of the `disabled` variable and react to the event of its change.
/obj/item/bodypart/proc/set_disabled(new_disabled)
	if(bodypart_disabled == new_disabled)
		return
	. = bodypart_disabled
	bodypart_disabled = new_disabled
	if(!owner)
		return
	for(var/bp in children_zones)
		var/obj/item/bodypart/child = owner.get_bodypart(bp)
		if(!child)
			continue
		if(child.can_be_disabled)
			child.update_disabled()
	/// Handle grasp
	if(held_index)
		if(!. && bodypart_disabled)
			owner.set_usable_hands(owner.usable_hands - 1)
			if(held_index)
				owner.dropItemToGround(owner.get_item_for_held_index(held_index))
		else if(. && !bodypart_disabled)
			owner.set_usable_hands(owner.usable_hands + 1)
		if(owner.hud_used)
			var/atom/movable/screen/inventory/hand/hand_screen_object = owner.hud_used.hand_slots["[held_index]"]
			hand_screen_object?.update_appearance()
	/// Handle stance
	if(stance_index)
		if(!. && bodypart_disabled)
			owner.set_usable_legs(owner.usable_legs - 1)
		else if(. && !bodypart_disabled)
			owner.set_usable_legs(owner.usable_legs + 1)

	owner.update_health_hud() //update the healthdoll
	owner.update_body()

///Proc to change the value of the `owner` variable and react to the event of its change.
/obj/item/bodypart/proc/set_owner(new_owner, no_update = FALSE)
	if(owner == new_owner)
		return FALSE //`null` is a valid option, so we need to use a num var to make it clear no change was made.
	. = owner
	owner = new_owner
	var/needs_update_disabled = FALSE //Only really relevant if there's an owner
	if(.)
		var/mob/living/carbon/old_owner = .
		if(initial(can_be_disabled))
			if(HAS_TRAIT(old_owner, TRAIT_NOLIMBDISABLE))
				if(!owner || !HAS_TRAIT(owner, TRAIT_NOLIMBDISABLE))
					set_can_be_disabled(initial(can_be_disabled))
					needs_update_disabled = TRUE
			UnregisterSignal(old_owner, list(
				SIGNAL_REMOVETRAIT(TRAIT_NOLIMBDISABLE),
				SIGNAL_ADDTRAIT(TRAIT_NOLIMBDISABLE),
				))
	if(owner)
		if(initial(can_be_disabled))
			if(HAS_TRAIT(owner, TRAIT_NOLIMBDISABLE))
				set_can_be_disabled(FALSE)
				needs_update_disabled = FALSE
			RegisterSignal(owner, SIGNAL_REMOVETRAIT(TRAIT_NOLIMBDISABLE), .proc/on_owner_nolimbdisable_trait_loss)
			RegisterSignal(owner, SIGNAL_ADDTRAIT(TRAIT_NOLIMBDISABLE), .proc/on_owner_nolimbdisable_trait_gain)
		if(needs_update_disabled && !no_update)
			update_disabled()

///Proc to change the value of the `can_be_disabled` variable and react to the event of its change.
/obj/item/bodypart/proc/set_can_be_disabled(new_can_be_disabled)
	if(can_be_disabled == new_can_be_disabled)
		return
	. = can_be_disabled
	can_be_disabled = new_can_be_disabled
	if(can_be_disabled)
		if(owner)
			if(HAS_TRAIT(owner, TRAIT_NOLIMBDISABLE))
				CRASH("set_can_be_disabled to TRUE with for limb whose owner has TRAIT_NOLIMBDISABLE")
			RegisterSignal(owner, SIGNAL_ADDTRAIT(TRAIT_PARALYSIS), .proc/on_paralysis_trait_gain)
			RegisterSignal(owner, SIGNAL_REMOVETRAIT(TRAIT_PARALYSIS), .proc/on_paralysis_trait_loss)
		update_disabled()
	else if(.)
		if(owner)
			UnregisterSignal(owner, list(
				SIGNAL_ADDTRAIT(TRAIT_PARALYSIS),
				SIGNAL_REMOVETRAIT(TRAIT_PARALYSIS),
				))
		set_disabled(FALSE)

///Called when TRAIT_PARALYSIS is added to the limb.
/obj/item/bodypart/proc/on_paralysis_trait_gain(obj/item/bodypart/source)
	SIGNAL_HANDLER

	update_limb(!owner, owner)
	update_limb_efficiency()

///Called when TRAIT_PARALYSIS is removed from the limb.
/obj/item/bodypart/proc/on_paralysis_trait_loss(obj/item/bodypart/source)
	SIGNAL_HANDLER

	update_limb(!owner, owner)
	update_limb_efficiency()

///Called when TRAIT_ROTTEN is added to the limb.
/obj/item/bodypart/proc/on_rotten_trait_gain(obj/item/bodypart/source)
	SIGNAL_HANDLER

	germ_level = INFECTION_LEVEL_THREE
	limb_flags |= BODYPART_DEAD
	update_limb(!owner, owner)
	update_limb_efficiency()

///Called when TRAIT_ROTTEN is removed from the limb.
/obj/item/bodypart/proc/on_rotten_trait_loss(obj/item/bodypart/source)
	SIGNAL_HANDLER

	limb_flags &= ~BODYPART_DEAD
	update_limb(!owner, owner)
	update_limb_efficiency()

///Called when TRAIT_NOLIMBDISABLE is added to the owner.
/obj/item/bodypart/proc/on_owner_nolimbdisable_trait_gain(mob/living/carbon/source)
	SIGNAL_HANDLER

	set_can_be_disabled(FALSE)

///Called when TRAIT_NOLIMBDISABLE is removed from the owner.
/obj/item/bodypart/proc/on_owner_nolimbdisable_trait_loss(mob/living/carbon/source)
	SIGNAL_HANDLER

	set_can_be_disabled(initial(can_be_disabled))

//Change bodypart status
/obj/item/bodypart/proc/change_bodypart_status(new_limb_status = BODYPART_ORGANIC, heal_limb = FALSE, change_icon_to_default = FALSE)
	status = new_limb_status
	if(heal_limb)
		heal_damage(brute_dam, burn_dam, stamina_dam, updating_health = FALSE)
		brutestate = 0
		burnstate = 0

	if(change_icon_to_default)
		if(status == BODYPART_ORGANIC)
			render_icon = DEFAULT_BODYPART_ICON_ORGANIC
		else if(status == BODYPART_ROBOTIC)
			render_icon = DEFAULT_BODYPART_ICON_ROBOTIC

	if(owner && !(owner.status_flags & BUILDING_ORGANS))
		owner.updatehealth()
		owner.update_body() //if our head becomes robotic, we remove the lizard horns and human hair.
		owner.update_hair()
		owner.update_damage_overlays()

/// Get whatever wound of the given type is currently attached to this limb, if any
/obj/item/bodypart/proc/get_wound_type(checking_type)
	if(!wounds)
		return

	for(var/wound in wounds)
		if(istype(wound, checking_type))
			return wound

/**
 * update_wounds() is called whenever a wound is gained or lost on this bodypart, as well as if there's a change of some kind on a bone wound possibly changing disabled status
 *
 * Covers tabulating the damage multipliers we have from wounds (burn specifically), as well as deleting our gauze wrapping if we don't have any wounds that can use bandaging
 *
 * Arguments:
 * * replaced- If true, this is being called from the remove_wound() of a wound that's being replaced, so the bandage that already existed is still relevant, but the new wound hasn't been added yet
 */
/obj/item/bodypart/proc/update_wounds(replaced = FALSE)
	var/dam_mul = initial(damage_multiplier)

	// we can (normally) only have one wound per type, but remember there's multiple types (smites like :B:loodless can generate multiple cuts on a limb)
	for(var/datum/wound/iter_wound as anything in wounds)
		dam_mul *= iter_wound.damage_multiplier_penalty

	damage_multiplier = dam_mul

/obj/item/bodypart/proc/get_bleed_rate(ignore_gauze = FALSE)
	if(owner && HAS_TRAIT(owner, TRAIT_NOBLEED))
		return

	var/bleed_rate = 0
	if(generic_bleedstacks > 0)
		bleed_rate += 1

	for(var/datum/wound/wound as anything in wounds)
		if(wound.wound_type != WOUND_ARTERY)
			bleed_rate += wound.blood_flow

	for(var/datum/injury/injury as anything in injuries)
		if(injury.is_bleeding())
			bleed_rate += injury.get_bleed_rate()

	if(owner.body_position == LYING_DOWN)
		bleed_rate *= 0.8

	if(LAZYLEN(grasped_by)) //lazylist
		bleed_rate *= 0.5

	if(!ignore_gauze && current_gauze)
		bleed_rate = 0

	return bleed_rate

/**
 * apply_gauze() is used to- well, apply gauze to a bodypart
 *
 * As of the Wounds 2 PR, all bleeding is now bodypart based rather than the old bleedstacks system, and 90% of standard bleeding comes from flesh wounds (the exception is embedded weapons).
 * The same way bleeding is totaled up by bodyparts, gauze now applies to all wounds on the same part. Thus, having a slash wound, a pierce wound, and a broken bone wound would have the gauze
 * applying blood staunching to the first two wounds, while also acting as a sling for the third one. Once enough blood has been absorbed or all wounds with the ACCEPTS_GAUZE flag have been cleared,
 * the gauze falls off.
 *
 * Arguments:
 * * gauze- Just the gauze stack we're taking a sheet from to apply here
 */
/obj/item/bodypart/proc/apply_gauze(obj/item/stack/gauze)
	if(!istype(gauze) || (gauze.absorption_capacity <= 0))
		return
	var/newly_gauzed = FALSE
	if(!current_gauze)
		newly_gauzed = TRUE
	QDEL_NULL(current_gauze)
	current_gauze = new gauze.type(src, 1)
	gauze.use(1)

	SEND_SIGNAL(src, COMSIG_BODYPART_GAUZED, gauze, newly_gauzed)
	if(owner)
		owner.update_medicine_overlays()
	else
		update_icon_dropped()

/**
 * seep_gauze() is for when a gauze wrapping absorbs blood or pus from wounds, lowering its absorption capacity.
 *
 * The passed amount of seepage is deducted from the bandage's absorption capacity, and if we reach a negative absorption capacity, the bandages falls off and we're left with nothing.
 *
 * Arguments:
 * * seep_amt - How much absorption capacity we're removing from our current bandages (think, how much blood or pus are we soaking up this tick?)
 */
/obj/item/bodypart/proc/seep_gauze(seep_amt = 0)
	if(!current_gauze)
		return

	current_gauze.absorption_capacity -= seep_amt
	if(current_gauze.absorption_capacity <= 0)
		owner.visible_message(span_danger("<b>[owner]</b>'s [current_gauze] on [owner.p_their()] [name] falls away in rags."), \
						span_userdanger("<i>[current_gauze] on my [name] falls away in rags.</i>"), \
						vision_distance=COMBAT_MESSAGE_RANGE,\
						)
		remove_gauze(FALSE)

/**
 * Removes the current_gauze from the limb safely
 *
 * Arguments:
 * * drop_gauze - If false, the gauze is destroyed. If true, it is dropped on the appropriate turf.
 */
/obj/item/bodypart/proc/remove_gauze(drop_gauze = FALSE)
	if(!current_gauze)
		return

	if(!drop_gauze)
		QDEL_NULL(current_gauze)
	else
		var/turf/drop
		if(owner)
			drop = get_turf(owner)
		else
			drop = get_turf(src)

		if(istype(drop))
			current_gauze.forceMove(drop)
		else
			qdel(current_gauze)
		current_gauze = null

	SEND_SIGNAL(src, COMSIG_BODYPART_GAUZE_DESTROYED, drop_gauze)
	update_limb_efficiency()
	if(owner)
		owner.update_medicine_overlays()
	else
		update_icon_dropped()

/**
 * This below is bad copypasta of the previous code but for splinting limbs.
 */
/obj/item/bodypart/proc/apply_splint(obj/item/stack/splint)
	if(!istype(splint))
		return
	var/newly_splinted = FALSE
	if(!current_splint)
		newly_splinted = TRUE
	QDEL_NULL(current_splint)
	splint.use(1)
	current_splint = new splint.type(src, 1)

	SEND_SIGNAL(src, COMSIG_BODYPART_SPLINTED, splint, newly_splinted)
	update_limb_efficiency()
	if(owner)
		owner.update_medicine_overlays()
	else
		update_icon_dropped()

/obj/item/bodypart/proc/seep_splint(seep_amt = 0)
	if(!current_splint)
		return

	current_splint.absorption_capacity -= seep_amt
	if(current_splint.absorption_capacity <= 0)
		owner.visible_message(span_danger("<b>[owner]</b>'s [current_splint] on [name] falls away in rags."), \
						span_warning("\The [current_splint] on my [name] falls away in rags."), \
						vision_distance=COMBAT_MESSAGE_RANGE,\
						)
		remove_gauze(FALSE)

/obj/item/bodypart/proc/remove_splint(drop_splint = FALSE)
	if(!current_splint)
		return

	if(!drop_splint)
		QDEL_NULL(current_splint)
	else
		var/turf/drop
		if(owner)
			drop = get_turf(owner)
		else
			drop = get_turf(src)

		if(istype(drop))
			current_gauze.forceMove(drop)
		else
			qdel(current_splint)
		current_splint = null

	SEND_SIGNAL(src, COMSIG_BODYPART_SPLINT_DESTROYED, drop_splint)
	update_limb_efficiency()
	if(!owner)
		owner.update_medicine_overlays()
	else
		update_icon_dropped()

/// Proc to turn bodypart into another.
/obj/item/bodypart/proc/change_bodypart(obj/item/bodypart/new_type)
	if(!owner)
		return
	var/mob/living/carbon/our_owner = owner //dropping nulls the limb
	for(var/obj/item/organ/organ as anything in get_organs())
		if(istype(organ, /obj/item/organ/tendon) || istype(organ, /obj/item/organ/artery) || istype(organ, /obj/item/organ/nerve) || istype(organ, /obj/item/organ/bone))
			organ.Remove(our_owner, special = TRUE)
			qdel(organ)
			continue
	drop_limb(special = TRUE, dismembered = FALSE, ignore_child_limbs = TRUE)
	var/obj/item/bodypart/new_part = new_type
	if(!istype(new_part))
		new_part = new new_type()
	new_part.attach_limb(our_owner, special = TRUE, ignore_parent_limb = TRUE)
	qdel(src)

/// Proc to get the first available incision
/obj/item/bodypart/proc/get_incision(strict = FALSE, ignore_gauze = FALSE)
	if(ignore_gauze && (current_gauze || current_splint))
		return
	var/datum/injury/incision
	for(var/datum/injury/slash/slash in injuries)
		if(slash.is_bandaged() || slash.current_stage > slash.max_bleeding_stage) // Shit's unusable
			continue
		if(strict && !slash.is_surgical()) //We don't need dirty ones
			continue
		if(!incision)
			incision = slash
			continue
		if(slash.is_surgical() && incision.is_surgical()) //If they're both dirty or both are surgical, just get bigger one
			if(slash.damage > incision.damage)
				incision = slash
		else if(slash.is_surgical()) //otherwise surgical one takes priority
			incision = slash
	return incision

/// Proc to open incision and expose implants - this is the retract step of surgery
/obj/item/bodypart/proc/open_incision(mob/user)
	var/datum/injury/injury = get_incision(ignore_gauze = TRUE)
	if(!injury)
		return
	injury.open_injury(min(injury.damage, injury.damage_list[1] - injury.damage), TRUE)
	for(var/obj/item/organ/organ as anything in get_organs())
		organ.on_find(user)

/// Proc for bitflags on "how open" a bodypart is
/obj/item/bodypart/proc/how_open()
	. = 0
	var/datum/injury/incision = get_incision()
	if(incision)
		. |= SURGERY_INCISED
		if(CHECK_BITFIELD(incision.injury_flags, INJURY_RETRACTED))
			. |= SURGERY_RETRACTED
		if(CHECK_BITFIELD(incision.injury_flags, INJURY_DRILLED))
			. |= SURGERY_DRILLED
	if(is_fractured())
		. |= SURGERY_BROKEN
	else if(is_dislocated())
		. |= SURGERY_DISLOCATED

/obj/item/bodypart/proc/is_organic_limb()
	return (status == BODYPART_ORGANIC)

/obj/item/bodypart/proc/is_robotic_limb()
	return (status == BODYPART_ROBOTIC)

/obj/item/bodypart/proc/is_dead()
	return (limb_flags & BODYPART_DEAD)

/obj/item/bodypart/proc/is_cut_away()
	return (limb_flags & BODYPART_CUT_AWAY)

/obj/item/bodypart/proc/is_deformed()
	return (limb_flags & BODYPART_DEFORMED)

/obj/item/bodypart/proc/bone_needed()
	return (limb_flags & BODYPART_HAS_BONE)

/obj/item/bodypart/proc/no_bone()
	return (!getorganslot(ORGAN_SLOT_BONE))

/obj/item/bodypart/proc/bone_missing()
	return (bone_needed() && no_bone())

/obj/item/bodypart/proc/is_encased()
	. = FALSE
	for(var/thing in getorganslotlist(ORGAN_SLOT_BONE))
		var/obj/item/organ/bone/bone = thing
		if(bone.bone_flags & BONE_ENCASING)
			return TRUE

/obj/item/bodypart/proc/is_jointed()
	. = FALSE
	for(var/thing in getorganslotlist(ORGAN_SLOT_BONE))
		var/obj/item/organ/bone/bone = thing
		if(bone.bone_flags & BONE_JOINTED)
			return TRUE

/obj/item/bodypart/proc/is_bone_damaged()
	. = FALSE
	for(var/thing in getorganslotlist(ORGAN_SLOT_BONE))
		var/obj/item/organ/bone/bone = thing
		if(bone.damage >= bone.low_threshold)
			return TRUE

/obj/item/bodypart/proc/is_dislocated()
	. = FALSE
	for(var/thing in getorganslotlist(ORGAN_SLOT_BONE))
		var/obj/item/organ/bone/bone = thing
		if((bone.bone_flags & BONE_JOINTED) && (bone.damage >= bone.low_threshold) && (bone.damage < bone.medium_threshold))
			return TRUE

/obj/item/bodypart/proc/is_fractured()
	. = FALSE
	for(var/thing in getorganslotlist(ORGAN_SLOT_BONE))
		var/obj/item/organ/bone/bone = thing
		if(bone.damage >= bone.medium_threshold)
			return TRUE

/obj/item/bodypart/proc/is_hairline_fractured()
	. = FALSE
	for(var/thing in getorganslotlist(ORGAN_SLOT_BONE))
		var/obj/item/organ/bone/bone = thing
		if((bone.damage >= bone.medium_threshold) && (bone.damage < bone.high_threshold))
			return TRUE

/obj/item/bodypart/proc/is_compound_fractured()
	. = FALSE
	for(var/thing in getorganslotlist(ORGAN_SLOT_BONE))
		var/obj/item/organ/bone/bone = thing
		if(bone.damage >= bone.high_threshold)
			return TRUE

/obj/item/bodypart/proc/tendon_needed()
	return CHECK_BITFIELD(limb_flags, BODYPART_HAS_TENDON)

/obj/item/bodypart/proc/no_tendon()
	return (!getorganslot(ORGAN_SLOT_TENDON))

/obj/item/bodypart/proc/tendon_missing()
	return (tendon_needed() && no_tendon())

/obj/item/bodypart/proc/is_tendon_torn()
	. = FALSE
	for(var/obj/item/organ/tendon/tendon as anything in getorganslotlist(ORGAN_SLOT_TENDON))
		if(tendon.is_bruised())
			return TRUE

/obj/item/bodypart/proc/is_tendon_dissected()
	. = FALSE
	for(var/obj/item/organ/tendon/tendon as anything in getorganslotlist(ORGAN_SLOT_TENDON))
		if(tendon.is_broken())
			return TRUE

/obj/item/bodypart/proc/nerve_needed()
	return CHECK_BITFIELD(limb_flags, BODYPART_HAS_NERVE)

/obj/item/bodypart/proc/no_nerve()
	return (!getorganslot(ORGAN_SLOT_NERVE))

/obj/item/bodypart/proc/nerve_missing()
	return (nerve_needed() && no_nerve())

/obj/item/bodypart/proc/is_nerve_torn()
	. = FALSE
	for(var/obj/item/organ/nerve/nerve as anything in getorganslotlist(ORGAN_SLOT_NERVE))
		if(nerve.is_bruised())
			return TRUE

/obj/item/bodypart/proc/is_nerve_dissected()
	. = FALSE
	for(var/obj/item/organ/nerve/nerve as anything in getorganslotlist(ORGAN_SLOT_NERVE))
		if(nerve.is_broken())
			return TRUE

/obj/item/bodypart/proc/artery_needed()
	return CHECK_BITFIELD(limb_flags, BODYPART_HAS_ARTERY)

/obj/item/bodypart/proc/no_artery()
	return (!getorganslot(ORGAN_SLOT_ARTERY))

/obj/item/bodypart/proc/artery_missing()
	return (artery_needed() && no_artery())

/obj/item/bodypart/proc/is_artery_torn()
	. = FALSE
	for(var/obj/item/organ/artery/artery as anything in getorganslotlist(ORGAN_SLOT_ARTERY))
		if(artery.is_bruised())
			return TRUE

/obj/item/bodypart/proc/is_artery_dissected()
	. = FALSE
	for(var/obj/item/organ/artery/artery as anything in getorganslotlist(ORGAN_SLOT_ARTERY))
		if(artery.is_broken())
			return TRUE

/obj/item/bodypart/proc/is_bandaged()
	. = TRUE
	for(var/datum/injury/injury in injuries)
		if(!injury.is_bandaged())
			return FALSE

/obj/item/bodypart/proc/is_salved()
	. = TRUE
	for(var/datum/injury/injury in injuries)
		if(!injury.is_salved())
			return FALSE

/obj/item/bodypart/proc/is_disinfected()
	. = TRUE
	for(var/datum/injury/injury in injuries)
		if(!injury.is_disinfected())
			return FALSE

/obj/item/bodypart/proc/is_clamped()
	. = TRUE
	for(var/datum/injury/injury in injuries)
		if(!injury.is_clamped())
			return FALSE

/obj/item/bodypart/proc/is_stump()
	return FALSE

/obj/item/bodypart/proc/clamp_limb()
	for(var/datum/injury/injury as anything in injuries)
		injury.clamp_injury()

/obj/item/bodypart/proc/unclamp_limb()
	for(var/datum/injury/injury as anything in injuries)
		injury.unclamp_injury()

/obj/item/bodypart/proc/suture_limb()
	for(var/datum/injury/injury as anything in injuries)
		injury.suture_injury()

/obj/item/bodypart/proc/unsuture_limb()
	for(var/datum/injury/injury as anything in injuries)
		injury.unsuture_injury()

/obj/item/bodypart/proc/salve_limb()
	for(var/datum/injury/injury as anything in injuries)
		injury.salve_injury()

/obj/item/bodypart/proc/unsalve_limb()
	for(var/datum/injury/injury as anything in injuries)
		injury.unsalve_injury()

/obj/item/bodypart/proc/disinfect_limb()
	for(var/datum/injury/injury as anything in injuries)
		injury.disinfect_injury()

/obj/item/bodypart/proc/undisinfect_limb()
	for(var/datum/injury/injury as anything in injuries)
		injury.undisinfect_injury()

/obj/item/bodypart/proc/bandage_limb()
	for(var/datum/injury/injury as anything in injuries)
		injury.bandage_injury()

/obj/item/bodypart/proc/unbandage_limb()
	for(var/datum/injury/injury as anything in injuries)
		injury.unbandage_injury()

/obj/item/bodypart/proc/kill_limb()
	if(!can_decay())
		return
	var/already_rot = HAS_TRAIT_FROM(src, TRAIT_ROTTEN, GERM_LEVEL_TRAIT)
	if(!already_rot)
		ADD_TRAIT(src, TRAIT_ROTTEN, GERM_LEVEL_TRAIT)
	if(owner && !already_rot)
		owner.update_body()
	else
		update_icon_dropped()

/obj/item/bodypart/proc/revive_limb()
	if(!can_decay())
		return
	var/already_rot = HAS_TRAIT_FROM(src, TRAIT_ROTTEN, GERM_LEVEL_TRAIT)
	if(already_rot)
		REMOVE_TRAIT(src, TRAIT_ROTTEN, GERM_LEVEL_TRAIT)
	if(owner && already_rot)
		owner.update_body()
	else
		update_icon_dropped()

/obj/item/bodypart/proc/cut_away_limb()
	limb_flags |= BODYPART_CUT_AWAY
	update_limb_efficiency()

/obj/item/bodypart/proc/sew_limb()
	limb_flags &= ~BODYPART_CUT_AWAY
	update_limb_efficiency()
