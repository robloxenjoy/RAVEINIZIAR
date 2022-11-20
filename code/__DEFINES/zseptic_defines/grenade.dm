/// The grenade is operated via a pin.
#define	GRENADE_PINNED (1<<0)
/// The grenade is operated via a button (Removes the spoon instantly)
#define	GRENADE_BUTTONED (1<<1)
/// The grenade is a dynamite/pipebomb type. Operated by fuse (Removes the spoon instantly)
#define	GRENADE_FUSED (1<<2)
/// The grenade starts It's spoon timer when it hits the floor, rather then when It is thrown.
#define GRENADE_IMPACT (1<<3)
/// Defines if the grenade has a visible spoon (our overlay)
#define GRENADE_VISIBLE_SPOON (1<<4)
/// Defines if the grenade has a visible pin (our overlay)
#define GRENADE_VISIBLE_PIN (1<<5)
/// Defines if the grenade has a visible button (our overlay)
#define	GRENADE_VISIBLE_BUTTON (1<<6)
/// Defines if the grenade is not triggered in the conventional sence. Nullifies all flags
#define GRENADE_UNCONVENTIONAL_TRIGGER (1<<7)
