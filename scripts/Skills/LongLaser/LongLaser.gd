extends Sprite2D

@export var scale_speed: float
@export var max_scale: float = 800
@export var can_skill = true

var default_y: float
func _ready():
	default_y = position.y
	
	var area: Area2D = get_node("Area2D")
	area.area_entered.connect(_area_entered)
	area.area_exited.connect(_area_exited)

func _process(delta):
	if can_skill && scale.y <= max_scale:
		show()
		scale.y += scale_speed
	elif !can_skill && scale.y > -1:
		scale.y -= scale_speed
	elif scale.y < 1:
		scale.y = 0
		hide()
	position.y = -abs(default_y + (texture.get_height() * scale.y / 2))

func stop_skill():
	can_skill = !can_skill

var areas = []
func _area_entered(area: Area2D):
	if area.name != "DamageHandler": return
	area.send_damage(3)
	for ar in areas: if ar.get_instance_id() == area.get_instance_id(): return
	areas.append(area)
	
func _area_exited(area: Area2D):
	if area.name != "DamageHandler": return
	areas = areas.filter(func(ar): return ar.get_instance_id() != area.get_instance_id())
	print(areas.size())
