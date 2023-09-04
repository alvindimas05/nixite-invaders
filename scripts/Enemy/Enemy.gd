extends PlaneStats

@export var move_range = 100.0
@export var move_speed = 2.0

var can_move = false
var moving: EnemyMovement
func _ready():
	moving = EnemyMovement.new(self, move_range, move_speed)

func _physics_process(_delta):
	if !can_move: return
	moving.move()
