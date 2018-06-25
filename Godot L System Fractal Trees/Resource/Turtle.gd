extends Resource

var point = Vector3()
var dir = Vector3(0,1,0).normalized()
var length = 4
var size = Vector2(1,1)
var wc = {}
var p = []
var r = []
var l = []
var s = []
var w = []

func push():
	p.push_back(point)
	r.push_back(dir)
	l.push_back(length)
	s.push_back(size)
	w.push_back(wc)

func pop():
	point = p.pop_back()
	dir = r.pop_back()
	length = l.pop_back()
	size = s.pop_back()
	wc = w.pop_back()

func move():
	point += length * dir

func move_to(v):
	length = (point - v).length()
	dir = (v - point).normalized()

func rotate(rot,v = Vector3(0,0,1)):
	dir = dir.rotated(v,deg2rad(rot))