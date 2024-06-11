extends Control

@export var main_scene : PackedScene

func _ready():
	$"PvE/Button".button_up.connect(_on_pve_button_up)
	$"PvP/Button".button_up.connect(_on_pvp_button_up)
	$"Exit/Button".button_up.connect(_on_exit_button_up)

func _process(delta):
	pass


func _on_pve_button_up():
	GlobalVariables.game_mode = GlobalVariables.Mode.PvE
	get_tree().change_scene_to_packed(main_scene)

func _on_pvp_button_up():
	GlobalVariables.game_mode = GlobalVariables.Mode.PvP
	get_tree().change_scene_to_packed(main_scene)

func _on_exit_button_up():
	get_tree().quit()
