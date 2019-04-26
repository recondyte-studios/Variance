extends KinematicBody2D

const GRAVITY = 10;
const SPEED = 150;
const FLOOR = Vector2(0,-1);
const SPIDERWEB = preload("res://scene/SpiderWeb.tscn")

var spiderHealth = 20;
var velocity = Vector2();
var direction = 1;
var i = 0
var raycastValue = 250
onready var player = get_node("../player");


func _physics_process(delta):
	velocity.x = SPEED * direction;
	velocity.y += GRAVITY;
	velocity = move_and_slide(velocity, FLOOR);
	
	if $RayCast2D.is_colliding() == false:
		direction = direction * -1;
		$RayCast2D.position.x *= -1
		raycastValue*=-1
		$spiderWeb.set_cast_to(Vector2(0,raycastValue))
	
#	if $wallDectective.is_colliding() == false:
#		direction = direction * -1;
#		$RayCast2D.position.x *= -1
#		raycastValue*=-1
#		$spiderWeb.set_cast_to(Vector2(0,raycastValue))
		
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
				
				if $spiderWeb.get_cast_to().y < 0:
					spiderWeb.direction*=-1
					
				spiderWeb.position = $Position2D.global_position;
				i = 9
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
		var x = 0
		while x < 10:
			body._subtractHealth(1)
			x+=2;
	pass # replace with function body
