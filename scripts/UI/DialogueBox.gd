extends TextureRect

@export var delay_per_character = .05

var text_label: RichTextLabel
var dialog: String
func _ready():
	text_label = get_node("Panel/RichTextLabel")
	set_timer_dialog()
	set_text("Lorem ipsum dolor sit amet")

var on_dialog = false
func set_text(txt: String):
	if on_dialog:
		assert(false, "ERROR: Trying to set dialog text while on dialog!")
		return
	
	dialog = txt
	char_index = 0
	
	text_label.clear()
	timer_dialog.start()
	on_dialog = true

var timer_dialog = Timer.new()
func set_timer_dialog():
	timer_dialog.one_shot = false
	timer_dialog.wait_time = delay_per_character
	timer_dialog.timeout.connect(set_character)
	add_child(timer_dialog)

var char_index: int
func set_character():
	text_label.add_text(dialog[char_index])
	char_index += 1
	
	if char_index >= dialog.length():
		timer_dialog.stop()
		on_dialog = false
