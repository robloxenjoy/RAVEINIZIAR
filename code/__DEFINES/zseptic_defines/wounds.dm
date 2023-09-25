
// ~wound damage/rolling defines
/// the cornerstone of the wound threshold system, your base wound roll for any attack is rand(1, damage^this), after armor reduces said damage. See [/obj/item/bodypart/proc/check_wounding]
#define WOUND_DAMAGE_EXPONENT 1.4
/// any damage dealt over this is ignored for damage rolls unless the target has the frail quirk (50^1.4=250)
#define WOUND_MAX_CONSIDERED_DAMAGE 50
/// an attack must do this much damage after armor in order to roll for being a wound (so pressure damage/being on fire doesn't proc it)
#define WOUND_MINIMUM_DAMAGE 5
/// an attack must do this much damage after armor in order to be eliigible to dismember a suitably mushed bodypart
#define DISMEMBER_MINIMUM_DAMAGE 13
/// If an attack rolls this high with their wound (including mods), we try to outright dismember the limb. Note 250 is incredibly hard to reach even with the maximum damage! (1/250 chance)
#define WOUND_DISMEMBER_OUTRIGHT_THRESH 250
/// If a limb has mangled flesh, these wounds are more likely to happen
#define BODYPART_MANGLED_FLESH_AFFECTED_WOUNDS list(WOUND_ARTERY, WOUND_TENDON)
/// If a limb has mangled flesh, then apply this modifier to wound rolls
#define BODYPART_MANGLED_FLESH_MODIFIER 15
/// If a limb has pulped flesh, then apply this modifier to wound rolls
#define BODYPART_PULPED_FLESH_MODIFIER 15
/// set wound_bonus on an item or attack to this to disable checking wounding for the attack
#define CANT_WOUND -100

/// an attack must do this much damage after armor to roll for artery wounds
#define ARTERY_MINIMUM_DAMAGE 10
/// ditto but for tendon wounds
#define TENDON_MINIMUM_DAMAGE 10
/// ditto but for nerve wounds
#define NERVE_MINIMUM_DAMAGE 15
/// ditto but for internal organ damage
#define ORGAN_MINIMUM_DAMAGE 12.5
/// ditto but for teeth
#define TEETH_MINIMUM_DAMAGE 15
/// ditto but for kids named finger
#define DIGITS_MINIMUM_DAMAGE 8
/// ditto but for spills
#define SPILL_MINIMUM_DAMAGE 15

/// set wound_bonus on an item or attack to this to disable organ damage for the attack
#define CANT_ORGAN -100

// ~wound severities
/// for jokey/meme wounds like stubbed toe, no standard messages/sounds or second winds
#define WOUND_SEVERITY_TRIVIAL 0
#define WOUND_SEVERITY_MODERATE 1
#define WOUND_SEVERITY_SEVERE 2
#define WOUND_SEVERITY_CRITICAL 3
/// outright dismemberment of limb
#define WOUND_SEVERITY_LOSS 4

// ~wound categories
/// doesn't actually wound
#define WOUND_NONE 0
/// any brute weapon/attack that doesn't have sharpness - rolls for blunt bone wounds
#define WOUND_BLUNT 1
/// any sharp weapon, edged or pointy, can cause arteries to be torn
#define WOUND_ARTERY 2
/// any sharp weapon, edged or pointy, can cause tendons to be torn
#define WOUND_TENDON 3
/// any sharp weapon, edged or pointy, can cause nerves to be torn
#define WOUND_NERVE 4
/// britification lol
#define WOUND_TEETH 5
/// fingers or toes
#define WOUND_DIGITS 6
/// any kind of organ spilling
#define WOUND_SPILL 7
/// any brute weapon/attack with sharpness = SHARP_EDGED. rolls for slash wounds
#define WOUND_SLASH 8
/// any brute weapon/attack with sharpness = SHARP_POINTY. rolls for piercing wounds
#define WOUND_PIERCE 9
/// any concentrated burn attack (lasers really). rolls for burning wounds
#define WOUND_BURN 10

// ~determination second wind defines
// How much determination reagent to add each time someone gains a new wound in [/datum/wound/proc/second_wind]
#define WOUND_DETERMINATION_MODERATE 1
#define WOUND_DETERMINATION_SEVERE 2.5
#define WOUND_DETERMINATION_CRITICAL 5
#define WOUND_DETERMINATION_LOSS 7.5

/// the max amount of determination you can have
#define WOUND_DETERMINATION_MAX 10

