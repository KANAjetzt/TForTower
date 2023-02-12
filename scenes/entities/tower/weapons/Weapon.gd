extends Node3D

var target_current : PhysicsBody3D = null
var target_closest : PhysicsBody3D = null
var is_shooting := false

func shoot(target):
	print("SHOOTING")
	# shot at target
	
	# spawn projectile
	
	# projectile fly to target
	
	# give target damage on projectile hit

func _on_cooldown_timeout():
	# Check if current does not exist
	if not is_instance_valid(target_current):
		# If the closest target exists switch to that and shoot
		if is_instance_valid(target_closest):
			target_current = target_closest
			shoot(target_current)
		return
	
	shoot(target_current)


func _on_tower_closest_changed(body):
	print("TOWER WEAPON: Closest Target is now -> ", body)
	target_closest = body
