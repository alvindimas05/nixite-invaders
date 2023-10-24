extends PlaneStats

@export var move_range = 100.0
@export var move_speed = 2.0

var enemy_factory: Node

var can_move: bool
var can_fire: bool : set = _set_can_fire

var damage_handler: Node
var moving: EnemyMovement
var fire: Node
func _ready():
	damage_handler = get_node("DamageHandler")
	moving = EnemyMovement.new(self, move_range, move_speed)
	
	fire = get_node("EnemyFire")
	fire.can_fire = can_fire
	
	damage_handler.on_destroyed.connect(on_destroyed)

func on_destroyed(): enemy_factory.planes = enemy_factory.planes.filter(func(plane): return plane != self)

func _physics_process(_delta):
	if !can_move: return
#	print(can_move)
	moving.move()

#func _set_can_move(val: bool):
#	can_move = val

func _set_can_fire(val: bool):
	if fire != null: fire.can_fire = val
	can_fire = val
