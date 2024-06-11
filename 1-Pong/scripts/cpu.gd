extends Player

var target : float

func _init() -> void:
	speed = 500

func _ready() -> void:
	viewport_height = get_viewport_rect().size.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	if target > position.y + 10.0:
		position.y = clamp(position.y + speed * delta, 0.0, viewport_height)
	elif target < position.y - 10.0:
		position.y = clamp(position.y - speed * delta, 0.0, viewport_height)


func set_direction(ball_position : Vector2, ball_direction : Vector2) -> void:
	# Px + lambda * Dx = bar_pos.x
	var lambda = (position.x - ball_position.x) / ball_direction.x
	# Py + lambda * Dy = gamma (target)
	target = ball_position.y + lambda * ball_direction.y
	
