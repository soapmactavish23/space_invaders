extends Area2D

var vel = 80
var dir = Vector2(0, -1)

func _ready():
	set_process(true)
	
func _process(delta):
	translate(dir * vel * delta)