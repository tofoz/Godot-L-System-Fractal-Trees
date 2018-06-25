extends Node

onready var s = preload("res://Resource/General Stat.gd")
var stats
var tt = 0

func _ready():
	stats = s.new()
	
	#inisaliz stats
	stats.create({"hp_now" : 300,"hp_max" : 300,"mp_now" : 300,"mp_max" : 300,"str" : 10,"spd" : 10,"int" : 10,})
	
	
	#inisaliz modifiers
	var magic_up = {"padd" :
	{"str" : -0.2},
	"flat" :
	{"int" : 5},
	"pmult" :
	{"int" : 1.15}
	}
	var str_up = {"padd" :
	{"str" : +0.2},
	"flat" :
	{"int" : -0.5}
	}
	
	
	# or
	
	stats.make_Modifier(3,15, 0, "str")
	stats.make_Modifier(3,-1, 0, "int")
	stats.make_Modifier(3,1.25, 1, "int")
	
	
	#add modifiers
	stats.add_Modifier(0,magic_up)
	stats.add_Modifier(1,str_up)
	
	#get finel stat

func _process(delta):
	tt += delta
	
	if tt >= 1.0:
		print("str :: ",stats.get_Stat("str"))
		print("int :: ",stats.get_Stat("int"))
		tt = 0.0