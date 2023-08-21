extends Node2D

var min_y = -645
var max_y = -325

func _ready():
	if not is_mobile():
		hide()

func is_mobile() -> bool:
	return DisplayServer.is_touchscreen_available()

func move_to_top():
	position.x = 0
	position.y = min_y
