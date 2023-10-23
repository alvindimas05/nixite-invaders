extends AnimatedControl

@export var hide_minus_mobile: Vector2
var desktop_position: Vector2

func _ready():
	super()
	var is_mobile = DisplayServer.is_touchscreen_available()
	if self.name.contains("Mobile") && !is_mobile || self.name.contains("Desktop") && is_mobile: queue_free()
	
	if self.name.contains("Mobile"):
		var skill_2: Control = get_node("Skill 2")
		skill_2.position = Vector2(20, -150)
		
		var skill_3: Control = get_node("Skill 3")
		skill_3.position = Vector2(160, -220)
	
	if is_mobile: _hide_position = position - hide_minus_mobile
	hide_position()
