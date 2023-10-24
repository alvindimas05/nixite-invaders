extends Area2D

@export var effect_delay = .2
@export var effect_color = Color(.7, .7, .7)

signal on_destroyed

var pre_explosion = preload("res://objects/plane_explosion.tscn")

var parent: CharacterBody2D
var sprite: Node2D
var is_player: bool
var root: Node
var explosion: AnimatedSprite2D
func _ready():
	root = get_node("/root/Main")
	parent = get_parent()
	sprite = parent.get_node("Sprite2D")
	is_player = parent.name == "Player"
	explosion = pre_explosion.instantiate()
	set_sound_destroy()

# Send damage to parent (Character)
func send_damage(damage: int):
	parent.health_points -= damage
	effect()
	check_for_destroy()

# Destroy parent if hp below or equals to 0
func check_for_destroy():
	if parent.health_points > 0: return
	emit_signal("on_destroyed")
	destroy_plane()

func destroy_plane():
	var dupe: AnimatedSprite2D = explosion.duplicate()
	dupe.position = parent.position
	dupe.animation_finished.connect(func(): dupe.queue_free())
	root.add_child(dupe)
	dupe.play()
	
	sound_destroy.play()
	parent.queue_free()

var sfx = preload("res://sounds/plane_destroyed.mp3")
var sound_destroy = AudioStreamPlayer2D.new()
func set_sound_destroy():
	sound_destroy.stream = sfx
	root.add_child.call_deferred(sound_destroy)

# Effect when hit by bullet
var timer = Timer.new()
func effect():
	timer.wait_time = effect_delay
	# Return opacity effect
	timer.timeout.connect(func():
		sprite.modulate = Color(1, 1, 1)
		remove_child(timer)
	)
	
	# Reduce opacity effect
	sprite.modulate = effect_color
	add_child(timer)
	timer.start()
