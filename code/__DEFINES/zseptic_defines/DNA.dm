#define DNA_BLOCK_SIZE 6

#define DNA_HAIRSTYLE_BLOCK 1
#define DNA_HAIR_COLOR_BLOCK 2
#define DNA_FACIAL_HAIRSTYLE_BLOCK 3
#define DNA_FACIAL_HAIR_COLOR_BLOCK 4
#define DNA_LEFT_EYE_COLOR_BLOCK 5
#define DNA_RIGHT_EYE_COLOR_BLOCK 6
#define DNA_GENDER_BLOCK 7
#define DNA_SKIN_TONE_BLOCK 8
#define DNA_HEIGHT_BLOCK 9

#define DNA_UNI_IDENTITY_BLOCKS 9

#define DNA_LIZARD_MARKINGS_BLOCK 1
#define DNA_LIZARD_TAIL_BLOCK 2
#define DNA_MONKEY_TAIL_BLOCK 3
#define DNA_HUMAN_TAIL_BLOCK 4
#define DNA_WINGS_BLOCK 5
#define DNA_MOTH_WINGS_BLOCK 6
#define DNA_MOTH_ANTENNAE_BLOCK 7
#define DNA_SNOUT_BLOCK 8
#define DNA_HORNS_BLOCK 9
#define DNA_FRILLS_BLOCK 10
#define DNA_SPINES_BLOCK 11
#define DNA_EARS_BLOCK 12
#define DNA_MUSHROOM_CAPS_BLOCK 13

#define DNA_FEATURE_BLOCKS 13

#define DNA_MUTANT_COLOR_BLOCK 1
#define DNA_MUTANT_COLOR_2_BLOCK 2
#define DNA_MUTANT_COLOR_3_BLOCK 3
#define DNA_ETHEREAL_COLOR_BLOCK 4
#define DNA_SKIN_COLOR_BLOCK 5

#define DNA_MANDATORY_COLOR_BLOCKS 5

#define DNA_BLOCKS_PER_FEATURE 4
#define DNA_BLOCKS_PER_MARKING 2
#define DNA_BLOCKS_PER_MARKING_ZONE (1+(MAXIMUM_MARKINGS_PER_LIMB*DNA_BLOCKS_PER_MARKING))

// ~species traits
// we start from 28 to not interfere with TG species defines, should they add more
// We're using all three mutcolor features for our skin coloration
#define MUTCOLOR_MATRIXED 28
#define MUTCOLORS2 29
#define MUTCOLORS3 30
// Defines for whether an accessory should have one or three colors to choose for
#define USE_ONE_COLOR 31
#define USE_MATRIXED_COLORS	32
// Defines for robotic species
#define REVIVES_BY_HEALING 33
#define ROBOTIC_LIMBS 34
#define ROBOTIC_ORGANS 35
#define NOPAIN 36
#define NOHEART 37
#define NOLUNGS 38
#define NOLIVER 39
#define NOKIDNEYS 40
#define NOSPLEEN 41
#define NOINTESTINES 42
#define NOBLADDER 43
#define NOHORNY 44

#define MANDATORY_FEATURE_LIST list("mcolor" = "FFFFBB",\
								"mcolor2" = "FFFFBB",\
								"mcolor3" = "FFFFBB",\
								"ethcolor" = "FFCCCC",\
								"skin_color" = "FFEEDD",\
								"breasts_size" = BREASTS_DEFAULT_SIZE,\
								"breasts_lactation" = BREASTS_DEFAULT_LACTATION,\
								"penis_size" = PENIS_DEFAULT_LENGTH,\
								"penis_girth" = PENIS_DEFAULT_GIRTH,\
								"penis_taur_mode" = FALSE,\
								"penis_sheath" = SHEATH_NONE,\
								"penis_circumcised" = FALSE, \
								"balls_size" = BALLS_DEFAULT_SIZE,\
								"body_size" = BODY_SIZE_NORMAL,\
								"uses_skintones" = FALSE)

#define RANDOM_FEATURE_LIST list("mcolor" = "FFFFBB",\
								"mcolor2" = "FFFFBB",\
								"mcolor3" = "FFFFBB",\
								"ethcolor" = "FFCCCC",\
								"skin_color" = "FFEEDD",\
								"breasts_size" = BREASTS_DEFAULT_SIZE,\
								"breasts_lactation" = BREASTS_DEFAULT_LACTATION,\
								"penis_size" = PENIS_DEFAULT_LENGTH,\
								"penis_girth" = PENIS_DEFAULT_GIRTH,\
								"penis_taur_mode" = FALSE,\
								"penis_sheath" = SHEATH_NONE,\
								"balls_size" = BALLS_DEFAULT_SIZE,\
								"body_size" = BODY_SIZE_NORMAL,\
								"uses_skintones" = FALSE)

#define SPECIES_HUMANOID "humanoid"
#define SPECIES_SKRELL "skrell"
#define SPECIES_HOMIE "homie"
#define SPECIES_TENDONISHE "tendonishe"
#define SPECIES_WEREWOLF "werewolf"
#define SPECIES_WERECAT "werecat"
#define SPECIES_WEREBIRD "werebird"
#define SPECIES_MAMMAL "mammal"
#define SPECIES_AQUATIC "aquatic"
#define SPECIES_INSECT "insect"
#define SPECIES_SYNTHMAMMAL "synthmammal"
#define SPECIES_SYNTHLIZARD "synthlizard"
#define SPECIES_SYNTHHUMAN "synthhuman"
#define SPECIES_IPC "ipc"
#define SPECIES_INBORN "nagger"
#define SPECIES_WEAKWILLET "weakwillet"
#define SPECIES_HALBERMENSCH "halbermensch"
#define SPECIES_DENOMINATOR "combiners"

// ~body types
#define BODY_TYPE_MASCULINE MALE
#define BODY_TYPE_FEMININE FEMALE

#define FEMININE_BODY_TYPES list(BODY_TYPE_FEMININE)

/// Human height defines
#define HUMAN_HEIGHT_GNOME "gnome"
#define HUMAN_HEIGHT_SHORTEST "pocket king"
#define HUMAN_HEIGHT_SHORT "manlet"
#define HUMAN_HEIGHT_MEDIUM "normal"
#define HUMAN_HEIGHT_TALL "lanklet"
#define HUMAN_HEIGHT_TALLEST "manmore"
