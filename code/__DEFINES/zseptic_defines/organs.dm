// ~organ status var
///This organ is organic - It can get infected and heal damage over time
#define ORGAN_ORGANIC 1
///This organ is robotic - Affected by emps, doesn't get infected, doesn't heal damage over time
#define ORGAN_ROBOTIC 2

// ~organ organ_flags var
/// Frozen organ, doesn't rot
#define ORGAN_FROZEN (1<<0)
/// Failing organs don't work (duh) and might cause other ill effects
#define ORGAN_FAILING (1<<1)
/// Destroyed organs don't function and cannot be repaired, needs a transplant
#define ORGAN_DESTROYED (1<<2)
/// Not only is the organ failing, it is completely septic and spreading germs around
#define ORGAN_DEAD (1<<3)
/// Organ has been cut away from the owner and can be safely removed during surgery
#define ORGAN_CUT_AWAY (1<<4)
/// Currently only the brain - Removal of the organ will cause death to the owner
#define ORGAN_VITAL	(1<<5)
/// Organ is edible and uses the edible component
#define ORGAN_EDIBLE (1<<6)
/// Can be affected by EMPs - Organic or not
#define ORGAN_SYNTHETIC (1<<7)
/// Currently being affected by EMP effects
#define ORGAN_SYNTHETIC_EMP	(1<<8)
/// Does not rot nor get infected
#define ORGAN_NOINFECTION (1<<9)
/// Can't be removed via common means
#define ORGAN_UNREMOVABLE (1<<10)
/// Was this organ implanted/inserted/etc, if true will not be removed during species change
#define ORGAN_EXTERNAL (1<<11)
/// Organ cannot ever become destroyed beyond repair
#define ORGAN_INDESTRUCTIBLE (1<<12)
/// Organ should update limb efficiency when damaged or healed
#define ORGAN_LIMB_SUPPORTER (1<<13)
/// Organ shouldn't be counted in /obj/item/bodypart/proc/damage_internal_organs()
#define ORGAN_NO_VIOLENT_DAMAGE (1<<14)

/// How many toxins a single liver can hold
#define LIVER_MAX_TOXIN 50
/// How much toxin a single kidney can hold
#define KIDNEY_MAX_TOXIN 25

/// How much oxyloss a single lung can hold
#define LUNG_MAX_OXYLOSS 50

/// How much blood the spleen normally generates per second
#define BLOOD_REGEN_FACTOR	0.25

// ~kidney stuff
#define KIDNEY_DEFAULT_TOX_TOLERANCE 1.5 //amount of toxins a single kidney can filter out
#define KIDNEY_DEFAULT_TOX_LETHALITY 0.0025 //lower values lower how harmful toxins are to the kidneys

// ~toxin pain factors
#define LIVER_TOXIN_PAIN_FACTOR 1
#define KIDNEY_TOXIN_PAIN_FACTOR 0.5

//The contant in the rate of reagent transfer on life ticks
#define STOMACH_METABOLISM_CONSTANT 0.35

/// default organ maxHealth
#define STANDARD_ORGAN_THRESHOLD 60
/// designed to heal organs fully when left on a mob for ~4 minutes
#define STANDARD_ORGAN_HEALING 50 / 100000
/// designed to fail organs when left to decay for ~25 minutes
#define STANDARD_ORGAN_DECAY 100 / 100000

// ~should take around 20 minutes for a body to fully rot
#define MIN_ORGAN_DECAY_INFECTION 1
#define MAX_ORGAN_DECAY_INFECTION 2

/// Minimum organ damage at once to tell the player about the ouchie
#define ORGAN_DAMAGE_NOTIFY_PLAYER 3

// ~organ sides
#define NO_SIDE 0
#define RIGHT_SIDE (1<<0)
#define LEFT_SIDE (1<<1)

// ~organ slots
#define ORGAN_SLOT_BONE "bone"
#define ORGAN_SLOT_TENDON "tendon"
#define ORGAN_SLOT_NERVE "nerve"
#define ORGAN_SLOT_ARTERY "artery"
#define ORGAN_SLOT_ADAMANTINE_RESONATOR "adamantine resonator"
#define ORGAN_SLOT_APPENDIX "appendix"
#define ORGAN_SLOT_SPLEEN "spleen"
#define ORGAN_SLOT_BRAIN "brain"
#define ORGAN_SLOT_HEAD_AUG "head augment"
#define ORGAN_SLOT_BRAIN_ANTIDROP "brain antidrop"
#define ORGAN_SLOT_BRAIN_ANTISTUN "brain antistun"
#define ORGAN_SLOT_MOUTH_AUG "mouth device"
#define ORGAN_SLOT_BREATHING_TUBE "breathing tube"
#define ORGAN_SLOT_EARS "ear"
#define ORGAN_SLOT_EYES "eye"
#define ORGAN_SLOT_HEART "heart"
#define ORGAN_SLOT_HEART_AID "heart aid"
#define ORGAN_SLOT_HUD "eye hud"
#define ORGAN_SLOT_LIVER "liver"
#define ORGAN_SLOT_KIDNEYS "kidney"
#define ORGAN_SLOT_LUNGS "lung"
#define ORGAN_SLOT_ANUS "anus"
#define ORGAN_SLOT_PARASITE_EGG "parasite egg"
#define ORGAN_SLOT_REGENERATIVE_CORE "hivecore"
#define ORGAN_SLOT_ARM_AUG "arm augment"
#define ORGAN_SLOT_RIGHT_ARM_AUG "right arm augment"
#define ORGAN_SLOT_LEFT_ARM_AUG "left arm augment" //This one ignores alphabetical order cause the arms should be together
#define ORGAN_SLOT_STOMACH "stomach"
#define ORGAN_SLOT_STOMACH_AID "stomach aid"
#define ORGAN_SLOT_INTESTINES "intestines"
#define ORGAN_SLOT_BLADDER "bladder"
#define ORGAN_SLOT_CHEST_AUG "chest augment"
#define ORGAN_SLOT_NECK_AUG "neck augment"
#define ORGAN_SLOT_TAIL "tail"
#define ORGAN_SLOT_THRUSTERS "thrusters"
#define ORGAN_SLOT_TONGUE "tongue"
#define ORGAN_SLOT_VOICE "vocal cord"
#define ORGAN_SLOT_ZOMBIE "zombie infection"

