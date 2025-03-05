extends VBoxContainer

const pre_item = preload("res://scenes/score_item.tscn")

func _ready():
	
	for a in range(10):
		var item = pre_item.instance()
		item.name = str(a) + "AA"
		add_child(item)
		
