extends Sprite2D

@export var scale_speed: float
@export var max_scale: float = 800

var default_y: float
func _ready():
	default_y = position.y

func _process(delta):
	if scale.y >= max_scale: return
	
	scale.y += scale_speed
	position.y = -abs(default_y + (texture.get_height() * scale.y / 2))
