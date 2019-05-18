extends KinematicBody2D

const GRAVITY = 10;
const FLOOR = Vector2(0,-1);

#var goliath = 40;
var velocity = Vector2();
var direction = 1;
var raycastValue = 50
var stalking = false
var i = 0
var check = 0
var SPEED = 200;
var claw = false;
var Hp = 20;


onready var player = get_node("../player")
onready var position1 = self.get_position().x + 600;
onready var position2 = self.get_position().x;

func _ready():
	pass

func _process(delta):
	$CanvasLayer/HpBar.set_value(Hp);

func _physics_process(delta):
#	velocity.x = SPEED * direction;
	velocity.y += GRAVITY;
	
	if(check == 0):
		velocity.x= SPEED;
		if(self.get_position().x > position1):
			check = 1;
			direction *= -1
			$AnimatedSprite.flip_h = false;
	if(check == 1):
		velocity.x= -SPEED;
		if(self.get_position().x < position2):
			check = 0;
			direction *= -1
			$AnimatedSprite.flip_h = true;
	
#	if $RayCast2D.is_colliding() == false:
#		direction = direction * -1;
#		$RayCast2D.position.x *= -1
#		raycastValue*=-1
#		$wallDetection.set_cast_to(Vector2(0,raycastValue))
		
	if direction == 1:
		$AnimatedSprite.flip_h = false;
	else:
		$AnimatedSprite.flip_h = true;
	
#	if $wallDetection.is_colliding() == true:
#		var obj = $wallDetection.get_collider()
#		if obj.get_name() == "player":
#			while i < 6:
#				player._subtractHealth(5);
#				i = 7
#		else:
#			direction = direction * -1;
#			$RayCast2D.position.x *= -1
#			raycastValue*=-1
#			$wallDetection.set_cast_to(Vector2(0,raycastValue))
#	else:
#		i = 0
		
	if stalking:
		SPEED = 350
		if player.get_position().x > self.get_position().x:
			velocity.x = SPEED
			direction = 1
		if player.get_position().x < self.get_position().x:
			velocity.x = -SPEED
			direction = -1
	else:
		SPEED = 200
	velocity = move_and_slide(velocity, FLOOR);


func _on_StalkRange_body_entered(body):
	if body.get_name() == "player":
		stalking = true
	pass # Replace with function body.


func _on_StalkRange_body_exited(body):
	if body.get_name() == "player":
		stalking = false
		direction *= -1
	pass # Replace with function body.


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
			player._subtractHealth(5)
	pass # Replace with function body.


func _on_Bounce_body_entered(body):
	if body.get_name() == "player":
		body._subtractHealth(5);
		body.miniEnemyBounce = true
	pass # Replace with function body.

func _hurt(dmg):
	print("you've hurt the Goliath's feelings for: " + str(dmg));
	if Hp > 0:
		Hp = Hp - dmg;
		if Hp <= 0:
			self.queue_free();