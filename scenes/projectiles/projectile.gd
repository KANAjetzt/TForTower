extends Node3D

signal target_reached(target_instance)

var speed: int = 100
var velocity = Vector3.ZERO


func _physics_process(delta):
	position += velocity * delta
	# Make sure projectile don't fly in the ground
	position.y = maxf(position.y , 1.0)
	
	
func fly_to_target(target: Target):
	var direction = global_position.direction_to(target.instance.position)
	
	velocity = Vector3(direction.x, direction.y, direction.z)  * speed
	look_at(target.instance.position)


func _on_visible_on_screen_notifier_3d_screen_exited():
	queue_free()


func _on_hitbox_hit(body):
	emit_signal("target_reached", body)
	hide()
	queue_free()
