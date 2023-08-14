extends PlaneStats

@export var bullet_delay = .2

const Bullet = preload("res://scripts/Bullet.gd")
func _ready():
	set_timer()

var timer = Timer.new()
func set_timer():
	timer.timeout.connect(add_bullet)
	timer.wait_time = bullet_delay
	timer.one_shot = false
	add_child(timer)
	timer.start()

func add_bullet():
	Bullet.new(self, damage, position, false)
