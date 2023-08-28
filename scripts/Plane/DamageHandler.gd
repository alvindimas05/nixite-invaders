extends Area2D

@export var effect_delay = .2
@export var effect_opacity = .8

var parent: CharacterBody2D
var sprite: Node2D
var is_player: bool
var root: Node
func _ready():
	root = get_node("/root/Main")
	parent = get_parent()
	sprite = parent.get_node("Sprite2D")
	is_player = parent.name == "Player"
	set_sound_destroy()

# Send damage to parent (Character)
func send_damage(damage: int):
	parent.health_points -= damage
	effect()
	check_for_destroy()

# Destroy parent if hp below or equals to 0
func check_for_destroy():
	if parent.health_points > 0: return
	parent.queue_free()
	sound_destroy.play()

var sfx = preload("res://sounds/plane_destroyed.mp3")
var sound_destroy = AudioStreamPlayer2D.new()
func set_sound_destroy():
	sound_destroy.stream = sfx
	root.add_child(sound_destroy)

# Effect when hit by bullet
var timer = Timer.new()
func effect():
	timer.wait_time = effect_delay
	# Return opacity effect
	timer.timeout.connect(func():
		sprite.modulate.a = 1
		remove_child(timer)
	)
	
	# Reduce opacity effect
	sprite.modulate.a = effect_opacity
	add_child(timer)
	timer.start()
