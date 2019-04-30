extends Area2D

const SPEED = 350;
var velocity = Vector2();
var direction = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	if direction == 1:
		velocity.x = SPEED * delta;
		translate(velocity);
	else:
		velocity.x = SPEED * delta * -1;
		translate(velocity);


func _on_shockWave__body_entered(body):
	if body.name == "player":
		body._subtractHealth(5);
		queue_free();
	pass # Replace with function body.


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	pass # Replace with function body.
