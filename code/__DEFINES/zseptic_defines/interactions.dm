/// Default interaction cooldown, can be changed on each datum
#define INTERACTION_COOLDOWN 0.5 SECONDS

#define INTERACT_SELF "self"
#define INTERACT_OTHER "other"
#define INTERACT_BOTH "both"

// ~interaction flags
/// Respects interaction_cooldown
#define INTERACTION_RESPECT_COOLDOWN (1<<0)
/// Respects sex_interaction_cooldown
#define INTERACTION_RESPECT_SEX_COOLDOWN (1<<1)
/// Interaction will call climax() on the user, if applicable
#define INTERACTION_USER_CLIMAX (1<<2)
/// Interaction will call climax() on the target, if applicable
#define INTERACTION_TARGET_CLIMAX (1<<3)
/// Interaction will call lust_message() on the user, if applicable
#define INTERACTION_USER_LUST (1<<4)
/// Interaction will call lust_message() on the target, if applicable
#define INTERACTION_TARGET_LUST (1<<5)
/// Use audible_message instead of visible_message
#define INTERACTION_AUDIBLE (1<<6)
/// User and target must be adjacent
#define INTERACTION_NEEDS_PHYSICAL_CONTACT (1<<7)

// ~interaction categories
#define INTERACTION_CATEGORY_UNFRIENDLY "Unfriendly"
#define INTERACTION_CATEGORY_FRIENDLY "Friendly"
#define INTERACTION_CATEGORY_ROMANTIC "Romantic"
#define INTERACTION_CATEGORY_FORBIDDEN_FRUITS "Forbidden Fruits"

// ~body zone or organ that needs to be exposed on interactions, avoid using this in zones in favor of organs
#define INTERACTION_ZONE_EXISTS (1<<0)
#define INTERACTION_ZONE_COVERED (1<<1)
#define INTERACTION_ZONE_UNCOVERED (1<<1)

/// Factor at which genitals lose their proximity to cumming, per second
#define DELUST_FACTOR 0.2

/// Once we hit this amount of lust, we cum
#define LUST_CLIMAX 300
/// No arousal increase
#define AROUSAL_GAIN_NONE 0
/// Small arousal gain
#define AROUSAL_GAIN_LOW AROUSAL_LEVEL_AROUSED/10
/// Normal arousal gain
#define AROUSAL_GAIN_NORMAL AROUSAL_LEVEL_AROUSED/5

/// No lust increase (ass slap)
#define LUST_GAIN_NONE 0
/// Low lust increase on sex (thigh smother, deep kiss, etc)
#define LUST_GAIN_LOW 2.5
/// Normal lust increase on sex
#define LUST_GAIN_NORMAL 10

#define INTERACTION_CATEGORY_ORDER list(\
			INTERACTION_CATEGORY_UNFRIENDLY, \
			INTERACTION_CATEGORY_FRIENDLY, \
			INTERACTION_CATEGORY_ROMANTIC, \
			INTERACTION_CATEGORY_FORBIDDEN_FRUITS, \
			)
