/proc/initialize_bartering_recipes()
    . = list()
    for(var/datum/bartering_recipe/new_recipe as anything in init_subtypes(/datum/bartering_recipe))
        if(!LAZYLEN(new_recipe.outputs) || !LAZYLEN(new_recipe.inputs))
            qdel(new_recipe)
            continue
        .[new_recipe.type] = new_recipe

/proc/initalize_bartering_inputs()
    . = list()
    for(var/thing in GLOB.bartering_recipes)
        var/datum/bartering_recipe/recipe = GLOB.bartering_recipes[thing]
        for(var/input in recipe.inputs) //Fatherful and Fatherless input
            for(var/child in typesof(input))
                .[child] = TRUE
