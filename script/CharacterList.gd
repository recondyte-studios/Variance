extends Node

onready var DisplayPic = get_node("../Background/DisplayPanel/DisplayPanelFrame/CharPic");
var StatSave = load("res://saves/SaveGame.gd");
#var Selected = StatSave.SelectedCharacer;
onready var global = get_node("/root/Global");



func StatsDisplay(Char):
	var HP = Char.MaxHp;
	var STR = Char.Str;
	var CON = Char.Con;
	var DEX = Char.Dex;
	var TEQ = Char.Teq;
	
	print(HP);
	print(STR);
	print(CON);
	print(DEX);
	print(TEQ);
	
	get_node("Health").set_value(Char.MaxHp);
	get_node("Str").set_value(Char.Str);
	get_node("Con").set_value(Char.Con);
	get_node("Dex").set_value(Char.Dex);
	get_node("Teq").set_value(Char.Teq);
	
#	DisplayPic.texture = Char.CharImg;


func _on_Rima_pressed():
	StatsDisplay(global.RimaStat);


func _on_Noel_pressed():
	StatsDisplay(global.NoelStat);


func _on_Jackson_pressed():
	StatsDisplay(global.JacksonStat);


func _on_Volcan_pressed():
	StatsDisplay(global.VolcanStat);
#

func _on_StartGame_pressed():
	get_tree().change_scene("res://scene/MainScene.tscn");

