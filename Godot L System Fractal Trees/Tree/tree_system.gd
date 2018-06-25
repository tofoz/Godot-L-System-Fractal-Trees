extends Spatial

onready var ls = preload("res://Resource/L_System.gd")
onready var t = preload("res://Resource/Turtle.gd")
onready var vi = preload("res://Resource/Verlet Integration.gd")
var branch_s = preload("res://Tree/branch.tscn")

var branch_list = []

var start_length = 18
var rand_rot = 5

var tt = -0.2
var wind =0

func _process(delta):
	if tt >= 0.06:
		
		var rf = (0.01*sin(1.5*cos(wind*0.05))) + (0.01*sin(wind*0.1))
		vi.update(1)
		wind += 0.213 
		tt = 0
	tt += delta
	

func _ready():
	vi = vi.new()
	set_as_toplevel(true)
	set_identity()
	
	t = t.new()
	ls = ls.new()
	ls.rule = {"f":"ffl+[+f90l-f92-f95l]-[-f85l+f92+f80l]"}
	ls.ax = "f"
	ls.set_s()

#gen tree data

func treegen(n):
	for x in range(n):
		ls.generate()
	turtle()
	print("points : ",vi.points.size())
	print("sticks : ",vi.sticks.size())

func turtle():
	t.length = start_length
	for i in ls.s.length():
		var c = ls.s[i]
		randomize()
		if c == "f":
			if has_num(ls.s,i+1):
				if rand_range(0,100) < get_num(ls.s,i+1):
					branch()
					pass
			else:
				branch()
			t.length *= 0.85
			t.length = clamp(t.length,2,1000)
		if c == "+":
			if has_num(ls.s,i+1):
				t.rotate(get_num(ls.s,i+1))
			else:
				t.rotate(25 + rand_range(-rand_rot,rand_rot) , rand_vec3(Vector3(0.5,0,0.5)))
		if c == "-":
			if has_num(ls.s,i+1):
				t.rotate(get_num(ls.s,i+1))
			else:
				t.rotate(-25 + rand_range(-rand_rot,rand_rot) , rand_vec3(Vector3(0.5,0,0.5)))
		if c == "[":
			t.push()
		if c == "]":
			t.pop()
		if c == "l":
			pass#leave()

func rand_vec3(v):
	return (Vector3(rand_range(-1,1),rand_range(-1,1),rand_range(-1,1)) * v).normalized()

var lp
func branch():
	var b = branch_s.instance()
	
	var p
	
	if branch_list.empty():
		add_child(b)
		
	else:
		t.wc["parent"].add_child(b)
	
	
	if lp == null:
		lp = vi.add_point(t.point,Vector3(),true)
		t.wc = {"p":lp}
		b.points = p
	
	b.start = t.point
	t.move()
	b.end = t.point
	
	
	p = vi.add_point(t.point,Vector3())
	
	if not lp == null:
		vi.add_stick(t.wc["p"],p,p.v.distance_to(t.wc["p"].v))
		b.points = t.wc["p"]
		b.pointe = p
	
	
	var depth = 0
	b.root = self
	
	if t.wc.has("parent"):
		b.parent = t.wc["parent"]
		b.depth = t.wc["depth"]
		depth = t.wc["depth"]
		t.wc["parent"].child.push_back(b)
		lp = t.wc["p"]
	
	 depth+=1
	
	t.wc = {"parent":b,"depth":depth,"p":p}
	
	branch_list.push_back(b)
	

func has_num(s,start):
	var nums = "0123456789"
	for i in nums:
		if s[start] == i:
			return true
	return false 

func get_num(s,start):
	var num = "" 
	var i = start
	while has_num(s,i):
		num += s[i]
		i+=1
	return num.to_float()





