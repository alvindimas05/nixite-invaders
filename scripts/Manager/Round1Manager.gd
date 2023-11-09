extends Node

@export var plane_move_duration = .1
@export var delay_before_dialogue_0 = 1
@export var delay_before_dialogue_1 = 2
@export var delay_before_dialogue_2 = 5
@export var meteors_count = 7
@export var second_meteors_count = 20

var player: PlaneStats
var user_interface: Node
var dialogue: Control
var asteroid_factory: Node
var flying_dialogue: Node

var dialogues_0: JSON = load("res://dialogues/round_1/dialogues_0.json")
var dialogues_1: JSON = load("res://dialogues/round_1/dialogues_1.json")
var dialogues_2: JSON = load("res://dialogues/round_1/dialogues_2.json")
var dialogues_3: JSON = load("res://dialogues/round_1/dialogues_3.json")

var wait_for_shotting = false

func _ready():
	player = get_node("Player")
	user_interface = get_node("UserInterface")
	dialogue = get_node("UserInterface/DialogueBox")
	asteroid_factory = get_node("AsteroidFactory")
	flying_dialogue = get_node("UserInterface/FlyingDialogue")
	
#	start_without_cutscene()
	next_turn()
	
func _process(delta):
	if wait_for_shotting && Input.is_action_just_pressed('fire'):
		wait_for_shotting = false
		next_turn()

var turn = -1
func next_turn():
	turn += 1
	match turn:
		0: move_and_show_player()
		1: start_dialogue_0()
		2: allow_controls()
		3: start_dialogue_1()
		4: spawn_asteroids()
		5: start_dialogue_2()
		6: spawn_asteroids()
		7: allow_skills()
		8: start_dialogue_3()
		9: spawn_second_asteroids()

func move_and_show_player():
	var tween = get_tree().create_tween()
	tween.tween_property(player, "position", Vector2.ZERO, plane_move_duration).set_trans(Tween.TRANS_LINEAR)
	tween.tween_callback(next_turn)
	tween.play()

func start_dialogue_0():
	var timer = Timer.new()
	timer.one_shot = true 
	timer.wait_time = delay_before_dialogue_0
	timer.timeout.connect(func():
		dialogue.on_dialogs_done.connect(next_turn)
		dialogue.start_dialogs(dialogues_0.data)
	)
	add_child(timer)
	timer.start()

func allow_controls():
	wait_for_shotting = true
	player.can_move = true
	player.can_shot = true

func start_dialogue_1():
	var timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = delay_before_dialogue_1
	timer.timeout.connect(func():
		flying_dialogue.start_dialogues(dialogues_1.data)
		flying_dialogue.on_dialog_done.connect(next_turn)
	)
	add_child(timer)
	timer.start()

func spawn_asteroids():
	asteroid_factory.spawn_asteroids(meteors_count)
	next_turn()

func start_dialogue_2():
	var timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = delay_before_dialogue_2
	timer.timeout.connect(func():
		flying_dialogue.start_dialogues(dialogues_2.data)
	)
	add_child(timer)
	timer.start()

func allow_skills():
	user_interface.show_all()
	player.can_skill = true
	next_turn()

func start_dialogue_3():
	flying_dialogue.start_dialogues(dialogues_3.data)
	next_turn()

func spawn_second_asteroids():
	asteroid_factory.spawn_asteroids(second_meteors_count)
