class_name PlayerHealthStatusController

var warning_percentage = .50
var critical_percentage = .15

const Status = {
	GOOD = 0,
	WARNING = 1,
	CRITICAL = 2
}

var good: Node2D
var warning: Node2D
var critical: Node2D

var path = "/root/Main/UserInterface/PlayerHealthStatus"
func _init(node: Node):
	good = node.get_node(path + "/Good")
	warning = node.get_node(path + "/Warning")
	critical = node.get_node(path + "/Critical")

func on_change_health_points(hp: float, max_hp: float):
	var percentage_hp = hp / max_hp
	if percentage_hp > warning_percentage:
		change_status(Status.GOOD)
	elif percentage_hp > critical_percentage:
		change_status(Status.WARNING)
	elif percentage_hp < critical_percentage:
		change_status(Status.CRITICAL)

func change_status(status: int):
	hide_all()
	match status:
		Status.GOOD:
			good.show()
		Status.WARNING:
			warning.show()
		Status.CRITICAL:
			critical.show()

func hide_all():
	good.hide()
	warning.hide()
	critical.hide()
