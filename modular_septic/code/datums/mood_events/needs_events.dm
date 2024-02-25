//hydration
/datum/mood_event/thirsty
	description = span_warning("Попить бы.")
	mood_change = -4

/datum/mood_event/dehydrated
	description = span_boldwarning("Я обезвожен!")
	mood_change = -6

//nutrition
/datum/mood_event/hungry
	description = span_warning("Я голоден...")
	mood_change = -4

/datum/mood_event/starving
	description = span_warning("Я голодаю!")
	mood_change = -6

//urination
/datum/mood_event/needpiss
	description = span_warning("Мне нужно поссать.")
	mood_change = -3

/datum/mood_event/reallyneedpiss
	description = span_boldwarning("Мой мочевой пузырь лопнет!")
	mood_change = -5

/datum/mood_event/pissed_self
	description = span_necrosis("Я тупо себя обоссал сука.")
	mood_change = -8
	timeout = 10 MINUTES

//defecation
/datum/mood_event/needshit
	description = span_warning("Мне нужно посрать.")
	mood_change = -3

/datum/mood_event/reallyneedshit
	description = span_boldwarning("Пора <b>СРАТЬ!</b>")
	mood_change = -5

/datum/mood_event/shat_self
	description = span_necrosis("Я просто обосрал себя.")
	mood_change = -8
	timeout = 10 MINUTES

//hygiene
/datum/mood_event/clean
	description = span_nicegreen("Я такой чистый!")
	mood_change = 2

/datum/mood_event/needshower
	description = span_warning("Мне нужно помыться.")
	mood_change = -2

/datum/mood_event/reallyneedshower
	description = span_infection("Я грязный.")
	mood_change = -4

/datum/mood_event/smashplayer
	description = span_necrosis("Вонь конечно блять...")
	mood_change = -6

//sex!
/datum/mood_event/goodsex
	description = span_nicegreen("ВОТ ЭТО было заебись.")
	mood_change = 4
	timeout = 3 MINUTES

/datum/mood_event/goodmasturbation
	description = span_nicegreen("А это было нормально.")
	mood_change = 2
	timeout = 3 MINUTES

/datum/mood_event/needsex
	description = span_love("Я чувствую возбуждение.")
	mood_change = -2

/datum/mood_event/reallyneedsex
	description = span_userlove("Нужно ТРАХНУТЬСЯ!")
	mood_change = -4
