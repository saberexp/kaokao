extends Button

func _pressed()->void:
	if SceneManager.state_game_scene.state != SceneManager.IDLE:
		return
	SceneManager.set_game_room("game_room")
