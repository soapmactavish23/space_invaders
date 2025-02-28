extends Node

var pre_game = preload("res://scenes/game.tscn")
var game

var extra_life_index = 0
var score = 0
var lifes = 3

func _ready():
	pass
	
func new_game():
	if game != null:
		game.queue_free()
	game = pre_game.instance()
	add_child(game)
	game.connect("game_over", self, "on_game_over")
	game.connect("victory", self, "on_victory")


func _on_Button_pressed():
	get_node("btn_new_game").hide()
	new_game()

func on_game_over():
	get_node("btn_new_game").show()

func on_victory():
	extra_life_index = game.extra_life_index
	score = game.score
	lifes = game.lifes
	new_game()
	game.extra_life_index = extra_life_index
	game.score = score
	game.lifes = lifes