/atom/movable/triangle
	name = ""
	icon = 'modular_septic/icons/triangle.dmi'
	icon_state = "triangle"
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	vis_flags = VIS_INHERIT_PLANE | VIS_INHERIT_LAYER
	animate_movement = NO_STEPS

/atom/movable/triangle/New(x1, y1, x2, y2, x3, y3)
	. = ..()
	//a, b, c, d, e, f
	transform = matrix((x3*0.03125)-(x2*0.03125), \
					-(x2*0.03125)+(x1*0.03125), \
					(x3*0.5)+(x1*0.5), \
					-(y2*0.03125)+(y3*0.03125), \
					(y1*0.03125)-(y2*0.03125), \
					(y1*0.5)+(y3*0.5))
	tag = "triangle-movable-[x1]-[y1]-[x2]-[y2]-[x3]-[y3]"
