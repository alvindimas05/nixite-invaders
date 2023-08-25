extends Node

@export var random_range_duration = 3.0

var enemy: CharacterBody2D
func _ready():
	enemy = get_parent()
	set_timer()

# Add delay for every bullet before shooting
var timer: Timer
var rng = RandomNumberGenerator.new()
func set_timer():
	if timer != null:
		add_bullet()
		remove_child(timer)
	
	timer = Timer.new()
	timer.timeout.connect(set_timer)
	timer.wait_time = rng.randf_range(0, random_range_duration)
	add_child(timer)
	timer.start()

# Random delay before timer started

func add_bullet():
	var bullet = Bullet.new(self)
	bullet.target_position = Vector2(enemy.position.x, 1000)
	bullet.add_bullet(enemy.damage, enemy.position, false)
