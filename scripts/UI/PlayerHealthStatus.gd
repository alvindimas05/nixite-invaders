extends AnimatedControl

@export var hide_minus_mobile: Vector2

var pos_y = -110

var is_mobile: bool
func _ready():
	super()
	is_mobile = DisplayServer.is_touchscreen_available()
	if is_mobile: move_to_top()

func move_to_top():
	anchors_preset = PRESET_CENTER_TOP
	position.y = pos_y
	
	reset_position()
	_hide_position = position - hide_minus_mobile
	hide_position()

