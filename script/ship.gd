extends Area2D

const VEL = 80

var prev_shot = preload("res://scenes/ship_shot.tscn")

var left
var right
var lazer
var prev_lazer = false

var dir = 0

func _ready():
	set_process(true)
	
func _process(delta):
	dir = 0
	
	right = Input.is_action_pressed("ui_right")
	left = Input.is_action_pressed("ui_left")
	lazer = Input.is_action_pressed("disparo")
	
	if right:
		dir += 1
	
	if left:
		dir -= 1
	
	translate(Vector2(1, 0) * VEL * dir * delta)
	
	if get_global_pos().x < 7:
		set_global_pos(Vector2(7, get_global_pos().y))
		
	if get_global_pos().x > 173:
		set_global_pos(Vector2(173, get_global_pos().y))
	
	if lazer and not prev_lazer:
		var shot = prev_shot.instance()
		get_parent().add_child(shot)
		shot.set_global_pos(get_global_pos())
		
	prev_lazer = lazer
