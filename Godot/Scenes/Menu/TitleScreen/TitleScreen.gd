extends Control

onready var new_game_button : Button = $Control/HBoxContainer/NewGameButton


func _ready():
	new_game_button.grab_focus()


func _on_ExitButton_pressed():
	get_tree().quit()
