// ~bodypart icons
#define DEFAULT_BODYPART_ICON 'modular_septic/icons/mob/human/species/human/dismembered_human_parts.dmi'
#define DEFAULT_BODYPART_ICON_ORGANIC 'modular_septic/icons/mob/human/species/human/new_human_parts.dmi'
#define DEFAULT_BODYPART_ICON_ROBOTIC 'modular_septic/icons/mob/human/augments/augments.dmi'
#define DEFAULT_BODYPART_ICON_ANIMAL 'modular_septic/icons/mob/carbon/animal_parts.dmi'

// ~bodypart damage messages
#define DEFAULT_NO_BRUTE_MSG "normal"
#define DEFAULT_LIGHT_BRUTE_MSG "bruised"
#define DEFAULT_MEDIUM_BRUTE_MSG "mutilated"
#define DEFAULT_HEAVY_BRUTE_MSG "MANGLED"

#define DEFAULT_NO_BURN_MSG "normal"
#define DEFAULT_LIGHT_BURN_MSG "красновато"
#define DEFAULT_MEDIUM_BURN_MSG "в волдырях"
#define DEFAULT_HEAVY_BURN_MSG "CARBON"

#define DEFAULT_NO_PAIN_MSG "unpaiful"
#define DEFAULT_LIGHT_PAIN_MSG "pain"
#define DEFAULT_MEDIUM_PAIN_MSG "PAIN"
#define DEFAULT_HEAVY_PAIN_MSG "AGONY"

#define ROBOTIC_NO_BRUTE_MSG "normal"
#define ROBOTIC_LIGHT_BRUTE_MSG "bruised"
#define ROBOTIC_MEDIUM_BRUTE_MSG "mutilated"
#define ROBOTIC_HEAVY_BRUTE_MSG "MANGLED"

#define ROBOTIC_NO_BURN_MSG "normal"
#define ROBOTIC_LIGHT_BURN_MSG "red"
#define ROBOTIC_MEDIUM_BURN_MSG "boils"
#define ROBOTIC_HEAVY_BURN_MSG "CARBON"

// ~cyborg limbs
#define ROBOTIC_BRUTE_DMG_MULTIPLIER 0.9
#define ROBOTIC_BURN_DMG_MULTIPLIER 0.9
#define ROBOTIC_PAIN_DMG_MULTIPLIER 0.8

// ~limb efficiency thresholds
#define LIMB_EFFICIENCY_OPTIMAL 100
#define LIMB_EFFICIENCY_DISABLING 50

// ~bodypart status flags
///This organ is organic - It can get infected and heal damage over time
#define BODYPART_ORGANIC 1
///This organ is robotic - Affected by emps, doesn't get infected, doesn't heal damage over time
#define BODYPART_ROBOTIC 2

// ~bodypart animal origins
#define MONKEY_BODYPART "monkey"
#define ALIEN_BODYPART "alien"
#define LARVA_BODYPART "larva"
#define HOMIE_BODYPART "homie"
#define TENDONISHE_BODYPART "tendonishe"

// ~flags for the limb_flags var on /obj/item/bodypart
/// Can suffer bone wounds
#define	BODYPART_HAS_BONE (1<<0)
/// Can suffer tendon wounds
#define	BODYPART_HAS_TENDON	(1<<1)
/// Can suffer artery wounds
#define	BODYPART_HAS_ARTERY	(1<<2)
/// Bodypart is edible and uses the edible component
#define BODYPART_EDIBLE (1<<3)
/// Removal or destruction of this limb kills the owner
#define	BODYPART_VITAL (1<<4)
/// Does not leave a stump behind when violently severed or destroyed
#define	BODYPART_NO_STUMP (1<<5)
/// Bodypart will never spoil nor get infected
#define BODYPART_NO_INFECTION (1<<6)
/// Completely septic and unusable limb
#define BODYPART_DEAD (1<<7)
/// Bodypart is genetically damaged and not functioning good
#define BODYPART_DEFORMED (1<<8)
/// Frozen limb, doesn't rot
#define BODYPART_FROZEN	(1<<9)
/// Just got attached but needs to be sewn onto owner
#define BODYPART_CUT_AWAY (1<<10)
/// Autoheals severe injuries that normally require medical treatment
#define	BODYPART_GOOD_HEALER (1<<11)
/// Bodypart can be affected by EMPs, organic or not
#define BODYPART_SYNTHETIC (1<<12)
/// Bodypart has been EMPed and is malfunctioning
#define BODYPART_SYNTHETIC_EMP (1<<13)

