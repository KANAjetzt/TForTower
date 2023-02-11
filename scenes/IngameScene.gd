extends Node3D

@export var enemy_scene: PackedScene

@onready var fade_overlay = %FadeOverlay
@onready var pause_overlay = %PauseOverlay

@onready var camera = $Camera3D
@onready var base = $Base
@onready var tower_preview = $TowerPreview
@onready var towers = $Base/Towers
@onready var spawn_point = $SpawnManager/SpawnPoint

func _physics_process(delta):
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_length = 100
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * ray_length
	var space = get_world_3d().direct_space_state
	var ray_query = PhysicsRayQueryParameters3D.new()
	ray_query.from = from
	ray_query.to = to
	ray_query.collide_with_areas = true
	var raycast_result = space.intersect_ray(ray_query)
	
	if raycast_result.collider == base:
		print(raycast_result)
		tower_preview.position = Vector3(raycast_result.position.x, 1.0, raycast_result.position.z)


func _ready() -> void:
	randomize()
	fade_overlay.visible = true
	
	if SaveGame.has_save():
		SaveGame.load_game(get_tree())
	
	pause_overlay.game_exited.connect(_save_game)

func _input(event) -> void:
	if event.is_action_pressed("pause") and not pause_overlay.visible:
		get_viewport().set_input_as_handled()
		get_tree().paused = true
		pause_overlay.grab_focus()
		pause_overlay.visible = true
	
	if event.is_action_pressed('place_tower') and not pause_overlay.visible:
		var new_tower = preload("res://scenes/entities/tower/tower.tscn").instantiate()
		new_tower.position = tower_preview.position
		towers.add_child(new_tower)
		
		
func _save_game() -> void:
	SaveGame.save_game(get_tree())

func _on_spawn_point_spawn(spawner_instance):
	var enemy = spawner_instance.enemy_type.instantiate()
	enemy.initialize(spawner_instance.position, base.position)
	add_child(enemy)
