extends AudioStreamPlayer

var voices = {}
func _ready():
	load_all_voices()

func play_voice(name: String):
	stream = voices[name]
	play()
	
func stop_voice():
	stop()

func load_all_voices():
	var dir = DirAccess.open("res://sounds/voices")
	assert(dir, "ERROR: Directory voices missing!")
	
	dir.list_dir_begin()
	var fname = dir.get_next()
	while fname != "":
		var nname = fname.replace(".wav", "")
		voices[nname] = load("res://sounds/voices/" + fname)
		fname = dir.get_next()
