extends Node2D

@export var gui_scene_key:String

func _ready()->void:
	if gui_scene_key.is_empty():
		return
	SceneManager.set_gui(gui_scene_key)

