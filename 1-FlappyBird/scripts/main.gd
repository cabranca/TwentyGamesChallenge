extends Node2D

@export var mcScene : PackedScene
@export var obstacleScene : PackedScene

const OBSTACLE_X_POSITION = 0

var difficulty = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	init_mc()
	$Timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if difficulty == 0:
		print("NO SE COMO LLEGASTE HASTA ACA")


func init_mc():
	var mc = mcScene.instantiate()
	mc.position = GlobalVariables.MC_POSITION
	mc.game_over.connect(on_game_over)
	add_child(mc)


func _on_timer_timeout():
	difficulty -= 0.01
	spawn_obstacles()

func spawn_obstacles():
	var distanceToCenter = generateObstaclesDistance() / 2
	var offset = generateObstaclesSpawnOffset()
	var viewportHeight = ProjectSettings.get_setting("display/window/size/viewport_height")
	
	var firstObstacleYPos = viewportHeight / 2 - distanceToCenter + offset
	init_obstacle(firstObstacleYPos, true)
	
	var secondObstacleYPos = viewportHeight / 2 + distanceToCenter + offset
	init_obstacle(secondObstacleYPos, false)


func generateObstaclesDistance():
	# Minimum opening = 96px (Ir probando)
	# Maximum opening = 96px * 4 = 288
	# Generate random number in [0, 1] and translate & scale to [96, 288]
	var seed = randf()
	seed *= difficulty # Apply difficulty (shorter range)
	seed *= 192 # Scale the range 
	seed += 96 # Translate the range
	return seed

func generateObstaclesSpawnOffset():
	var seed = randf()
	seed *= 128 # Scale the range 
	seed -= 64 # Translate the range
	return seed

func init_obstacle(yPosition, connectSignal):
	var obstacle = obstacleScene.instantiate()
	obstacle.position = Vector2(OBSTACLE_X_POSITION, yPosition)
	if connectSignal:
		obstacle.on_scored.connect(on_scored)
	add_child(obstacle)


func on_scored():
	GlobalVariables.score += 1
	$UI/Score.text = str(GlobalVariables.score)

func on_game_over():
	$Timer.stop()
	get_tree().call_group("Obstacle", "queue_free")
	$UI/ButtonsContainer.visible = true
	$UI/GameOverBG.visible = true


func _on_restart():
	get_tree().reload_current_scene()


func _on_exit():
	get_tree().quit()
