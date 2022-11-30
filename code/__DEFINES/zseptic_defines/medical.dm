/// Max damage we consider for damage_organs()
#define MAX_CONSIDERED_ORGAN_DAMAGE_ROLL 75

// ~pulse levels, very simplified.
#define PULSE_NONE 0   // So !M.pulse checks would be possible.
#define PULSE_SLOW 1   // <60     bpm
#define PULSE_NORM 2   //  60-90  bpm
#define PULSE_FAST 3   //  90-120 bpm
#define PULSE_FASTER 4   // >120    bpm
#define PULSE_THREADY 5   // Occurs during hypovolemic shock
#define PULSE_MAX_BPM 250 // Highest, readable BPM by machines and humans.
#define GETPULSE_BASIC 0   // Less accurate. (hand, health analyzer, etc.)
#define GETPULSE_ADVANCED 1   // More accurate. (med scanner, sleeper, etc.)
#define GETPULSE_PERFECT 2   // Perfectly accurate. (currently no non-adminbus means, you get the exact value 0-5)

// ~germ defines
/// Medical equipment should start out as this
#define GERM_LEVEL_STERILE 0
/// Maximum germ level you can reach by standing still.
#define GERM_LEVEL_AMBIENT 250
/// Maximum germ level any atom can normally achieve
#define GERM_LEVEL_MAXIMUM 1000

/// Exposure to blood germ level per unit
#define GERM_PER_UNIT_BLOOD 2
/// Exposure to piss germ level per unit
#define GERM_PER_UNIT_PISS 2
/// Exposure to shit germ level per unit
#define GERM_PER_UNIT_SHIT 5

// ~sanitization defines, related to lowering germ level
/// Sterilizine sanitization per unit
#define SANITIZATION_PER_UNIT_STERILIZINE 50
/// Space cleaner sanitization per unit
#define SANITIZATION_PER_UNIT_SPACE_CLEANER 25
/// Water sanitization per unit
#define SANITIZATION_PER_UNIT_WATER 10
/// CE_ANTIBIOTIC bodypart/organ sanitization per CE unit
#define SANITIZATION_ANTIBIOTIC 0.1
/// Bodypart/organ sanitization for laying down
#define SANITIZATION_LYING 1

// ~infection levels
/// infections grow from ambient to one in ~5 minutes
#define INFECTION_LEVEL_ONE 250
/// infections grow from ambient to two in ~10 minutes
#define INFECTION_LEVEL_TWO 500
/// infections grow from two to three in ~15 minutes
#define INFECTION_LEVEL_THREE 1000

/// Maximum amount of germs surgery can cause
#define SURGERY_GERM_MAXIMUM 800

/// Organ and bodypart rejection levels
#define REJECTION_LEVEL_1 1
#define REJECTION_LEVEL_2 50
#define REJECTION_LEVEL_3 200
#define REJECTION_LEVEL_4 500

//~brain damage related defines
/// We need to take at least this much brainloss gained at once to roll for brain traumas, any less it won't roll
#define TRAUMA_ROLL_THRESHOLD 4.5
/// Brainloss caused by mildly low blood oxygenation
#define BRAIN_DAMAGE_LOW_OXYGENATION 1.5
/// Brainloss caused by lower than low blood oxygenation
#define BRAIN_DAMAGE_LOWER_OXYGENATION 3
/// Brainloss caused by a complete lack of oxygen flow
#define BRAIN_DAMAGE_LOWEST_OXYGENATION 4.5

//Brain damage defines
#undef BRAIN_DAMAGE_MILD
#undef BRAIN_DAMAGE_SEVERE
#undef BRAIN_DAMAGE_DEATH
#define BRAIN_DAMAGE_MILD 10
#define BRAIN_DAMAGE_SEVERE 50
#define BRAIN_DAMAGE_DEATH 100

#undef HUMAN_MAX_OXYLOSS
#define HUMAN_MAX_OXYLOSS 3

// ~CPR types
/// Mouth to mouth - Heals oxygen deprivation
#define CPR_MOUTH "m2m"
#define CPR_CHEST "cardio"

/// Mouth to mouth cooldown duration
#define M2M_COOLDOWN 0.5 SECONDS
///Cpr cooldown duration
#define CPR_COOLDOWN 0.3 SECONDS

// ~simple brainloss defines
#define GETBRAINLOSS(mob) mob.getOrganLoss(ORGAN_SLOT_BRAIN)
#define ADJUSTBRAINLOSS(mob, amount) mob.adjustOrganLoss(ORGAN_SLOT_BRAIN, amount)
#define SETBRAINLOSS(mob, amount) mob.setOrganLoss(ORGAN_SLOT_BRAIN, amount)
