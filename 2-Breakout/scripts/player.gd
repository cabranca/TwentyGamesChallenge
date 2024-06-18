extends Area2D

const SPEED := 400.0
var viewport_width : float
var sprite_width : float

var direction := 0.0

func _ready():
	viewport_width = get_viewport_rect().size.x
	sprite_width = $Sprite2D.get_rect().size.x * scale.x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("move_right"):
		direction = 1.0
	elif Input.is_action_pressed("move_left"):
		direction = -1.0
	else:
		direction = 0.0
	
	position.x = clamp(position.x + direction * SPEED * delta, sprite_width / 2, viewport_width - sprite_width / 2)