/// While someone has determination in their system, their bleed rate is slightly reduced
#define WOUND_DETERMINATION_BLEED_MOD 0.85

// ~infection defines
// Thresholds for infection for injuries, limbs and organs - once germ_level hits each threshold, things get steadily worse
/// below this has no ill effects from infection
#define WOUND_INFECTION_MODERATE 250
/// then below here, you ooze some pus and suffer minor tox damage, but nothing serious
#define WOUND_INFECTION_SEVERE 330
/// then below here, your limb occasionally locks up from damage and infection and briefly becomes disabled. Things are getting really bad
#define WOUND_INFECTION_CRITICAL 600
/// below here, your skin is almost entirely falling off and your limb locks up more frequently. You are within a stone's throw of septic paralysis and losing the limb
#define WOUND_INFECTION_SEPTIC 1000
// above WOUND_INFECTION_SEPTIC, your limb is completely putrid and you start rolling to lose the entire limb by way of paralyzation. After 3 failed rolls (~4-5% each probably), the limb is paralyzed

// ~wound global lists
// list in order of highest severity to lowest
GLOBAL_LIST_INIT(global_wound_types, list(\
	WOUND_BLUNT = list(/datum/wound/blunt/critical, /datum/wound/blunt/severe, /datum/wound/blunt/moderate),
	WOUND_ARTERY = list(/datum/wound/artery/dissect, /datum/wound/artery/tear),
	WOUND_TENDON = list(/datum/wound/tendon/dissect, /datum/wound/tendon/tear),
	WOUND_NERVE = list(/datum/wound/nerve/dissect, /datum/wound/nerve/tear),
	WOUND_TEETH = list(/datum/wound/teeth),
	WOUND_DIGITS = list(/datum/wound/digits),
	WOUND_SPILL = list(/datum/wound/spill/brain, /datum/wound/spill/gut, /datum/wound/spill/eyes)))

// every single type of wound that can be rolled naturally, in case you need to pull a random one
GLOBAL_LIST_INIT(global_all_wound_types, \
	list(/datum/wound/blunt/critical, \
	/datum/wound/blunt/severe, \
	/datum/wound/blunt/moderate, \
	/datum/wound/artery/dissect, \
	/datum/wound/artery/tear,
	/datum/wound/tendon/dissect, \
	/datum/wound/tendon/tear,
	/datum/wound/nerve/dissect, \
	/datum/wound/nerve/tear, \
	/datum/wound/teeth, \
	/datum/wound/digits, \
	/datum/wound/spill/brain, \
	/datum/wound/spill/eyes, \
	/datum/wound/spill/gut))

// ~random wound balance defines
/// how quickly sanitization removes infestation and decays per second
#define WOUND_INFECTION_SANITIZATION_RATE 10
/// sanitization for each point in the antibiotic chem effect
#define WOUND_SANITIZATION_PER_ANTIBIOTIC 1
/// how much sterilizer sanitizes a wound
#define WOUND_SANITIZATION_STERILIZER 100
/// how much we seep gauze per life tick
#define WOUND_INFECTION_SEEP_RATE 0.15
/// how much blood you can lose per second per slash max. 4 is a LOT of blood for one cut so don't worry about hitting it easily
#define WOUND_SLASH_MAX_BLOODFLOW 4
/// dead people don't bleed, but they can clot! this is the minimum amount of clotting per tick on dead people, so even critical cuts will slowly clot in dead people
#define WOUND_SLASH_DEAD_CLOT_MIN 0.025
/// if we suffer a bone wound to the head that creates brain traumas, the timer for the trauma cycle is +/- by this percent (0-100)
#define WOUND_BONE_HEAD_TIME_VARIANCE 20

// ~mangling defines
// With the wounds pt. 2 update, general dismemberment now requires 2 things for a limb to be dismemberable (bone only creatures just need the second):
// 1. Skin is mangled: A critical slash or pierce wound on that limb
// 2. Bone is mangled: At least a severe bone wound on that limb
// see [/obj/item/bodypart/proc/get_mangled_state] for more information
#define BODYPART_MANGLED_NONE 0
#define BODYPART_MANGLED_BONE 1
#define BODYPART_MANGLED_FLESH 2
#define BODYPART_MANGLED_BOTH 3

