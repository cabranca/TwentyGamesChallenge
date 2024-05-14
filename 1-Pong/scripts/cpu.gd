extends Area2D

@export var speed := 250.0

var _direction : Vector2
var _reached_top := false
var _reached_bottom := false

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	if (_reached_bottom and _direction.y > 0) or (_reached_top and _direction.y < 0) or _direction.y == 0:
		return 
	position += _direction * speed * delta


func _on_area_entered(area) -> void:
	if area.is_in_group("Top Wall"):
		_reached_top = true;
	if area.is_in_group("Bottom Wall"):
		_reached_bottom = true

func _on_area_exited(area) -> void:
	if area.is_in_group("Top Wall"):
		_reached_top = false;
	if area.is_in_group("Bottom Wall"):
		_reached_bottom = false

func set_direction(ball_y_position : float) -> void:
	var y_direction = 1 if ball_y_position > position.y else -1 
	_direction = Vector2(0, y_direction)
