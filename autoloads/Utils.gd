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
