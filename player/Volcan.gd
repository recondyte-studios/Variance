extends Node

var FlameStacks = 0
onready var VolcanAxe = load("res://scene/VolcanAxe.tscn")


func _process(delta):
	if not FlameStacks <= 0:
		FlameStacks -= 1;

func _BasicAttack():
	
	pass