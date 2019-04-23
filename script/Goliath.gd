extends KinematicBody2D

const GRAVITY = 10;
const SPEED = 150;
const FLOOR = Vector2(0,-1);

var goliath = 40;
var velocity = Vector2();
var direction = 1;

func _ready():
	pass

func _physics_process(delta):
	velocity.x = SPEED * direction;
	velocity.y += GRAVITY;
	velocity = move_and_slide(velocity, FLOOR);
	if is_on_wall():
		direction = direction * -1;
		
	if $RayCast2D.is_colliding() == false:
		direction = direction * -1
		
	if direction == 1:
		$Sprite.flip_h = false;
	else:
		$Sprite.flip_h = true;
