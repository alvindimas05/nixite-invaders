extends Node

@export var move_speed = 5

var bg1: Node2D
var bg2: Node2D

var bg1_move: BackgroundMove
var bg2_move: BackgroundMove

var limit: float


# Moving background to bottom
func _ready():
	bg1 = get_node("Background1")
	bg2 = get_node("Background2")
	limit = ProjectSettings.get_setting("display/window/size/viewport_height")

	bg1_move = BackgroundMove.new(bg1, move_speed, limit)
	bg2_move = BackgroundMove.new(bg2, move_speed, limit)

# Move the background
func _process(delta):
	bg1_move.move()
	bg2_move.move()

class BackgroundMove:
	var bg: Node2D
	var move_speed: float
	var limit: float
	
	func _init(bg: Node2D, move_speed: float, limit: float):
		self.bg = bg
		self.move_speed = move_speed
		self.limit = limit
#	Move the background
	func move():
		check_if_limit()
		bg.position.y += move_speed
#	If more than limit then turn the position into top screen
	func check_if_limit():
		if bg.position.y >= limit:
			bg.position.y = -limit
