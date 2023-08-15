extends PlaneStats

@export var move_range = 100.0
@export var move_speed = 2.0

var moving: EnemyMovement
func _ready():
	moving = EnemyMovement.new(self, move_range, move_speed)

func _physics_process(_delta):
	moving.move()
