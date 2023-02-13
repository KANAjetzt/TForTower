extends CharacterBody3D

signal closest_changed(body)

@onready var range = $Range
@onready var weapons = $Weapons
@onready var label = $CanvasLayer/Label


@onready var body_closest = null

func _ready():
	get_closest()


func _physics_process(delta):
	get_closest()


func get_closest() -> void:
	# Update the position of the current cloests body
	if body_closest != null && is_instance_valid(body_closest.body):
		body_closest.distance = global_position.distance_squared_to(body_closest.body.position)
	
	# Get closest enemy
	for body in range.bodies:
		if not is_instance_valid(body):
			return
		
		# Get the distance from the tower to the current enemy
		var distance_current := global_position.distance_squared_to(body.position)
		
		# If there is no closest body yet use this one and send closest_changed signal.
		if body_closest == null || !is_instance_valid(body_closest.body):
			body_closest = {
				"body": body,
				"distance": distance_current
			}
			
			emit_signal("closest_changed", body_closest.body)
		
		# If the distance to current closest enemy is higher then to the current one.
		# Update the closest enemy and send closest_changed signal.
		if body_closest.distance > distance_current:
			body_closest = {
				"body": body,
				"distance": distance_current
			}
			
			emit_signal("closest_changed", body_closest.body)
