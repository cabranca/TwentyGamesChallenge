extends Node2D

@export var ball_scene : PackedScene

var _left_score := 0
var _right_score := 0
var _pvp := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"Boundaries/Left Wall".area_exited.connect(_on_left_wall_area_exited)
	$"Boundaries/Right Wall".area_exited.connect(_on_right_wall_area_exited)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	# Make ball signal to tell when direction changed
	if not _pvp and $Ball.get_direction() > 0.0:
		$cpu.set_direction($Ball.position.y)


func _on_left_wall_area_exited(area: Area2D) -> void:
	_right_score += 1
	$"UI/Right Score".text = str(_right_score)
	reset_ball()

func _on_right_wall_area_exited(area: Area2D) -> void:
	_left_score += 1
	$"UI/Left Score".text = str(_left_score)
	reset_ball()

func reset_ball():
	remove_child($Ball)
	var ball_instance = ball_scene.instantiate()
	ball_instance.scale = Vector2(0.3, 0.3)
	add_child(ball_instance)
	
