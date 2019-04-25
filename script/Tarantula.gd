extends KinematicBody2D

const GRAVITY = 10;
const SPEED = 150;
const FLOOR = Vector2(0,-1);
const SPIDERWEB = preload("res://scene/SpiderWeb.tscn")

var spiderHealth = 20;
var velocity = Vector2();
var direction = 1;

func _physics_process(delta):
	velocity.x = SPEED * direction;
	velocity.y += GRAVITY;
	velocity = move_and_slide(velocity, FLOOR);
	
	if is_on_wall():
		direction = direction * -1;
		$RayCast2D.position.x *= -1
		
	if $RayCast2D.is_colliding() == false:
		direction = direction * -1
		$RayCast2D.position.x *= -1
		
	print($RayCast2D.is_colliding())
	if direction == 1:
		$Sprite.flip_h = false;
	else:
		$Sprite.flip_h = true;

func _on_SpiderWeb_body_entered(body):
	if body.get_name() == "player":
		var spiderWeb = SPIDERWEB.instance();
		get_parent().add_child(spiderWeb);
		spiderWeb.position = $Position2D.global_position;
	pass # replace with function body


func _on_Bite_body_entered(body):
	if body.get_name() == "player":
		body._subtractHealth(2)
	pass # replace with function body
