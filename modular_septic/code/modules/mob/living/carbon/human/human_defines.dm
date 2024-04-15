/mob/living/carbon/human
	body_type = BODY_TYPE_MASCULINE
	has_field_of_vision = TRUE
	hair_color = "000000"
	facial_hair_color = "000000"
	grad_color = "000000"
	underwear_color = "000000"
	/// Flags for showing/hiding underwear
	var/underwear_visibility = NONE
	/// Render key for mutant bodyparts, utilized to reduce the amount of re-rendering
	var/mutant_renderkey = ""
	// Eye colors
	var/left_eye_color = "#000000"
	var/right_eye_color = "#000000"

	/// How horny we are
	var/arousal = AROUSAL_LEVEL_START_MIN
	/// How close we are to cooming
	var/lust = 0
	var/bot = 0

	/// How much shit we have on our hands
	var/shit_in_hands = 0
	/// How much cum we have on our hands
	var/cum_in_hands = 0
	/// How much femcum we have on our hands
	var/femcum_in_hands = 0

	// ~ACTIVE DEFENSE VARIABLES
	/// Dodging capability flags
	var/dodging_flags = BLOCK_FLAG_MELEE | BLOCK_FLAG_UNARMED | BLOCK_FLAG_PROJECTILE
	/// Last time we tried to block an attack
	COOLDOWN_DECLARE(blocking_cooldown)
	/// Timer for resetting the blocking penalty
	var/blocking_penalty_timer = null
	/// Blocking penalty, normally applied by feints
	var/blocking_penalty = 0
	/// Last time we tried to dodge
	COOLDOWN_DECLARE(dodging_cooldown)
	/// Timer for resetting the dodging penalty
	var/dodging_penalty_timer = null
	/// Dodging penalty, normally applied by feints
	var/dodging_penalty = 0
	/// Timer for resetting the parrying penalty
	var/parrying_penalty_timer = null
	/// Subtract this from parry sccore
	var/parrying_penalty = 0

	// ~DATE OF BIRTH VARIABLES
	/// Day of the month born
	var/day_born = 1
	/// Month born
	var/month_born = JANUARY
