extends PlaneStats

@export var move_speed = 400.0

var status_controller: PlayerHealthStatusController
func _ready():
	status_controller = PlayerHealthStatusController.new(self)
	on_health_points_change.connect(status_controller.on_change_health_points)

# Get Input for velocity movement
func get_input():
	var input = Input.get_vector('ui_left', 'ui_right', 'ui_up', 'ui_down')
	velocity = input * move_speed

func _physics_process(_delta):
	get_input()
	move_and_slide()
