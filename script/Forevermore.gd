extends KinematicBody2D

const movespeed = 200;
var speed = Vector2();
var check = 0;
var position1;
var position2;
var direction = 1


func _ready():
	position1 = self.get_position().x + 400;
	position2 = self.get_position().x;
	pass


func _physics_process(delta):
	if(check == 0):
		speed.x= movespeed;
		if(self.get_position().x > position1):
			check = 1;
			direction *= -1
	if(check == 1):
		speed.x= -movespeed;
		if(self.get_position().x < position2):
			direction *= -1
			check = 0;
	
	if direction == 1:
		$Sprite.flip_h = true;
	else:
		$Sprite.flip_h = false;
	
	move_and_slide(speed, Vector2(0, -1))
	pass