// ~biology defines
// What kind of biology we have, and what wounds we can suffer, mostly relies on the HAS_FLESH and HAS_BONE species traits on human species
/// golems and androids, cannot suffer any wounds
#define BIO_INORGANIC 0
/// skeletons and plasmemes, can only suffer bone wounds, only needs mangled bone to be able to dismember
#define BIO_JUST_BONE 1
/// nothing right now, maybe slimepeople in the future, can only suffer slashing, piercing, and burn wounds
#define BIO_JUST_FLESH 2
/// standard humanoids, can suffer all wounds, needs mangled bone and flesh to dismember. conveniently, what you get when you combine BIO_JUST_BONE and BIO_JUST_FLESH
#define BIO_FLESH_BONE 3

// ~wound flag defines
/// This wound creates sounds hints when applied
#define WOUND_SOUND_HINTS (1<<0)
/// The wound gets treated before others
#define WOUND_PRIORITY (1<<1)
/// If having this wound counts as mangled flesh for dismemberment
#define WOUND_MANGLES_FLESH (1<<3)
/// If having this wound counts as mangled bone for dismemberment
#define WOUND_MANGLES_BONE (1<<4)
/// This wound is visible even under clothing
#define WOUND_VISIBLE_THROUGH_CLOTHING (1<<5)
/// This wound does an injection check before being treated
#define WOUND_INJECT_CHECK (1<<6)
/// Stumps can be affected by this wound
#define WOUND_ACCEPTS_STUMP (1<<7)
/// The wound can stack with others of the same type
#define WOUND_STACKABLE (1<<8)

// ~injury flags
/// This injury creates sounds hints when applied
#define INJURY_SOUND_HINTS (1<<0)
/// This injury is bandaged and won't bleed
#define INJURY_BANDAGED (1<<1)
/// This injury is sutured and won't bleed
#define INJURY_SUTURED (1<<2)
/// This injury is clamped and won't bleed
#define INJURY_CLAMPED (1<<3)
/// This injury is salved, and the infection won't progress
#define INJURY_SALVED (1<<4)
/// This injury is disinfected, and the infection has been wiped AND won't progress
#define INJURY_DISINFECTED (1<<5)
/// This is a surgical injury and will not autoheal
#define INJURY_SURGICAL (1<<6)
/// This injury is retracted and gives access to people's yummy guts and bones
#define INJURY_RETRACTED (1<<7)
/// This injury has been drilled and will let you put stuff in a cavity (dental implants and cavity implants)
#define INJURY_DRILLED (1<<8)
/// The bones have been set in this injury and are waiting to be gelled
#define INJURY_SET_BONES (1<<9)

// ~scar persistence defines
// The following are the order placements for persistent scar save formats
/// The version number of the scar we're saving, any scars being loaded below this number will be discarded, see SCAR_CURRENT_VERSION below
#define SCAR_SAVE_VERS 1
/// The body_zone we're applying to on granting
#define SCAR_SAVE_ZONE 2
/// The description we're loading
#define SCAR_SAVE_DESC 3
/// The precise location we're loading
#define SCAR_SAVE_PRECISE_LOCATION 4
/// The severity the scar had
#define SCAR_SAVE_SEVERITY 5
/// Whether this is a BIO_JUST_BONE scar, a BIO_JUST_FLESH scar, or a BIO_FLESH_BONE scar (so you can't load fleshy human scars on a plasmaman character)
#define SCAR_SAVE_BIOLOGY 6
/// Which character slot this was saved to
#define SCAR_SAVE_CHAR_SLOT 7
///how many fields we save for each scar (so the number of above fields)
#define SCAR_SAVE_LENGTH 7

/// saved scars with a version lower than this will be discarded, increment when you update the persistent scarring format in a way that invalidates previous saved scars (new fields, reordering, etc)
#define SCAR_CURRENT_VERSION 3
/// how many scar slots, per character slot, we have to cycle through for persistent scarring, if enabled in character prefs
#define PERSISTENT_SCAR_SLOTS 3

// ~blood_flow rates of change, these are used by [/datum/wound/proc/get_bleed_rate_of_change] from [/mob/living/carbon/proc/bleed_warn] to let the player know if their bleeding is getting better/worse/the same
/// Our wound is clotting and will eventually stop bleeding if this continues
#define BLOOD_FLOW_DECREASING -1
/// Our wound is bleeding but is holding steady at the same rate.
#define BLOOD_FLOW_STEADY 0
/// Our wound is bleeding and actively getting worse, like if we're a critical slash or if we're afflicted with heparin
#define BLOOD_FLOW_INCREASING 1

/// How often can we annoy the player about their bleeding? This duration is extended if it's not serious bleeding
#define BLEEDING_MESSAGE_BASE_CD 15 SECONDS
