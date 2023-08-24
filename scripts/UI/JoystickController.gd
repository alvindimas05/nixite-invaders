extends Button

var player: PlaneStats
var tip: TextureRect
var tip_pos: Vector2

# Minimum limit tip (if joystick 64 and tip 32 then -4)
var min: float
# Maximum limit tip (if joystick 64 and tip 32 then 40)	
var max: float
func _ready():
	player = get_node("/root/Main/Player")
	tip = get_child(0)
	tip_pos = tip.position
	
	min = (0 - (tip.size.x / 4))
	max = (size.x + (tip.size.x / 2)) / 2

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
	# Checking if limit then put position to limit
	if norm.x < min: norm.x = min
	elif norm.x > max: norm.x = max
	
	# Checking if limit then put position to limit	
	if norm.y < min: norm.y = min
	elif norm.y > max: norm.y = max
	
	tip.position = norm

# Move based on velocity
func _process(delta):
	player.velocity = velo
	player.move_and_slide()

func normalized_vector(eposi: Vector2) -> Vector2:
	var s = size / 2
	return eposi - s
