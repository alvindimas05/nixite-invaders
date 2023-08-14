class_name Bullet

var bullet: Node2D
var root: Node
func _init(node: Node2D, damage: float, position: Vector2, from_player: bool):
	root = node.get_node('/root/Main')
	bullet = node.get_node('/root/Main/Bullet')
	add_bullet(damage, position, from_player)

func add_bullet(damage: float, position: Vector2, from_player: bool):
	var dupe = bullet.duplicate()
	dupe.damage = damage
	dupe.position = position 
	dupe.can_move = true
	dupe.from_player = from_player
	
	root.add_child(dupe)
	dupe.name = bullet.name
