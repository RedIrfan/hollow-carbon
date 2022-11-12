class_name EventDialogue
extends Event

export var dialogue_speed : float = 0.1
export(Array, String, MULTILINE) var dialogue_texts
export(Array, Texture) var characters_profile
export(Array, int) var characters_direction
export(Array, float) var dialogue_durations = []
export var check_if_activated : bool = false

var reseted : bool = false


func _ready():
	add_to_group("Reseter")


func reset():
	reseted = true


func start():
	reseted = false
	var gui = Global.stage_master().gui
	var dialogue_box = gui.get_gui("DialogueBox")
	
	dialogue_box.insert_dialogues(dialogue_speed, dialogue_texts, characters_profile, characters_direction, dialogue_durations)
	
	if gui.guis["dialoguebox"].activated == false and check_if_activated == false:
		gui.enter_gui("DialogueBox")
		yield(dialogue_box, "exited")
		if reseted == false:
			gui.enter_gui("Hud")
	
	exit()
