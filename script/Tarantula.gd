extends KinematicBody2D

const GRAVITY = 10;
const SPEED = 150;
const FLOOR = Vector2(0,-1);
const SPIDERWEB = preload("res://scene/SpiderWeb.tscn")

#var spiderHealth = 20;
var velocity = Vector2();
var direction = 1;
var i = 0
var raycastValue = 250
var bite = false
var stealthActive = false
var Hp = 40

onready var player = get_node("../player")

func _physics_process(delta):
	velocity.x = SPEED * direction;
	velocity.y += GRAVITY;
	velocity = move_and_slide(velocity, FLOOR);
	
	if $RayCast2D.is_colliding() == false:
		direction = direction * -1;
		$RayCast2D.position.x *= -1
		raycastValue*=-1
		$spiderWeb.set_cast_to(Vector2(0,raycastValue))
		
	if direction == 1:
		$Sprite.flip_h = false;
	else:
		$Sprite.flip_h = true;
	
	if $spiderWeb.is_colliding() == true:
		var obj = get_node("spiderWeb").get_collider()
		if obj.get_name() == "player" && stealthActive ==false:
			while i < 6:
				var spiderWeb = SPIDERWEB.instance();
				get_parent().call_deferred("add_child", spiderWeb)
				
				if $spiderWeb.get_cast_to().y < 0:
					spiderWeb.direction*=-1
					
				spiderWeb.position = $Position2D.global_position;
				i = 9
		else:
			direction = direction * -1;
			$RayCast2D.position.x *= -1
			raycastValue*=-1
			$spiderWeb.set_cast_to(Vector2(0,raycastValue))
	else:
		i = 0
	


func _on_Bite_body_entered(body):
	if body.get_name() == "player":
		bite = true
	pass # replace with function body


func _on_Bite_body_exited(body):
	if body.get_name() == "player":
		bite = false
	pass # Replace with function body.


func _on_BiteTimer_timeout():
	if bite && stealthActive == false:
		var randomInt = randi() % 11
		if randomInt < 6:
			player._subtractHealth(2)
			print(player.health)
	pass # Replace with function body.

func _hurt(dmg):
	print("you've hurt the Goliath's feelings for: " + str(dmg));
	if Hp > 0:
		Hp = Hp - dmg;
		if Hp <= 0:
			self.queue_free();