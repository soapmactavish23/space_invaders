extends Node

const letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_*# "

var index = 0
var letter = 0

func _ready():
	set_process_input(true)
	
func _input(event):
	var alterou = false
	if event.is_action_pressed("ui_right") and not event.is_echo():
		index += 1
		alterou = true
	
	if event.is_action_pressed("ui_left") and not event.is_echo():
		index -= 1
		alterou = true
	
	if alterou:
		get_node("container").get_child(letter).set_text(letters[index])


func _on_timer_timeout():
	if get_node("container").get_child(letter).get_opacity() > 0:
		get_node("container").get_child(letter).set_opacity(0)
	else:
		get_node("container").get_child(letter).set_opacity(1)
