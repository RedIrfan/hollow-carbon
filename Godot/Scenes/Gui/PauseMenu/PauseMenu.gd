extends GuiChild

onready var resume_button : Button = $Control/VBoxContainer/ResumeButton
onready var option_button : Button = $Control/VBoxContainer/OptionButton
onready var option_menu : GuiChild = $OptionMenu
onready var confirmation_menu : GuiChild = $ConfirmationMenu


func enter():
	.enter()
	Global.pause(true)
	
	resume_button.grab_focus()
	get_parent().pause_mode = Node.PAUSE_MODE_STOP


func exit():
	.exit()
	Global.pause(false)
	
	get_parent().pause_mode = Node.PAUSE_MODE_PROCESS


func _on_ResumeButton_pressed():
	exit()


func _on_OptionButton_pressed():
	option_menu.enter()


func _on_ExitButton_pressed():
	confirmation_menu.insert_confirmation("Are you sure?")
	yield(confirmation_menu, "answered")
	if confirmation_menu.answer == true:
		Global.change_scene("res://Scenes/Menu/MainMenu/MainMenu.tscn")


func _on_OptionMenu_exited():
	option_button.grab_focus()


func _physics_process(_delta):
	if self.visible == false:
		if Input.is_action_just_pressed("ui_accept"):
			enter()
