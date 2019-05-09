extends VBoxContainer

var save = preload("res://saves/GameSaver.gd")
onready var FileId = get_node("GameFileSelect");

func _on_StartButton_pressed():
	get_tree().change_scene("res://scene/CharacterSelect.tscn");


func _on_NewSaveButton_pressed():
	save.save(FileId.value);
	
