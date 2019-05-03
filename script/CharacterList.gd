extends Node

var VolcanStat = {
	"Character" : "Volcan Forge",
	"Str" : 35,
	"Con" : 25,
	"Dex" : 20,
	"Teq" : 30,
	"MaxHp" : 100,
	"CurrentHp" : 100
}

var NoelStat = {
	"Character" : "Noel Carbon",
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
	"Str" : 20,
	"Con" : 30,
	"Dex" : 15,
	"Teq" : 15,
	"MaxHp" : 200,
	"CurrentHp" : 200
}

func StatsDisplay(CharStats):
	var HP = CharStats.MaxHp;
	var STR = CharStats.Str;
	var CON = CharStats.Con;
	var DEX = CharStats.Dex;
	var TEQ = CharStats.Teq;
	
	get_node("Health").set_value(HP);
	get_node("Str").set_value(STR);
	get_node("Con").set_value(CON);
	get_node("Dex").set_value(DEX);
	get_node("Teq").set_value(TEQ);

func _on_Rima_pressed():
	StatsDisplay(RimaStat);


func _on_Noel_pressed():
	StatsDisplay(NoelStat);


func _on_Jackson_pressed():
	StatsDisplay(JacksonStat);


func _on_Volcan_pressed():
	StatsDisplay(VolcanStat);