// ~genital slots
#define ORGAN_SLOT_PENIS "penis"
#define ORGAN_SLOT_TESTICLES "testicles"
#define ORGAN_SLOT_VAGINA "vagina"
#define ORGAN_SLOT_WOMB "womb"
#define ORGAN_SLOT_BREASTS "breasts"
#define ORGAN_SLOT_ANUS "anus"

// ~xenomorph organ slots
#define ORGAN_SLOT_XENO_ACIDGLAND "acid_gland"
#define ORGAN_SLOT_XENO_EGGSAC "eggsac"
#define ORGAN_SLOT_XENO_HIVENODE "hive_node"
#define ORGAN_SLOT_XENO_NEUROTOXINGLAND "neurotoxin_gland"
#define ORGAN_SLOT_XENO_PLASMAVESSEL "plasma_vessel"
#define ORGAN_SLOT_XENO_RESINSPINNER "resin_spinner"

// ~organ slot external
#define ORGAN_SLOT_EXTERNAL_TAIL "tail"
#define ORGAN_SLOT_EXTERNAL_SPINES "spines"
#define ORGAN_SLOT_EXTERNAL_SNOUT "snout"
#define ORGAN_SLOT_EXTERNAL_FRILLS "frills"
#define ORGAN_SLOT_EXTERNAL_HORNS "horns"
#define ORGAN_SLOT_EXTERNAL_WINGS "wings"
#define ORGAN_SLOT_EXTERNAL_ANTENNAE "antennae"
#define ORGAN_SLOT_EXTERNAL_BODYMARKINGS "bodymarkings"

// ~bones
#define BONE_MAX_HEALTH 100

// ~bone flags
/// Can suffer dislocations
#define BONE_JOINTED (1<<0)
/// Encases the limb, providing protection to internal organs
#define BONE_ENCASING (1<<1)
/// Bone is crushed (dentbrain)
#define BONE_CRUSHED (1<<2)

#define BONE_HEAD /obj/item/organ/bone/head
#define BONE_MOUTH /obj/item/organ/bone/mouth
#define BONE_NECK /obj/item/organ/bone/neck
#define BONE_CHEST /obj/item/organ/bone/chest
#define BONE_GROIN /obj/item/organ/bone/groin
#define BONE_L_ARM /obj/item/organ/bone/l_arm
#define BONE_L_HAND	/obj/item/organ/bone/l_hand
#define BONE_R_ARM /obj/item/organ/bone/r_arm
#define BONE_R_HAND /obj/item/organ/bone/r_hand
#define BONE_L_LEG /obj/item/organ/bone/l_leg
#define BONE_L_FOOT /obj/item/organ/bone/l_foot
#define BONE_R_LEG /obj/item/organ/bone/r_leg
#define BONE_R_FOOT /obj/item/organ/bone/r_foot

#define BONE_HEAD_HALBER /obj/item/organ/bone/head/halber
#define BONE_MOUTH_HALBER /obj/item/organ/bone/mouth/halber
#define BONE_NECK_HALBER /obj/item/organ/bone/neck/halber
#define BONE_CHEST_HALBER /obj/item/organ/bone/chest/halber
#define BONE_GROIN_HALBER /obj/item/organ/bone/groin/halber
#define BONE_L_ARM_HALBER /obj/item/organ/bone/l_arm/halber
#define BONE_L_HAND_HALBER	/obj/item/organ/bone/l_hand/halber
#define BONE_R_ARM_HALBER /obj/item/organ/bone/r_arm/halber
#define BONE_R_HAND_HALBER /obj/item/organ/bone/r_hand/halber
#define BONE_L_LEG_HALBER /obj/item/organ/bone/l_leg/halber
#define BONE_L_FOOT_HALBER /obj/item/organ/bone/l_foot/halber
#define BONE_R_LEG_HALBER /obj/item/organ/bone/r_leg/halber
#define BONE_R_FOOT_HALBER /obj/item/organ/bone/r_foot/halber
// ~tendons
#define TENDON_MAX_HEALTH 100

