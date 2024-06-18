extends Node2D

@export var mcScene : PackedScene
@export var obstacleScene : PackedScene

const OBSTACLE_X_POSITION := 0

var viewportHeight : float
var difficulty := 1.0

var obstacles : Array
var spawnIndex := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalVariables.score = 0
	#viewportHeight = ProjectSettings.get_setting("display/window/size/viewport_height")
	viewportHeight = get_viewport_rect().size.y
	for i in range(20):
		var obstacle = obstacleScene.instantiate() 
		obstacles.append(obstacle)
		add_child(obstacle)
	init_mc()
	$Timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta) -> void:
	if difficulty == 0:
		print("NO SE COMO LLEGASTE HASTA ACA")


func init_mc() -> void:
	var mc = mcScene.instantiate()
	mc.position = GlobalVariables.MC_POSITION
	mc.game_over.connect(on_game_over)
	add_child(mc)


func _on_timer_timeout() -> void:
	if difficulty > 0.0:
		difficulty -= 0.01
	print(difficulty)
	spawn_obstacles()

func spawn_obstacles() -> void:
	var distanceToCenter = generateObstaclesDistance() / 2
	var offset = generateObstaclesSpawnOffset()
	
	var firstObstacleYPos = viewportHeight / 2 - distanceToCenter + offset
	init_obstacle(firstObstacleYPos, true)
	
	var secondObstacleYPos = viewportHeight / 2 + distanceToCenter + offset
	init_obstacle(secondObstacleYPos, false)


func generateObstaclesDistance() -> float:
	# Minimum opening = 96px (Ir probando)
	# Maximum opening = 96px * 4 = 288
	# Generate random number in [0, 1] and translate & scale to [96, 288]
	var seed = randf()
	seed *= difficulty # Apply difficulty (shorter range)
	seed *= 192 # Scale the range 
	seed += 96 # Translate the range
	return seed

func generateObstaclesSpawnOffset() -> float:
	var seed = randf()
	seed *= 128 # Scale the range 
	seed -= 64 # Translate the range
	return seed

func init_obstacle(yPosition, connectSignal) -> void:
	var obstacle = obstacles[spawnIndex]
	obstacle.position = Vector2(OBSTACLE_X_POSITION, yPosition)
	if connectSignal:
		obstacle.on_scored.connect(on_scored)
	obstacle.reset()
	add_child(obstacle)
	spawnIndex = 0 if spawnIndex == 9 else spawnIndex + 1


func on_scored() -> void:
	GlobalVariables.score += 1
	$UI/Score.text = str(GlobalVariables.score)

func on_game_over() -> void:
	$Timer.stop()
	get_tree().call_group("Obstacle", "queue_free")
	$UI/ButtonsContainer.visible = true
	$UI/GameOverBG.visible = true


func _on_restart() -> void:
	get_tree().reload_current_scene()


func _on_exit() -> void:
	get_tree().quit()
