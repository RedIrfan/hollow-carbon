class_name GuiChild
extends Control

signal entered()
signal exited()


func _ready():
	pause_mode = PAUSE_MODE_PROCESS
	add_to_group("Gui Child")


func enter():
	self.visible = true


func exit():
	self.visible = false
	emit_signal("exited")


func physics_process(_delta):
	pass
