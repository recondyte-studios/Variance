extends Node

var stats = {
		"Character" : "Volcan Forge",
		"Str" : 35,
		"Con" : 25,
		"Dex" : 20,
		"Teq" : 30,
		"MaxHp" : 100,
		"CurrentHp" : 100
	}



#Pssst, check the godot save system to read the keys line by line
#It's free Real Estate
func _on_Save_pressed():
	var file = File.new();
	if file.open("user://saved_game.sav", File.WRITE) != 0:
		print("Error opening file");
		return;
	file.store_line(parse_json(stats));
	file.close();
