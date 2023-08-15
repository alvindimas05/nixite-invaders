extends Node

var root: Node2D
var bullet: Sprite2D
var player: CharacterBody2D

const Bullet = preload("res://scripts/Bullet/Bullet.gd")

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
	fire_timer.timeout.connect(add_bullet)
	fire_timer.wait_time = bullet_delay
	fire_timer.one_shot = false
	add_child(fire_timer)

func fire():
	# If pressed, shoot bullet then start timer
	if Input.is_action_just_pressed('fire'):
		add_bullet()
		fire_timer.start()
	elif Input.is_action_just_released('fire'):
		fire_timer.stop()

func add_bullet():
	Bullet.new(self, player.damage, player.position, true)
