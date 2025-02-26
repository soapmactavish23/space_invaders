extends Node

var extra_life_points = [100, 350, 600]

var extra_life_index = 0

var score = 0
var lifes = 3

func _ready():
	randomize()
	update_score()
	get_node("alien_group").connect("enemy_down", self, "on_alien_group_enemy_down")
	get_node("alien_group").connect("ready", self, "on_alien_group_ready")
	get_node("alien_group").connect("earth_dominated", self, "on_alien_earth_dominated")
	get_node("ship").connect("destroied", self, "on_ship_destroied")
	get_node("ship").connect("respawn", self, "on_ship_respawn")

func on_alien_group_enemy_down(alien):
	score += alien.score
	if extra_life_index < extra_life_points.size() and score >= extra_life_points[extra_life_index]:
		lifes += 1
		get_node("HUD/life_draw").lifes = lifes
		extra_life_index += 1
	update_score()
	
func on_alien_group_ready():
	get_node("ship").start()

func update_score():
	get_node("HUD/score").set_text(str(score))

func on_ship_destroied():
	get_node("alien_group").stop_all()
	lifes -= 1
	get_node("HUD/life_draw").lifes = lifes
	get_tree().call_group(0, "alien_shot", "destroy", self)

func on_ship_respawn():
	get_node("alien_group").start_all()
	if lifes <= 0:
		game_over()
	else:
		get_node("alien_group").start_all()
	
func on_alien_earth_dominated():
	game_over()
	
func game_over():
	get_node("alien_group").stop_all()
	get_node("ship").disable()