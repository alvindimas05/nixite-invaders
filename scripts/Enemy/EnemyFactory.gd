extends Node

@export var total_enemy = 0
@export var plane_spacing = 150.0
@export var limit_per_column = 10
@export var start_y = 500.0
@export var move_speed = 50.0

var pre_enemy = preload("res://objects/enemy.tscn")
var enemy: CharacterBody2D
var root: Node

var planes = []
var enemy_show: EnemyShow
var can_move = false : set = _set_can_move
var can_fire = false : set = _set_can_fire
	
func _set_can_move(val: bool):
	for plane in planes: plane.can_move = val
	can_move = val

func _set_can_fire(val: bool):
	for plane in planes: plane.can_fire = val
	can_move = val

func _ready():
	root = get_parent()
	enemy = pre_enemy.instantiate()

func spawn_enemies():
	for ttl in split_total():
		for i in ttl + 1: spawn_enemy()
		reset_spawn()
	enemy_show = EnemyShow.new(root, planes, start_y, move_speed * 8)

func _physics_process(delta):
	if enemy_show == null or enemy_show.done: return
	enemy_show.move(delta)

var extra_y = 0
func reset_spawn():
	total_spawn = 1
	left_spawn = 1
	extra_y += plane_spacing

func split_total() -> Array:
	var total = total_enemy
	var result = []
	while total > 0:
		var valueToAdd = min(total, limit_per_column)
		result.append(valueToAdd)
		total -= valueToAdd
	return result
	
func is_odd() -> bool: return total_spawn % 2 == 0

# Spawn enemy and add spacing between planes
# DON'T TOUCH
# I HAVE NO IDEA HOW IS THIS WORKS
# <DONT TOUCH START>
var total_spawn = 1
var left_spawn = 1
func spawn_enemy():
	var dupe: CharacterBody2D = enemy.duplicate()

	# THIS IS THE PART WHERE I DONT UNDERSTAND
	dupe.position.x += plane_spacing * (total_spawn - left_spawn)
	dupe.position.y += extra_y
	if is_odd():
		dupe.position.x = plane_spacing * left_spawn
		dupe.position.x *= -1
		left_spawn += 1

	planes.append(dupe)
	total_spawn += 1
# <DONT TOUCH END>
