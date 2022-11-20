///Smoke coming from cigarettes and fires
/datum/pollutant/smoke
	name = "Smoke"
	pollutant_flags = POLLUTANT_APPEARANCE | POLLUTANT_SMELL | POLLUTANT_BREATHE_ACT
	smell_intensity = 1
	descriptor = SCENT_DESC_SMELL
	scent = "smoke"

/datum/pollutant/smoke/breathe_act(mob/living/carbon/victim, amount)
	if(amount <= 30)
		return
	if(prob(20))
		victim.emote("cough")

/datum/pollutant/smoke/cannabis
	name = "Cannabis"
	smell_intensity = 2 //Stronger than the normal smoke
	scent = "cannabis"

/datum/pollutant/smoke/vape
	name = "Vape Cloud"
	thickness = 2
	scent = "pleasant and soft vapour"

///Sulphur coming from igniting matches
/datum/pollutant/sulphur
	name = "Sulphur"
	pollutant_flags = POLLUTANT_SMELL
	smell_intensity = 5 //Very pronounced smell (and good too, sniff sniff)
	descriptor = SCENT_DESC_SMELL
	scent = "sulphur"

///Organic waste and garbage makes this
/datum/pollutant/decaying_waste
	name = "Decaying Waste"
	pollutant_flags = POLLUTANT_SMELL
	smell_intensity = 3
	descriptor = SCENT_DESC_ODOR
	scent = "decaying waste"

///Green goo piles and medicine chemical reactions make this
/datum/pollutant/chemical_vapors
	name = "Chemical Vapors"
	pollutant_flags = POLLUTANT_SMELL
	smell_intensity = 1
	descriptor = SCENT_DESC_SMELL
	scent = "chemicals"

//Food related smells
/datum/pollutant/food
	pollutant_flags = POLLUTANT_SMELL
	smell_intensity = 0.5 //Low intensity because we want to carry it farther with more amounts
	descriptor = SCENT_DESC_SMELL

/datum/pollutant/food/fried_meat
	name = "Fried Meat"
	scent = "fried meat"

/datum/pollutant/food/fried_chicken
	name = "Fried Chicke"
	scent = "fried chicken"

/datum/pollutant/food/fried_bacon
	name = "Fried Bacon"
	scent = "fried bacon"

/datum/pollutant/food/fried_fish
	name = "Fried Fish"
	scent = "fried fish"

/datum/pollutant/food/pancakes
	name = "Pancakes"
	scent = "pancakes"

/datum/pollutant/food/coffee
	name = "Coffee"
	scent = "coffee"

/datum/pollutant/food/tea
	name = "Tea"
	scent = "tea"

/datum/pollutant/food/chocolate
	name = "Chocolate"
	scent = "chocolate"

/datum/pollutant/food/spicy_noodles
	name = "Spicy Noodles"
	scent = "spicy noodles"

/// Fragrances that we spray on thing to make them smell nice
/datum/pollutant/fragrance
	pollutant_flags = POLLUTANT_SMELL
	smell_intensity = 1
	descriptor = SCENT_DESC_FRAGRANCE

/datum/pollutant/fragrance/air_refresher
	name = "Air Refresher"
	scent = "a strong flowery scent"
	smell_intensity = 3

//simple fragrances
/datum/pollutant/fragrance/cologne
	name = "Cologne Water"
	scent = "cologne"

/datum/pollutant/fragrance/wood
	name = "Wood Perfume"
	scent = "aging wood"

/datum/pollutant/fragrance/rose
	name = "Rose Perfume"
	scent = "roses"

/datum/pollutant/fragrance/jasmine
	name = "Jasmine Perfume"
	scent = "jasmine"

/datum/pollutant/fragrance/mint
	name = "Mint Perfume"
	scent = "mint"

/datum/pollutant/fragrance/vanilla
	name = "Vanilla Perfume"
	scent = "vanilla"

/datum/pollutant/fragrance/pear
	name = "Pear Perfume"
	scent = "pear"

/datum/pollutant/fragrance/strawberry
	name = "Strawberry Perfume"
	scent = "strawberries"

/datum/pollutant/fragrance/cherry
	name = "Cherry Perfume"
	scent = "cherries"

/datum/pollutant/fragrance/amber
	name = "Amber Perfume"
	scent = "a sweet and powdery scent"
