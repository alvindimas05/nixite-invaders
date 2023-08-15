extends Area2D

@export var effect_delay = .2
@export var effect_opacity = .8

var parent: CharacterBody2D
var sprite: Sprite2D
var is_player: bool
func _ready():
	parent = get_parent()
	sprite = parent.get_node("Sprite2D")
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
	if is_player:
		get_tree().quit()

# Check if a bullet hit or entering character area
func _area_entered(area: Area2D):
	var bullet = area.get_parent()
	# Checking if a bullet or the character is the enemy of character
	if !bullet.name.contains("Bullet") or bullet.from_player == is_player: return

	send_damage(bullet.damage)
	bullet.queue_free()
	effect()

# Effect when hit by bullet
var timer = Timer.new()
func effect():
	timer.wait_time = effect_delay
	# Return opacity effect
	timer.timeout.connect(func():
		sprite.modulate.a = 1
		remove_child(timer)
	)
	
	# Reduce opacity effect
	sprite.modulate.a = effect_opacity
	add_child(timer)
	timer.start()
