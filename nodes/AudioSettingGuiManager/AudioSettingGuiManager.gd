extends Node
## Containers holding sliders. Their name should represent audio bus names.
@export var slider_container:Array[Node]
## Resource controlling audio settings
@export var audio_settings_resource:AudioSettingsResource

func _ready()->void:
	update_sliders()
	for node in slider_container:
		var bus_name: = node.name
		var slider:Slider = node.get_node("Slider")
		#slider.drag_ended.connect(on_drag_end.bind(bus_name, slider))
		slider.value_changed.connect(on_drag_end.bind(bus_name, slider))

## Position sliders values
func update_sliders()->void:
	for node in slider_container:
		var bus_name: = node.name
		var slider:Slider = node.get_node("Slider")
		slider.value = audio_settings_resource.get_bus_volume(bus_name)

## callback for slider drag end
func on_drag_end(bus_name:String, slider:Slider)->void:
	audio_settings_resource.set_bus_volume(bus_name, slider.value)

## callback for slider value change
func on_value_changed(value:float, bus_name:String, slider:Slider)->void:
	audio_settings_resource.set_bus_volume(bus_name, slider.value)
