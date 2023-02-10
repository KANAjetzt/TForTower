extends CharacterBody3D


const SPEED = 1.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	move_and_slide()

func _ready():
	initialize(position, Vector3.ZERO)

func initialize(start_position, player_position) -> void:
	look_at_from_position(start_position, player_position, Vector3.UP)
	
	velocity = Vector3.FORWARD * SPEED
	velocity = velocity.rotated(Vector3.UP, rotation.y)
