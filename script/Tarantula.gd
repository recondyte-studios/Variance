extends KinematicBody2D

const GRAVITY = 10;
const SPEED = 150;
const FLOOR = Vector2(0,-1);
const SPIDERWEB = preload("res://scene/SpiderWeb.tscn")

var spiderHealth = 20;
var velocity = Vector2();
var direction = 1;
var i = 0

onready var player = get_node("../player");

func _physics_process(delta):
	velocity.x = SPEED * direction;
	velocity.y += GRAVITY;
	velocity = move_and_slide(velocity, FLOOR);
	
	if is_on_wall() || $RayCast2D.is_colliding() == false:
		direction = direction * -1;
		$RayCast2D.position.x *= -1
		$spiderWeb.position.x *= -1
		
	if direction == 1:
		$Sprite.flip_h = false;
	else:
		$Sprite.flip_h = true;
	
	if $spiderWeb.is_colliding() == true:
		var obj = get_node("spiderWeb").get_collider()
		if obj.get_name() == "player":
			while i < 6:
				var spiderWeb = SPIDERWEB.instance();
				get_parent().call_deferred("add_child", spiderWeb)
				spiderWeb.position = $Position2D.global_position;
				i += 3
	else:
		i = 0


#func _on_SpiderWeb_body_entered(body):
##	if body.get_name() == "player":
##		var spiderWeb = SPIDERWEB.instance();
##		get_parent().call_deferred("add_child", spiderWeb)
##		if player.position.x < self.position.x:
##			spiderWeb.position = $Position2D.global_position;
#	pass # replace with function body


func _on_Bite_body_entered(body):
	if body.get_name() == "player":
		body._subtractHealth(2)
	pass # replace with function body
