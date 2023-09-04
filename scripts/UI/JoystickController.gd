extends Button

var player: PlaneStats
var tip: TextureRect
var tip_pos: Vector2

# Limit tip based on joystick size
var limit: float
var center: Vector2
func _ready():
	disable_if_not_mobile()
	player = get_node("/root/Main/Player")
	tip = get_child(0)
	tip_pos = tip.position
	
	limit = (size.x / 2) - (tip.size.x / 4)
	center = size / 4
	
func disable_if_not_mobile():
	if DisplayServer.is_touchscreen_available(): show()
	else: hide()

var velo = Vector2(0, 0)
func _gui_input(event):
	if not event is InputEventScreenTouch and not event is InputEventScreenDrag: return
	
	# Reset velocity and button position if released
	if event is InputEventScreenTouch and event.is_released():
		velo = Vector2(0, 0)
		tip.position = tip_pos
		return
	
	# Normalized velocity for smooth movement
	var normalized = normalized_vector(event.position)
	velo = normalized.normalized() * player.move_speed
	
	# Moving tip based on touch position
	move_tip(normalized + (tip.size / 2))

func move_tip(norm: Vector2):
	var distance = (norm - center).length()
	# Limit the vector if distance more than limit
	if distance > limit:
		norm = center + (norm - center).normalized() * limit
	tip.position = norm

# Move based on velocity
func _process(delta):
	if player == null: return
	player.velocity = velo * 1.1
	player.move_and_slide()

func normalized_vector(eposi: Vector2) -> Vector2:
	var s = size / 2
	return eposi - s
