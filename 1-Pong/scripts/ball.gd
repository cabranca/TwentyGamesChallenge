extends Area2D

@export var speed := 500.0

var RADIUS : float

var _direction : Vector2

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	$Timer.timeout.connect(_on_timeout)
	RADIUS = $Sprite2D.get_rect().size.y


func _process(delta: float) -> void:
	position += _direction * speed * delta

func start() -> void:
	var initial_angle = randf_range(-45.0, 45.0)
	var possible_directions = [-1, 1]
	var initial_direction = possible_directions.pick_random()
	_direction = Vector2(initial_direction, 0).rotated((initial_angle * PI) / 180.0)

func _on_area_entered(area: Area2D) -> void:
	# If the ball tresspassed the bar front face more than its radius, it will not bounce.
	# and abs(area.position.x - position.x) > RADIUS /// YET NOT IMPLEMENTED
	if area.is_in_group("Bar"):
		_direction = Vector2(-_direction.x, _direction.y)
		speed += 20.0
	if area.is_in_group("Wall"):
		_direction = Vector2(_direction.x, -_direction.y)

func _on_timeout() -> void:
	start()

func get_direction() -> float:
	return _direction.x
