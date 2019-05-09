extends KinematicBody2D

var run_speed = 300
var jump_speed = -950
var gravity = 2500
var velocity = Vector2()
var onAir = false;
var timer = false;
var health = 300;
var bounce = false


onready var sprite = get_node("Sprite");
onready var Character = load("res://saves/SaveGame.gd");

#onready var label = get_node("../Player/Camera2D/Label");
#onready var animForward = get_node("../Player/Sprite/walkingCycle")

#func _ready():
#	$sprite.texture(Character.SelectedCharacter);


func _process(delta):
	if run_speed < 300:
		if timer == false:
			$SlowWalkTimer.start()
			timer = true;
	
func _subtractHealth(var dmg):
	health -= dmg

func get_input():
	velocity.x = 0
	var right = Input.is_action_pressed('ui_right')
	var left = Input.is_action_pressed('ui_left')
	var jump = Input.is_action_just_pressed('ui_up')

	if is_on_floor() and jump:
		velocity.y = jump_speed
		onAir = true;
		
	if right:
#		animForward.play("Forward");
#		animForward.seek(0, true)
		velocity.x += run_speed;
		
	if left:
		velocity.x -= run_speed
		
	if onAir == true:
		if !is_on_floor() and jump:
			velocity.y = jump_speed + 200;
			onAir = false;

func _physics_process(delta):
	velocity.y += gravity * delta;
	get_input();
	velocity = move_and_slide(velocity, Vector2(0, -1));
	if bounce == true:
		var direction1 = (position - get_node("../Boss/Position2D2").get_position()).normalized()
		var motion = (direction1 * run_speed * delta)
		position -= motion
		gravity = 1700

func _on_Timer_timeout():
	run_speed = 300;
	timer = false;
	pass # replace with function body
