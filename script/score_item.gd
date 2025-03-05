extends HBoxContainer

var pos = "1ST" setget set_pos
var name = "AAA" setget set_name
var score = "99999" setget set_score

func set_pos(val):
	pos = val
	get_node("pos").set_text(str(val))
	
func set_name(val):
	name = val
	get_node("name").set_text(str(val))
	
func set_score(val):
	score = val
	get_node("score").set_text(str(val))
