class_name Bullet

var pre_bullet = preload("res://objects/bullet.tscn")

var bullet: Node
var root: Node

var ybullet = preload("res://assets/Bullets/Bullet Yellow.png")
var bbullet = preload("res://assets/Bullets/Bullet Blue.png")

signal on_hit

func _init(node: Node):
	root = node.get_node('/root/Main')
	bullet = pre_bullet.instantiate()

@export var target_position: Vector2
# Adding bullet by player position
func add_bullet(damage: float, position: Vector2, from_player: bool):
	var dupe = bullet.duplicate()
	var txr: Sprite2D = dupe.get_node("Sprite2D")
	txr.texture = bbullet if from_player else ybullet
	
	dupe.damage = damage
	dupe.position = position 
	dupe.can_move = true
	dupe.from_player = from_player
	dupe.target_position = target_position
	
	# Prevent bullet to go above plane
	dupe.z_index = -1
	
	dupe.on_hit.connect(func(blt): emit_signal("on_hit", blt))
	
	root.add_child(dupe)
	dupe.name = bullet.name
