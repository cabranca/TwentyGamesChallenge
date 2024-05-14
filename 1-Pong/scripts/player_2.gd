extends Area2D

@export var speed := 500.0

var _direction : Vector2
var _reached_top := false
var _reached_bottom := false

func _ready():
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("P2 up") and not _reached_top:
		_direction = Vector2.UP
	elif Input.is_action_pressed("P2 down") and not _reached_bottom:
		_direction = Vector2.DOWN
	else:
		_direction = Vector2.ZERO
	
	position += _direction * speed * delta


func _on_area_entered(area):
	if area.is_in_group("Top Wall"):
		_reached_top = true;
	if area.is_in_group("Bottom Wall"):
		_reached_bottom = true

func _on_area_exited(area):
	if area.is_in_group("Top Wall"):
		_reached_top = false;
	if area.is_in_group("Bottom Wall"):
		_reached_bottom = false
