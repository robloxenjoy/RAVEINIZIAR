//hot embers of the fire
/particles/fire_embers
	icon_state = list("spark"=5,"cross"=1,"curl"=1)
	width = 64
	height = 128
	count = 500
	spawning = 10
	lifespan = 3 SECONDS
	fade = 1 SECONDS
	color = 0
	color_change = 0.1
	gradient = list("#FBDB28", "#FCE6B6", "#FF532B")
	position = generator("box", list(-16,-12,-32), list(16,32,32), NORMAL_RAND)
	drift = generator("vector", list(-0.1,0), list(0.1,0.2), UNIFORM_RAND)
	scale = generator("vector", list(0.5,0.5), list(2,2), NORMAL_RAND)
	spin = generator("num", list(-30,30), NORMAL_RAND)

//smoke of the fire
/particles/fire_smoke
	icon_state = list("puff"=5,"puff_oval"=2,"puff_ball"=2)
	width = 64
	height = 128
	count = 200
	spawning = 10
	lifespan = 2 SECONDS
	fade = 1 SECONDS
	color = 0
	color_change = 0.05
	gradient = list("#dadada", "#5e5e5e", "#3a3a3a")
	position = generator("box", list(-16,0,-32), list(16,32,32), NORMAL_RAND)
	drift = generator("vector", list(-0.1,0), list(0.1,0.05), UNIFORM_RAND)
	scale = generator("vector", list(0.5,0.5), list(2,2), NORMAL_RAND)
	grow = generator("vector", list(-0.1,-0.1), list(0.1,0.1), NORMAL_RAND)
	spin = generator("num", list(-15,15), NORMAL_RAND)
