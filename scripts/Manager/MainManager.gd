extends Node

@export var plane_move_duration = 5

var player: PlaneStats
var dialogue: Control
func _ready():
	player = get_node("Player")
	dialogue = get_node("UserInterface/DialogueBox")
	dialogue.start_dialogs(dialogs)
#	move_and_show_player()
	
func move_and_show_player():
	var tween = get_tree().create_tween()
	tween.tween_property(player, "position", Vector2.ZERO, plane_move_duration).set_trans(Tween.TRANS_LINEAR)
	tween.tween_callback(start_dialog)
	tween.play()

var dialogs = [
	{
		"character_name": "Radio",
		"potrait_type": "default",
		"dialog": "Cras fringilla ut ante auctor cursus. Nunc laoreet malesuada purus vitae faucibus. Donec malesuada euismod arcu, eu sollicitudin ante euismod at. Donec justo erat, commodo ac finibus vitae, malesuada convallis massa."
	},
	{
		"character_name": "Nako",
		"potrait_type": "default",
		"dialog": "Nunc tempor sapien ut suscipit pulvinar. Phasellus iaculis rutrum ipsum, ut pulvinar tortor hendrerit at. Fusce nec neque sollicitudin, mollis nulla a, vehicula metus. Suspendisse potenti."
	},
]
func start_dialog():
	var timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = 2
	timer.timeout.connect(func(): 
		dialogue.start_dialogs(dialogs)
	)
	add_child(timer)
	timer.start()
