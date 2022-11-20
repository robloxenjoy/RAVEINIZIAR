/obj/item/organ/stomach/ethereal
	name = "biological battery"
	icon_state = "stomach-p" //Welp. At least it's more unique in functionaliy.
	desc = "A crystal-like organ that stores the electric charge of ethereals."
	var/drain_time = 0
	var/crystal_charge = ETHEREAL_CHARGE_FULL

/obj/item/organ/stomach/ethereal/on_life(delta_time, times_fired)
	. = ..()
	adjust_charge(-ETHEREAL_CHARGE_FACTOR * delta_time)

/obj/item/organ/stomach/ethereal/Insert(mob/living/carbon/new_owner, special = FALSE, drop_if_replaced = TRUE, new_zone = null)
	. = ..()
	RegisterSignal(new_owner, COMSIG_PROCESS_BORGCHARGER_OCCUPANT, .proc/charge)
	RegisterSignal(new_owner, COMSIG_LIVING_ELECTROCUTE_ACT, .proc/on_electrocute)

/obj/item/organ/stomach/ethereal/Remove(mob/living/carbon/old_owner, special = FALSE)
	UnregisterSignal(old_owner, COMSIG_PROCESS_BORGCHARGER_OCCUPANT)
	UnregisterSignal(old_owner, COMSIG_LIVING_ELECTROCUTE_ACT)
	return ..()

/obj/item/organ/stomach/ethereal/proc/charge(datum/source, amount, repairs)
	adjust_charge(amount / 3.5)

/obj/item/organ/stomach/ethereal/proc/on_electrocute(datum/source, shock_damage, siemens_coeff = 1, flags = NONE)
	if(flags & SHOCK_ILLUSION)
		return
	adjust_charge(shock_damage * siemens_coeff * 2)
	to_chat(owner, span_notice("You absorb some of the shock into your body!"))

/obj/item/organ/stomach/ethereal/proc/adjust_charge(amount)
	crystal_charge = clamp(crystal_charge + amount, ETHEREAL_CHARGE_NONE, ETHEREAL_CHARGE_DANGEROUS)
