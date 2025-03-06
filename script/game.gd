extends Node

var extra_life_points = [100, 350, 600]

var data = {
	extra_life_index = 0,
	score = 0,
	lifes = 3
} setget set_data

signal game_over
signal victory

func _ready():
	randomize()
	update_score()
	get_node("alien_group").connect("enemy_down", self, "on_alien_group_enemy_down")
	get_node("alien_group").connect("ready", self, "on_alien_group_ready")
	get_node("alien_group").connect("earth_dominated", self, "on_alien_earth_dominated")
	get_node("alien_group").connect("victory", self, "on_alien_group_victory")
	get_node("ship").connect("destroied", self, "on_ship_destroied")
	get_node("ship").connect("respawn", self, "on_ship_respawn")

func on_alien_group_enemy_down(alien):
	data.score += alien.score
	if data.extra_life_index < extra_life_points.size() and data.score >= extra_life_points[data.extra_life_index]:
		data.lifes += 1
		update_lifes()
		data.extra_life_index += 1
	update_score()
	
func on_alien_group_ready():
	get_node("ship").start()
	
func update_lifes():
	get_node("HUD/life_draw").lifes = data.lifes

func update_score():
	get_node("HUD/score").set_text(str(data.score))

func update_hud():
	update_score()
	update_lifes()

func on_ship_destroied():
	get_node("alien_group").stop_all()
	data.lifes -= 1
	update_lifes()
	get_tree().call_group(0, "alien_shot", "destroy", self)

func on_ship_respawn():
	get_node("alien_group").start_all()
	if data.lifes <= 0:
		game_over()
	else:
		get_node("alien_group").start_all()
	
func on_alien_earth_dominated():
	game_over()
	
func game_over():
	get_node("alien_group").stop_all()
	get_node("ship").disable()
	get_node("ship").queue_free()
	emit_signal("game_over")
	
func on_alien_group_victory():
	get_node("alien_group").stop_all()
	get_node("ship").disable()
	emit_signal("victory")
	
func set_data(val):
	data = val
	update_hud()
	
	
	