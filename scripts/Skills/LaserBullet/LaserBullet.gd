extends Sprite2D

@export var scale_speed: float = 15
@export var max_scale: float = 150
@export var activated = true
@export var deactivate_delay = .1
@export var is_player = true
@export var damage = 5

var sfx: AudioStreamPlayer
func _ready():
	position.y -= randf_range(0, 35)
	set_laser()

# Set the Laser
func set_laser():
	var area: Area2D = get_node("Area2D")
	area.area_entered.connect(_area_entered)

func _on_activated():
	show()
	scale.y += scale_speed

func _on_deactivated():
	queue_free()

func _process(delta):
	# Show and increase height if activated and height below max height
	if activated && scale.y < 1: _on_activated()
	elif activated && scale.y <= max_scale: scale.y += scale_speed
	elif activated && scale.y >= max_scale: activated = false
	# Decrease if deactivated and scale above -1
	elif !activated && scale.y > -1: scale.y -= scale_speed
	# If height below 1 then stop timer and hide
	elif scale.y < 1: _on_deactivated()

# Send damage
func _area_entered(area: Area2D):
	if area.name != "DamageHandler" || is_player == area.is_player: return
	area.send_damage(damage)
