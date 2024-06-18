extends Area2D

signal on_scored

const SPEED := 300.0

var scored := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func reset() -> void:
	if position.y > ProjectSettings.get_setting("display/window/size/viewport_height") / 2:
		position.y += $CollisionShape2D.shape.size.y * scale.y / 2
	else:
		position.y -= $CollisionShape2D.shape.size.y * scale.y / 2
	position.x -= $CollisionShape2D.shape.size.x / 2 + 1
	scored = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	if not scored and position.x > GlobalVariables.MC_POSITION.x:
		scored = true
		on_scored.emit()
	position.x += SPEED * delta
