extends KinematicBody2D

const GRAVITY = 10;
const SPEED = 200;
const FLOOR = Vector2(0,-1);
const FIREBALL = preload("res://scene/SpiderWeb.tscn")
const POISON = preload("res://scene/SpiderPoison.tscn")
var spiderHealth = 110;
var velocity = Vector2();
var direction = 1;
var i = 0
var raycastValue = 250
var spwn= false
var walk = false

onready var spawnPt = [get_node("../spawnPt1"), get_node("../spawnPt2"), get_node("../spawnPt3")]
onready var player = get_node("../player")


func _physics_process(delta):
	if walk == true:
		velocity.x = SPEED * direction;
		velocity.y += GRAVITY;
		velocity = move_and_slide(velocity, FLOOR);
	
	if direction == 1:
		$Sprite.flip_h = false;
	else:
		$Sprite.flip_h = true;
		i =0
	
	if $spiderWeb.is_colliding() == true:
		var randomInt = randi() % 11
		if randomInt > 6:
			FireBall()
			walk = false;
		else:
			Claw()
			walk = false


func FireBall():
	var obj = get_node("FireBallDetector").get_collider()
	if obj.get_name() == "player":
		while i < 6:
			var fireball = FIREBALL.instance();
			get_parent().call_deferred("add_child", fireball)
			if $FireBallDetector.get_cast_to().y < 0:
				fireball.direction*=-1
			fireball.position = $Position2D.global_position;
			i = 9
	if obj.get_name() !="player":
		_directional()

#need to be fix
func Claw():
	var obj = get_node("FireBallDetector").get_collider()
	if obj.get_name() == "player":
		while i < 6:
			var fireball = FIREBALL.instance();
			get_parent().call_deferred("add_child", fireball)
			if $FireBallDetector.get_cast_to().y < 0:
					fireball.direction*=-1
			fireball.position = $Position2D.global_position;
			i = 9
	if obj.get_name() !="player":
		_directional()


func _directional():
		direction = direction * -1;
		$spiderWeb.position.x *= -1
		$Position2D.position.x *= -1
		raycastValue*=-1
		$spiderWeb.set_cast_to(Vector2(0,raycastValue))
