extends Node

@export var plane_move_duration = 1
@export var delay_before_dialog_0 = 1
@export var delay_before_dialog_1 = 1

@export var delay_before_spawn_enemies = 1
@export var enemies_total = 10

var player: PlaneStats
var dialogue: Control
var enemy_factory: Node
var turn = -1
func _ready():
	player = get_node("Player")
	dialogue = get_node("UserInterface/DialogueBox")
	enemy_factory = get_node("EnemyFactory")
	
	next_turn()

func next_turn():
	turn += 1
	match turn:
		0: move_and_show_player()
		1: start_dialogue_0()
		2: spawn_enemies()
		3: start_dialogue_1()

func spawn_enemies():
	var timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = delay_before_spawn_enemies
	timer.timeout.connect(func():
		enemy_factory.total_enemy = enemies_total
		enemy_factory.spawn_enemies()
		next_turn()
	)
	add_child(timer)
	timer.start()

func move_and_show_player():
	var tween = get_tree().create_tween()
	tween.tween_property(player, "position", Vector2.ZERO, plane_move_duration).set_trans(Tween.TRANS_LINEAR)
	tween.tween_callback(next_turn)
	tween.play()

var dialogues_0: JSON = load("res://dialogues/plane_dialouges_0.json")
var dialogues_1: JSON = load("res://dialogues/plane_dialouges_1.json")

func start_dialogue_0():
	var timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = delay_before_dialog_0
	timer.timeout.connect(func():
		dialogue.on_dialogs_done.connect(next_turn)
		dialogue.start_dialogs(dialogues_0.data)
	)
	add_child(timer)
	timer.start()

func start_dialogue_1():
	var timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = delay_before_dialog_1
	timer.timeout.connect(func():
		dialogue.on_dialogs_done.disconnect(next_turn)
		dialogue.start_dialogs(dialogues_1.data)
	)
	add_child(timer)
	timer.start()
