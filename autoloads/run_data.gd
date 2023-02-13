extends Node

signal material_changed(new_value)

var material_count = 1000 : set = set_material_count


func set_material_count(new_material_count):
	material_count = new_material_count
	emit_signal("material_changed", material_count)


func material_remove(amount_to_remove: int) -> int:
	material_count = material_count - amount_to_remove
	return material_count
