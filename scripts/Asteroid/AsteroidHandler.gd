extends Area2D

@export var damage: float
@export var damage_handler: Node2D
func _ready():
	damage_handler = get_parent().get_node("DamageHandler")
	damage = get_parent().damage
	area_entered.connect(_area_entered)

func _area_entered(area: Area2D):
	var parent = area.get_parent()
	if area.name != "DamageHandler" or !area.is_player: return
	
	area.send_damage(damage)
	damage_handler.destroy_plane()
