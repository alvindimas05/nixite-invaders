extends Skill
class_name SkillLongLaser

@export var is_player = true

var texture = preload("res://assets/Buttons/Skill Long Laser.png")

func _init(plr: PlaneStats):
	super(plr)
	skill_texture = texture
	
	after_duration.connect(_after_duration)
	after_cooldown.connect(_after_cooldown)
	on_skill.connect(_on_skill)
	set_laser()
	
	set_requirements()

var pre_laser = preload("res://objects/long_laser.tscn")
var laser: Node
func set_laser():
	laser = pre_laser.instantiate()
	player.add_child(laser)

# Start skill then start cooldown and skill duration
func _on_skill(): laser.can_skill = true

# Stop skill after duration
func _after_duration(): laser.can_skill = false

# Return opacity and can use skill again after cooldown
func _after_cooldown(): can_skill = true
