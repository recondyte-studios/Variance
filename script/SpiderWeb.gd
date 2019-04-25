extends Area2D

const SPEED = 300;
var velocity = Vector2();

func _ready():
	pass

func _physics_process(delta):
	velocity.x = SPEED * delta;
	translate(velocity);
	

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	pass # replace with function body


func _on_SpiderWeb_body_entered(body):
	if body.name == "player":
		body.run_speed = body.run_speed - 50
		if (body.run_speed == 100):
			body.run_speed = 100;
		queue_free();
	pass # replace with function body
