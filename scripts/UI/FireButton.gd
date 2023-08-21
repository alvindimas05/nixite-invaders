extends Button

func _ready():
	if not DisplayServer.is_touchscreen_available():
		hide()
	button_down.connect(_on_button_down)
	button_up.connect(_on_button_up)

func _on_button_down():
	Input.action_press("fire")

func _on_button_up():
	Input.action_release("fire")
