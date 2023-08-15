extends PlaneStats

@export var move_speed = 400.0

# Get Input for velocity movement
func get_input():
	var input = Input.get_vector('ui_left', 'ui_right', 'ui_up', 'ui_down')
	velocity = input * move_speed

func _physics_process(_delta):
	get_input()
	move_and_slide()
