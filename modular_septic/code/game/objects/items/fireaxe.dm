/obj/item/fireaxe
	skill_melee = SKILL_POLEARM

/obj/item/fireaxe/Initialize()
	. = ..()
	AddElement(/datum/element/conditional_destructive, "fireaxe", TRUE, TRUE)
