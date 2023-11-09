extends RichTextLabel

@export var delay_per_character = .03
@export var delay_per_character_before_clear = .05

signal on_dialog_done

var on_dialog = false
func _ready():
	set_timer_dialog()
	set_timer_clear_dialog()
	set_timer_before_clear_dialog()

func random_position():
	var half_x = size.x / 2
	position.x = randf_range(position.x - half_x, position.x + half_x)

var dialogues = []
var dialogue_index: int
func start_dialogues(dialogues: Array):
	assert(!on_dialog, "ERROR: Trying to start dialogues while on dialogue!")
	
	self.dialogues = dialogues
	
	set_dialogue()
	continue_dialog(true)

var character_name: String
var dialogue: String
func set_dialogue():
	var dlg = dialogues[dialogue_index]
	character_name = dlg["character_name"]
	dialogue = dlg["dialog"]

var timer_dialog = Timer.new()
func set_timer_dialog():
	timer_dialog.one_shot = false
	timer_dialog.wait_time = delay_per_character
	timer_dialog.timeout.connect(set_character)
	add_child(timer_dialog)

var timer_clear_dialog = Timer.new()
func set_timer_clear_dialog():
	timer_clear_dialog.one_shot = false
	timer_clear_dialog.wait_time = delay_per_character
	timer_clear_dialog.timeout.connect(clear_character)
	add_child(timer_clear_dialog)

var timer_before_clear_dialog = Timer.new()
func set_timer_before_clear_dialog():
	timer_before_clear_dialog.one_shot = true
	timer_before_clear_dialog.timeout.connect(func(): timer_clear_dialog.start())
	add_child(timer_before_clear_dialog)

func continue_dialog(is_first: bool = false):
	if(!is_first): dialogue_index += 1
	if(dialogue_index >= dialogues.size()): return end_dialogue()
	
	random_position()
	set_dialogue()
	
	dialogue = "(" + character_name + ")" + "\n" + dialogue
	
	char_index = 0
	timer_dialog.start()
#	set_text(dialogs[dialog_index]["dialog"])

func end_dialogue():
	char_index = 0
	dialogue_index = 0
	emit_signal("on_dialog_done")

func clear_character():
	char_index -= 5
	text = dialogue.substr(0, char_index if char_index > -1 else 0)
	if char_index < 0:
		timer_clear_dialog.stop()
		continue_dialog()

var char_index: int
func set_character():
	add_text(dialogue[char_index])
	char_index += 1
	
	if char_index >= dialogue.length():
		timer_dialog.stop()
		timer_before_clear_dialog.wait_time = delay_per_character_before_clear * dialogue.length()
		timer_before_clear_dialog.start()
