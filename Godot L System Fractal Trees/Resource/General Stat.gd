extends Resource

var stats = {}
var modifiers = {}
const m_type = {0:"flat", 1:"padd", 2:"pmult"}
#Flat, PercentAdd, PercentMult
#stats
func create(_stats):
	stats = _stats

func set_Stat(id, val):
	stats[id] = val

func get_BaseStat(id):
	return stats[id]

func get_Modifier(id):
	return modifiers[id]

func add_Modifier(id,_modifier):
	modifiers[id] =_modifier

func remove_Modifier(id):
	modifiers.erase(id)

func make_Modifier(id ,value, type, stat, source = null, order = null):
	var t = m_type[type]
	
	if order == null:
		order = 0
	
	if not modifiers.has(id):
		var M
		
		if source == null:
			M = {m_type[0]:{},m_type[1]:{},m_type[2]:{}, "order":order}
		else:
			M = {m_type[0]:{}, m_type[1]:{}, m_type[2]:{}, "source":source, "order":order}
		
		add_Modifier(id,M)
		make_Modifier(id ,value, type, stat, source, order)
	else:
		if modifiers[id].has(t):
			modifiers[id][t][stat] = value
			return true
	return false

func get_Stat(stat):
	var stimp = stats[stat]
	
	for x in modifiers.keys():
		if not modifiers[x].has("tick") and modifiers[x].has("flat"):
			if modifiers[x]["flat"].has(stat):
				stimp += modifiers[x]["flat"][stat]
	
	var ts = stimp
	for x in modifiers.keys():
		if not modifiers[x].has("tick") and modifiers[x].has("padd"):
			if modifiers[x]["padd"].has(stat):
				stimp += modifiers[x]["padd"][stat] * ts
	
	for x in modifiers.keys():
		if not modifiers[x].has("tick") and modifiers[x].has("pmult"):
			if modifiers[x]["pmult"].has(stat):
				stimp = modifiers[x]["pmult"][stat] * stimp
	return stimp

