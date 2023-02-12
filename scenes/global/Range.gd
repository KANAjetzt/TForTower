extends Area3D

var bodies := []

func _on_body_entered(body):
	body.removed.connect(_clear_body_from_bodies)
	bodies.push_front(body)

func _clear_body_from_bodies():
	Utils.array_clean(bodies)
