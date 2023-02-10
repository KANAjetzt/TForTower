extends MeshInstance3D

signal spawn(spawner_instance)

@export var rate : float = 0.5
@export var radius : int = 250.0
@export var speed : float = 2.0
@export var enemy_type : PackedScene

@onready var timer = $Timer

var d := 0.0

func _ready():
	timer.wait_time = rate


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	d += delta
	
	position = Vector3(
		sin(d * speed) * radius,
		position.y,
		cos(d * speed) * radius,
		)
	


func _on_timer_timeout():
	emit_signal("spawn", self)
