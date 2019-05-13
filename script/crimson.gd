extends KinematicBody2D

const GRAVITY = 10;
const FLOOR = Vector2(0,-1);
const FIREBALL = preload("res://scene/Fireball.tscn")


#var CrimsonHealth = 300;
var velocity = Vector2();
var direction = 1;
var raycastValue = 50
var stalking = false
var i = 0
var SPEED = 200;
var claw = false
var check =0 
var fireball = false


onready var player = get_node("../player")
onready var position1 = self.get_position().x + 800;
onready var position2 = self.get_position().x;

func _ready():
	pass

func _physics_process(delta):
	velocity.x = SPEED * direction;
	velocity.y += GRAVITY;
	velocity = move_and_slide(velocity, FLOOR);
	
	if direction == 1:
		$Sprite.flip_h = true;
		$Position2D.position.x *= -1
	else:
		$Sprite.flip_h = false;
		$Position2D.position.x *= -1
	
#	if $FireBallDetector.is_colliding() == true:
#		var obj = $FireBallDetector.get_collider()
#		if obj.get_name() == "player":
#			while i < 6:
#				var fireball = FIREBALL.instance();
#				get_parent().call_deferred("add_child", fireball)
#				if $FireBallDetector.get_cast_to().y < 0:
#					fireball.direction*=-1
#				fireball.position = $Position2D.global_position;
#				i = 9
#		else:
#			direction = direction * -1;
#			$RayCast2D.position.x *= -1
#			raycastValue*=-1
#			$FireBallDetector.set_cast_to(Vector2(0,raycastValue))
#	else:
#		i = 0
	
	if(check == 0):
		velocity.x= SPEED;
		if(self.get_position().x > position1):
			check = 1;
			direction *= -1
	if(check == 1):
		velocity.x= -SPEED;
		if(self.get_position().x < position2):
			check = 0;
			direction *= -1
	
	if stalking:
		SPEED = 300
		if player.get_position().x > self.get_position().x:
			velocity.x = SPEED
			direction = 1
		if player.get_position().x < self.get_position().x:
			velocity.x = -SPEED
			direction = -1
	else:
		SPEED = 200


func _on_Claw_body_entered(body):
	if body.get_name() == "player":
		claw = true;
	pass # Replace with function body.


func _on_Claw_body_exited(body):
	if body.get_name() == "player":
		claw = false
	pass # Replace with function body.


func _on_Timer_timeout():
	if claw:
		var randomInt = randi() % 11
		if randomInt < 6:
			player._subtractHealth(2)
		print(player.health)
	pass # Replace with function body.


func _on_stalking_body_entered(body):
	if body.get_name() == "player":
		stalking = true
		fireball = true
	pass # Replace with function body.


func _on_stalking_body_exited(body):
	if body.get_name() == "player":
		stalking = false
		fireball = false
		direction *= -1
	pass # Replace with function body.


func _on_FireballTimer_timeout():
	if fireball:
		var randomInt = randi() % 11
		if randomInt > 5:
			var fireball = FIREBALL.instance();
			get_parent().call_deferred("add_child", fireball)
			if direction != 1:
				fireball.direction*=-1
			fireball.position = $Position2D.global_position;
	pass # Replace with function body.
