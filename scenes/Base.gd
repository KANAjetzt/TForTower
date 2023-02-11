extends CharacterBody3D

@onready var tower = $Towers/Tower


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _physics_process(delta):
	move_and_slide()
	
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		
		if collision.get_collider() == null:
			continue
		
		if collision.get_collider().is_in_group("enemy"):
			var enemy = collision.get_collider()
			enemy.remove()


#func _on_input_event(camera, event, position, normal, shape_idx):	
#
#	if event is InputEventMouseMotion:
#		print(event)
#		print("I LIKE TO MOVE IT!")
#		print(tower.position)
#
#
#	if event is InputEventMouseButton:
#		print(event)
#		print("CLICKIDY!")
