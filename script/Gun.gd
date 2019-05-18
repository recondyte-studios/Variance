extends Node2D

var Bullet = preload("res://player/Volcan/VortexAxe.tscn")
var bullet_speed = 500;

func _shoot(GunDir) -> void:
	#Bullet scene is loading into game
	var new_bullet = Bullet.instance();
	self.add_child(new_bullet);
	new_bullet.add_to_group("Bullet", true);
	#Bullet position and rotation is set to the spawn point and rotation on the player
	if GunDir == 1:
		new_bullet.position = $"RightBulletSpawn".global_position;
	else:
		new_bullet.position = $"LeftBulletSpawn".global_position;
#	print("Bullet Position is: ")
#	print(new_bullet);
	new_bullet.linear_velocity = Vector2(bullet_speed*GunDir, 1);
#	print("Linear Velocity of the bullet is: ")
#	print(new_bullet.linear_velocity);
