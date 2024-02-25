// important note: Tendons in medical terminology connect muscles to bone - Here,
// any sort of muscle tissue could be made as a tendon
/obj/item/organ/tendon
	name = "tendon"
	desc = "Not the song made by experimental musician Igorrr."
	icon_state = "tendon"
	base_icon_state = "tendon"

	organ_flags = ORGAN_EDIBLE|ORGAN_LIMB_SUPPORTER|ORGAN_INDESTRUCTIBLE|ORGAN_NO_VIOLENT_DAMAGE
	organ_efficiency = list(ORGAN_SLOT_TENDON = 100)
	needs_processing = FALSE

	maxHealth = TENDON_MAX_HEALTH
	high_threshold = TENDON_MAX_HEALTH * 0.8
	low_threshold = TENDON_MAX_HEALTH * 0.2
	pain_multiplier = 0.15

	organ_volume = 0.5
	max_blood_storage = 1.5
	current_blood = 1.5
	blood_req = 0.25
	nutriment_req = 0.2
	hydration_req = 0.25

/obj/item/organ/tendon/can_heal(delta_time, times_fired)
	return FALSE

/obj/item/organ/tendon/tear()
	if(!owner)
		return
	applyOrganDamage(maxHealth * 0.5)

/obj/item/organ/tendon/dissect()
	if(!owner)
		return
	applyOrganDamage(maxHealth)

/obj/item/organ/tendon/mend()
	if(!owner)
		return
	setOrganDamage(0)
