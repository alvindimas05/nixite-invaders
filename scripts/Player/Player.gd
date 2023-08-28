extends PlaneStats

@export var move_speed = 400.0

var status_controller: PlayerHealthStatusController
func _ready():
	status_controller = PlayerHealthStatusController.new(self)
	on_health_points_change.connect(status_controller.on_change_health_points)
	set_skills()

var skill_1: SkillTripleBullets
var skill_2: SkillLongLaser
func _process(delta):
	if Input.is_key_pressed(KEY_J): skill_1.run_skill()
	if Input.is_key_pressed(KEY_K): skill_2.run_skill()

func set_skills():
	skill_1 = SkillTripleBullets.new(self)
	skill_1.set_key_label("J")
	skill_2 = SkillLongLaser.new(self)
	skill_2.set_key_label("K")

# Get Input for velocity movement
func get_input():
	var input = Input.get_vector('ui_left', 'ui_right', 'ui_up', 'ui_down')
	velocity = input * move_speed * 1.1

func _physics_process(_delta):
	get_input()
	move_and_slide()
