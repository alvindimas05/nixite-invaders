extends PlaneStats

@export var move_range: float
@export var move_speed: float

var moving: EnemyMovement

func _ready():
	moving = EnemyMovement.new(self, move_range, move_speed)

func _physics_process(_delta):
	moving.move()
