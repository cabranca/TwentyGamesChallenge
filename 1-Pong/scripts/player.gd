extends Area2D
class_name Player

var speed := 500.0

var direction : int
var viewport_height: float

func _ready():
	viewport_height = get_viewport_rect().size.y
