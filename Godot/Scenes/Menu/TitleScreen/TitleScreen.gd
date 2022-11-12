extends Control

onready var new_game_button : Button = $Items/HBoxContainer/NewGameButton
onready var option_button : Button = $Items/HBoxContainer/OptionButton
onready var option_menu : GuiChild = $Items/OptionMenu
onready var fade_panel : GuiChild = $FadePanel
onready var confirmation_menu : GuiChild = $ConfirmationMenu


func _ready():
	fade_panel.set_fade(Tween.EASE_OUT, Color(0,0,0,1), Color(0,0,0,0), 1)
	fade_panel.enter()
	yield(fade_panel, "exited")
	
	new_game_button.grab_focus()


func _on_ExitButton_pressed():
	confirmation_menu.insert_confirmation("exit")
	yield(confirmation_menu, "answered")
	
	if confirmation_menu.answer == true:
		fade_panel.set_fade(Tween.EASE_IN, Color(0,0,0,0), Color(0,0,0,1), 0.5)
		fade_panel.enter()
		yield(fade_panel, "exited")
		fade_panel.visible = true
	
		get_tree().quit()
	else:
		$Items/HBoxContainer/ExitButton.grab_focus()


func _on_OptionButton_pressed():
	option_menu.enter()


func _on_OptionMenu_exited():
	option_button.grab_focus()


func _on_NewGameButton_pressed():
	confirmation_menu.insert_confirmation("exit")
	yield(confirmation_menu, "answered")
	
	if confirmation_menu.answer == true:
		Global.change_scene("res://Scenes/Cutscene/Cutscene.tscn")
	else:
		$Items/HBoxContainer/NewGameButton.grab_focus()
