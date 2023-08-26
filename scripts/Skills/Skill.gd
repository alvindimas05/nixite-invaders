class_name Skill

signal after_duration
signal after_cooldown
signal on_skill

@export var cooldown: float = 10
@export var duration: float = 3

var player: PlaneStats
var can_skill = true
var skills: Control

var skill_control: Control
var skill_texture: CompressedTexture2D

func _init(plr: PlaneStats):
	player = plr
	skills = plr.get_node("/root/Main/UserInterface/Skills")
	
# Call after init on extend class
func set_requirements():
	set_timer_cooldown()
	set_timer_duration()
	
	get_skill_position()
	set_texture()

func run_skill():
	if !can_skill: return
	can_skill = false
	# Start timers
	timer_cd.start()
	timer_duration.start()
	# Reduce opacity skill button
	skill_control.modulate.a = .2
	emit_signal("on_skill")
	
# Get empty skill to put and check if can be put
func get_skill_position():
	for i in skills.get_child_count():
		var con: Control = skills.get_child(i)
		var txr: TextureRect = con.get_node("TextureRect")
		var lbl: RichTextLabel = con.get_node("TextLabel")
		
		if txr.texture == null and lbl.text == "":
			skill_control = con
			return
	assert(false, "ERROR: Can't add skill texture or key label on class " + get_class())

# Set Texture for indicator, error if no texture rect that can added
func set_texture():
	var c: TextureRect = skill_control.get_node("TextureRect")
	c.texture = skill_texture

func set_key_label(key: String):
	var t: RichTextLabel = skill_control.get_node("TextLabel")
	t.text = key

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
		skill_control.modulate.a = 1
		emit_signal("after_cooldown")
	)
	player.add_child(timer_cd)