///Body type bitfields for allowed_animal_origin used to check compatible surgery body types (use NONE for no matching body type)
#define HUMAN_BODY (1 << 0)
#define MONKEY_BODY (1 << 1)
#define ALIEN_BODY (1 << 2)
#define LARVA_BODY (1 << 3)
#define TENDONISHE_BODY (1 << 4)

// ~handedness flags
/// Decent at using even index bodyparts
#define RIGHT_HANDED (1<<0)
/// Decent at using uneven index bodyparats
#define LEFT_HANDED (1<<1)
/// Jack of all trades, master of none (this is different from (RIGHT_HANDED|LEFT_HANDED))
#define AMBIDEXTROUS (1<<2)
/// Default handedness given to carbon mobs
#define DEFAULT_HANDEDNESS RIGHT_HANDED

// ~should take ~20 minutes for a body to fully rot
#define MIN_BODYPART_DECAY_INFECTION 1
#define MAX_BODYPART_DECAY_INFECTION 2

/// Amount of teeth a normal human has
#define HUMAN_TEETH_AMOUNT 32

// ~body zones
#define BODY_ZONE_PRECISE_L_EYE "l_eye"
#define BODY_ZONE_PRECISE_R_EYE "r_eye"
#define BODY_ZONE_PRECISE_MOUTH "mouth"
#define BODY_ZONE_PRECISE_FACE "face"
#define BODY_ZONE_HEAD "head"
#define BODY_ZONE_PRECISE_NECK "neck"
#define BODY_ZONE_CHEST "chest"
#define BODY_ZONE_PRECISE_VITALS "vitals"
#define BODY_ZONE_PRECISE_GROIN "groin"
#define BODY_ZONE_L_ARM "l_arm"
#define BODY_ZONE_PRECISE_L_HAND "l_hand"
#define BODY_ZONE_R_ARM "r_arm"
#define BODY_ZONE_PRECISE_R_HAND "r_hand"
#define BODY_ZONE_L_LEG "l_leg"
#define BODY_ZONE_PRECISE_L_FOOT "l_foot"
#define BODY_ZONE_R_LEG "r_leg"
#define BODY_ZONE_PRECISE_R_FOOT "r_foot"

