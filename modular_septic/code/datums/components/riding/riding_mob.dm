/datum/component/riding/creature/human/Initialize(mob/living/riding_mob, force = FALSE, ride_check_flags = NONE, potion_boost = FALSE)
	. = ..()
	if(!.)
		var/mob/living/carbon/human/human_parent = parent
		human_parent?.update_carry_weight()

/datum/component/riding/creature/human/vehicle_mob_unbuckle(datum/source, mob/living/former_rider, force = FALSE)
	var/mob/living/carbon/human/former_parent = parent
	. = ..()
	former_parent.update_carry_weight()

/datum/component/riding/creature/human/on_host_unarmed_melee(mob/living/carbon/human/human_parent, atom/target, proximity, modifiers)
	if(IS_DISARM_INTENT(human_parent, modifiers) && (target in human_parent.buckled_mobs))
		force_dismount(target)
		return COMPONENT_CANCEL_ATTACK_CHAIN

/datum/component/riding/creature/human/check_carrier_fall_over(mob/living/carbon/human/human_parent)
	for(var/i in human_parent.buckled_mobs)
		var/mob/living/rider = i
		human_parent.unbuckle_mob(rider)
		rider.Paralyze(1 SECONDS)
		rider.Knockdown(4 SECONDS)
		human_parent.visible_message(span_danger("<b>[rider]</b> topples off of <b>[human_parent]</b> as they both fall to the ground!"), \
					span_warning("I fall to the ground, bringing [rider] with me!"), \
					span_hear("I hear two consecutive thuds."), \
					COMBAT_MESSAGE_RANGE, \
					ignored_mobs=rider)
		to_chat(rider, span_danger("<b>[human_parent]</b> falls to the ground, bringing me with [human_parent.p_them()]!"))

/datum/component/riding/creature/human/force_dismount(mob/living/dismounted_rider)
	var/mob/living/carbon/human/former_parent = parent
	former_parent.unbuckle_mob(dismounted_rider)
	dismounted_rider.Paralyze(1 SECONDS)
	dismounted_rider.Knockdown(4 SECONDS)
	dismounted_rider.visible_message(span_warning("<b>[former_parent]</b> pushes <b>[dismounted_rider]</b> off of [former_parent.p_them()]!"), \
						span_warning("<b>[former_parent]</b> pushes you off of [former_parent.p_them()]!"))
