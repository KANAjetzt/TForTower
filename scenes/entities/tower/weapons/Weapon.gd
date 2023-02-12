extends Node3D

@export var projectial : PackedScene

var target_current : PhysicsBody3D = null
var target_closest : PhysicsBody3D = null
var damage := 25
var krit_multiplier := 2.0

func shoot(target):
	print("SHOOTING")
	# shot at target
	
	# spawn projectile
	# set position to global tower position
	var new_projectial = Utils.instance_on_main(projectial, global_position)
	
	# projectile fly to target
	new_projectial.fly_to_target(target)
	
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
