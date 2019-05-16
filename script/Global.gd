extends Node


var current_scene = null

func _ready():
    var root = get_tree().get_root()
    current_scene = root.get_child(root.get_child_count() - 1)

var Volcan = load("res://saves/Volcan.tres");
var Noel = load("res://saves/Noel.tres");
var Rima = load("res://saves/Rima.tres");
var Jackson = load("res://saves/Jackson.tres");

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