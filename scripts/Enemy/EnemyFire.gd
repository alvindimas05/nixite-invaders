extends Node

@export var random_range_duration = 2.0
@export var bullet_delay = .2

var enemy: CharacterBody2D
func _ready():
	enemy = get_parent()
	random_delay_before_timer()

# Add delay for every bullet before shooting
var timer = Timer.new()
var rand_timer = Timer.new()
func set_timer():
	remove_child(rand_timer)
	
	timer.timeout.connect(add_bullet)
	timer.wait_time = bullet_delay
	timer.one_shot = false
	add_child(timer)
	timer.start()

# Random delay before timer started
var rng = RandomNumberGenerator.new()
func random_delay_before_timer():
	rand_timer.wait_time = rng.randf_range(0, random_range_duration)
	rand_timer.timeout.connect(set_timer)
	add_child(rand_timer)
	rand_timer.start()

func add_bullet():
	Bullet.new(self, enemy.damage, enemy.position, false)
