/obj/structure/closet/crate/grief
	name = "Grief Crate"

/obj/structure/closet/grief
	name = "Grief Crate"

/obj/structure/closet/crate/grief/rare
	name = "Grief Crate"

/obj/structure/closet/grief/rare
	name = "Grief Crate"

/obj/structure/closet/grief/PopulateContents()
	. = ..()
	new /obj/effect/spawner/random/lootshoot(src)
	new /obj/effect/spawner/random/lootshoot/clothing(src)


/obj/structure/closet/crate/grief/PopulateContents()
	. = ..()
	new /obj/effect/spawner/random/lootshoot(src)
	new /obj/effect/spawner/random/lootshoot/clothing(src)

/obj/structure/closet/grief/rare/PopulateContents()
	. = ..()
	new /obj/effect/spawner/random/lootshoot/rare(src)
	new /obj/effect/spawner/random/lootshoot/clothing/rare(src)


/obj/structure/closet/crate/grief/rare/PopulateContents()
	. = ..()
	new /obj/effect/spawner/random/lootshoot/rare(src)
	new /obj/effect/spawner/random/lootshoot/clothing/rare(src)
