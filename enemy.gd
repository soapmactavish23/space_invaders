extends Area2D

export (int, "A", "B", "C") var tipo = 0 setget set_tipo

var score = 0
var frame = 0

var atributes = [
	{
		texture = preload("res://assets/sprites/InvaderA_sheet.png"), 
		score = 10
	},
	{
		texture = preload("res://assets/sprites/InvaderB_sheet.png"), 
		score = 20
	},
	{
		texture = preload("res://assets/sprites/InvaderC_sheet.png"), 
		score = 30
	}
]

func _ready():
	pass
	
func _draw():
	var atribute = atributes[tipo]
	get_node("sprite").set_texture(atribute.texture)
	score = atribute.score

func set_tipo(val):
	tipo = val
	if is_inside_tree() and get_tree().is_editor_hint():
		update()
		
func destroy(obj):
	queue_free()
	
func next_frame():
	if frame == 0:
		frame = 1
	else:
		frame = 0
	get_node("sprite").set_frame(frame)