extends Area2D

const VEL = 80

var prev_shot = preload("res://scenes/ship_shot.tscn")

var left
var right
var lazer
var prev_lazer = false

var dir = 0

var alive = true

signal destroied
signal respawn 

func _ready():
	hide()
	#set_process(true)
	
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
	
	set_global_pos(Vector2(clamp(get_global_pos().x, 7, 173), get_global_pos().y))
	
	
	if lazer and not prev_lazer and get_tree().get_nodes_in_group("ship_shot").size() == 0:
		get_node("sample").play("ship_shoot")
		var shot = prev_shot.instance()
		get_parent().add_child(shot)
		shot.set_global_pos(get_global_pos())
		
	prev_lazer = lazer

func start():
	show()
	set_process(true)

func disable():
	hide()
	set_process(false)
	alive = false

func destroy(obj):
	if alive:
		get_node("sample").play("ship_explosion")
		alive = false
		set_process(false)
		emit_signal("destroied")
		get_node("anim").play("explode")
		yield(get_node("anim"), "finished")
		emit_signal("respawn")
		set_process(true)
		alive = true
		get_node("sprite").set_frame(0)