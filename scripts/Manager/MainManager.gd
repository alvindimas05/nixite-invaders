extends Node

@export var plane_move_duration = 5

var player: PlaneStats
var dialogue: Control
func _ready():
	player = get_node("Player")
	dialogue = get_node("UserInterface/DialogueBox")
	move_and_show_player()
	
func move_and_show_player():
	var tween = get_tree().create_tween()
	tween.tween_property(player, "position", Vector2.ZERO, plane_move_duration).set_trans(Tween.TRANS_LINEAR)
	tween.tween_callback(start_dialog)
	tween.play()

func start_dialog():
	var timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = 2
	timer.timeout.connect(func(): dialogue.start_dialogs("Nako", "default", ["Lorem ipsum dolor sit amet"]))
	add_child(timer)
	timer.start()
