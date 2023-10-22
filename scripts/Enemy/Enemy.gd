extends PlaneStats

@export var move_range = 100.0
@export var move_speed = 2.0

var can_move = false
var can_fire = false : set = _set_can_fire

var moving: EnemyMovement
var fire: Node
func _ready():
	moving = EnemyMovement.new(self, move_range, move_speed)
	fire = get_node("EnemyFire")

func _physics_process(_delta):
	if !can_move: return
#	print(can_move)
	moving.move()

#func _set_can_move(val: bool):
#	can_move = val

func _set_can_fire(val: bool):
	fire.can_fire = val
	can_fire = val
