class_name Bullet

var pre_bullet = preload("res://objects/bullet.tscn")

var bullet: Node
var root: Node

var bullet_tex: ImageTexture
func _init(node: Node, damage: float, position: Vector2, from_player: bool):
	root = node.get_node('/root/Main')
	bullet = pre_bullet.instantiate()
	set_texture(from_player)
	add_bullet(damage, position, from_player)

# Check player and set texture of the bullet
func set_texture(from_player: bool):
	var src = "res://assets/Bullet Blue.png" if from_player else "res://assets/Bullet Yellow.png"
	var img = Image.load_from_file(src)
	bullet_tex = ImageTexture.create_from_image(img)

# Adding bullet by player position
func add_bullet(damage: float, position: Vector2, from_player: bool):
	var dupe = bullet.duplicate()
	dupe.texture = bullet_tex
	dupe.damage = damage
	dupe.position = position 
	dupe.can_move = true
	dupe.from_player = from_player
	
	# Prevent bullet to go above plane
	dupe.z_index = -1
	
	root.add_child(dupe)
	dupe.name = bullet.name
