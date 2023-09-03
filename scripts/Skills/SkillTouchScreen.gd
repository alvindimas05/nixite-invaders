extends Control

func _ready():
	if !DisplayServer.is_touchscreen_available(): return
	position = Vector2(1400, 970)
	
	var skill_2: Control = get_node("Skill 2")
	skill_2.position = Vector2(20, -150)
	
	var skill_3: Control = get_node("Skill 3")
	skill_3.position = Vector2(140, -215)
