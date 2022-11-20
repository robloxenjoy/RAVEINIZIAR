/mob/living/carbon/human/update_carry_weight()
	. = 0
	var/list/inventory_items = list(back, wear_mask, wear_neck, head, gloves, shoes, glasses, wrist_r, wrist_l, wear_suit, w_uniform, belt, wear_id, r_store, l_store, s_store)
	//we do need a typecheck here to avoid nulls
	for(var/obj/item/thing in inventory_items)
		. += thing.get_carry_weight()
	for(var/obj/item/thing in held_items)
		. += thing.get_carry_weight()
	var/datum/component/riding/creature/human/piggyback = GetComponent(/datum/component/riding/creature/human)
	if(piggyback)
		for(var/mob/living/carbon/human/friend in buckled_mobs)
			//For now, let's assume our friend weighs 60kg
			. += HUMAN_WEIGHT
	carry_weight = .
	update_encumbrance()
	if(buckled && ishuman(buckled))
		var/mob/living/carbon/human/buckle_human = buckled
		buckle_human.update_carry_weight()
