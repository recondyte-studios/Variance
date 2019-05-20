extends Area2D

const SPEED = 500;
var velocity = Vector2();
var direction = 1

func _ready():
	pass

func _physics_process(delta):
	if direction == 1:
		velocity.x = SPEED * delta;
		translate(velocity);
	else:
		velocity.x = SPEED * delta * -1;
		translate(velocity);


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	pass # replace with function body

func _on_Fireball_body_entered(body):
	if body.name == "player":
		body._subtractHealth(25);
		queue_free();
	pass # Replace with function body.
