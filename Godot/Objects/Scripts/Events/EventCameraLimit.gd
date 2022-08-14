class_name EventCameraLimit
extends Event

export(String, "Top Left", "Left", "Top", "None") var top_left = "Top Left"
export(String ,"Bottom Right", "Right", "Bottom", "None") var bottom_right = "Bottom Right"
export var bottom_right_node_path :NodePath = ""

var bottom_right_node : Node


func _ready():
	if bottom_right_node_path != "":
		bottom_right_node = get_node(bottom_right_node_path)


func start():
	var camera = Global.stage_master().camera
	
	if top_left == "Top Left" or top_left == "Left":
		camera.limit_left = self.global_position.x
	if top_left == "Top Left" or top_left == "Top":
		camera.limit_top = self.global_position.y
	
	if bottom_right == "Bottom Right" or bottom_right == "Right":
		camera.limit_right = bottom_right_node.global_position.x
	if bottom_right == "Bottom Right" or bottom_right == "Bottom":
		camera.limit_bottom = bottom_right_node.global_position.y
	exit()
