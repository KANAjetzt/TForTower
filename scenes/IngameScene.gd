extends Node

@export var enemy_scene: PackedScene

@onready var fade_overlay = %FadeOverlay
@onready var pause_overlay = %PauseOverlay

@onready var base = $Base
@onready var enemy_spawn_location_0 = $SpawnPath_0/SpawnLocation
@onready var enemy_spawn_location_1 = $SpawnPath_1/SpawnLocation
@onready var spawn_point = $SpawnManager/SpawnPoint




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
		
func _save_game() -> void:
	SaveGame.save_game(get_tree())

func _on_spawn_point_spawn():
	var enemy = spawn_point.enemy_type.instantiate()
	enemy.initialize(spawn_point.position, base.position)
	add_child(enemy)
