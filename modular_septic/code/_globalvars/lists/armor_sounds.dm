GLOBAL_LIST_INIT(armor_sounds_damage, \
	list( \
		"heavy" = list( \
			CRUSHING = list('modular_septic/sound/armor/blunt_heavy1.ogg', 'modular_septic/sound/armor/blunt_heavy2.ogg', 'modular_septic/sound/armor/blunt_heavy3.ogg'), \
			PIERCING = list('modular_septic/sound/bullet/ricochet1.wav', 'modular_septic/sound/bullet/ricochet2.wav', 'modular_septic/sound/bullet/ricochet3.wav', 'modular_septic/sound/bullet/ricochet4.wav'), \
			CUTTING = list('modular_septic/sound/armor/stab_heavy1.ogg', 'modular_septic/sound/armor/stab_heavy2.ogg', 'modular_septic/sound/armor/stab_heavy1.ogg'), \
			IMPALING = list('modular_septic/sound/armor/chop_heavy1.ogg', 'modular_septic/sound/armor/chop_heavy2.ogg', 'modular_septic/sound/armor/chop_heavy1.ogg'), \
			), \
		"light" = list( \
			CRUSHING = list('modular_septic/sound/armor/light1.ogg', 'modular_septic/sound/armor/light2.ogg', 'modular_septic/sound/armor/light3.ogg'), \
			PIERCING = 'modular_septic/sound/bullet/bullet_light.ogg', \
			CUTTING = list('modular_septic/sound/armor/light1.ogg', 'modular_septic/sound/armor/light2.ogg', 'modular_septic/sound/armor/light3.ogg'), \
			IMPALING = list('modular_septic/sound/armor/light1.ogg', 'modular_septic/sound/armor/light2.ogg', 'modular_septic/sound/armor/light3.ogg'), \
			), \
		"heavy_helmet" = list( \
			CRUSHING = list('modular_septic/sound/armor/blunt_heavy1.ogg', 'modular_septic/sound/armor/blunt_heavy2.ogg', 'modular_septic/sound/armor/blunt_heavy3.ogg'), \
			PIERCING = list('modular_septic/sound/bullet/ricochet1.wav', 'modular_septic/sound/bullet/ricochet2.wav', 'modular_septic/sound/bullet/ricochet3.wav', 'modular_septic/sound/bullet/ricochet4.wav'), \
			CUTTING = list('modular_septic/sound/armor/stab_heavy1.ogg', 'modular_septic/sound/armor/stab_heavy2.ogg', 'modular_septic/sound/armor/stab_heavy1.ogg'), \
			IMPALING = list('modular_septic/sound/armor/chop_heavy1.ogg', 'modular_septic/sound/armor/chop_heavy2.ogg', 'modular_septic/sound/armor/chop_heavy1.ogg'), \
			), \
		) \
	)
GLOBAL_LIST_INIT(armor_sounds_damage_local, \
	list( \
		"heavy_helmet" = list( \
			CRUSHING = 'modular_septic/sound/armor/helmet_rape.wav', \
			PIERCING = 'modular_septic/sound/armor/helmet_rape.wav', \
			CUTTING = 'modular_septic/sound/armor/helmet_rape.wav', \
			IMPALING = 'modular_septic/sound/armor/helmet_rape.wav', \
			), \
		) \
	)
GLOBAL_LIST_INIT(armor_sounds_break, \
	list( \
		"heavy" = 'modular_septic/sound/armor/break_heavy1.wav', \
		"light" = list('modular_septic/sound/armor/break_light1.wav', 'modular_septic/sound/armor/break_light2.wav'), \
		"heavy_helmet" = 'modular_septic/sound/armor/break_heavy1.wav', \
		) \
	)
GLOBAL_LIST_INIT(armor_sounds_break_local, list() )
