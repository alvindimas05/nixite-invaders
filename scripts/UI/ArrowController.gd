extends Button

var player: PlaneStats
func _ready():
	player = get_node("/root/Main/Player")

func _gui_input(event):
	if not event is InputEventScreenTouch and not event is InputEventScreenDrag: return
	
	var normalized = normalized_vector(event.position)
	player.velocity = normalized.normalized() * player.move_speed
	player.move_and_slide()
#	if event is InputEventScreenTouch and event.is_released():
#		Input.action_release("ui_right")
#		Input.action_release("ui_left")
#		Input.action_release("ui_down")
#		Input.action_release("ui_up")
#	else:
#		var normalized = normalized_vector(event.position)
#		if normalized.x > 0:
#			Input.action_press("ui_right")
#			Input.action_release("ui_left")
#		else:
#			Input.action_press("ui_left")
#			Input.action_release("ui_right")
#
#		if normalized.y > 0:
#			Input.action_press("ui_down")
#			Input.action_release("ui_up")
#		else:
#			Input.action_press("ui_up")
#			Input.action_release("ui_down")

func normalized_vector(eposi: Vector2) -> Vector2:
	var s = size / 2
	return eposi - s
