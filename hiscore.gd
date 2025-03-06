extends VBoxContainer

const pre_item = preload("res://scenes/score_item.tscn")

const positions = ["1ST", "2ND", "3RD", "4TH", "5TH", "6TH", "7TH", "8TH", "9TH", "10TH"]
const colors = ["ff0000", "ff7700", "ffb900", "fdff00", "c7ff00", "49ff00", "00ff5d","00fff3", "008dff", "0700ff"]
		
func show_hiscores(hiscores):
	for c in get_children():
		if c extends HBoxContainer:
			c.queue_free()
	
	var item = pre_item.instance()
	item.pos = "RANK"
	item.name = "NAME"
	item.score = "SCORE"
	add_child(item)
	
	var a = 0
	for hiscore in hiscores:
		item = pre_item.instance()
		item.pos = positions[a]
		item.name = hiscore.name
		item.score = hiscore.score
		item.color = Color(colors[a])
		add_child(item)
		get_node("timer").start()
		yield(get_node("timer"), "timeout")
		a += 1