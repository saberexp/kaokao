extends Label

func _ready():
	update_size()
	resized.connect(update_size)

func update_size()->void:
	get_parent().custom_minimum_size = size
