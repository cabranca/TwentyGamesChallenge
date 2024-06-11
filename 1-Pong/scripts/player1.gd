extends "res://scripts/player.gd"

	# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("P1 up"):
		direction = -1
	elif Input.is_action_pressed("P1 down"):
		direction = 1
	else:
		direction = 0
	
	position.y = clamp(position.y + direction * speed * delta, 0.0, viewport_height)
