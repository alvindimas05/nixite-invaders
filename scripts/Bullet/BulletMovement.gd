extends CharacterBody2D

@export var damage: int

@export var speed = 1500
@export var can_move = false
@export var from_player: bool
@export var target_position: Vector2

func _physics_process(delta):
	# Calculate the direction vector towards the target position
	var direction = (target_position - position).normalized()
	
	# Calculate the distance to the target position
	var distance = position.distance_to(target_position)
	move_and_collide(direction * speed * delta)
	
	# Check if the object has reached or passed the target position
	if distance <= speed * delta:
		queue_free()  # Destroy the object
