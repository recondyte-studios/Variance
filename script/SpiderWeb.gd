extends Area2D

const SPEED = 300;
var velocity = Vector2();

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _physics_process(delta):
	velocity.x = SPEED * delta;
	translate(velocity);
	


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	pass # replace with function body
