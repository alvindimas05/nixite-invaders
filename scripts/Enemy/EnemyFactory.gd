extends Node

@export var total_enemy: int
@export var plane_spacing = 150.0

var pre_enemy = preload("res://objects/enemy.tscn")
var enemy: CharacterBody2D
var root: Node

func _ready():
	root = get_parent()
	enemy = pre_enemy.instantiate()
	# Add total enemy because ignoring the first enemy
	for i in total_enemy + 1:
		spawn_enemy()

func is_odd() -> bool:
	return total_spawn % 2 == 0

# Spawn enemy and add spacing between planes
# DON'T TOUCH
# I HAVE NO IDEA HOW IS THIS WORKS
# <DONT TOUCH START>
var total_spawn = 0
var left_spawn = 1
func spawn_enemy():
	var dupe: CharacterBody2D = enemy.duplicate()
	# Ignoring first enemy
	if total_spawn < 1:
		total_spawn += 1
		return

	# THIS IS THE PART WHERE I DONT UNDERSTAND
	dupe.position.x += plane_spacing * (total_spawn - left_spawn)
	if is_odd():
		dupe.position.x = plane_spacing * left_spawn
		dupe.position.x *= -1
		left_spawn += 1

	root.call_deferred("add_child", dupe)
	total_spawn += 1
# <DONT TOUCH END>
