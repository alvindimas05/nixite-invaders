extends Area2D

var parent: CharacterBody2D
var is_player: bool
func _ready():
	parent = get_parent()
	is_player = parent.name == "Player"
	area_entered.connect(_area_entered)

# Send damage to parent (Character)
func send_damage(damage: int):
	parent.health_points -= damage
	check_for_destroy()

# Destroy parent if hp below or equals to 0
func check_for_destroy():
	if parent.health_points > 0: return
	parent.queue_free()

# Check if a bullet hit or entering character area
func _area_entered(area: Area2D):
	var bullet = area.get_parent()
	# Checking if a bullet or the character is the enemy of character
	if !bullet.name.contains("Bullet") or bullet.from_player == is_player: return

	send_damage(bullet.damage)
	bullet.queue_free()
