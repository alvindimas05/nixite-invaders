extends Sprite2D

@export var scale_speed: float = 25
@export var max_scale: float = 800
@export var can_skill = false
@export var delay = .5
@export var damage = 10
@export var is_player = true

var default_y: float
func _ready():
	default_y = position.y
	set_laser()

func set_laser():
	var area: Area2D = get_node("Area2D")
	area.area_entered.connect(_area_entered)
	area.area_exited.connect(_area_exited)
	set_timer_damage()
	
func _process(delta):
	if can_skill && scale.y <= max_scale:
		show()
		timer_damage.start()
		scale.y += scale_speed
	elif !can_skill && scale.y > -1:
		scale.y -= scale_speed
	elif scale.y < 1:
		timer_damage.stop()
		scale.y = 0
		hide()
	position.y = -abs(default_y + (texture.get_height() * scale.y / 2))

var timer_damage = Timer.new()
func set_timer_damage():
	timer_damage.one_shot = false
	timer_damage.wait_time = delay
	timer_damage.timeout.connect(send_damage_to_areas)
	add_child(timer_damage)

func send_damage_to_areas():
	for area in areas: area.send_damage(damage)

var areas = []
func _area_entered(area: Area2D):
	if area.name != "DamageHandler" || is_player == area.is_player: return
	area.send_damage(damage)
	for ar in areas: if ar.get_instance_id() == area.get_instance_id(): return
	areas.append(area)
	
func _area_exited(area: Area2D):
	if area.name != "DamageHandler" || is_player == area.is_player: return
	areas = areas.filter(func(ar): return ar.get_instance_id() != area.get_instance_id())
