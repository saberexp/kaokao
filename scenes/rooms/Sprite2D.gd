extends Sprite2D
var pos:Vector2 = global_position
var target:Vector2 = global_position

# https://twitter.com/itsmatharoo/status/1148297551931572224
# Matharoo springy movement
func _process(delta)->void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		target = get_global_mouse_position()
	
	var dir:Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	pos = pos.lerp((target - dir) * 0.25, 0.1)
	dir += pos
	global_position = dir
