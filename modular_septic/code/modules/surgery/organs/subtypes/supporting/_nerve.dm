/obj/item/organ/nerve
	name = "nerve"
	desc = "An unnerving sight."
	icon_state = "nerve"
	base_icon_state = "nerve"

	organ_flags = ORGAN_EDIBLE|ORGAN_LIMB_SUPPORTER|ORGAN_INDESTRUCTIBLE|ORGAN_NO_VIOLENT_DAMAGE
	organ_efficiency = list(ORGAN_SLOT_NERVE = 100)
	needs_processing = FALSE

	maxHealth = NERVE_MAX_HEALTH
	high_threshold = NERVE_MAX_HEALTH * 0.8
	low_threshold = NERVE_MAX_HEALTH * 0.2
	pain_multiplier = 0.5 // it's a fucking nerve, of course it hurts like hell

	organ_volume = 0.5
	max_blood_storage = 1
	current_blood = 1
	blood_req = 0.2
	oxygen_req = 0.1
	nutriment_req = 0.2
	hydration_req = 0.25

	healing_tools = null
	healing_items = list(/obj/item/stack/medical/nervemend)

/obj/item/organ/nerve/can_heal(delta_time, times_fired)
	return FALSE

/obj/item/organ/nerve/tear()
	if(!owner)
		return
	if(owner)
		if(owner.stat < UNCONSCIOUS)
			owner.death_scream()
	applyOrganDamage(maxHealth * 0.5)
	if(owner && (damage >= maxHealth))
		owner.client?.give_award(/datum/award/achievement/misc/nervous, owner)

/obj/item/organ/nerve/tear()
	if(!owner)
		return
	if(owner)
		if(owner.stat < UNCONSCIOUS)
			owner.death_scream()
	applyOrganDamage(maxHealth)
	if(owner && (damage >= maxHealth))
		owner.client?.give_award(/datum/award/achievement/misc/nervous, owner)

/obj/item/organ/nerve/mend()
	if(!owner)
		return
	setOrganDamage(0)
