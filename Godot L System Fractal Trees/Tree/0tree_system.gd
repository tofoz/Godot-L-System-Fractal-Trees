extends Resource

var branch_list = []
var lp = []
var t 
var ls
var start_length = 18
var rand_rot = 5
var branch_s = load("res://branch.tscn")
var p

func set_resources(_t,_ls):
	t = _t
	ls = _ls

#gen tree data

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
				t.rotate(25 + rand_range(-rand_rot,rand_rot), rand_vec3(Vector3(0.5,1,0.5)) )
		if c == "-":
			if has_num(ls.s,i+1):
				t.rotate(get_num(ls.s,i+1))
			else:
				t.rotate(-25 + rand_range(-rand_rot,rand_rot), rand_vec3(Vector3(0.5,0,0.5)) )
		if c == "[":
			t.push()
		if c == "]":
			t.pop()
		if c == "l":
			leave()
			pass

func rand_vec3(v):
	return (Vector3(rand_range(-1,1),rand_range(-1,1),rand_range(-1,1)) * v).normalized()

func leave():
	lp.push_back(t.point)



func branch():
	var b = branch_s.instance()
	if branch_list.empty():
		p.add_child(b)
	else:
		p.add_child(b)
	
	b.start = t.point
	print("t",t.point)
	print("b",b.start)
	t.move()
	b.end = t.point
	#t.wc = {"object":branch_list.size()}
	#b.p_index = t.wc["object"]
	
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

