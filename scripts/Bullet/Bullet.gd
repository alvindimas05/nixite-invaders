class_name Bullet

var pre_bullet = preload("res://objects/bullet.tscn")

var bullet: Node
var root: Node
func _init(node: Node, damage: float, position: Vector2, from_player: bool):
	root = node.get_node('/root/Main')
	bullet = pre_bullet.instantiate()
	add_bullet(damage, position, from_player)

# Adding bullet by player position
func add_bullet(damage: float, position: Vector2, from_player: bool):
	var dupe = bullet.duplicate()
	dupe.damage = damage
	dupe.position = position 
	dupe.can_move = true
	dupe.from_player = from_player
	
	# Prevent bullet to go above plane
	dupe.z_index = -1
	
	root.add_child(dupe)
	dupe.name = bullet.name
