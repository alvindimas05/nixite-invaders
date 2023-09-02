extends Node

var root: Node2D
var bullet: Sprite2D
var player: CharacterBody2D

signal on_hit
signal custom_skill

func _ready():
	player = get_parent()
	set_timer()

func _process(_delta):
	fire()

var fire_timer = Timer.new()
@export var bullet_delay = .2
# Add delay for every bullet before shooting
# Exploit for spamming bullets ignored
func set_timer():
	fire_timer.wait_time = bullet_delay
	fire_timer.one_shot = false
	fire_timer.timeout.connect(on_fire)
	add_child(fire_timer)

func on_fire():
	add_bullet()
	emit_signal("custom_skill")

func fire():
	# If pressed, shoot bullet then start timer
	if Input.is_action_just_pressed('fire'):
		on_fire()
		fire_timer.start()
	elif Input.is_action_just_released('fire'):
		fire_timer.stop()

func add_bullet(target_pos: Vector2 = Vector2(player.position.x, -1000)):
	var bullet = Bullet.new(self)
	bullet.target_position = target_pos
	bullet.on_hit.connect(func(blt): emit_signal("on_hit", blt))
	bullet.add_bullet(player.damage, player.position, true)
