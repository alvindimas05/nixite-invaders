extends Control

func _ready():
	if !DisplayServer.is_touchscreen_available(): return
	var fire_button = get_node("/root/Main/UserInterface/FireButton")
	position = fire_button.position
	position += Vector2(-40, 180)
	
	var skill_2: Control = get_node("Skill 2")
	skill_2.position = Vector2(20, -150)
	
	var skill_3: Control = get_node("Skill 3")
	skill_3.position = Vector2(160, -220)
