extends Node

@export var plane_move_duration = 5

var player: PlaneStats
func _ready():
	player = get_node("Player")
	move_and_show_player()
	
func move_and_show_player():
	var tween = get_tree().create_tween()
	tween.tween_property(player, "position", Vector2.ZERO, plane_move_duration).set_trans(Tween.TRANS_LINEAR)
	tween.play()
