extends Node2D

func _ready():
	get_node("anim").play("explosion")
	yield(get_node("anim"), "finished")
	queue_free()
