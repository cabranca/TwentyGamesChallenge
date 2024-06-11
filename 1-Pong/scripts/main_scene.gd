extends Node2D

@export var ball_scene : PackedScene
@export var player_scene : PackedScene
@export var cpu_scene : PackedScene

@export var p1_script : Script
@export var p2_script : Script
@export var cpu_script : Script
@export var ball_script : Script

var _left_score := 0
var _right_score := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var p1_instance = player_scene.instantiate()
	p1_instance.set_script(p1_script)
	add_child(p1_instance)
	
	if(GlobalVariables.game_mode == GlobalVariables.Mode.PvE):
		_instance_rival(cpu_scene, cpu_script)
	else:
		_instance_rival(player_scene, p2_script)
	
	var ball_instance = ball_scene.instantiate()
	ball_instance.set_script(ball_script)
	add_child(ball_instance)
	
	$"Boundaries/Left Wall".area_exited.connect(_on_left_wall_area_exited)
	$"Boundaries/Right Wall".area_exited.connect(_on_right_wall_area_exited)
	ball_instance.ball_collision.connect(_on_ball_collision)

func _instance_rival(scene: PackedScene, script: Script) -> void:
	var instance = scene.instantiate()
	instance.set_script(script)
	add_child(instance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	pass


func _on_left_wall_area_exited(area: Area2D) -> void:
	_right_score += 1
	$"UI/Right Score".text = str(_right_score)
	await get_tree().create_timer(1.0).timeout
	$Ball.reset()

func _on_right_wall_area_exited(area: Area2D) -> void:
	_left_score += 1
	$"UI/Left Score".text = str(_left_score)
	await get_tree().create_timer(1.0).timeout
	$Ball.reset()

func _on_ball_collision(ball_position: Vector2, direction: Vector2):
	get_node("CPU").set_direction(ball_position, direction)
