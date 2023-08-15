extends Sprite2D

@export var damage: int

@export var limitY: int
@export var speed: int
@export var can_move = false
@export var from_player: bool

func _process(_delta):
	# Prevent original bullet to move
	if !can_move: return
	
	# If from enemy and limit is minus, change the limit into plus
	if !from_player && limitY < 0:
		limitY = -limitY
	
	# If enemy and bullet position more than minus limit
	# OR
	# If player and bullet position more than plus limit
	if (from_player && position.y < limitY) or (!from_player && position.y > limitY):
		queue_free()
	
	# If player then move to top else move to bottom
	position.y -= speed * (1 if from_player else -1)
