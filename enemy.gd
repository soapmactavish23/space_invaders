extends Area2D

export (int, "A", "B", "C") var tipo = 0

var score = 0

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
	var atribute = atributes[tipo]
	get_node("sprite").set_texture(atribute.texture)
	score = atribute.score
