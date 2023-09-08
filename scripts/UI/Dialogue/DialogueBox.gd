extends AnimatedControl

@export var delay_per_character = .02

var text_label: RichTextLabel
var dialog: String
var dialogue_potrait: DialoguePotrait
var voice_effect: AudioStreamPlayer
func _ready():
	super()
	after_hide.connect(func(): text_label.clear())
	
	dialogue_potrait = get_node("DialoguePotrait")
	voice_effect = get_node("VoiceEffect")
	text_label = get_node("TextPanel/RichTextLabel")
	
	set_timer_dialog()
	set_timer_clear_dialog()
#	start_dialogs("Nako", "default", ["Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed dapibus posuere vulputate."])

func _process(delta):
	if wait_for_move && !on_move && on_show:
		wait_for_move = false
		start_dialogs(character_name, potrait_type, dialogs)

func _input(event):
	if event.is_action_pressed("ui_accept") && wait_for_input:
		if dialog_index == dialogs.size() - 1: hide_ui()
		else: timer_clear_dialog.start()

var dialogs = []
var dialog_index = 0
var wait_for_move = false
var wait_for_clear = false

var character_name: String
var potrait_type: String
func start_dialogs(character_name: String, potrait_type: String, dialogs: Array):
	self.character_name = character_name
	self.potrait_type = potrait_type
	if !on_show:
		dialogue_potrait.reset_dialog(character_name, potrait_type)
		show_ui()
		wait_for_move = true
	
	self.dialogs = dialogs
	dialog_index = 0
	
	if wait_for_move: return
	voice_effect.play_voice(character_name)
	set_text(dialogs[dialog_index])

func continue_dialog():
	voice_effect.play_voice()
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
	dialogue_potrait.start_dialog(character_name, potrait_type)
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
	timer_clear_dialog.wait_time = delay_per_character
	timer_clear_dialog.timeout.connect(clear_character)
	add_child(timer_clear_dialog)

func clear_character():
	char_index -= 5
	text_label.text = dialog.substr(0, char_index if char_index > -1 else 0)
	if char_index < 0:
		timer_clear_dialog.stop()
		if dialog_index < dialogs.size() - 1: continue_dialog()

var char_index: int
func set_character():
	text_label.add_text(dialog[char_index])
	char_index += 1
	
	if char_index >= dialog.length():
		voice_effect.stop()
		dialogue_potrait.stop_dialog(character_name, potrait_type)
		
		timer_dialog.stop()
		on_dialog = false
		wait_for_input = true
