extends Node2D

var pre_alien_shot = preload("res://scenes/alien_shot.tscn")

func _ready():
	get_node("timer_shot").start()

func shoot():
	var n_aliens = get_node("aliens").get_child_count()
	var alien = get_node("aliens").get_child(randi() % n_aliens)
	var alien_shot = pre_alien_shot.instance()
	get_parent().add_child(alien_shot)
	alien_shot.set_global_pos(alien.get_global_pos())
	



func _on_timer_shot_timeout():
	get_node("timer_shot").set_wait_time(rand_range(.5, 3))
	shoot()
