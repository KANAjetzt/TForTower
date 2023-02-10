extends Node

@export var enemy_scene: PackedScene

@onready var fade_overlay = %FadeOverlay
@onready var pause_overlay = %PauseOverlay

@onready var base = $Base
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

func _on_spawn_point_spawn(spawner_instance):
	var enemy = spawner_instance.enemy_type.instantiate()
	enemy.initialize(spawner_instance.position, base.position)
	add_child(enemy)
