extends Control

@onready var count = $HBoxContainer/count


# Called when the node enters the scene tree for the first time.
func _ready():
	update_count()
	RunData.connect("material_changed", _on_material_changed)


func update_count():
	count.text = str(RunData.material_count)


func _on_material_changed(new_count):
	update_count()
