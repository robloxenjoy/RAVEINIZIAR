#define RADIATION_CLEAN_IMMUNITY_TIME (SSMACHINES_DT + (1 SECONDS))

/datum/component/irradiated
	dupe_mode = COMPONENT_DUPE_UNIQUE
	/// Only matters for humans, represents our stage of radiation sickness
	var/radiation_sickness = 0
	/// How irradiated we are
	var/rads = 100

/datum/component/irradiated/Initialize(rads, radiation_sickness)
	if(!CAN_IRRADIATE(parent))
		return COMPONENT_INCOMPATIBLE

	// This isn't incompatible, it's just wrong
	if(HAS_TRAIT(parent, TRAIT_RADIMMUNE))
		qdel(src)
		return

	if(rads)
		src.rads = rads
	if(radiation_sickness)
		src.radiation_sickness = radiation_sickness

	create_glow()

	beginning_of_irradiation = world.time

	START_PROCESSING(SSobj, src)
	if(!HAS_TRAIT(parent, TRAIT_IRRADIATED))
		first_radiation_dose(parent)

	ADD_TRAIT(parent, TRAIT_IRRADIATED, REF(src))
	ADD_TRAIT(parent, TRAIT_BYPASS_EARLY_IRRADIATED_CHECK, REF(src))

/datum/component/irradiated/InheritComponent(datum/component/irradiated/irradiated, i_am_original)
	. = ..()
	// try and remove previous radioactive element
	if(isitem(parent))
		remove_item_radioactive(parent)
	rads = clamp(CEILING(rads + irradiated.rads, 1), 0, RADIATION_MAXIMUM_RADS)
	radiation_sickness = clamp(CEILING(radiation_sickness + irradiated.radiation_sickness, 1), 0, RADIATION_SICKNESS_MAXIMUM)
	if(isitem(parent))
		make_item_radioactive(parent)

/datum/component/irradiated/Destroy(force, silent)
	if(ishuman(parent))
		REMOVE_TRAIT(parent, TRAIT_METALLIC_TASTES, RADIATION_TRAIT)
		REMOVE_TRAIT(parent, TRAIT_IMMUNITY_CRIPPLED, RADIATION_TRAIT)
	else if(isitem(parent))
		remove_item_radioactive(parent)
	REMOVE_TRAIT(parent, TRAIT_BYPASS_EARLY_IRRADIATED_CHECK, REF(src))
	return ..()

/datum/component/irradiated/RegisterWithParent()
	RegisterSignal(parent, COMSIG_COMPONENT_CLEAN_ACT, .proc/on_clean)
	RegisterSignal(parent, COMSIG_GEIGER_COUNTER_SCAN, .proc/on_geiger_counter_scan)
	if(isitem(parent))
		RegisterSignal(parent, COMSIG_RADIOACTIVE_PULSE_SENT, .proc/pulse_sent)

/datum/component/irradiated/process(delta_time)
	if(!CAN_IRRADIATE(parent))
		return PROCESS_KILL

	if(HAS_TRAIT(parent, TRAIT_RADIMMUNE))
		qdel(src)
		return PROCESS_KILL

	if((rads <= 0) && (radiation_sickness <= 0))
		qdel(src)
		return PROCESS_KILL

	var/mob/living/carbon/human/human_parent = parent
	if(istype(human_parent))
		if(should_halt_effects(parent))
			if((rads <= 0) && (radiation_sickness < RADIATION_SICKNESS_HEALING_CUTOFF))
				radiation_sickness -= (RADIATION_SICKNESS_PER_RAD * RADIATION_SICKNESS_NATURAL_HEALING)
			return
		human_parent.dna?.species?.handle_radiation(human_parent, delta_time, world.time - beginning_of_irradiation, rads, radiation_sickness)
		if(rads > 0)
			radiation_sickness = clamp(CEILING(radiation_sickness + (RADIATION_SICKNESS_PER_RAD * rads), 1), 0, RADIATION_SICKNESS_MAXIMUM)
		else if(radiation_sickness < RADIATION_SICKNESS_HEALING_CUTOFF)
			radiation_sickness = clamp(CEILING(radiation_sickness - (RADIATION_SICKNESS_PER_RAD * RADIATION_SICKNESS_NATURAL_HEALING), 1), 0, RADIATION_SICKNESS_MAXIMUM)

