/*Система распределения звуковых каналов во время игры

Тут будет список всех зарезервированных каналов

1 - ticker.dm, preferences.dm, лобби саунд
2 - playsound.dm, глобал и локал админ саунды
3 - turnrable.dm, джукбокс
4-11 - blowout.dm, звуки для выброса
12-14 - weather.dm, звуки дождя
15-18 - ambient.dm, звуки эмбиента
19-20 - campfire.dm, звуки костра
21 - cars.dm, звуки грузовичка
22-30 - simulated.dm, звуки шагов
31 - life.dm, звук дыхания хумана
32 - geiger_counter.dm, звук счетчика гейгера
33 - sounded.dm, шум бара
34 - dyatel.dm, шум дятла(аномалия)
35 - guards.dm, фраза

Так же в файле sounded.dm присваиюватся дальнейшие каналы, но уже автоматически

*/
SUBSYSTEM_DEF(channels)
	name = "Channels management"
	flags = SS_NO_FIRE

	var/list/reserved_channels = list()
	var/list/channels = list()

//datum/controller/subsystem/channels/stat_entry()
//	..("CH:[channels.len]")

/datum/controller/subsystem/channels/proc/get_reserved_channel(forced_channel = 0)
	if(forced_channel)
		if(!reserved_channels[num2text(forced_channel)])
			reserved_channels[num2text(forced_channel)] = 1
		return forced_channel
	for(var/i = 1 to 124)
		if(!reserved_channels["[i]"])
			reserved_channels["[i]"] = 1
			return i

/datum/controller/subsystem/channels/proc/get_channel(time_till_remove)
	for(var/i = 125 to 1024)
		if(!channels["[i]"])
			channels["[i]"] = 1
			spawn(time_till_remove)
				channels.Remove("[i]")
			return i