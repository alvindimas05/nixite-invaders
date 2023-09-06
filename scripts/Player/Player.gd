extends PlaneStats

@export var move_speed = 400.0
@export var can_control = false

var collision: CollisionShape2D
var status_controller: PlayerHealthStatusController
func _ready():
	collision = get_node("CollisionShape2D")
	status_controller = PlayerHealthStatusController.new(self)
	on_health_points_change.connect(status_controller.on_change_health_points)
	set_skills()

var skill_1: SkillTripleBullets
var skill_2: SkillLongLaser
var skill_3: SkillLaserBullet
func _process(delta):
	if !can_control: return
	
	if Input.is_key_pressed(KEY_J): skill_1.run_skill()
	if Input.is_key_pressed(KEY_K): skill_2.run_skill()
	if Input.is_key_pressed(KEY_L): skill_3.run_skill()

func set_skills():
	skill_1 = SkillTripleBullets.new(self)
	skill_1.set_key_label("J")
	skill_2 = SkillLongLaser.new(self)
	skill_2.set_key_label("K")
	skill_3 = SkillLaserBullet.new(self)
	skill_3.set_key_label("L")

# Get Input for velocity movement
func get_input():
	var input = Input.get_vector('ui_left', 'ui_right', 'ui_up', 'ui_down')
	velocity = input * move_speed * 1.1

func _physics_process(_delta):
	if !can_control: return
	
	get_input()
	move_and_slide()
