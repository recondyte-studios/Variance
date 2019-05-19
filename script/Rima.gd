extends KinematicBody2D

const goliath = preload("res://script/Goliath.gd")
const tarantula = preload("res://script/Tarantula.gd")
const broodmother = preload("res://script/Broodmother.gd")
const crimson = preload("res://script/crimson.gd")

var run_speed = 300
var jump_speed = -950
var gravity = 2500
var velocity = Vector2()
var onAir = false;
var timer = false;
var health = 300;
var bounce = false

var miniEnemyBounce = false


#onready var sprite = get_node("Sprite");
#onready var Volcan = load("res://player/Volcan.gd");

#onready var label = get_node("../Player/Camera2D/Label");
#onready var animForward = get_node("../Player/Sprite/walkingCycle")

#func _ready():
#	$sprite.texture(Character.SelectedCharacter);


func _process(delta):
	if run_speed < 300:
		if timer == false:
			$SlowWalkTimer.start();
			timer = true;
	var hpBar = $CanvasLayer/HpBar;
	hpBar.set_value(health);
	if health < 0:
		get_tree().change_scene("res://scene/DeathScreen.tscn");
	
func _subtractHealth(var dmg):
	health -= dmg

func get_input():
	velocity.x = 0
	var right = Input.is_action_pressed('ui_right');
	var left = Input.is_action_pressed('ui_left');
	var jump = Input.is_action_just_pressed('ui_up');
	#var baseAttack = Input.is_action_just_pressed("BasicAttack");
	var stealth = Input.is_action_just_pressed('Shift');
	
	if is_on_floor() and jump:
		velocity.y = jump_speed
		onAir = true;
		
	if right:
#		animForward.play("Forward");
#		animForward.seek(0, true)
		velocity.x += run_speed;
		
	if left:
		velocity.x -= run_speed
		
#	if baseAttack:
#		_BasicAttack();
		
	if onAir == true:
		if !is_on_floor() and jump:
			velocity.y = jump_speed + 200;
			onAir = false;
			
	if stealth:
		goliath.stealthActive = true
		tarantula.stealACtive = true
		broodmother.stealthActive = true
		crimson.stealthActive = true
	else:
		goliath.stealthActive = false
		tarantula.stealACtive = false
		broodmother.stealthActive = false
		crimson.stealthActive = false

func _physics_process(delta):
	velocity.y += gravity * delta;
	get_input();
	velocity = move_and_slide(velocity, Vector2(0, -1));
	if bounce == true:
		velocity.x += run_speed;
		velocity.y = jump_speed
		if position.y > get_node("../Boss/bouncePos").get_position().y:
			bounce = false
	if miniEnemyBounce == true:
		velocity.x += run_speed;
		velocity.y = jump_speed
		if position.y > get_node("../Goliath/bouncePos").get_position().y:
			miniEnemyBounce = false
	


func _on_Timer_timeout():
	run_speed = 300;
	timer = false;
	pass # replace with function body
