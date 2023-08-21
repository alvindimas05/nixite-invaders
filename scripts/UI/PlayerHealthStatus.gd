extends Control

var pos_y = -110

func _ready():
	if is_mobile():
		move_to_top()

func is_mobile() -> bool:
	return DisplayServer.is_touchscreen_available()

func move_to_top():
	anchors_preset = PRESET_CENTER_TOP
	position.y = pos_y
