// Since we don't use the tg burn wounds, we jack variables up a bit
// Remember however that this is damage per second, though (delta time)
#define HEAT_DAMAGE_LEVEL_1 1 //Amount of damage applied when your body temperature just passes the 360.15k safety point
#define HEAT_DAMAGE_LEVEL_2 2 //Amount of damage applied when your body temperature passes the 400K point
#define HEAT_DAMAGE_LEVEL_3 3 //Amount of damage applied when your body temperature passes the 460K point and you are on fire

#define COLD_DAMAGE_LEVEL_1 1 //Amount of damage applied when your body temperature just passes the 260.15k safety point
#define COLD_DAMAGE_LEVEL_2 2 //Amount of damage applied when your body temperature passes the 200K point
#define COLD_DAMAGE_LEVEL_3 3 //Amount of damage applied when your body temperature passes the 120K point

/// Mob status_flags
#define BLEEDOUT (1<<5)
#define BUILDING_ORGANS (1<<6)

/// Yeah we can't have 17 year olds. It's gonna get me exposed on reddit.
#undef AGE_MIN
#define AGE_MIN 18 //youngest a character can be

/// Hydration levels for humans
#define HYDRATION_LEVEL_SOAKED 600
#define HYDRATION_LEVEL_FULL 550
#define HYDRATION_LEVEL_WELL_HYDRATED 450
#define HYDRATION_LEVEL_HYDRATED 350
#define HYDRATION_LEVEL_THIRSTY 250
#define HYDRATION_LEVEL_DEHYDRATED 150

#define HYDRATION_LEVEL_START_MIN 250
#define HYDRATION_LEVEL_START_MAX 400

/// Used as an upper limit for species that continuously gain hydration
#define HYDRATION_LEVEL_ALMOST_FULL 535

/// Arousal levels for humans
//maximum arousal one person can have
#define AROUSAL_LEVEL_MAXIMUM 1000
//second horny mood
#define AROUSAL_LEVEL_HORNY 550
//first horny mood
#define AROUSAL_LEVEL_AROUSED 300

#define AROUSAL_LEVEL_START_MIN 0
#define AROUSAL_LEVEL_START_MAX 200

/// Factor at which mob hydration decreases
#define THIRST_FACTOR 1.5

/// How much moving around increases carbon germ level
#define GERM_LEVEL_MOVEMENT_INCREASE 0.2

/// Germ levels for carbon mob hygiene
#define GERM_LEVEL_START_MIN 0
#define GERM_LEVEL_START_MAX 100
#define GERM_LEVEL_DIRTY 250
#define GERM_LEVEL_FILTHY 500
#define GERM_LEVEL_SMASHPLAYER 750

#undef CAN_SUCCUMB
#define CAN_SUCCUMB(target) (HAS_TRAIT(target, TRAIT_DEATHS_DOOR) && !HAS_TRAIT(target, TRAIT_NODEATH))

/// I don't know where else to put all of this, but these make 3/4ths look much better
#define MOB_PIXEL_Z 7
#define NORMAL_MOB_SHADOW "shadow"
#define LYING_MOB_SHADOW "shadow_lying"
