//Went to funkytown
/datum/mood_event/face_off
	description = span_necrosis("Ёб твою мать, У МЕНЯ НЕТ ЛИЦА!")
	mood_change = -5
	timeout = 0

//Turned into a brain
/datum/mood_event/freakofnature
	description = span_warning("ГДЕ МОЁ ТЕЛО?!")
	mood_change = -15
	timeout = 10 MINUTES

//Cringe filter
/datum/mood_event/cringe
	description = span_boldwarning("Я такой идиот.")
	mood_change = -4
	timeout = 5 MINUTES

/datum/mood_event/ultracringe
	description = span_boldwarning("Какой же я еблан!")
	mood_change = -8
	timeout = 15 MINUTES

//Pain mood
/datum/mood_event/painbad
	description = span_danger("Я чувствую много боли!")
	mood_change = -6
	timeout = 3 MINUTES

//Saw a badly injured crewmember
/datum/mood_event/saw_injured
	description = span_danger("Я видел омрачняющие вещи!")
	mood_change = -3
	timeout = 5 MINUTES

/datum/mood_event/saw_injured/lesser
	mood_change = -1
	timeout = 5 MINUTES

//Saw a crewmember die

/datum/mood_event/saw_dead
	description = span_dead("Я видел умирающее существо...")
	mood_change = -5
	timeout = 10 MINUTES

/datum/mood_event/saw_dead/lesser
	description = span_dead("Ну, я видел умирающее существо.")
	mood_change = -2
	timeout = 5 MINUTES

/datum/mood_event/saw_dead/good
	description = span_dead("Я видел умирающее существо, круто!")
	mood_change = 2
	timeout = 5 MINUTES

/datum/mood_event/saw_dead/friend
	description = span_dead("Я видел умирающего товарища...")
	mood_change = -5
	timeout = 10 MINUTES

//Died
/datum/mood_event/died
	description = span_dead("<b>Я знаю что такое НИЧЕГО.</b>")
	mood_change = -6
	timeout = 10 MINUTES

//Bad smell
/datum/mood_event/miasma
	description = span_warning("Пахнет пиздецом!")
	mood_change = -3
	timeout = 2 MINUTES

/datum/mood_event/miasma/harsh
	description = span_danger("Пахнет пиздецом ебанутым!")
	mood_change = -6

/datum/mood_event/shit
	description = span_warning("Пахнет говном!")
	mood_change = -3
	timeout = 2 MINUTES

/datum/mood_event/shit/harsh
	description = span_danger("Пахнет блять говном!")
	mood_change = -6

/datum/mood_event/retarded
	description = span_warning("Какой-то хуйнёй пахнет!")
	mood_change = -2
	timeout = 2 MINUTES

/datum/mood_event/retarded/harsh
	description = span_danger("Какой-то блять хуйнёй пахнет!")
	mood_change = -4

//WORST smell
/datum/mood_event/incredible_gas
	description = span_infection("Пахнет опасно!")
	mood_change = -4
	timeout = 1 MINUTES

/datum/mood_event/incredible_gas/harsh
	description = span_infection("Ебануто пахнет!")
	mood_change = -8

/datum/mood_event/urinepoo_gas
	description = span_infection("Пахнет какой-то хуйнёй!")
	mood_change = -5
	timeout = 1 MINUTES

/datum/mood_event/urinepoo_gas/harsh
	description = span_infection("ОТВРАТИТЕЛЬНО! ПАХНЕТ ПРОСТО ОТВРАТИТЕЛЬНО!")
	mood_change = -9

/datum/mood_event/sleeptime_gas
	description = span_infection("Пахнет уютненько.")
	mood_change = 1
	timeout = 1 MINUTES

/datum/mood_event/sleeptime_gas/harsh
	description = span_infection("Какой хороший запах...")
	mood_change = 2

/datum/mood_event/vilir
	description = span_infection("I AM PETTY! I FEEL COLOSSAL ATROCITY!")
	mood_change = -3
	timeout = 1 MINUTES

/datum/mood_event/vilir/harsh
	description = span_infection("THE FIRST CREATOR!!!!")
	mood_change = -6

//Ate shit
/datum/mood_event/creampie/shitface
	description = span_infection("Моё лицо в говне.")
	mood_change = -2
	timeout = 10 MINUTES

//Gun pointed at us
/datum/mood_event/gunpoint
	description = span_userdanger("На Меня... Наставлено оружие!")
	mood_change = -4

//Embedded thing
/datum/mood_event/embedded
	description = span_userdanger("Во мне застряло что-то!")
	mood_change = -4
