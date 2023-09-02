extends Skill
class_name SkillLaserBullet

@export var is_player = true
@export var duration = 4

var texture = preload("res://assets/Buttons/Skill Laser Bullet.png")
var pre_laser_bullet = preload("res://objects/laser_bullet.tscn")

var root: Node
var player_fire: Node
var laser_bullet: Node2D
func _init(plr: PlaneStats):
	super(plr)
	_duration = duration
	skill_texture = texture
	
	root = plr.get_node("/root/Main")
	player_fire = plr.get_node("PlayerFire")
	laser_bullet = pre_laser_bullet.instantiate()
	
	after_duration.connect(_after_duration)
	after_cooldown.connect(_after_cooldown)
	on_skill.connect(_on_skill)
	
	set_requirements()
	
# Add laser when bullet hit
func add_laser_bullet(blt: CharacterBody2D):
	var dupe = laser_bullet.duplicate()
	dupe.position = blt.position
	root.add_child(dupe)

# Start skill then start cooldown and skill duration
func _on_skill(): player_fire.on_hit.connect(add_laser_bullet)

# Stop skill after duration
func _after_duration(): player_fire.on_hit.disconnect(add_laser_bullet)

# Return opacity and can use skill again after cooldown
func _after_cooldown(): can_skill = true
