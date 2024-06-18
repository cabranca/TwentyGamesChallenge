extends Node2D

@export var ball_scene : PackedScene
@export var player_scene: PackedScene

func _ready() -> void:
	# Create the ball and connect to its signal
	var ball_node = ball_scene.instantiate()
	ball_node.life_lost.connect(on_life_lost)
	add_child(ball_node)
	
	# Create the player
	var player_node = player_scene.instantiate()
	add_child(player_node)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta) -> void:
	pass

func on_life_lost() -> void:
	print("reset ball")
	await get_tree().create_timer(1.0).timeout
	$Ball.start()
