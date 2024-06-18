extends Area2D

signal life_lost

const SPEED := 400.0
var viewport_size : Vector2

var direction : Vector2

func _ready() -> void:
	viewport_size = get_viewport_rect().size
	area_entered.connect(on_area_entered)
	$VisibleOnScreenNotifier2D.screen_exited.connect(on_screen_exited)
	
	start()

func _process(delta) -> void:
	position += direction * SPEED * delta # clamp for x axis?

func start() -> void:
	position = viewport_size / 2
	var initial_direction = randf_range(-1.0, 1.0)
	direction = Vector2(initial_direction, 1.0).normalized()

func on_area_entered(area) -> void:
	if area.is_in_group("horizontal_collider"):
		direction = Vector2(-direction.x, direction.y)
	elif area.is_in_group("vertical_collider"):
		direction = Vector2(direction.x, -direction.y)
	else:
		print("ERROR: COLLIDED WITH UNKOWN AREA")

func on_screen_exited() -> void:
	life_lost.emit()
	print("lost")
