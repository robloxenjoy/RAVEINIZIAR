/mob/living/carbon
	maximum_examine_distance = EYE_CONTACT_RANGE

	/// Only carbons are capable of having intents
	a_intent = INTENT_HELP
	possible_a_intents = DEFAULT_INTENTS_LIST
	hand_index_to_intent = list(INTENT_HELP, INTENT_HELP)
	hand_index_to_zone = list(BODY_ZONE_CHEST, BODY_ZONE_CHEST)
	hand_index_to_throw = list(FALSE, FALSE)

	/// Basically used to know what are supposed to be our original genitals
	var/genitals = GENITALS_MALE

	/// Height of the mob, only used by humans.
	var/height = HUMAN_HEIGHT_MEDIUM

	/// Handedness impacts dicerolls most of the time
	var/handed_flags = DEFAULT_HANDEDNESS
	/// A collection of bodyparts used to stand
	var/list/leg_bodyparts = list()
	// Carbon mobs actually have 4 "legs" (the feet help, too!)
	default_num_legs = 4
	num_legs = 0
	usable_legs = 0
	/// Makes carbon account the new bodyparts
	bodyparts = BODYPARTS_PATH
	/// Associated list - zone = bodypart
	var/list/bodyparts_zones = list()

	/// To reduce processing, this list is used to associate body zone with all organs inside that zone
	var/list/organs_by_zone = list()

	/// A collection of organs (eyes) used to see
	var/list/eye_organs = list()
	default_num_eyes = 2
	num_eyes = 0
	usable_eyes = 0

	/// All injuries we have accumulated on our body
	var/list/datum/injury/all_injuries

	/// Speech modifiers
	var/list/datum/speech_modifier/speech_modifiers

	/// Descriptive string used in combat messages
	var/wound_message = ""

	/// Current immune system strength
	var/immunity = 100
	/// It will regenerate to this value
	var/default_immunity = 100

	/// Pulse can't be handled on an organ-by-organ basis, since we can have multiple hearts
	var/pulse = PULSE_NORM
	/// Used to handle the heartbeat sounds
	var/heartbeat_sound = BEAT_NONE
	/// How long effectively a pump lasts
	var/heart_pump_duration = 5 SECONDS
	/// Used by CPR and blood circulation - Time of the pumping associated with "effectiveness", from 0 to 1
	var/list/recent_heart_pump
	/// Last time we got mouth to mouthed
	COOLDOWN_DECLARE(last_mtom)
	/// Last time we got CPR'd
	COOLDOWN_DECLARE(last_cpr)

	/// Total sum of organ and bodypart blood requirement
	var/total_blood_req = DEFAULT_TOTAL_BLOOD_REQ
	/// Total sum of organ and bodypart oxygen requirement
	var/total_oxygen_req = DEFAULT_TOTAL_OXYGEN_REQ
	/// Total sum of organ and bodypart nutriment requirement
	var/total_nutriment_req = DEFAULT_TOTAL_NUTRIMENT_REQ
	/// Total sum of organ and bodypart hydration requirement
	var/total_hydration_req  = DEFAULT_TOTAL_HYDRATION_REQ

	/// Pollution smell cooldown
	COOLDOWN_DECLARE(next_smell)

	// ~WEIGHT SYSTEM
	/// Maximum weight we can carry, this point and beyond means maximum encumbrance
	var/maximum_carry_weight = 50
	/// Weight we are currently carrying
	var/carry_weight = 0
	/// State of encumbrance we are in, cheaper to store this than keeping calling update_carry_weight()
	var/encumbrance = ENCUMBRANCE_NONE

	// ~INVENTORY VARIABLES
	/// Second ear slot
	var/obj/item/clothing/ears_extra = null
	/// Wrists slot
	var/obj/item/clothing/gloves/wrists/wrists = null
	/// Pants slot
	var/obj/item/clothing/pants/pants = null
	/// Oversuit slot
	var/obj/item/clothing/oversuit/oversuit = null

	// ~INJURY PENALTIES
	/// Timer for injury penalty, should reset if we take more damage
	var/shock_penalty_timer = null
	/// How much our injury penalty currently affects our DX and IQ
	var/shock_penalty = 0
	/// Last time we got a major wound
	var/last_major_wound = 0
