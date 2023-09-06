extends AnimatedControl

@export var delay_per_character = .03
@export var clear_delay_per_character = .01

var text_label: RichTextLabel
var dialog: String
func _ready():
	super()
	text_label = get_node("Panel/RichTextLabel")
	set_timer_dialog()
	set_timer_clear_dialog()

func _process(delta):
	if wait_for_move && !on_move && on_show:
		wait_for_move = false
		start_dialogs(dialogs)

func _input(event):
	if event.is_action_pressed("ui_accept") && wait_for_input:
		if dialog_index == dialogs.size() - 1:
			timer_clear_dialog.start()
			hide_ui()
		else: timer_clear_dialog.start()

var dialogs = []
var dialog_index = 0
var wait_for_move = false
var wait_for_clear = false
func start_dialogs(dialogs: Array):
	if !on_show:
		show_ui()
		wait_for_move = true
	
	self.dialogs = dialogs
	dialog_index = 0
	
	if wait_for_move: return
	set_text(dialogs[dialog_index])

func continue_dialog():
	dialog_index += 1
	set_text(dialogs[dialog_index])

var on_dialog = false
var wait_for_input = false
func set_text(txt: String):
	assert(!on_dialog, "ERROR: Trying to set dialog text while on dialog!")
	
	show()
	wait_for_input = false
	dialog = txt
	char_index = 0
	
	timer_dialog.start()
	on_dialog = true

var timer_dialog = Timer.new()
func set_timer_dialog():
	timer_dialog.one_shot = false
	timer_dialog.wait_time = delay_per_character
	timer_dialog.timeout.connect(set_character)
	add_child(timer_dialog)

var timer_clear_dialog = Timer.new()
func set_timer_clear_dialog():
	timer_clear_dialog.one_shot = false
	timer_clear_dialog.wait_time = clear_delay_per_character
	timer_clear_dialog.timeout.connect(clear_character)
	add_child(timer_clear_dialog)

func clear_character():
	text_label.text = dialog.substr(0, char_index)
	char_index -= 1
	if char_index < 0:
		timer_clear_dialog.stop()
		if dialog_index < dialogs.size() - 1: continue_dialog()

var char_index: int
func set_character():
	text_label.add_text(dialog[char_index])
	char_index += 1
	
	if char_index >= dialog.length():
		timer_dialog.stop()
		on_dialog = false
		wait_for_input = true
