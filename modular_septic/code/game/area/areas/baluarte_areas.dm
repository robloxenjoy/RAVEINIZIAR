/area/service/janitor
	name = "\improper Public Custodial Area"

/area/hallway/entrance
	name = "\improper Outpost Entrance"
	icon_state = "hallA"

/area/hallway/train_station
	name = "\improper Train Station"
	icon_state = "hallF"

/area/hallway/train_station/janitorial_supplies
	name = "\improper Train Station Janitorial Supplies"

/area/hallway/train_station/emergency_supplies
	name = "\improper Train Station Emergency Supplies"

/area/hallway/train_station/arrival
	name = "\improper Arrival Station"
	icon_state = "hallF"

/area/hallway/train_station/path
	name = "\improper Train Path"
	icon_state = "hallP"

/area/sky
	name = "\improper Sky"
	icon_state = "hallS"

/area/hallway/streets
	name = "\improper Streets"
	icon_state = "hallS"
	droning_sound = DRONING_CONCORDIA
	droning_volume = 65
	ambience_index = AMBIENCE_GENERIC

/area/commons
	ambience_index = AMBIENCE_GENERIC

/area/commons/dorms
	ambience_index = AMBIENCE_MAINT

/area/commons/dorms/lower
	name = "Lower Dormitories"

/area/commons/dorms/upper
	name = "Upper dormitories"

/area/commons/detroit
	name = "detroit"

/area/commons/detroit/lower
	name = "Lower detroit"

/area/commons/detroit/upper
	name = "Upper detroit"

/area/commons/detroit/dormitories
	name = "detroit dormitories"

/area/maintenance/lift
	name = "\proper Central Lift"
	icon_state = "maintcentral"
	droning_sound = DRONING_LIFT

/area/maintenance/pitofdespair
	name = "\proper PIT OF DESPAIR"
	icon_state = "showroom"
	droning_sound = DRONING_PITOFDESPAIR

/area/maintenance/liminal/intro
	name = "Liminal Introduction"
	icon_state = "introduction"
	icon = 'modular_septic/icons/turf/areas.dmi'
	droning_sound = DRONING_LIMINALINTRO

/area/engineering/greed
	name = "\improper Greed Engine"
	icon_state = "engine_sm"
	area_flags = BLOBS_ALLOWED | UNIQUE_AREA | CULT_PERMITTED
	sound_environment = SOUND_AREA_LARGE_ENCLOSED

/area/engineering/caving_equipment
	name = "Caving Equipment"
	icon_state = "engine"
