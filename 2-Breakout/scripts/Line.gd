extends Node2D

signal scored

# Called when the node enters the scene tree for the first time.
func _ready():
	child_order_changed.connect(on_child_order_changed)

# This is called whenever a brick is freed
func on_child_order_changed():
	scored.emit()
	if get_child_count() == 0:
		queue_free()
