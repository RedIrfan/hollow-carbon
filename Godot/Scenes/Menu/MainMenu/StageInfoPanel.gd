extends Panel

onready var character_profile : TextureRect = $VBoxContainer/TextureRect
onready var boss_name : Label = $VBoxContainer/Label

onready var score : Label = $VBoxContainer/VBoxContainer/Label3
onready var record_time : Label = $VBoxContainer/VBoxContainer/Label2


func _on_MainMenu_stage_changed(button_node):
	get_parent().get_node("Label").text = button_node.stage_name
	character_profile.texture = button_node.boss_profile
	boss_name.text = button_node.boss_name
