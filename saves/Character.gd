extends Resource

class_name Character

export(String) var name = "";
export(Texture) var CharImg;
export(int) var Str;
export(int) var Con;
export(int) var Dex;
export(int) var Teq;
export(int) var MaxHp;
export(int) var CurrentHp;
export(float) var Pen;

#var VolcanStat = {
#	"Character" : "Volcan Forge",
#	"CharImg" :"res://image/Volcan-CharSelect.png",
#	"Str" : 35,
#	"Con" : 25,
#	"Dex" : 20,
#	"Teq" : 30,
#	"MaxHp" : 100,
#	"CurrentHp" : 100
#}
#
#var NoelStat = {
#	"Character" : "Noel Carbon",
#	"CharImg" : "res://image/Noel-CharSelect.png",
#	"Str" : 40,
#	"Con" : 20,
#	"Dex" : 15,
#	"Teq" : 15,
#	"Pen" : 0.80,
#	"MaxHp" : 300,
#	"CurrentHp" : 300
#}
#
#var RimaStat = {
#	"Character" : "Rima Smokes",
#	"CharImg" : "res://image/Rima-CharSelect.png",
#	"Str" : 10,
#	"Con" : 15,
#	"Dex" : 40,
#	"Teq" : 25,
#	"Pen" : 0.50,
#	"MaxHp" : 100,
#	"CurrentHp" : 100
#}
#
#var JacksonStat = {
#	"Character" : "Jackson Mori",
#	"CharImg" : "res://image/Jackson-CharSelect.png",
#	"Str" : 20,
#	"Con" : 30,
#	"Dex" : 15,
#	"Teq" : 15,
#	"MaxHp" : 200,
#	"CurrentHp" : 200
#}