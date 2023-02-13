extends Node3D


func fly_to_target(target: PhysicsBody3D):
	look_at(target.position)
	var tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", target.position, 0.1)
	tween.tween_callback(self.queue_free)

func _on_visible_on_screen_notifier_3d_screen_exited():
	queue_free()
