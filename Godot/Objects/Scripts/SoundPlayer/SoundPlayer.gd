class_name SoundPlayer
extends AudioStreamPlayer2D


func _ready():
	self.bus = "Sfx"
	self.connect("finished", self, "_on_audio_finished")


func spawn(new_pos, sound_file):
	self.global_position = new_pos
	
	self.pause_mode = PAUSE_MODE_PROCESS
	self.stream = sound_file
	self.play()


func _on_audio_finished():
	queue_free()
