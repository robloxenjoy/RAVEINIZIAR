/obj/effect/mob_spawn/human/denominator
	name = "denominator's spawner"
	desc = "A nice comfy bed."
	random = TRUE
	icon = 'icons/obj/lavaland/survival_pod.dmi'
	icon_state = "bed"
	mob_name = "an intruder, remember to work with your team-mates, they're your only friends, will you escape together"
	outfit = /datum/outfit/denominator
	roundstart = FALSE
	death = FALSE
	anchored = TRUE
	density = FALSE
	show_flavour = FALSE
	short_desc = "You are a Denominator."
	flavour_text = "Being one of the Denominators you are a cult sect based on transparacy with the goal to reveal all of the mysteries about this warehouse, and recover some profit in the process, your services aren't free, after all."
	spawner_job_path = /datum/job/denominator
	mob_species = /datum/species/denominator
	uses = 3
	var/shotgunner = FALSE
	var/spawn_oldpod = TRUE

/obj/effect/mob_spawn/human/denominator/Destroy()
	if(spawn_oldpod)
		new /obj/structure/bed/pod(drop_location())
	return ..()

/obj/effect/mob_spawn/human/denominator/equip(mob/living/carbon/human/H)
	if(prob(10))
		shotgunner = TRUE
		outfit = /datum/outfit/denominator/shotgunner
	. = ..()
	outfit = initial(outfit)

/obj/effect/mob_spawn/human/denominator/special(mob/living/carbon/human/new_spawn)
	. = ..()
	if(!shotgunner)
		new_spawn.mind.add_antag_datum(/datum/antagonist/denominator)
		new_spawn.attributes.add_sheet(/datum/attribute_holder/sheet/job/denominator)
	else
		new_spawn.mind.add_antag_datum(/datum/antagonist/denominator/shotgunner)
		new_spawn.attributes.add_sheet(/datum/attribute_holder/sheet/job/denominator/shotgunner)
		shotgunner = FALSE
	new_spawn.hairstyle = "Bald"
	new_spawn.facial_hairstyle = "Shaved"
	new_spawn.skin_tone = "albino"
	new_spawn.update_body()
	new_spawn.update_hair()

	new_spawn.real_name = "[denominator_first()] [prob(1) ? "Sixty-Nine" : denominator_last()]"
	new_spawn.update_name()
