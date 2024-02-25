extends Button

export var boss_profile: Texture
export var boss_name : String
export var stage_name : String
export var stage_data_name : String
export var stage_path : String

var menu_parent : Control


func _ready():
	add_to_group("StageButton")
	menu_parent = get_parent().get_parent().get_parent()
	self.connect("pressed", self, "_on_pressed")


func _on_pressed():
	menu_parent.change_stage(self.name)

