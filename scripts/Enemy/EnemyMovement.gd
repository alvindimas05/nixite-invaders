class_name EnemyMovement

var enemy: CharacterBody2D

var move_range: float # if 10 then left right 10 10
var move_speed: float

var min_x: float
var max_x: float

# Set range for movement
func _init(enemy: CharacterBody2D, move_range: float, move_speed: float):
	self.enemy = enemy
	self.move_range = move_range
	self.move_speed = move_speed
	
	min_x = enemy.position.x - move_range
	max_x = enemy.position.x + move_range

func move_left():
	enemy.position.x -= move_speed

func move_right():
	enemy.position.x += move_speed

var right = true
func move():
	# If more than limit left then move right
	if enemy.position.x <= min_x:
		right = true
		move_right()
	# If more than limit right then move left
	elif enemy.position.x >= max_x:
		right = false
		move_left()
	# Move right if right
	elif right: move_right()
	# Move left if not right
	else: move_left()
