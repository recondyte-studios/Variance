extends Area2D

const SPEED = 400;

var playerPos 
var pos = false;

func _ready():
	$Timer.start()
	pass

func _physics_process(delta):
	if pos == true:
		var direction1 = (playerPos - position).normalized()
		var motion = (direction1 * SPEED * delta)
		position += motion

func _on_shockWave__body_entered(body):
	if body.name == "player":
		body._subtractHealth(5);
		queue_free();
	pass # Replace with function body.


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	pass # Replace with function body.


func _on_Timer_timeout():
	playerPos = get_node("../player").get_position() + Vector2(0,300)
	pos = true
	pass # Replace with function body.
