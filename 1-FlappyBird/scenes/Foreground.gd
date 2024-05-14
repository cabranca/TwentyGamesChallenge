extends TextureRect

var viewportWidth = ProjectSettings.get_setting("display/window/size/viewport_width")
const SPEED = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if position.x > viewportWidth:
		position.x = -viewportWidth
	else:
		position.x += SPEED * delta
