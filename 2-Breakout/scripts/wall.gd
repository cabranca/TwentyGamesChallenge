extends Node2D

signal scored

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	child_order_changed.connect(on_child_order_changed)
	for line in get_children():
		line.scored.connect(on_scored)

# This is called whenever a line is completely freed
func on_child_order_changed() -> void:
	if get_child_count() == 0:
		queue_free()

func on_scored() -> void:
	scored.emit()
