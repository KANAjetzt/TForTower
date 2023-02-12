extends Node

# Removes null instances from an array
static func array_clean(array) -> void:
	# Loop through bodies backwards and remove first null element
	# https://www.reddit.com/r/godot/comments/zlxco4/quick_tip_deleting_elements_from_an_array_iterate/
	for i in range(array.size() - 1, -1, -1):
			var element = array[i]
			if not is_instance_valid(element):
				array.remove_at(i)
				break

func instance_on_main(scene: PackedScene, position: Vector3) -> Node:
	var main = get_tree().current_scene
	var instance = scene.instantiate()
	main.add_child(instance)
	
	instance.global_position = position
	
	return instance
