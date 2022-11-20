// ~flags for /obj/item/cellphone phone_flags variable
/// Phone can be flipped open/closed
#define PHONE_FLIPHONE (1<<0)
/// Phone should not have overlays when flipped closed
#define PHONE_NO_UNFLIPPED_SCREEN (1<<1)
/// Phone currently has an input menu open
#define PHONE_RECEIVING_INPUT (1<<2)
/// Phone is being factory reset
#define PHONE_RESETTING (1<<3)
/// Phone is glitching the fuck out
#define PHONE_GLITCHING (1<<4)
/// Phone is being mindjacked
#define PHONE_MINDJACKED (1<<5)

// states for connection_state on cellphones
/// Nothing happening
#define CONNECTION_NONE 0
/// Phone is calling connected_phone
#define CONNECTION_CALLING 1
/// Phone is being called by connected_phone
#define CONNECTION_BEING_CALLED 2
/// Phone is in active call with connected_phone
#define CONNECTION_ACTIVE_CALL 3
