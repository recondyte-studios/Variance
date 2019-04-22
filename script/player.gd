extends KinematicBody2D

var run_speed = 300
var jump_speed = -950
var gravity = 2500

var velocity = Vector2()

var onAir = false;

var score = 0;

#onready var label = get_node("../Player/Camera2D/Label");
#onready var animForward = get_node("../Player/Sprite/walkingCycle")

	

func add_score(var amount):
	score += amount
	var stringScore = str(score);
#	label.set_text(stringScore);

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
	get_input()
	velocity = move_and_slide(velocity, Vector2(0, -1))
	
	

