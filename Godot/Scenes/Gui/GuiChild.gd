class_name GuiChild
extends Control

# warning-ignore:unused_signal
signal entered()
signal exited()


func _ready():
	pause_mode = PAUSE_MODE_PROCESS
	add_to_group("Gui Child")


func enter():
	self.visible = true


func exit():
	self.visible = false
	
	yield(get_tree().create_timer(0.1), "timeout")
	emit_signal("exited")


func physics_process(_delta):
	pass
