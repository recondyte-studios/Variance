extends KinematicBody2D

const movespeed = 150;
const SHOCKWAVE = preload("res://scene/shockWave .tscn")

var speed = Vector2();
var check = 0;
var saveCheck =0;
var position1;
var position2;
var yPos;
var direction = 1
var inRange = 400
var i =0
#var direction1
#var motion 
var attack = false
#onready var origPos = get_position()

onready var player = get_node("../player");

func _ready():
	position1 = self.get_position().x + 400;
	position2 = self.get_position().x;
	yPos = get_position().y;
	print(position2 , yPos)
	pass


#warning-ignore:unused_argument
func _physics_process(delta):
	var to_player = player.global_position - self.global_position
	var distance = to_player.length();
	
	if(check == 0):
		speed.x= movespeed;
		if attack == true:
			_attack()
			attack = false
		if(self.get_position().x > position1):
			check = 1;
			direction *= -1
			saveCheck = check;
		
	if(check == 1):
		speed.x= -movespeed;
		if attack == true:
			_attack()
			attack = false
		if(self.get_position().x < position2):
			direction *= -1
			check = 0;
			saveCheck = check 
			
#	if check == 3:
#		if distance > inRange && distance < inRange - 200:
#			direction1 = (player.position - position).normalized()
#			motion = direction1 * movespeed * delta
#			position += motion
##			if player.position.x < position.x:
##				direction = 1
##			else:
##				direction = -1 
#		else:
#			while i < 9:
##				direction1 = (player.position - position).normalized()
##				motion = direction1 * movespeed * delta
##				position -= motion 
#				_attack();
#				i = 10
#				check = 0
#
#
	if direction == 1:
		$Sprite.flip_h = true;
		$spawnPt.set_position(Vector2(235, 86))
	
	else:
		$Sprite.flip_h = false;
		$spawnPt.set_position(Vector2(-235, 86))
		i = 0
	
#warning-ignore:return_value_discarded
	move_and_slide(speed, Vector2(0, 0))
	
	pass

#func _followPlayer():
#	if player.position.x > position.x:
#		speed.x += 5
#		direction = 1
#	if player.position.x < position.x:
#		speed.x -= 5
#		direction = -1
#	if player.position.y > position.y:
#		speed.y += 5
#	if player.position.y < position.y:
#		speed.y -= 5

func _attack():
	var shockwave = SHOCKWAVE.instance();
	get_parent().call_deferred("add_child", shockwave)
	shockwave.position = $spawnPt.global_position;

func _on_ClawZone_body_entered(body):
	if body.get_name() == "player":
		attack = true
	pass # Replace with function body.
