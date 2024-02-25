extends GuiChild

var character_profiles : Array = []
var character_profiles_direction : Array = []
var dialogue_texts : Array = []
var dialogue_durations : Array = []
var dialogue_speed : float = 0.2

var current_text : String = ""
var current_character_index : int = 0
var current_text_index : int = 0
var check_for_player_input : bool = false
var activated : bool = false

onready var animation_player : AnimationPlayer = $AnimationPlayer
onready var arrow_animation : AnimationPlayer = $ArrowAnimation
onready var character_profile_left : TextureRect = $TextureRect/MarginContainer/HSplitContainer/CharacterProfileLeft
onready var character_profile_right : TextureRect = $TextureRect/MarginContainer/HSplitContainer/CharacterProfileRight
onready var dialogue_text_label : RichTextLabel = $TextureRect/MarginContainer/HSplitContainer/RichTextLabel
onready var character_timer : Timer = $CharacterTimer
onready var dialogue_timer : Timer = $DialogueTimer


func _ready():
# warning-ignore:return_value_discarded
	Global.connect("paused", self, "_on_global_paused")


func enter():
	.enter()
	animation_player.play("Open")
	
	yield(animation_player, "animation_finished")
	
	start_dialogue()


func exit():
	arrow_animation.play("RESET")
	
	activated = false
	dialogue_texts = []
	character_profiles = []
	character_profiles_direction = []
	dialogue_durations = []
	
	animation_player.play_backwards("Open")
	yield(animation_player,"animation_finished")
	.exit()


func insert_dialogues(new_dialogue_speed, new_dialogue_texts, new_character_profiles, new_character_profiles_direction=[], new_dialogue_durations=[]):
	dialogue_speed = new_dialogue_speed
	dialogue_texts += new_dialogue_texts
	character_profiles += new_character_profiles
	character_profiles_direction += new_character_profiles_direction
	dialogue_durations += new_dialogue_durations


func start_dialogue():
	activated = true
	current_text_index = 0
	current_character_index = 0
	character_profile_left.texture = null
	character_profile_right.texture = null
	dialogue_text_label.bbcode_text = ""
	update_dialogue()


func update_dialogue():
	if current_text_index >= dialogue_texts.size():
		end_dialogue()
	else:
		current_character_index = 0
		dialogue_text_label.bbcode_text = ""
		current_text = dialogue_texts[current_text_index]
		
		if character_profiles_direction.size() > 1:
			var index = current_text_index
			if character_profiles_direction.size() <= index:
				index = character_profiles_direction.size() - 1
			update_profile(index)
		else:
			update_profile(0)
		
		character_timer.start(dialogue_speed)


func update_profile(index = current_text_index):
	if character_profiles_direction[index] == 1:
		character_profile_left.texture = character_profiles[index]
		character_profile_right.texture = null
	else:
		character_profile_left.texture = null
		character_profile_right.texture = character_profiles[index]


func end_dialogue():
	exit()


func physics_process(_delta):
	if check_for_player_input:
		arrow_animation.play("Bounce")
		if Input.is_action_just_pressed("action_attack"):
			current_text_index += 1
			check_for_player_input = false
			arrow_animation.play("RESET")
			
			update_dialogue()


func _on_CharacterTimer_timeout():
	dialogue_text_label.bbcode_text += current_text[current_character_index]
	current_character_index += 1
	
	if current_character_index < current_text.length():
		character_timer.start(dialogue_speed)
	elif current_text_index < dialogue_durations.size():
		dialogue_timer.start(dialogue_durations[current_text_index])
	else:
		check_for_player_input = true


func _on_DialogueTimer_timeout():
	current_text_index += 1
	
	update_dialogue()


func _on_global_paused(mode:int):
	match mode:
		Global.PAUSES.FULL:
			character_timer.pause_mode = PAUSE_MODE_STOP
			dialogue_timer.pause_mode = PAUSE_MODE_STOP
		Global.PAUSES.CUTSCENE:
			character_timer.pause_mode = PAUSE_MODE_PROCESS
			dialogue_timer.pause_mode = PAUSE_MODE_PROCESS
