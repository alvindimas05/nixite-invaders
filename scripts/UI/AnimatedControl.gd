class_name AnimatedControl
extends Control

@export var hide_minus_position: Vector2
@export var animation_duration = 1
@export var hide_on_default = true

var _show_position: Vector2
var _hide_position: Vector2
var on_move = false
var on_show: bool

signal after_hide
signal after_show

func _ready():
	reset_position()
	on_show = !hide_on_default
	if hide_on_default: position = _hide_position

func reset_position():
	_show_position = position
	_hide_position = position - hide_minus_position

func hide_position(): position = _hide_position

func hide_ui():
	_move_ui(_hide_position)
	on_show = false
func show_ui():
	_move_ui(_show_position)
	on_show = true

var tween: Tween
func _move_ui(ui_position: Vector2):
	if tween != null && tween.is_running(): tween.stop()
	
	on_move = true
	tween = get_tree().create_tween()
	
	tween.tween_property(self, "position", ui_position, animation_duration).set_trans(Tween.TRANS_BACK)
	tween.tween_callback(func():
		on_move = false
		if on_show: emit_signal("after_show")
		else: emit_signal("after_hide")
	)
	tween.play()
