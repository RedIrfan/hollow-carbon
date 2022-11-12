extends Control

signal stage_changed(button_node)

var current_stage : String = ""
var stage_buttons = {}

onready var buttons_parent = $TextureRect/TextureRect


func _ready():
	for child in buttons_parent.get_children():
		print(child.name)
		if child.is_in_group("StageButton"):
			stage_buttons[child.name] = child


func _on_ExitButton_pressed():
	
	Global.change_scene("res://Scenes/Menu/TitleScreen/TitleScreen.tscn")


func _on_StartButton_pressed():
	pass # Replace with function body.


func change_stage(stage_name:String):
	if stage_buttons.has(stage_name):
		for button in stage_buttons:
			stage_buttons[button].pressed = false
		stage_buttons[stage_name].pressed = true
		current_stage = stage_name
		emit_signal("stage_changed", stage_buttons[stage_name])
