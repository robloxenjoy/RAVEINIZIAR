// ~return values for the how_open() proc
#define SURGERY_INCISED (1<<0)
#define SURGERY_RETRACTED (1<<1)
#define SURGERY_DISLOCATED (1<<2)
#define SURGERY_BROKEN (1<<3)
#define SURGERY_DRILLED (1<<4)

// ~flags for requirements for a surgery step
#define STEP_NEEDS_INCISED (1<<0)
#define STEP_NEEDS_NOT_INCISED (1<<1)
#define STEP_NEEDS_RETRACTED (1<<2)
#define STEP_NEEDS_DISLOCATED (1<<3)
#define STEP_NEEDS_BROKEN (1<<4)
#define STEP_NEEDS_DRILLED (1<<5)
#define STEP_NEEDS_ENCASED (1<<6)

#define SURGERY_SUCCESS TRUE
#define SURGERY_FAILURE FALSE