// ~bodypart group defines
#define ENHANCEABLE_BODYZONES list(\
	BODY_ZONE_PRECISE_L_EYE, BODY_ZONE_PRECISE_R_EYE, \
	BODY_ZONE_PRECISE_FACE, BODY_ZONE_PRECISE_MOUTH, \
	BODY_ZONE_PRECISE_NECK, BODY_ZONE_HEAD, \
)
#define ALL_BODYPARTS_MINUS_EYES list(\
	BODY_ZONE_HEAD, BODY_ZONE_PRECISE_FACE, \
	BODY_ZONE_PRECISE_MOUTH, BODY_ZONE_PRECISE_NECK, \
	BODY_ZONE_CHEST, BODY_ZONE_PRECISE_GROIN, \
	BODY_ZONE_R_ARM, BODY_ZONE_L_ARM, \
	BODY_ZONE_R_LEG, BODY_ZONE_L_LEG, \
	BODY_ZONE_PRECISE_R_HAND, BODY_ZONE_PRECISE_L_HAND, \
	BODY_ZONE_PRECISE_R_FOOT, BODY_ZONE_PRECISE_L_FOOT, \
)
#define ALL_BODYPARTS_MINUS_EYES_AND_JAW list(\
	BODY_ZONE_HEAD, BODY_ZONE_PRECISE_FACE, \
	BODY_ZONE_PRECISE_NECK, \
	BODY_ZONE_CHEST, BODY_ZONE_PRECISE_GROIN, \
	BODY_ZONE_R_ARM, BODY_ZONE_L_ARM, \
	BODY_ZONE_R_LEG, BODY_ZONE_L_LEG, \
	BODY_ZONE_PRECISE_R_HAND, BODY_ZONE_PRECISE_L_HAND, \
	BODY_ZONE_PRECISE_R_FOOT, BODY_ZONE_PRECISE_L_FOOT, \
)
#define ALL_BODYPARTS list(\
	BODY_ZONE_PRECISE_L_EYE, BODY_ZONE_PRECISE_R_EYE, \
	BODY_ZONE_PRECISE_FACE, \
	BODY_ZONE_PRECISE_MOUTH, \
	BODY_ZONE_HEAD, BODY_ZONE_PRECISE_NECK, \
	BODY_ZONE_CHEST, BODY_ZONE_PRECISE_VITALS, \
	BODY_ZONE_PRECISE_GROIN, \
	BODY_ZONE_R_ARM, BODY_ZONE_L_ARM, \
	BODY_ZONE_R_LEG, BODY_ZONE_L_LEG, \
	BODY_ZONE_PRECISE_R_HAND, BODY_ZONE_PRECISE_L_HAND, \
	BODY_ZONE_PRECISE_R_FOOT, BODY_ZONE_PRECISE_L_FOOT, \
)
#define ALL_BODYPARTS_CHECKSELF list(\
	BODY_ZONE_HEAD, \
	BODY_ZONE_PRECISE_L_EYE, BODY_ZONE_PRECISE_R_EYE, \
	BODY_ZONE_PRECISE_FACE, \
	BODY_ZONE_PRECISE_MOUTH, \
	BODY_ZONE_PRECISE_NECK, \
	BODY_ZONE_CHEST, BODY_ZONE_PRECISE_VITALS, \
	BODY_ZONE_PRECISE_GROIN, \
	BODY_ZONE_R_ARM, BODY_ZONE_PRECISE_R_HAND, \
	BODY_ZONE_L_ARM, BODY_ZONE_PRECISE_L_HAND, \
	BODY_ZONE_R_LEG, BODY_ZONE_PRECISE_R_FOOT, \
	BODY_ZONE_L_LEG, BODY_ZONE_PRECISE_L_FOOT, \
)
#define ALL_BODYPARTS_CHECKSELF_DETAILED list(\
	BODY_ZONE_HEAD, \
	BODY_ZONE_PRECISE_L_EYE, BODY_ZONE_PRECISE_R_EYE, \
	BODY_ZONE_PRECISE_FACE, \
	BODY_ZONE_PRECISE_MOUTH, \
	BODY_ZONE_PRECISE_NECK, \
	BODY_ZONE_CHEST, BODY_ZONE_PRECISE_VITALS, \
	BODY_ZONE_PRECISE_GROIN, \
	BODY_ZONE_R_ARM, BODY_ZONE_PRECISE_R_HAND, \
	BODY_ZONE_L_ARM, BODY_ZONE_PRECISE_L_HAND, \
	BODY_ZONE_R_LEG, BODY_ZONE_PRECISE_R_FOOT, \
	BODY_ZONE_L_LEG, BODY_ZONE_PRECISE_L_FOOT, \
)
#define ALL_BODYPARTS_ORDERED list(\
	BODY_ZONE_CHEST, BODY_ZONE_PRECISE_VITALS, \
	BODY_ZONE_PRECISE_GROIN, \
	BODY_ZONE_PRECISE_NECK, BODY_ZONE_HEAD, \
	BODY_ZONE_PRECISE_FACE, \
	BODY_ZONE_PRECISE_MOUTH, \
	BODY_ZONE_PRECISE_L_EYE, BODY_ZONE_PRECISE_R_EYE, \
	BODY_ZONE_R_ARM, BODY_ZONE_L_ARM, \
	BODY_ZONE_R_LEG, BODY_ZONE_L_LEG, \
	BODY_ZONE_PRECISE_R_HAND, BODY_ZONE_PRECISE_L_HAND, \
	BODY_ZONE_PRECISE_R_FOOT, BODY_ZONE_PRECISE_L_FOOT, \
)
#define TORSO_BODYPARTS list(\
	BODY_ZONE_CHEST, \
	BODY_ZONE_PRECISE_VITALS, \
	BODY_ZONE_PRECISE_GROIN, \
)
#define AMPUTATABLE_BODYPARTS list(\
	BODY_ZONE_PRECISE_L_EYE, BODY_ZONE_PRECISE_R_EYE, \
	BODY_ZONE_PRECISE_FACE, \
	BODY_ZONE_PRECISE_MOUTH, \
	BODY_ZONE_PRECISE_NECK, \
	BODY_ZONE_R_ARM, BODY_ZONE_L_ARM, \
	BODY_ZONE_PRECISE_GROIN, \
	BODY_ZONE_R_LEG, BODY_ZONE_L_LEG, \
	BODY_ZONE_PRECISE_R_HAND, BODY_ZONE_PRECISE_L_HAND, \
	BODY_ZONE_PRECISE_R_FOOT, BODY_ZONE_PRECISE_L_FOOT, \
)
#define LIMB_BODYPARTS list(\
	BODY_ZONE_R_ARM, BODY_ZONE_PRECISE_R_HAND, \
	BODY_ZONE_L_ARM, BODY_ZONE_PRECISE_L_HAND, \
	BODY_ZONE_R_LEG, BODY_ZONE_PRECISE_R_FOOT, \
	BODY_ZONE_L_LEG, BODY_ZONE_PRECISE_L_FOOT, \
)
#define MARKING_BODYPARTS list(\
	BODY_ZONE_HEAD, \
	BODY_ZONE_CHEST, BODY_ZONE_PRECISE_GROIN, \
	BODY_ZONE_R_ARM, BODY_ZONE_L_ARM, \
	BODY_ZONE_R_LEG, BODY_ZONE_L_LEG, \
	BODY_ZONE_PRECISE_R_HAND, BODY_ZONE_PRECISE_L_HAND, \
	BODY_ZONE_PRECISE_R_FOOT, BODY_ZONE_PRECISE_L_FOOT, \
)

