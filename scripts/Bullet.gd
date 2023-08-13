class_name Bullet
extends Sprite2D

@export var limitY: int
@export var speed: int
@export var can_move = false

var bullet: Sprite2D
func _ready():
	bullet = get_node('.')

func _process(_delta):
	if !can_move: return

	if bullet.position.y < limitY:
		queue_free()
	bullet.position.y -= speed
