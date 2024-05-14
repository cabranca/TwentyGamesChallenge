extends Area2D

@export var SPEED := 200.0

var _velocity := Vector2(0.0, 1.0)

func _ready():
	area_entered.connect(_on_area_entered)

func _process(delta):
	position += _velocity * SPEED * delta


func _on_area_entered(area):
	pass # Replace with function body.
