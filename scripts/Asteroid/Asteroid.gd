extends PlaneStats

@export var move_speed = 5.0

func _physics_process(delta):
	move_and_collide(Vector2(0, move_speed))
