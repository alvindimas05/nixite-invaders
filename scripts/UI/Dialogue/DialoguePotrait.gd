class_name DialoguePotrait
extends TextureRect

func _ready(): set_potraits()
	
var potraits = {}
func set_potraits():
	for c in get_children(): potraits[c.name] = c

var latest_character_name: String
var latest_potrait_type: String
func start_dialog(character_name: String, potrait_type: String):
#	_stop_all_timer()
	latest_potrait_type = character_name
	latest_potrait_type = potrait_type
	potraits[character_name].start(potrait_type)

func reset_dialog(character_name: String, potrait_type: String):
	latest_potrait_type = character_name
	latest_potrait_type = potrait_type
	potraits[character_name].stop(potrait_type)
#	stop_dialog(character_name, potrait_type)

func stop_dialog(character_name: String, potrait_type: String):
#	_stop_all_timer()
	potraits[character_name].stop(potrait_type)

#func _stop_all_timer():
#	for key in potraits: potraits[key].stop()
