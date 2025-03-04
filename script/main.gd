extends Node

var pre_game = preload("res://scenes/game.tscn")
var game

var hiscores = [
	{name = "AAA", score = 1000},
	{name = "BBB", score = 900},
	{name = "CCC", score = 800},
	{name = "DDD", score = 700},
	{name = "EEE", score = 600},
	{name = "FFF", score = 500},
	{name = "GGG", score = 400},
	{name = "HHH", score = 300},
	{name = "III", score = 200},
	{name = "JJJ", score = 100},
]

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
	for hs in hiscores:
		if game.data.score > hs.score:
			print(hs)
			break;
	
	get_node("btn_new_game").show()

func on_victory():
	var data = game.data
	new_game()
	game.data = data