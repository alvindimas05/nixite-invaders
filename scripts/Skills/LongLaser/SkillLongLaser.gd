extends Skill
class_name SkillLongLaser

@export var is_player = true
@export var duration = 3.5

var texture = preload("res://assets/Buttons/Skill Long Laser.png")

func _init(plr: PlaneStats):
	super(plr)
	_duration = duration
	skill_texture = texture
	
	after_duration.connect(_after_duration)
	after_cooldown.connect(_after_cooldown)
	on_skill.connect(_on_skill)
	set_laser()
	set_skill_timer()
	
	set_requirements()

var pre_laser = preload("res://objects/long_laser.tscn")
var laser: Node
func set_laser():
	laser = pre_laser.instantiate()
	player.add_child(laser)

var skill_timer = Timer.new()
func set_skill_timer():
	skill_timer.wait_time = .2
	skill_timer.one_shot = true
	skill_timer.timeout.connect(func(): laser.activated = true)
	player.add_child(skill_timer)
	

# Start skill then start cooldown and skill duration
func _on_skill():
	laser.play_sfx()
	skill_timer.start()

# Stop skill after duration
func _after_duration(): laser.activated = false

# Return opacity and can use skill again after cooldown
func _after_cooldown(): can_skill = true
