extends KinematicBody2D

onready var VolcanAxe = preload("res://scene/VolcanAxe.tscn")
onready var AttackRange = get_node("AttackRange");
onready var AttackAnim = get_node("AttackAnim");


var run_speed = 300
var jump_speed = -950
var gravity = 2500
var velocity = Vector2()
var onAir = false;
var timer = false;
var health = 300;
var bounce = false
var FlameStacks = 0;
var MaxStacks = 30;
var GunDir = 1;

onready var sprite = get_node("Sprite");
onready var Volcan = load("res://player/Volcan.gd");

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
	var ManaBar = $CanvasLayer/ManaBar;
	hpBar.set_value(health);
	ManaBar.set_value(FlameStacks);
	
	if health < 0:
		get_tree().change_scene("res://scene/DeathScreen.tscn");
	
#	if not FlameStacks <= 0:
##		$StacksTimer.start();
#		FlameStacks -= 1;

func _subtractHealth(var dmg):
	health -= dmg

func get_input():
	velocity.x = 0
	var right = Input.is_action_pressed('ui_right');
	var left = Input.is_action_pressed('ui_left');
	var jump = Input.is_action_just_pressed('ui_up');
	var baseAttack = Input.is_action_just_pressed("BasicAttack");
	var specialAttack = Input.is_action_just_pressed("SpecialAttack");
	
	if is_on_floor() and jump:
		velocity.y = jump_speed
		onAir = true;
		
	if right:
#		animForward.play("Forward");
#		animForward.seek(0, true)
		velocity.x += run_speed;
		GunDir = 1;
		
	if left:
		velocity.x -= run_speed
		GunDir = -1;
		
	if baseAttack:
		_BasicAttack();
	
	if specialAttack:
		_SpecialAttack();
		
	if onAir == true:
		if !is_on_floor() and jump:
			velocity.y = jump_speed + 200;
			onAir = false;

func _physics_process(delta):
	velocity.y += gravity * delta;
	get_input();
	velocity = move_and_slide(velocity, Vector2(0, -1));
	if bounce == true:
		velocity.x += run_speed;
		velocity.y = jump_speed
		if position.y > get_node("../Boss/Position2D2").get_position().y:
			bounce = false


func _on_Timer_timeout():
	run_speed = 300;
	timer = false;
	pass # replace with function body


#==================
#Volcan's Attacks
#==================


func _FlameStacks(stacks):
	if FlameStacks <= 30:
		FlameStacks = FlameStacks + stacks;
	else:
		pass;

func _BasicAttack():
	AttackAnim.play("BasicAttack");
	var body = AttackRange.get_overlapping_bodies();
	for i in body:
		if i.is_in_group("Enemy"):
			i._hurt(5);
			_FlameStacks(2);
		else:
			pass;
	if AttackAnim.animation_finished:
		AttackAnim.visible = false;

func _SpecialAttack():
	print("Used: " + str(FlameStacks));
	if FlameStacks == 0:
		_BasicAttack();
	elif FlameStacks >= 5:
		VolcanAxe.instance();
		pass