/// How much radiation sickness to gain, per second, per rad (100 is assumed to be the base dose)
#define RADIATION_SICKNESS_PER_RAD 0.1

/// How many rads cleaning reduces
#define RADIATION_CLEANING_POWER 50

/// The amount of rads in a single mob or item should never ever exceed this
#define RADIATION_MAXIMUM_RADS 5000

/// Metallic tastes and smells
#define RADIATION_SICKNESS_STAGE_1 30 SECONDS
/// Diarrhea, vomiting
#define RADIATION_SICKNESS_STAGE_2 60 SECONDS
/// Fever
#define RADIATION_SICKNESS_STAGE_3 90 SECONDS
/// Spleen damage
#define RADIATION_SICKNESS_STAGE_4 150 SECONDS
/// Bleeding, coughing, immunity cripple
#define RADIATION_SICKNESS_STAGE_5 200 SECONDS
/// DNA mutations
#define RADIATION_SICKNESS_STAGE_6 240 SECONDS
/// Stomach and intestine damage
#define RADIATION_SICKNESS_STAGE_7 260 SECONDS
/// Burns
#define RADIATION_SICKNESS_STAGE_8 420 SECONDS
/// Brain damage, seizures, unconsciousness
#define RADIATION_SICKNESS_STAGE_9 600 SECONDS

/// How much we heal radiation sickness naturally if we have no rads
#define RADIATION_SICKNESS_NATURAL_HEALING 250
/// Above this stage, radiation sickness stops healing itself even when flushed out of rads
#define RADIATION_SICKNESS_HEALING_CUTOFF RADIATION_SICKNESS_STAGE_7
/// Above this stage, radiation sickness requires stem cells to be treated
#define RADIATION_SICKNESS_UNHEALABLE RADIATION_SICKNESS_STAGE_8
/// Radiation sickness should never ever get above this value
#define RADIATION_SICKNESS_MAXIMUM 40 MINUTES

#undef RAD_MOB_VOMIT_PROB
/// Chance of vomiting when irradiated per second
#define RAD_MOB_VOMIT_PROB 0.5
/// Chance of shitting pants when irradiated per second
#define RAD_MOB_SHIT_PROB 0.25
/// Chance of pissing pants when irradiated per second
#define RAD_MOB_PISS_PROB 0.25
/// Chance of causing spleen damage when irradiated per second
#define RAD_MOB_SPLEEN_DAMAGE_PROB 0.5
/// How much damage to cause to the spleen when irradiated
#define RAD_MOB_SPLEEN_DAMAGE_AMOUNT 10
/// Chance of reducing blood volume when irradiated per second
#define RAD_MOB_BLEED_PROB 25
/// Amount of blood volume to reduce when irradiated
#define RAD_MOB_BLEED_AMOUNT 5
/// Chance of coughing up blood when irradiated per second
#define RAD_MOB_COUGH_BLOOD_PROB 0.5
/// How much blood to cough up when irradiated
#define RAD_MOB_COUGH_BLOOD_AMOUNT 2
/// Chance of causing stomach damage when irradiated per second
#define RAD_MOB_STOMACH_DAMAGE_PROB 1
/// How much damage to cause to the stomach when irradiated
#define RAD_MOB_STOMACH_DAMAGE_AMOUNT 10
/// Chance of causing intestine damage when irradiated per second
#define RAD_MOB_INTESTINES_DAMAGE_PROB 1
/// How much damage to cause to the intestines when irradiated
#define RAD_MOB_INTESTINES_DAMAGE_AMOUNT 10
/// Chance of causing burn damage when irradiated per second
#define RAD_MOB_BURN_PROB 3
/// How much burn damage to cause when irradiated
#define RAD_MOB_BURN_AMOUNT 12
/// Chance to have a seizure when irradiated
#define RAD_MOB_SEIZURE_PROB 5
/// Chance of causing brain damage when irradiated per second
#define RAD_MOB_BRAIN_DAMAGE_PROB 10
/// How much damage to cause to the brain when irradiated
#define RAD_MOB_BRAIN_DAMAGE_AMOUNT 10
