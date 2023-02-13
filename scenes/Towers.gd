extends Node3D


var tower_scene := preload("res://scenes/entities/tower/tower.tscn")


func add_tower(position: Vector3):
	var new_tower = tower_scene.instantiate()
	
	# Check if enough materials
	if (RunData.material_count - new_tower.price) < 0:
		print("Sorry no tower for you :/ ")
		return
	
	# Remove material
	RunData.material_remove(new_tower.price)
	
	# Add new tower on preview position
	new_tower.position = position
	add_child(new_tower)
