extends Sprite2D

@export var scale_speed: float = 20
@export var max_scale: float = 800
@export var activated = false
@export var delay = .5
@export var damage = 10
@export var is_player = true

var default_y: float
var sfx: AudioStreamPlayer
func _ready():
	default_y = position.y
	sfx = get_node("SoundEffect")
	set_laser()

func play_sfx():
	sfx.play(.2)

# Set the Laser
func set_laser():
	var area: Area2D = get_node("Area2D")
	area.area_entered.connect(_area_entered)
	area.area_exited.connect(_area_exited)
	set_timer_damage()

func _on_activated():
	show()
	timer_damage.start()
	scale.y += scale_speed

func _on_deactivated():
	timer_damage.stop()
	scale.y = 0
	hide()

func _process(delta):
	# Show and increase height if activated and height below max height
	if activated && scale.y < 1: _on_activated()
	elif activated && scale.y <= max_scale: scale.y += scale_speed
	# Decrease if deactivated and scale above -1
	elif !activated && scale.y > -1: scale.y -= scale_speed
	# If height below 1 then stop timer and hide
	elif scale.y < 1: _on_deactivated()
	position.y = -abs(default_y + (texture.get_height() * scale.y / 2))

# Set timer for repeated damage
var timer_damage = Timer.new()
func set_timer_damage():
	timer_damage.one_shot = false
	timer_damage.wait_time = delay
	timer_damage.timeout.connect(send_damage_to_areas)
	add_child(timer_damage)

func send_damage_to_areas():
	for area in areas: area.send_damage(damage)

# Send damage at first then add to areas
var areas = []
func _area_entered(area: Area2D):
	if !activated || area.name != "DamageHandler" || is_player == area.is_player: return
	area.send_damage(damage)
	for ar in areas: if ar.get_instance_id() == area.get_instance_id(): return
	areas.append(area)
	
# Remove areas based on instance id
func _area_exited(area: Area2D):
	if area.name != "DamageHandler" || is_player == area.is_player: return
	areas = areas.filter(func(ar): return ar.get_instance_id() != area.get_instance_id())
