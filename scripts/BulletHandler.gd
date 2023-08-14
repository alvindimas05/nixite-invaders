extends Area2D

var parent: CharacterBody2D
var is_player: bool
func _ready():
	parent = get_parent()
	is_player = parent.name == "Player"
	area_entered.connect(_area_entered)

func send_damage(damage: int):
	parent.health_points -= damage
	check_for_destroy()

func check_for_destroy():
	if parent.health_points > 0: return
	parent.queue_free()

func _area_entered(area: Area2D):
	var bullet = area.get_parent()
	if !bullet.name.contains("Bullet") or bullet.from_player == is_player: return

	send_damage(bullet.damage)
	bullet.queue_free()
