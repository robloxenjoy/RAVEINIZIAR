/obj/item/food/fishmeat/moonfish/MakeGrillable()
	AddComponent(/datum/component/grillable, /obj/item/food/grilled_moonfish, rand(40 SECONDS, 50 SECONDS), TRUE, TRUE, /datum/pollutant/food/fried_fish)

/obj/item/food/spiderleg/MakeGrillable()
	AddComponent(/datum/component/grillable, /obj/item/food/boiledspiderleg, rand(50 SECONDS, 60 SECONDS), TRUE, TRUE, /datum/pollutant/food/fried_meat)

/obj/item/food/raw_meatball/MakeGrillable()
	AddComponent(/datum/component/grillable, meatball_type, rand(30 SECONDS, 40 SECONDS), TRUE, pollutant_type = /datum/pollutant/food/fried_meat)

/obj/item/food/raw_patty/MakeGrillable()
	AddComponent(/datum/component/grillable, patty_type, rand(30 SECONDS, 40 SECONDS), TRUE, TRUE, pollutant_type = /datum/pollutant/food/fried_meat)

/obj/item/food/raw_sausage/MakeGrillable()
	AddComponent(/datum/component/grillable, /obj/item/food/sausage, rand(60 SECONDS, 75 SECONDS), TRUE, TRUE, pollutant_type = /datum/pollutant/food/fried_meat)

/obj/item/food/meat/slab/MakeGrillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/plain, rand(30 SECONDS, 90 SECONDS), TRUE, TRUE, /datum/pollutant/food/fried_meat) //Add medium rare later maybe?

/obj/item/food/meat/slab/human/MakeGrillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/plain/human, rand(30 SECONDS, 90 SECONDS), TRUE, TRUE, /datum/pollutant/food/fried_meat) //Add medium rare later maybe?

/obj/item/food/meat/slab/human/mutant/lizard/MakeGrillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/plain/human/lizard, rand(30 SECONDS, 90 SECONDS), TRUE, TRUE, /datum/pollutant/food/fried_meat)

/obj/item/food/meat/slab/meatproduct/MakeGrillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/meatproduct, rand(30 SECONDS, 90 SECONDS), TRUE, TRUE, /datum/pollutant/food/fried_meat)

/obj/item/food/meat/slab/bear/MakeGrillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/bear, rand(40 SECONDS, 70 SECONDS), TRUE, TRUE, /datum/pollutant/food/fried_meat)

/obj/item/food/meat/slab/xeno/MakeGrillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/xeno, rand(40 SECONDS, 70 SECONDS), TRUE, TRUE, /datum/pollutant/food/fried_meat)

/obj/item/food/meat/slab/spider/MakeGrillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/spider, rand(40 SECONDS, 70 SECONDS), TRUE, TRUE, /datum/pollutant/food/fried_meat)

/obj/item/food/meat/rawbacon/MakeGrillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/bacon, rand(25 SECONDS, 45 SECONDS), TRUE, TRUE, /datum/pollutant/food/fried_bacon)

/obj/item/food/meat/slab/gondola/MakeGrillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/gondola, rand(30 SECONDS, 90 SECONDS), TRUE, TRUE, /datum/pollutant/food/fried_meat) //Add medium rare later maybe?

/obj/item/food/meat/slab/penguin/MakeGrillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/penguin, rand(30 SECONDS, 90 SECONDS), TRUE, TRUE, /datum/pollutant/food/fried_chicken) //Add medium rare later maybe?

/obj/item/food/meat/slab/rawcrab/MakeGrillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/crab, rand(30 SECONDS, 90 SECONDS), TRUE, TRUE, /datum/pollutant/food/fried_fish) //Add medium rare later maybe?

/obj/item/food/meat/slab/chicken/MakeGrillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/chicken, rand(30 SECONDS, 90 SECONDS), TRUE, TRUE, /datum/pollutant/food/fried_chicken) //Add medium rare later maybe? (no this is chicken)

/obj/item/food/meat/rawcutlet/MakeGrillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/cutlet/plain, rand(35 SECONDS, 50 SECONDS), TRUE, TRUE, /datum/pollutant/food/fried_meat)

/obj/item/food/meat/rawcutlet/plain/human/MakeGrillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/cutlet/plain/human, rand(35 SECONDS, 50 SECONDS), TRUE, TRUE, /datum/pollutant/food/fried_meat)

/obj/item/food/meat/rawcutlet/bear/MakeGrillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/cutlet/bear, rand(35 SECONDS, 50 SECONDS), TRUE, TRUE, /datum/pollutant/food/fried_meat)

/obj/item/food/meat/rawcutlet/xeno/MakeGrillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/cutlet/xeno, rand(35 SECONDS, 50 SECONDS), TRUE, TRUE, /datum/pollutant/food/fried_meat)

/obj/item/food/meat/rawcutlet/spider/MakeGrillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/cutlet/spider, rand(35 SECONDS, 50 SECONDS), TRUE, TRUE, /datum/pollutant/food/fried_meat)

/obj/item/food/meat/rawcutlet/gondola/MakeGrillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/cutlet/gondola, rand(35 SECONDS, 50 SECONDS), TRUE, TRUE, /datum/pollutant/food/fried_meat)

/obj/item/food/meat/rawcutlet/penguin/MakeGrillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/cutlet/penguin, rand(35 SECONDS, 50 SECONDS), TRUE, TRUE, /datum/pollutant/food/fried_chicken)

/obj/item/food/meat/rawcutlet/chicken/MakeGrillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/cutlet/penguin, rand(35 SECONDS, 50 SECONDS), TRUE, TRUE, /datum/pollutant/food/fried_chicken)
