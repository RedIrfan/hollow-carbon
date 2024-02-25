extends Control

onready var lives_label : Label =$TextureRect/HBoxContainer/VBoxContainer2/LivesValue
onready var enemy_label : Label = $TextureRect/HBoxContainer/VBoxContainer2/EnemyValue
onready var times_label: Label = $TextureRect/HBoxContainer/VBoxContainer2/TimesValue
onready var rank_label : Label = $TextureRect/HBoxContainer/VBoxContainer2/RankValue
onready var animation_player : AnimationPlayer = $AnimationPlayer


func _ready():
	print(Global.game_data)
	print(Global.temporary_data)
	Global.game_data["levels"][Global.get_temporary_data("level_name")]['rank'] = Global.get_temporary_data("rank")
	Global.game_data["levels"][Global.get_temporary_data("level_name")]['time'] = Global.get_temporary_data("time")
	
	animation_player.play("Start")
	yield(animation_player, "animation_finished")
	Global.change_scene("res://Scenes/Menu/MainMenu/MainMenu.tscn")


func print_data(index:int):
	var score_data = Global.temporary_data
	match index:
		1:
			lives_label.set_text(str(score_data["lives"]))
		2:
			enemy_label.set_text(str(score_data["enemy"]))
		3:
			times_label.set_text(str(score_data["time"]))
		4:
			rank_label.set_text(str(score_data["rank"]))
