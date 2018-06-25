extends Resource

var points = []
var sticks = []

func add_point(v,v2,pin = false):
	var p = point.new()
	p.v=v
	p.sv = v
	setPointVelocity(p,v2)
	p.pin = pin
	points.push_back(p)
	return points.back()

func add_stick(p0,p1,l):
	var s = stick.new()
	s.p0 = p0
	s.p1 = p1
	s.length = l
	sticks.push_back(s)
	return sticks.back()

func update(delta,c =1.0):
	for i in range(c):
		updatePoints(delta/c)
	
	updateSticks()

func add_impulse(v,r,s):
	for i in points:
		if i.v.distance_to(v) <= r:
			setPointVelocity(i,(v-i.v).normalized()*s)

func updatePoints(delta):
	for i in points:
		if i.pin == false:
			var vv = getPointVelocity(i)
			i.oldv = i.v
			
			#grav to start, for tree
			vv *=0.98
			vv += (i.sv-i.v) * 0.02
			
			i.v += vv
		else:
			i.oldv = i.v

func updateSticks():
	for i in sticks:
		var dv = i.p1.v - i.p0.v
		var dis = i.p1.v.distance_to(i.p0.v)
		var diff = i.length - dis
		var percent = diff / dis / 2
		var offset = dv * percent
		
		if i.p0.pin == false:
			i.p0.v -= offset
		if i.p1.pin == false:
			i.p1.v += offset

func getPointVelocity(i):
	return (i.v - i.oldv)

func setPointVelocity(i,v):
	i.oldv = (i.v - v)



class point:
	var v
	var oldv
	var sv
	var pin = false

class stick:
	var p0
	var p1
	var length