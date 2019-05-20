extends KinematicBody2D

const GRAVITY = 10;
const SPEED = 200;
const FLOOR = Vector2(0,-1);
const SPIDERWEB = preload("res://scene/SpiderWeb.tscn")
const TARANTULA = preload("res://scene/Tarantula.tscn")
const POISON = preload("res://scene/SpiderPoison.tscn")

var spiderHealth = 110;
var velocity = Vector2();
var direction = 1;
var i = 0
var raycastValue = 250
var spwn= false
var walk = false
var poisonCounter = 0
var stealthActive = false
var Hp = 500

onready var spawnPt = [get_node("../spawnPt1"), get_node("../spawnPt2")]
onready var player = get_node("../player")


func _physics_process(delta):
	if walk == true:
		velocity.x = SPEED * direction;
		velocity.y += GRAVITY;
		velocity = move_and_slide(velocity, FLOOR);
		$Sprite/AnimationPlayer.play("EdgySpidyWalk")
	
	if Hp < 375 && spwn == false:
		_spwnMiniSpider()
		print("Spawn Mini Spider Activate")
	
	if direction == 1:
		$Sprite.flip_h = false;
	else:
		$Sprite.flip_h = true;
	
	if $spiderWeb.is_colliding() == true:
		var randomInt = randi() % 11
		if randomInt > 6:
			_shootWEB()
		else:
			_poisonPlayer()
	else:
		i =0



func _shootWEB():
	var obj = get_node("spiderWeb").get_collider()
	if obj.get_name() == "player" && stealthActive == false:
		#walk = false
		while i < 6:
			var spiderWeb = SPIDERWEB.instance();
			get_parent().call_deferred("add_child", spiderWeb)
			if $spiderWeb.get_cast_to().y < 0:
				spiderWeb.direction*=-1
				spiderWeb.get_node("Sprite").flip_h = true
			spiderWeb.position = $Position2D.global_position;
			i = 9
	else:
		_directional()



func _poisonPlayer():
	var obj = get_node("spiderWeb").get_collider()
	if obj.get_name() == "player" && stealthActive == false:
		#walk = false
		while i < 6:
			var poison = POISON.instance();
			get_parent().call_deferred("add_child", poison)
			if $spiderWeb.get_cast_to().y < 0:
				poison.direction*=-1
				poison.get_node("Sprite").flip_h = true
			poison.position = $Position2D.global_position;
			i = 9
	else:
		_directional()


func _directional():
	walk = false
	direction = direction * -1;
	$spiderWeb.position.x *= -1
	$Position2D.position.x *= -1
	raycastValue*=-1
	$spiderWeb.set_cast_to(Vector2(0,raycastValue))
	$Sprite/AnimationPlayer.stop()


func _spwnMiniSpider():
	for i in 2:
		var tarantula = TARANTULA.instance();
		get_parent().call_deferred("add_child", tarantula)
		tarantula.position = spawnPt[i].global_position;
		tarantula.get_node("spiderWeb").set_cast_to(Vector2(0,50))
	spwn = true
	$SpwnSpiderTimer.start()


func _on_Timer_timeout():
	spwn = false
	pass # Replace with function body.


func _on_BossWalkingTimer_timeout():
	walk = true
	pass # Replace with function body.


func _on_PoisonTimer_timeout():
	if poisonCounter < 3:
		player._subtractHealth(5)
		poisonCounter += 1
		$PoisonTimer.start()
		print(player.health) 
	pass # Replace with function body.


func _on_bounce_body_entered(body):
	if body.get_name() == "player":
		body._subtractHealth(5);
		body.bounce = true
	
	pass # Replace with function body.

func _hurt(dmg):
	print("you've hurt the Goliath's feelings for: " + str(dmg));
	if Hp > 0:
		Hp = Hp - dmg;
		if Hp <= 0:
			get_tree().change_scene("res://scene/Win Screen.tscn");
			self.queue_free();