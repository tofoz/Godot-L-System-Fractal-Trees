extends Resource

var ax = "f"
var rule = {"f":"fa"}
var s = ax

func set_s():
	s = ax

func generate():
	var nls = ""
	
	for i in s:
		var found = false
		for j in rule:
			if i == j:
				found = true
				nls += rule[j]
				break
		if not found:
			nls += i
		
	s = nls