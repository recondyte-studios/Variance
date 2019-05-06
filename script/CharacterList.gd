extends Node

onready var DisplayPic = get_node("../Background/DisplayPanel/DisplayPanelFrame/CharPic");
var SelectedCharacter;

var VolcanStat = {
	"Character" : "Volcan Forge",
	"CharImg" :"res://image/Volcan-CharSelect.png",
	"Str" : 35,
	"Con" : 25,
	"Dex" : 20,
	"Teq" : 30,
	"MaxHp" : 100,
	"CurrentHp" : 100
}

var NoelStat = {
	"Character" : "Noel Carbon",
	"CharImg" : "res://image/Noel-CharSelect.png",
	"Str" : 40,
	"Con" : 20,
	"Dex" : 15,
	"Teq" : 15,
	"Pen" : 0.80,
	"MaxHp" : 300,
	"CurrentHp" : 300
}

var RimaStat = {
	"Character" : "Rima Smokes",
	"CharImg" : "res://image/Rima-CharSelect.png",
	"Str" : 10,
	"Con" : 15,
	"Dex" : 40,
	"Teq" : 25,
	"Pen" : 0.50,
	"MaxHp" : 100,
	"CurrentHp" : 100
}

var JacksonStat = {
	"Character" : "Jackson Mori",
	"CharImg" : "res://image/Jackson-CharSelect.png",
	"Str" : 20,
	"Con" : 30,
	"Dex" : 15,
	"Teq" : 15,
	"MaxHp" : 200,
	"CurrentHp" : 200
}

func StatsDisplay(Char):
	var HP = Char.MaxHp;
	var STR = Char.Str;
	var CON = Char.Con;
	var DEX = Char.Dex;
	var TEQ = Char.Teq;
	
	get_node("Health").set_value(HP);
	get_node("Str").set_value(STR);
	get_node("Con").set_value(CON);
	get_node("Dex").set_value(DEX);
	get_node("Teq").set_value(TEQ);
	
	DisplayPic.texture = load(Char.CharImg);
	SelectedCharacter = Char.CharImg; 

func _on_Rima_pressed():
	StatsDisplay(RimaStat);


func _on_Noel_pressed():
	StatsDisplay(NoelStat);


func _on_Jackson_pressed():
	StatsDisplay(JacksonStat);


func _on_Volcan_pressed():
	StatsDisplay(VolcanStat);


func _on_StartGame_pressed():
	get_tree().change_scene("res://scene/MainScene.tscn");

