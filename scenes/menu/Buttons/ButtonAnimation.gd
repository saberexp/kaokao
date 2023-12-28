extends Node

@export var button:Button
@export var press_time:float = 0.0
@export var hover_time:float = 0.2
@export var focus_time:float = 0.5

var default_shader_parameters: = {
	scale = 1.0,
	rotation = 0.0,
	skew = Vector2.ZERO,
}

var style_box:AnimatedStyleBoxFlat
var tweens:Dictionary = {}
var is_down:bool
var is_hover:bool
var is_focused:bool
var material:ShaderMaterial

func _ready()->void:
	style_box = button.get_theme_stylebox("normal").duplicate()
	button.add_theme_stylebox_override("normal", style_box)
	button.add_theme_stylebox_override("pressed", style_box)
	button.add_theme_stylebox_override("hover", style_box)
	button.add_theme_stylebox_override("focus", style_box)
	button.add_theme_stylebox_override("disabled", style_box)
	set_style(style_box.normal)
	
	button.button_down.connect(set_is_down.bind(true))
	button.button_up.connect(set_is_down.bind(false))
	button.mouse_entered.connect(set_is_hover.bind(true))
	button.mouse_exited.connect(set_is_hover.bind(false))
	button.focus_entered.connect(set_is_focused.bind(true))
	button.focus_exited.connect(set_is_focused.bind(false))
	
	if button.material != null:
		material = button.material.duplicate()
		button.material = material

func set_is_down(value:bool)->void:
	is_down = value

func set_is_hover(value:bool)->void:
	is_hover = value
	if value:
		set_style_tween(style_box.hover, hover_time)
	else:
		set_style_tween(style_box.normal, hover_time)

func set_is_focused(value:bool)->void:
	is_focused = value

func set_style(value:Dictionary)->void:
	for key in value.keys():
		set(key, value[key])

func set_style_tween(value:Dictionary, tween_time:float)->void:
	if is_queued_for_deletion() || !is_inside_tree():
		return
	for key in value.keys():
		if !tweens.has(key):
			tweens[key] = null
		var tween:Tween = tweens[key]
		if tween != null:
			tween.kill()
		tween = create_tween()
		tweens[key] = tween
		tween.tween_property(style_box, key, value[key], tween_time).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)

func set_style_tween_subset(value:Dictionary, subset:Dictionary, tween_time:float)->void:
	for key in subset.keys():
		if !value.has(key):
			continue
		if !tweens.has(key):
			tweens[key] = null
		var tween:Tween = tweens[key]
		if tween != null:
			tween.kill()
		tween = create_tween()
		tweens[key] = tween
		tween.tween_property(style_box, key, value[key], tween_time)

func set_shader_tween(value:Dictionary, tween_time:float)->void:
	material.set_shader_parameter("size", button.size)
	for key in value.keys():
		material.set_shader_parameter(key, value[key])






