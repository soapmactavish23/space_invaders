extends Node2D

var pre_alien_shot = preload("res://scenes/alien_shot.tscn")
var pre_alien_explosion = preload("res://scenes/alien_explosion.tscn")

var dir = 1
const vel = Vector2(6, 0)

func _ready():
	get_node("timer_shot").start()
	
	for alien in get_node("aliens").get_children():
		alien.connect("destroyed", self, "on_alien_destroied")
	

func shoot():
	var n_aliens = get_node("aliens").get_child_count()
	var alien = get_node("aliens").get_child(randi() % n_aliens)
	var alien_shot = pre_alien_shot.instance()
	get_parent().add_child(alien_shot)
	alien_shot.set_global_pos(alien.get_global_pos())
	


func _on_timer_shot_timeout():
	get_node("timer_shot").set_wait_time(rand_range(.5, 3))
	shoot()


func _on_timer_move_timeout():
	var border = false
	
	for alien in get_node("aliens").get_children():
		alien.next_frame()
		if alien.get_global_pos().x > 170 and dir > 0:
			dir = -1
			border = true
		if alien.get_global_pos().x < 10 and dir < 0:
			dir = 1
			border = true
	
	if border:
		translate(Vector2(0, 8))
		if get_node("timer_move").get_wait_time() > .11:
			get_node("timer_move").set_wait_time(get_node("timer_move").get_wait_time() - .1)
	else:
		translate(vel * dir)
	
func on_alien_destroied(alien):
	var alien_exp = pre_alien_explosion.instance()
	get_parent().add_child(alien_exp)
	alien_exp.set_global_pos(alien.get_global_pos())