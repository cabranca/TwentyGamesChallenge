extends Area2D

signal ball_collision

@export var initial_speed := 500.0

var RADIUS : float
var speed := initial_speed
var direction : Vector2
var viewport_height: float

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	viewport_height = get_viewport_rect().size.y
	RADIUS = $Sprite2D.get_rect().size.y / 2
	start()

func reset() -> void:
	position = Vector2(560.0, 312.0)
	speed = initial_speed
	start()

func _process(delta: float) -> void:
	position.y = clamp(position.y + direction.y * speed * delta, RADIUS * scale.x, viewport_height - RADIUS * scale.x)
	position.x += direction.x * speed * delta
	

func start() -> void:
	var initial_angle = randf_range(-45.0, 45.0)
	var possible_directions = [-1, 1]
	var initial_direction = possible_directions.pick_random()
	direction = Vector2(initial_direction, 0).rotated(initial_angle * PI / 180.0)
	if initial_direction > 0:
		ball_collision.emit(position, direction)

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Bar"):
		var angle
		speed += 20.0
		if area.is_in_group("LeftBar"):
			angle = position.y - area.position.y
		else:
			angle = - (position.y - area.position.y)
		
		var scaled_angle = angle * 60 / (GlobalVariables.BAR_HEIGHT / 2)
		set_direction(scaled_angle)
		ball_collision.emit(position, direction)
	if area.is_in_group("Wall"):
		direction = Vector2(direction.x, -direction.y)
		if direction.x > 0:
			ball_collision.emit(position, direction)


func get_direction() -> float:
	return direction.x

func set_direction(newAngle: float) -> void:
	if direction.x > 0:
		direction = Vector2.LEFT
	elif direction.x < 0:
		direction = Vector2.RIGHT
	
	direction = direction.rotated(newAngle * PI / 180.0)