/datum/component/irradiated/create_glow()
	var/obj/item/parent_item = parent
	if(!istype(parent_item))
		return
	// Based on cherenkov glow
	parent_item.add_filter("rad_glow", 2, list("type" = "outline", "color" = "#14f7ff30", "size" = 2))
	// Things should look uneven
	addtimer(CALLBACK(src, .proc/start_glow_loop, parent_item), rand(0.1, 1.9) SECONDS)

/datum/component/irradiated/on_clean(datum/source, clean_types)
	if(!(clean_types & CLEAN_TYPE_RADIATION))
		return

	if(COOLDOWN_FINISHED(src, clean_cooldown))
		COOLDOWN_START(src, clean_cooldown, RADIATION_CLEAN_IMMUNITY_TIME)
		if(ishuman(parent))
			rads = clamp(CEILING(rads - RADIATION_CLEANING_POWER, 1), 0, RADIATION_MAXIMUM_RADS)
		else if(isitem(parent))
			remove_item_radioactive(source)
			rads = clamp(CEILING(rads - RADIATION_CLEANING_POWER, 1), 0, RADIATION_MAXIMUM_RADS)
			var/chance = clamp(CEILING((rads/100) * 10, 1), 0, 100)
			if(chance >= DEFAULT_RADIATION_CHANCE/2)
				make_item_radioactive(source)
			else if(chance <= 2)
				qdel(src)
				return COMPONENT_CLEANED

/datum/component/irradiated/should_halt_effects(mob/living/carbon/human/target)
	if(IS_IN_STASIS(target))
		return TRUE

	if(HAS_TRAIT(target, TRAIT_HALT_RADIATION_EFFECTS))
		return TRUE

	if(!COOLDOWN_FINISHED(src, clean_cooldown))
		return TRUE

	return FALSE

/datum/component/irradiated/proc/first_radiation_dose(atom/source)
	if(ishuman(source))
		var/mob/living/carbon/human/human_source = source
		//mmm... the sweet taste of blood
		var/datum/reagents/blood_holder = new(15)
		blood_holder.add_reagent(/datum/reagent/blood, blood_holder.maximum_volume)
		human_source.taste(blood_holder)
		qdel(blood_holder)
	else if(isitem(source))
		make_item_radioactive(source)

/datum/component/irradiated/proc/pulse_sent(obj/item/source)
	remove_item_radioactive(source)
	rads = clamp(CEILING(rads/2, 1), 0, RADIATION_MAXIMUM_RADS)
	var/chance = clamp(CEILING((rads/100) * 10, 1), 0, 100)
	if(chance >= DEFAULT_RADIATION_CHANCE/2)
		make_item_radioactive(source)
	else if(chance <= 2)
		qdel(src)

/datum/component/irradiated/proc/make_item_radioactive(obj/item/source)
	var/threshold = clamp(FLOOR(RAD_NO_INSULATION - (rads/200), 0.1), RAD_EXTREME_INSULATION, RAD_VERY_LIGHT_INSULATION)
	var/chance = clamp(CEILING((rads/100) * 10, 1), 0, 100)
	if(chance >= DEFAULT_RADIATION_CHANCE/2)
		source.AddElement(/datum/element/radioactive, 3 SECONDS, 3, threshold, chance, 3 SECONDS)

/datum/component/irradiated/proc/remove_item_radioactive(obj/item/source)
	var/threshold = clamp(FLOOR(RAD_NO_INSULATION - (rads/200), 0.1), RAD_EXTREME_INSULATION, RAD_VERY_LIGHT_INSULATION)
	var/chance = clamp(CEILING((rads/100) * 10, 1), 0, 100)
	if(chance >= DEFAULT_RADIATION_CHANCE/2)
		source.RemoveElement(/datum/element/radioactive, 3 SECONDS, 3, threshold, chance, 3 SECONDS)

#undef RADIATION_CLEAN_IMMUNITY_TIME
