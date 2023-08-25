class_name Skill

signal after_duration
signal after_cooldown
signal on_skill

@export var cooldown: float = 10
@export var duration: float = 3

var player: PlaneStats
var can_skill = true
var skills: Control

var rect: Control
var skill_texture: CompressedTexture2D

func _init(plr: PlaneStats):
	player = plr
	skills = plr.get_node("/root/Main/UserInterface/Skills")
	
# Call after init on extend class
func set_requirements():
	set_timer_cooldown()
	set_timer_duration()
	set_texture()

func run_skill():
	if !can_skill: return
	can_skill = false
	# Start timers
	timer_cd.start()
	timer_duration.start()
	# Reduce opacity skill button
	rect.modulate.a = .2
	emit_signal("on_skill")

# Set Texture for indicator, error if no texture rect that can added
func set_texture():
	for i in skills.get_child_count():
		var c: TextureRect = skills.get_child(i).get_node("TextureRect")
		if c == null: continue
		c.texture = skill_texture
		rect = skills.get_child(i)
		return
	assert(false, "ERROR: Can't add texture on class " + get_class())

# Set timer duration for reuse
var timer_duration: Timer
func set_timer_duration():
	timer_duration = Timer.new()
	timer_cd.one_shot = true
	timer_duration.wait_time = duration
	timer_duration.timeout.connect(func(): emit_signal("after_duration"))
	player.add_child(timer_duration)
	
# Set timer cooldown for reuse
var timer_cd: Timer
func set_timer_cooldown():
	timer_cd = Timer.new()
	timer_cd.one_shot = true
	timer_cd.wait_time = cooldown
	timer_cd.timeout.connect(func():
		rect.modulate.a = 1
		emit_signal("after_cooldown")
	)
	player.add_child(timer_cd)
