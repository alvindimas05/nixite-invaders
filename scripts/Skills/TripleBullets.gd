extends Skill
class_name SkillTripleBullets

@export var is_player = true
@export var range_x = 200

var fire: Node
var texture = preload("res://assets/Buttons/Skill Triple Bullets.png")

func _init(plr: PlaneStats):
	super(plr)
	fire = plr.get_node("PlayerFire")
	skill_texture = texture
	
	after_duration.connect(_after_duration)
	after_cooldown.connect(_after_cooldown)
	on_skill.connect(_on_skill)
	
	set_requirements()

# Start skill then start cooldown and skill duration
func _on_skill():
	fire.custom_skill.connect(add_bullets)

# Stop skill after duration
func _after_duration():
	fire.custom_skill.disconnect(add_bullets)

# Return opacity and can use skill again after cooldown
func _after_cooldown():
	can_skill = true

# Add 2 bullets when fire
func add_bullets():
	fire.add_bullet(Vector2(player.position.x + range_x, -1000 if is_player else 1000))
	fire.add_bullet(Vector2(player.position.x - range_x, -1000 if is_player else 1000))
