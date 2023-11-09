extends Node

@export var delay_min = .25 
@export var delay_max = 1.5

var root: Node
var pre_asteroid = preload("res://objects/asteroid.tscn")
var asteroid: CharacterBody2D
var range = ProjectSettings.get_setting("display/window/size/viewport_width") / 4

func _ready():
	root = get_parent()
	asteroid = pre_asteroid.instantiate()

func spawn_asteroids(count: int):
	for i in count: spawn_with_random_delay()

func spawn_asteroid():
	var dupe: CharacterBody2D = asteroid.duplicate()
	dupe.position.x = randf_range(-range, range)
	root.call_deferred("add_child", dupe)

func spawn_with_random_delay():
	var timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = randf_range(delay_min, delay_max)
	timer.timeout.connect(spawn_asteroid)
	add_child(timer)
	timer.start()
