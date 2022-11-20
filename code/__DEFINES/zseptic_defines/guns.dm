/**
 * Gun has no moving bolt mechanism, it cannot be racked, but can be broken open.
 * Example: Break action shotguns, revolvers
 */
#define BOLT_TYPE_BREAK_ACTION 5

// ~safety flags
/// Gun has a safety system
#define GUN_SAFETY_HAS_SAFETY (1<<0)
/// The safety is currently enabled
#define GUN_SAFETY_ENABLED (1<<1)
/// Gun has an overlay for enabled safety
#define GUN_SAFETY_OVERLAY_ENABLED (1<<2)
/// Gun has an overlay for disabled safety
#define GUN_SAFETY_OVERLAY_DISABLED (1<<3)
/// Trying to beat someone while the gun is unsafe will not attempt to fire a round
#define GUN_SAFETY_NO_FLOGGING (1<<4)

#define GUN_SAFETY_FLAGS_DEFAULT (GUN_SAFETY_HAS_SAFETY|GUN_SAFETY_ENABLED)
