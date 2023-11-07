extends CharacterBody2D

@export var damage: float

@export var speed = 1500
@export var can_move = false
@export var from_player: bool
@export var target_position: Vector2

signal on_hit

func _ready():
	var area: Area2D = get_node("Area2D")
	area.area_entered.connect(_area_entered)

func _physics_process(delta):
	# Calculate the direction vector towards the target position
	var direction = (target_position - position).normalized()
	
	# Calculate the distance to the target position
	var distance = position.distance_to(target_position)
	move_and_collide(direction * speed * delta)
	
	# Check if the object has reached or passed the target position
	if distance <= speed * delta:
		queue_free()  # Destroy the object

func _area_entered(area: Area2D):
	var parent = area.get_parent()
	if area.name != "DamageHandler" or area.is_player == from_player: return
	
	emit_signal("on_hit", self)
	area.send_damage(damage)
	queue_free()
