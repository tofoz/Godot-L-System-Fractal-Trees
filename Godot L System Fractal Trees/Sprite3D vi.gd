extends Sprite3D

onready var td = preload("res://texture draw.gd")
onready var vi = preload("res://Verlet Integration.gd")


var p2
func _ready():
	vi = vi.new()
	
	p2 = vi.add_point(Vector3(5,5,0),Vector3(0,0,0),true)
	var p0 = p2
	for i in range(2):
		
		var p1 = vi.add_point(Vector3(0,-4,0),Vector3(5,0,0))
		vi.add_stick(p0,p1,10)
		p0 = p1
	
	print("points :: ",vi.points.size())
	print("sticks :: ",vi.sticks.size())
	
	td = td.new()
	td.setup()
	#td.set_image_size(Vector2(64,64))


var tt = -0.2
var s = 0
func _process(delta):
	if tt >= 0.06:
		s +=0.05
		#p2.v += Vector3(sin(s),cos(s),0)
		
		vi.update(0.1)
		
		td.Ima.lock()
		draw_tree()
		td.Ima.unlock()
		td.update_ImageTexture()
		texture = td.ImaText
		tt = 0
	tt += delta
	


func draw_tree():
	var offset = Vector2(td.Ima.get_size().x/2, td.Ima.get_size().x/2)
	for i in vi.sticks:
		var s = Vector2(i.p0.v.x,i.p0.v.y) + offset
		var e = Vector2(i.p1.v.x,i.p1.v.y) + offset
		td.line(s,e,Color(1,1,0.1,1),1)
	
	for i in vi.points:
		var pv = Vector2(i.v.x,i.v.y) + offset
		td.draw_pixel(pv.x,pv.y,Color(1,0.1,0.1,1))