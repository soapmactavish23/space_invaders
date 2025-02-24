extends Node

var score = 0

func _ready():
	randomize()
	update_score()
	get_node("alien_group").connect("enemy_down", self, "on_alien_group_enemy_down")
	get_node("alien_group").connect("ready", self, "on_alien_group_ready")
	get_node("ship").connect("destroied", self, "on_ship_destroied")
	get_node("ship").connect("respawn", self, "on_ship_respawn")

func on_alien_group_enemy_down(alien):
	score += alien.score
	update_score()
	
func on_alien_group_ready():
	get_node("ship").start()

func update_score():
	get_node("HUD/score").set_text(str(score))

func on_ship_destroied():
	get_node("alien_group").stop_all()
	get_node("HUD/life_draw").lifes -= 1

func on_ship_respawn():
	get_node("alien_group").start_all()