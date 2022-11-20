//mob/living/carbon/human/monkeybrain

///////////////////////////////////////////////////////////////////
//You shall have no other gods before me                        //
//You shall not make for yourself an idol                       //
//You shall not bow down to them or worship them                //
//You shall not make wrongful use of the name of the LORD your God
//You shall not do any work (on the seventh day)                //
//Honor your father and mother                                  //
//You shall not murder                                          //
//You shall not commit adultery                                 //
//You shall not steal                                           //
//You shall not bear false witness against your neighbor        //
//You shall not covet your neighbor’s house                     // 
//You shall not covet your neighbor’s wife                      //
//////////////////////////////////////////////////////////////////

/obj/effect/mob_spawn/human/emoney
    name = "Emoney"
    outfit = /datum/outfit/job/emoney
    death = FALSE
    icon = 'modular_septic/icons/obj/spawner.dmi'
    icon_state = "raginggorrilla"

/obj/effect/mob_spawn/human/emoney/special(mob/living/new_spawn, name)
    if(ishuman(new_spawn))
        var/mob/living/carbon/human/H = new_spawn
        H.ai_controller = /datum/ai_controller/monkey/angry
