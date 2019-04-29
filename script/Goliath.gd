extends KinematicBody2D

const GRAVITY = 10;
const SPEED = 150;
const FLOOR = Vector2(0,-1);

#var goliath = 40;
var velocity = Vector2();
var direction = 1;
var raycastValue = 50
var stalking = false
var i = 0

onready var player = get_node("../player")

func _ready():
	pass

func _physics_process(delta):
	velocity.x = SPEED * direction;
	velocity.y += GRAVITY;
	velocity = move_and_slide(velocity, FLOOR);
	
	if $RayCast2D.is_colliding() == false:
		direction = direction * -1;
		$RayCast2D.position.x *= -1
		raycastValue*=-1
		$wallDetection.set_cast_to(Vector2(0,raycastValue))
		
	if direction == 1:
		$Sprite.flip_h = false;
	else:
		$Sprite.flip_h = true;
	
	if $wallDetection.is_colliding() == true:
		var obj = $wallDetection.get_collider()
		if obj.get_name() == "player":
			while i < 6:
				player._subtractHealth(5);
				i = 7
		else:
			direction = direction * -1;
			$RayCast2D.position.x *= -1
			raycastValue*=-1
			$wallDetection.set_cast_to(Vector2(0,raycastValue))
	else:
		i = 0
		
	if stalking:
		if player.get_position().x > self.get_position().x:
			velocity += Vector2(1,0)
		if player.get_position().x < self.get_position().x:
			velocity += Vector2(-1,0)


func _on_StalkRange_body_entered(body):
	if body.get_name() == "player":
		stalking = true
	pass # Replace with function body.


func _on_StalkRange_body_exited(body):
	if body.get_name() == "player":
		stalking = false
	pass # Replace with function body.
