extends Node

var pre_game = preload("res://scenes/game.tscn")
var game

func _ready():
	pass
	
func new_game():
	if game != null:
		remove_child(game)
	game = pre_game.instance()
	add_child(game)
	game.connect("game_over", self, "on_game_over")


func _on_Button_pressed():
	get_node("btn_new_game").hide()
	new_game()

func on_game_over():
	get_node("btn_new_game").show()