#define TENDON_R_EYE /obj/item/organ/tendon/r_eye
#define TENDON_L_EYE /obj/item/organ/tendon/l_eye
#define TENDON_HEAD /obj/item/organ/tendon/head
#define TENDON_MOUTH /obj/item/organ/tendon/mouth
#define TENDON_NECK /obj/item/organ/tendon/neck
#define TENDON_CHEST /obj/item/organ/tendon/chest
#define TENDON_VITALS /obj/item/organ/tendon/vitals
#define TENDON_GROIN /obj/item/organ/tendon/groin
#define TENDON_L_ARM /obj/item/organ/tendon/l_arm
#define TENDON_L_HAND /obj/item/organ/tendon/l_hand
#define TENDON_R_ARM /obj/item/organ/tendon/r_arm
#define TENDON_R_HAND /obj/item/organ/tendon/r_hand
#define TENDON_L_LEG /obj/item/organ/tendon/l_leg
#define TENDON_L_FOOT /obj/item/organ/tendon/l_foot
#define TENDON_R_LEG /obj/item/organ/tendon/r_leg
#define TENDON_R_FOOT /obj/item/organ/tendon/r_foot

// ~nerves
#define NERVE_MAX_HEALTH 100

#define NERVE_L_EYE /obj/item/organ/nerve/l_eye
#define NERVE_R_EYE /obj/item/organ/nerve/r_eye
#define NERVE_HEAD /obj/item/organ/nerve/head
#define NERVE_MOUTH /obj/item/organ/nerve/mouth
#define NERVE_NECK /obj/item/organ/nerve/neck
#define NERVE_CHEST /obj/item/organ/nerve/chest
#define NERVE_VITALS /obj/item/organ/nerve/vitals
#define NERVE_GROIN	/obj/item/organ/nerve/groin
#define NERVE_L_ARM /obj/item/organ/nerve/l_arm
#define NERVE_L_HAND /obj/item/organ/nerve/l_hand
#define NERVE_R_ARM	/obj/item/organ/nerve/r_arm
#define NERVE_R_HAND /obj/item/organ/nerve/r_hand
#define NERVE_L_LEG	/obj/item/organ/nerve/l_leg
#define NERVE_L_FOOT /obj/item/organ/nerve/l_foot
#define NERVE_R_LEG /obj/item/organ/nerve/r_leg
#define NERVE_R_FOOT /obj/item/organ/nerve/r_foot

// ~arteries
#define ARTERY_MAX_HEALTH 100
#define ARTERIAL_BLOOD_FLOW 3

#define ARTERY_L_EYE /obj/item/organ/artery/l_eye
#define ARTERY_R_EYE /obj/item/organ/artery/r_eye
#define ARTERY_HEAD /obj/item/organ/artery/head
#define ARTERY_MOUTH /obj/item/organ/artery/mouth
#define ARTERY_NECK /obj/item/organ/artery/neck
#define ARTERY_CHEST /obj/item/organ/artery/chest
#define ARTERY_VITALS /obj/item/organ/artery/vitals
#define ARTERY_GROIN /obj/item/organ/artery/groin
#define ARTERY_L_ARM /obj/item/organ/artery/l_arm
#define ARTERY_L_HAND /obj/item/organ/artery/l_hand
#define ARTERY_R_ARM /obj/item/organ/artery/r_arm
#define ARTERY_R_HAND /obj/item/organ/artery/r_hand
#define ARTERY_L_LEG /obj/item/organ/artery/l_leg
#define ARTERY_L_FOOT /obj/item/organ/artery/l_foot
#define ARTERY_R_LEG /obj/item/organ/artery/r_leg
#define ARTERY_R_FOOT /obj/item/organ/artery/r_foot

// ~efficiency defines
#define ORGAN_OPTIMAL_EFFICIENCY 100
#define ORGAN_BRUISED_EFFICIENCY 80
#define ORGAN_FAILING_EFFICIENCY 50
#define ORGAN_DESTROYED_EFFICIENCY 0

// ~organ failure defines
/// Amount of seconds before liver failure reaches a new stage
#define LIVER_FAILURE_STAGE_SECONDS 60

// ~organ requirements
/// Normally 50% of the default blood volume (230cl)
#define DEFAULT_TOTAL_BLOOD_REQ	BLOOD_VOLUME_NORMAL * 0.5
#define DEFAULT_TOTAL_OXYGEN_REQ 50
#define DEFAULT_TOTAL_NUTRIMENT_REQ	HUNGER_FACTOR
#define DEFAULT_TOTAL_HYDRATION_REQ THIRST_FACTOR

// ~simple list of organs that come in pairs
#define PAIRED_ORGAN_SLOTS list(ORGAN_SLOT_LUNGS, \
							ORGAN_SLOT_KIDNEYS, \
							ORGAN_SLOT_EYES, \
							ORGAN_SLOT_EARS)
