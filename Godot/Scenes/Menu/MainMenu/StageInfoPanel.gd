extends Panel

onready var character_profile : TextureRect = $Boss/ProfileTexture
onready var boss_name : Label = $Boss/NameLabel

onready var ranking_label : Label = $Score/RankingLabel
onready var record_time : Label = $Score/TimeLabel


func _on_MainMenu_stage_changed(button_node):
	get_parent().get_node("Label").text = button_node.stage_name
	character_profile.texture = button_node.boss_profile
	boss_name.text = button_node.boss_name
	var stage_data = Global.game_data["levels"][button_node.stage_data_name]
	ranking_label.set_text(str(stage_data["rank"]))
	record_time.set_text(str(stage_data["time"]))
