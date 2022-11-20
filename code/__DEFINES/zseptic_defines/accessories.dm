// Some defines for sprite accessories
// Which color source we're using when the accessory is added
#define DEFAULT_PRIMARY 1	//Uses primary color
#define DEFAULT_SECONDARY 2 //Uses secondary color
#define DEFAULT_TERTIARY 3	//Uses tertiary color
#define DEFAULT_MATRIXED 4 //Uses all three colors for a matrix
#define DEFAULT_SKIN_OR_PRIMARY	5 //Uses skin tone color if the character uses one, otherwise primary color

// Defines for extra bits of accessories
#define COLOR_SRC_PRIMARY 1
#define COLOR_SRC_SECONDARY	2
#define COLOR_SRC_TERTIARY 3
#define COLOR_SRC_MATRIXED 4

// Defines for mutant bodyparts indexes
#define MUTANT_INDEX_NAME "name"
#define MUTANT_INDEX_COLOR "color"

// The color list that is passed to color matrixed things when a person is husked
#define HUSK_COLOR_LIST list(list(0.64, 0.64, 0.64, 0), list(0.64, 0.64, 0.64, 0), list(0.64, 0.64, 0.64, 0), list(0, 0, 0, 1))

// Defines for an accessory to be randomed
#define ACC_RANDOM "random"

// Maximum amount of markings a single limb may have
#define MAXIMUM_MARKINGS_PER_LIMB 5

// Preview types
#define PREVIEW_PREF_JOB "Job"
#define PREVIEW_PREF_NAKED "Naked"
#define PREVIEW_PREF_NAKED_AROUSED "Aroused"

// Body size defines
#define BODY_SIZE_NORMAL 1
#define BODY_SIZE_MAX 1
#define BODY_SIZE_MIN 1

// Underwear visibility
#define UNDERWEAR_HIDE_SOCKS (1<<0)
#define UNDERWEAR_HIDE_SHIRT (1<<1)
#define UNDERWEAR_HIDE_UNDIES (1<<2)
