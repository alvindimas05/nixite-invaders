extends CanvasLayer

var player_health_status: AnimatedControl
var skills_desktop: AnimatedControl
func _ready():
	offset = Vector2.ZERO
	
	player_health_status = get_node("PlayerHealthStatus")
	skills_desktop = get_node("SkillsDesktop")

func show_all():
	player_health_status.show_ui()
	skills_desktop.show_ui()
