extends Node

var root: Node
var pre_asteroid = preload("res://objects/asteroid.tscn")
var asteroid: CharacterBody2D
var range = ProjectSettings.get_setting("display/window/size/viewport_width") / 4

func _ready():
	root = get_parent()
	asteroid = pre_asteroid.instantiate()

func spawn_asteroid():
	var dupe: CharacterBody2D = asteroid.duplicate()
	dupe.position.x = randf_range(-range, range)
	root.call_deferred("add_child", dupe)
