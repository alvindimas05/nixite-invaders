class_name PotraitSprites
extends Node

@export var blink_chance = .1

@export var sprite_frames: SpriteFrames
@export var delay_per_frame: float = .1

var _name = "default"
var _blink_name = "_blinking"

var rect: TextureRect

var _frame_name: String
func _ready():
	_frame_name = _name
	rect = get_parent()
	_set_timer()

var _index = 0
var _timer = Timer.new()
func _set_timer():
	_timer.one_shot = false
	_timer.wait_time = delay_per_frame
	_timer.timeout.connect(_set_sprite)
	add_child(_timer)

func start(potrait_type: String):
	_frame_name = potrait_type
	_timer.start()

func stop(potrait_type: String):
	_frame_name = potrait_type
	_timer.stop()
	_reset_sprite()

func _reset_sprite():
	rect.texture = sprite_frames.get_frame_texture(_frame_name, 0)

func random_blink():
	if !sprite_frames.has_animation(_frame_name + _blink_name): return
	is_blinking = randf() <= blink_chance

var is_blinking: bool
func _set_sprite():
	var frame_name = _frame_name + (_blink_name if is_blinking else "")
	rect.texture = sprite_frames.get_frame_texture(frame_name, _index)
	_index += 1
	if _index >= sprite_frames.get_frame_count(frame_name):
		_index = 0
		random_blink()
#		if !is_blinking: _frame_name = _name
