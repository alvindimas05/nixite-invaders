class_name EnemyMovement

var enemy: CharacterBody2D

var move_range: float # if 10 then left right 10 10
var move_speed: float

var min_x: float
var max_x: float

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
	if enemy.position.x <= min_x:
		right = true
		move_right()
	elif enemy.position.x >= max_x:
		right = false
		move_left()
	elif right: move_right()
	else: move_left()
