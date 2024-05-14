extends Area2D

signal on_scored

const SPEED = 300

var scored = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if position.y > ProjectSettings.get_setting("display/window/size/viewport_height") / 2:
		position.y += $CollisionShape2D.shape.size.y * scale.y / 2
	else:
		position.y -= $CollisionShape2D.shape.size.y * scale.y / 2
	position.x -= $CollisionShape2D.shape.size.x / 2 + 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not scored and position.x > GlobalVariables.MC_POSITION.x:
		scored = true
		on_scored.emit()
	position.x += SPEED * delta


func _on_exit():
	queue_free() #Podría pulirlo e ir por el lado de reubicar los obstaculos
