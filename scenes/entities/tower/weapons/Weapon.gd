extends Node3D

@export var projectial : PackedScene

@onready var cooldown = $Cooldown

var target_current : Target = Target.new()
var target_closest : Target = Target.new()
var attack_cooldown = 0.25
var damage := 25
var krit_multiplier := 2.0


func _ready():
	cooldown.start(attack_cooldown)


# shot at target
func shoot(target):
	# spawn projectile
	# set position to global tower position
	var new_projectial = Utils.instance_on_main(projectial, global_position)
	
	# projectile fly to target
	new_projectial.fly_to_target(target)
	
	# give target damage on projectile hit
	new_projectial.connect("target_reached", _on_projectial_target_reached)


func _on_cooldown_timeout():
	# Check if current does not exist
	if not is_instance_valid(target_current.instance):
		# If the closest target exists switch to that and shoot
		if is_instance_valid(target_closest.instance):
			target_current = target_closest
			shoot(target_current)
		return
	
	shoot(target_current)


func _on_tower_closest_changed(target: Target):
	target_closest = target


func _on_projectial_target_reached(target):
	target.remove_hp(damage)
