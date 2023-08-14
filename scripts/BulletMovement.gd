extends Sprite2D

@export var damage: int

@export var limitY: int
@export var speed: int
@export var can_move = false
@export var from_player: bool


func _process(_delta):
	if !can_move: return
	
	if !from_player && limitY < 0:
		limitY = -limitY
	
	if (from_player && position.y < limitY) or (!from_player && position.y > limitY):
		queue_free()
	position.y -= speed * (1 if from_player else -1)
