extends Sprite2D

var root: Node2D
var bullet: Sprite2D
var player: CharacterBody2D

func _ready():
	root = get_node('/root/Main')
	player = get_node('..')
	bullet = get_node('/root/Main/Bullet')

	set_timer()

func _process(_delta):
	fire()

var fire_timer = Timer.new()
@export var bullet_delay = .2
func set_timer():
	fire_timer.timeout.connect(add_bullet)
	fire_timer.wait_time = bullet_delay
	fire_timer.one_shot = false
	add_child(fire_timer)
	
func fire():
	if Input.is_action_just_pressed('fire'):
		add_bullet()
		fire_timer.start()
	elif Input.is_action_just_released('fire'):
		fire_timer.stop()

func add_bullet():
	var dupe = bullet.duplicate()
	dupe.position = player.position 
	dupe.can_move= true
	root.add_child(dupe)
