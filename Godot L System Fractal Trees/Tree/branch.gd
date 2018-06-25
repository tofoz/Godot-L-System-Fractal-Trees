extends Spatial

var start = Vector3() setget set_start, get_start
var end = Vector3() setget set_end, get_end
var size = Vector2(1,1) #start and end size

var rig = true

var points
var pointe

var depth = 0
var root 
var parent
var child = []

func get_start():
	start = global_transform.origin
	if rig == true:
		return global_transform.basis.xform(points.v)
	else:
		return start
func set_start(v):
	start = v
	global_transform.origin = v
func get_end():
	end = $"end".global_transform.origin
	if rig == true:
		return $"end".global_transform.basis.xform(pointe.v)
	else:
		return end

func set_end(v):
	end = v
	$"end".global_transform.origin = v
	
	# debug
	#$"RayCast".cast_to = $end.transform.origin
	#$RayCast.enabled = true



var tt = 0
var wind = 0
var rot = 0

func _process(delta):
	
	var rf = (0.01*sin(1.5*cos((wind+depth)*0.05))) + (0.01*sin((wind+depth)*0.1))
	if child.empty():
		if root != null:
			root.vi.add_impulse(pointe.v+Vector3(2,0.3,2),6,-(rf*27))
		#rotation_degrees = Vector3(0,0,32.5*cos(0.9*sin(tt*2)))
	
	
#	if child.size() == 1:
#		rotation_degrees = Vector3(0,0,rf*38.1)
	
	
	if parent == null:
		size.x = 2.1
		
		#rotation_degrees = Vector3(0,rot,0)
	
	wind += 0.313 - 0.1
	rot += 25 * delta
	tt += delta
	