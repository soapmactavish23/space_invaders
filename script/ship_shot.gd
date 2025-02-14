extends Area2D

var vel = 180
var dir = Vector2(0, -1)

func _ready():
	add_to_group("ship_shot")
	set_process(true)
	
func _process(delta):
	translate(dir * vel * delta)
	
	if get_global_pos().y < 0:
		queue_free()