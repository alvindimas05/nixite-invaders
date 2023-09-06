extends AnimatedControl

func _ready():
	super()
	if !DisplayServer.is_touchscreen_available():
		hide()
		return
	show()
	
	position = _hide_position

func _gui_input(event):
	if event is InputEventScreenTouch:
		if event.is_pressed(): _on_button_down()
		elif event.is_released(): _on_button_up()

func _on_button_down():
	Input.action_press("fire")

func _on_button_up():
	Input.action_release("fire")
