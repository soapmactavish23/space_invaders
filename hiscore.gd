extends VBoxContainer

const pre_item = preload("res://scenes/score_item.tscn")

const positions = ["1ST", "2ND", "3RD", "4TH", "5TH", "6TH", "7TH", "8TH", "9TH", "10TH"]
		
		
func show_hiscores(hiscores):
	var a = 0
	for hiscore in hiscores:
		var item = pre_item.instance()
		item.pos = positions[a]
		item.name = hiscore.name
		item.score = hiscore.score
		add_child(item)
		get_node("timer").start()
		yield(get_node("timer"), "timeout")
		a += 1