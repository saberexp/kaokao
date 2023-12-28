extends Node

@export var button:Button

func _ready()->void:
	button.pressed.connect(pressed)

func pressed()->void:
	if SceneManager.state_game_scene.state != SceneManager.IDLE:
		return
	SceneManager.set_game_room("game_room")
