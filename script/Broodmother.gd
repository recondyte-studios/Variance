extends KinematicBody2D

const GRAVITY = 10;
const SPEED = 150;
const FLOOR = Vector2(0,-1);
const SPIDERWEB = preload("res://scene/SpiderWeb.tscn")
const TARANTULA = preload("res://scene/Tarantula.tscn")
var spiderHealth = 110;
var velocity = Vector2();
var direction = 1;
var i = 0
var raycastValue = 250
var spwn= false
onready var spawnPt = [$spawnPt1, $spawnPt2, $spawnPt3]


func _physics_process(delta):
	velocity.x = SPEED * direction;
	velocity.y += GRAVITY;
	velocity = move_and_slide(velocity, FLOOR);
	
	
	if spiderHealth < spiderHealth*.75 && spwn == false:
		for i in 3:
			var tarantula = TARANTULA.instance();
			get_parent().call_deferred("add_child", tarantula)
			tarantula.position = spawnPt[i].global_position;
		spwn = true
		$Timer.start()
	
	if direction == 1:
		$Sprite.flip_h = false;
	else:
		$Sprite.flip_h = true;
		i =0
	
	if $spiderWeb.is_colliding() == true:
		_shootWEB()
	else:
		_directional()
	
func _shootWEB():
	var obj = get_node("spiderWeb").get_collider()
	if obj.get_name() == "player":
		while i < 6:
			var spiderWeb = SPIDERWEB.instance();
			get_parent().call_deferred("add_child", spiderWeb)
			if $spiderWeb.get_cast_to().y < 0:
				spiderWeb.direction*=-1
			spiderWeb.position = $Position2D.global_position;
			i = 9

func _directional():
		direction = direction * -1;
		$RayCast2D.position.x *= -1
		raycastValue*=-1
		$spiderWeb.set_cast_to(Vector2(0,raycastValue))

func _on_Bite_body_entered(body):
	if body.get_name() == "player":
		var x = 0
		while x < 10:
			body._subtractHealth(1)
			x+=2;
	pass # replace with function body


func _on_Timer_timeout():
	spwn = false
	pass # Replace with function body.
