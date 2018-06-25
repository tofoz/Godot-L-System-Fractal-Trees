extends Resource

var Ima
var ImaText

func setup():
	Ima = Image.new()
	
	Ima.create(128, 128, false, 5)
	
	Ima.flip_y()
	ImaText = ImageTexture.new()
	ImaText.create_from_image( Ima,0)

func set_image_size(v = Vector2(128,128)):
	Ima.create(v.x, v.y, false, 5)

func update_ImageTexture():
	Ima.flip_y()
	ImaText.create_from_image( Ima,0)
	Ima.fill(Color(0,0,0,0))


func draw_leaves(p,r,c):
	draw_circle(p,r,c)
	#for i in range(6):
	#	
	#	#draw_circle(p+c_randomPoint(r),r/2,c.lightened(0.2*i))

func draw_circle(p,r,c):
	
	var theta = 0
	while not theta >= 360:
		var pv = Vector2(r*cos(theta),r*sin(theta)) + p
		_line(p,pv,c,true)
		theta+=15#max(15/r,1)

func c_randomPoint(r):
	var xy = Vector2(rand_range(-1,1),rand_range(-1,1)).normalized()
	var l = rand_range(-r,r)
	return xy * l

func line(s,e,c,w):
	var dir = (e-s).normalized()
	var leng = (e-s).length()
	var wc = w/2
	var a = dir.rotated(deg2rad(45))
	for i in range(w):
		var z = wc - i
		var ns = (z*a)+s
		var ne = (z*a)+e
		_line(ns,ne,c)

func _line(s,e,c,b = false):
	var dir = (e-s).normalized()
	var leng = (e-s).length()
	for i in range(leng + 1):
		draw_pixel( s.x + (i * dir.x), s.y + (i * dir.y), c,b)



func draw_pixel(x,y,color, b = false):
	if (x >= 0 and x < Ima.get_size().x) and (y >= 0 and y < Ima.get_size().y):
		if b == true:
			var col = Ima.get_pixel(x,y).blend(color)
			col.s+=0.1
			col.v+=0.1
			col.h+=0.005
			Ima.set_pixel(x,y,col)
		else:
			Ima.set_pixel(x,y,color)
