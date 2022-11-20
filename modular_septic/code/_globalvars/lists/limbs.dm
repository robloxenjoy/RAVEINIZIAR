GLOBAL_LIST_INIT(bodyparts, setup_bodyparts())
GLOBAL_LIST_INIT(bodyparts_by_zone, setup_bodyparts_by_zone())
GLOBAL_LIST_INIT(bodyzone_to_parent, setup_bodyzone_to_parent_bodyzone())
GLOBAL_LIST_INIT(bodyzone_to_bitflag, setup_bodyzone_to_bitflag())
GLOBAL_LIST_INIT(bitflag_to_bodyzone, setup_bitflag_to_bodyzone())
GLOBAL_LIST_INIT(bodyzone_to_children, setup_bodyzone_to_parent_bodyzone())
GLOBAL_LIST_INIT(bodyzone_to_relative_size, list(BODY_ZONE_PRECISE_R_EYE = 1,
												BODY_ZONE_PRECISE_L_EYE = 1,
												BODY_ZONE_PRECISE_FACE = 10,
												BODY_ZONE_PRECISE_MOUTH = 10,
												BODY_ZONE_HEAD = 10,
												BODY_ZONE_PRECISE_NECK = 10,
												BODY_ZONE_CHEST = 50,
												BODY_ZONE_PRECISE_VITALS = 30,
												BODY_ZONE_PRECISE_GROIN = 30,
												BODY_ZONE_L_ARM = 20,
												BODY_ZONE_PRECISE_L_HAND = 10,
												BODY_ZONE_R_ARM = 20,
												BODY_ZONE_PRECISE_R_HAND = 10,
												BODY_ZONE_L_LEG = 25,
												BODY_ZONE_PRECISE_L_FOOT = 5,
												BODY_ZONE_R_LEG = 25,
												BODY_ZONE_PRECISE_R_FOOT = 5,
												))
