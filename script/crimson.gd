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
var stealthActive = false
var Hp = 500


onready var player = get_node("../player")
onready var position1 = self.get_position().x + 770;
onready var position2 = self.get_position().x;

func _ready():
	pass

func _physics_process(delta):
	velocity.x = SPEED * direction;
	velocity.y += GRAVITY;
	velocity = move_and_slide(velocity, FLOOR);
	SPEED = 200
	
	if direction == 1:
		$AnimatedSprite.flip_h = false;
		$FireballPos.position.x *= -1
	else:
		$AnimatedSprite.flip_h = true;
		$FireballPos.position.x *= -1
	
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
		fireball = false
	pass # Replace with function body.


func _on_Claw_body_exited(body):
	if body.get_name() == "player":
		claw = false
	pass # Replace with function body.


func _on_Timer_timeout():
	if claw && stealthActive == false:
		var randomInt = randi() % 11
		if randomInt < 6:
			player._subtractHealth(10)
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
	if fireball && stealthActive == false:
		var randomInt = randi() % 11
		if randomInt > 6:
			SPEED = 100
			var fireball = FIREBALL.instance();
			get_parent().call_deferred("add_child", fireball)
			if direction != 1:
				fireball.direction*=-1
			fireball.position = $FireballPos.global_position;
	pass # Replace with function body.


func _on_bounce_body_entered(body):
	if body.get_name() == "player":
		body._subtractHealth(2);
		body.bounce = true
	pass # Replace with function body.

func _hurt(dmg):
	print("you've hurt the Goliath's feelings for: " + str(dmg));
	if Hp > 0:
		Hp = Hp - dmg;
		if Hp <= 0:
			get_node("../PortalToSewer").set_position(Vector2(1346,618))
			self.queue_free();

