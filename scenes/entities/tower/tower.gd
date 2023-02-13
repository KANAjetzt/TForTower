extends CharacterBody3D

signal closest_changed(target: Target)

@onready var range = $Range
@onready var weapons = $Weapons


var target_closest: Target = Target.new()

func _ready():
	get_closest()


func _physics_process(delta):
	get_closest()


func get_closest() -> void:
	# Update the position of the current cloests target
	if target_closest != null && is_instance_valid(target_closest.instance):
		target_closest.distance = global_position.distance_squared_to(target_closest.instance.position)
	
	# Get closest enemy
	for target in range.bodies:
		if not is_instance_valid(target):
			return
		
		# Get the distance from the tower to the current enemy
		var distance_current := global_position.distance_squared_to(target.position)
		
		# If there is no closest target yet use this one and send closest_changed signal.
		if target_closest.instance == null || !is_instance_valid(target_closest.instance):
			target_closest.instance = target
			target_closest.distance = distance_current
			
			emit_signal("closest_changed", target_closest)
		
		# If the distance to current closest enemy is higher then to the current one.
		# Update the closest enemy and send closest_changed signal.
		if target_closest.distance > distance_current:
			target_closest.instance = target
			target_closest.distance = distance_current
			
			emit_signal("closest_changed", target_closest)
