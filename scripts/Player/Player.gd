extends PlaneStats

@export var speed = 400.0

func get_input():
	var input = Input.get_vector('ui_left', 'ui_right', 'ui_up', 'ui_down')
	velocity = input * speed

func _physics_process(_delta):
	get_input()
	move_and_slide()
