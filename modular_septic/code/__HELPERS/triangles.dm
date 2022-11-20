/proc/make_triangle_image(x1, y1, x2, y2, x3, y3)
	//first we try to find an existing triangle movable
	var/atom/movable/triangle/triangle_image = locate("triangle-movable-[x1]-[y1]-[x2]-[y2]-[x3]-[y3]")
	//if we fail to find one, we make one ourselves
	if(!triangle_image)
		triangle_image = new(x1, y1, x2, y2, x3, y3)
	return triangle_image
