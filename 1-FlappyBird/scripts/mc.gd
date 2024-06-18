extends Area2D

signal game_over

const JUMP_VELOCITY := -500.0
const GRAVITY := 5000.0

var ySpeed := 0.0

func _physics_process(delta):
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept"):
		ySpeed = JUMP_VELOCITY
	else:
		ySpeed += gravity * delta

	position.y += ySpeed * delta + GRAVITY * pow(delta, 2)


func _on_area_entered(_area):
	game_over.emit()
	queue_free()
