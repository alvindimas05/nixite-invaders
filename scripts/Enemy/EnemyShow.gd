class_name EnemyShow

var move_speed: float
var start_y: float
var planes: Array

var position_y = 0
var done = false

func _init(root: Node, planes: Array, start_y: float, move_speed: float):
	self.planes = planes
	self.start_y = start_y
	self.move_speed = move_speed
	
	for plane in planes:
		plane.position.y -= start_y
		root.call_deferred("add_child", plane)

func move(delta: float):
	if position_y >= start_y && !done:
		done = true
	else:
		position_y += move_speed * delta
		for plane in planes:
			if plane == null: continue
			plane.position.y += move_speed * delta
