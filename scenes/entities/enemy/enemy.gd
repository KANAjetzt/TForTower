extends CharacterBody3D

signal removed

var speed:= 20.0
var hp := 100
var is_alive := true


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	move_and_slide()


func initialize(start_position, player_position) -> void:
	look_at_from_position(start_position, player_position, Vector3.UP)
	
	velocity = Vector3.FORWARD * speed
	velocity = velocity.rotated(Vector3.UP, rotation.y)


func remove_hp(hp_to_remove):
	if(hp - hp_to_remove <= 0):
		is_alive = false
		remove()
		return
		
	hp = hp - hp_to_remove

func remove():
	removed.emit()
	queue_free()
