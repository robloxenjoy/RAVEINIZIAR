// ~defines for processing reagents, for synth/ipc support
/// Processes reagents with "REAGENT_ORGANIC" or "REAGENT_ORGANIC | REAGENT_SYNTHETIC"
#define REAGENT_ORGANIC (1<<0)
/// Processes reagents with "REAGENT_SYNTHETIC" or "REAGENT_ORGANIC | REAGENT_SYNTHETIC"
#define REAGENT_SYNTHETIC (1<<1)

// ~reagent flags
/// Show on advanced scanners only
#define REAGENT_VISIBLE_ADVANCED (1<<7)

// ~polarity defines
///Polar (water soluble)
#define POLARITY_POLAR "polar"
///Non-polar (not water soluble)
#define POLARITY_NONPOLAR "nonpolar"

///Standard amount necessary to overdose on most chemicals
#define OVERDOSE_STANDARD 30