#define SSPARTS	list(\
	/obj/item/bodypart/chest, /obj/item/bodypart/vitals, \
	/obj/item/bodypart/groin, \
	/obj/item/bodypart/neck, /obj/item/bodypart/head, \
	/obj/item/bodypart/face, /obj/item/bodypart/mouth, \
	/obj/item/bodypart/l_eyelid, /obj/item/bodypart/r_eyelid, \
	/obj/item/bodypart/r_arm, /obj/item/bodypart/r_hand, \
	/obj/item/bodypart/l_arm, /obj/item/bodypart/l_hand, \
	/obj/item/bodypart/r_leg, /obj/item/bodypart/r_foot, \
	/obj/item/bodypart/l_leg, /obj/item/bodypart/l_foot, \
)
#define BODYPARTS_PATH list(\
	/obj/item/bodypart/l_eyelid, /obj/item/bodypart/r_eyelid, \
	/obj/item/bodypart/face, /obj/item/bodypart/mouth, \
	/obj/item/bodypart/head, /obj/item/bodypart/neck, \
	/obj/item/bodypart/chest, /obj/item/bodypart/vitals, \
	/obj/item/bodypart/groin, \
	/obj/item/bodypart/l_arm, /obj/item/bodypart/l_hand, \
	/obj/item/bodypart/r_arm, /obj/item/bodypart/r_hand,\
	/obj/item/bodypart/l_leg, /obj/item/bodypart/l_foot, \
	/obj/item/bodypart/r_leg, /obj/item/bodypart/r_foot, \
)
