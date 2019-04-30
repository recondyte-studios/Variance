extends KinematicBody2D

const movespeed = 150;
const SHOCKWAVE = preload("res://scene/shockWave .tscn")

var speed = Vector2();
var check = 0;
var saveCheck =0;
var position1;
var position2;
var direction = 1

#onready var player = get_node("../player");


func _ready():
	position1 = self.get_position().x + 400;
	position2 = self.get_position().x;
	
	pass


#warning-ignore:unused_argument
func _physics_process(delta):
	if(check == 0):
		speed.x= movespeed;
		if(self.get_position().x > position1):
			check = 1;
			direction *= -1
			saveCheck = check;
	if(check == 1):
		speed.x= -movespeed;
		if(self.get_position().x < position2):
			direction *= -1
			check = 0;
			saveCheck = check 
			
	if check == 3:
		speed.x = 0
	
	if direction == 1:
		$Sprite.flip_h = true;
		$spawnPt.set_position(Vector2(235, 86))
	
	else:
		$Sprite.flip_h = false;
		$spawnPt.set_position(Vector2(-235, 86))
		
	
	move_and_slide(speed, Vector2(0, 0))
	
	pass


func _on_ClawZone_body_entered(body):
	if body.get_name() == "player":
		var playerPos = body.get_position()
		var selfPos = get_position()
		var x = abs(playerPos.x - selfPos.x)
		var y = abs(playerPos.y - selfPos.y)
		var angle = rad2deg(atan2(y,x));
		print(angle)
		var shockwave = SHOCKWAVE.instance();
		get_parent().call_deferred("add_child", shockwave)
		if saveCheck == 1:
			shockwave.direction*=-1
		shockwave.position = $spawnPt.global_position;
		check = 3;
	pass # Replace with function body.


func _on_ClawZone_body_exited(body):
	if body.get_name() == "player":
		check = saveCheck
	pass # Replace with function body.
