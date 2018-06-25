extends Sprite3D

onready var ts = $"tree_system"
onready var td = preload("res://Resource/texture draw.gd")


func _ready():
	
	
	td = td.new()
	td.setup()
	ts.treegen(2)
	#td.set_image_size(Vector2(64,64))
	print("branch num : ",ts.branch_list.size())


var tt = -0.2
func _process(delta):
	if tt >= 0.06:
		
		td.Ima.lock()
		draw_tree()
		td.Ima.unlock()
		td.update_ImageTexture()
		texture = td.ImaText
		tt = 0
		
		
	tt += delta
	


export var debug_r = true

func draw_tree():
	var offset = Vector2(td.Ima.get_size().x/2, 0)
	
	# branch
	for i in ts.branch_list.size():
		var ibv = ts.branch_list[i].start
		var ied = ts.branch_list[i].end
		var bv = Vector2(ibv.x,ibv.y) + offset
		var ed = Vector2(ied.x,ied.y) + offset
		
		var inc = range_lerp(i,0,ts.branch_list.size(),0.1,1)
		
		td.line(bv, ed, Color(inc,range_lerp(inc,0,1,0.1,0.9),0.1,1) , ts.branch_list[i].size.x*2.1)
		
		
		# leaves
		if ts.branch_list[i].child.empty():
			
			var ilv = ts.branch_list[i].end
			ilv = Vector2(ilv.x,ilv.y) + offset
			var ra = (ts.branch_list[i].depth + 2) * clamp(range_lerp(ts.branch_list[i].end.z,40,-40,0.2,1),0.5,2)
			td.draw_leaves(ilv, ra, Color(0.4,0.5,0.2,0.4))
			#td.Ima.blend_rect( tex, Rect2(), Vector2() )
			
	
	
	if debug_r == true:
		for i in ts.vi.sticks:
			var s = Vector2(i.p0.v.x,i.p0.v.y) + offset
			var e = Vector2(i.p1.v.x,i.p1.v.y) + offset
			td.line(s,e,Color(1,1,0.1,1),1)
		
		for i in ts.vi.points:
			var pv = Vector2(i.v.x,i.v.y) + offset
			td.draw_pixel(pv.x,pv.y,Color(1,0.1,0.1,1))
