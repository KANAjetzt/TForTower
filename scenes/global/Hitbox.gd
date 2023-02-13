extends Area3D

signal hit(body)

func _on_body_entered(body):
	emit_signal("hit", body)
