extends Node

var score = 0

func _ready():
	update_score()
	get_node("alien_group").connect("enemy_down", self, "on_alien_group_enemy_down")
	pass

func on_alien_group_enemy_down(alien):
	score += alien.score
	update_score()

func update_score():
	get_node("HUD/score").set_text(str(score))