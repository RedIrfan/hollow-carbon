class_name EventBoss
extends Event

export var boss_path: NodePath = ""

var boss:Node


func _ready():
	boss = get_node(boss_path)


func start():
	Global.stage_master().set_boss(boss)
	exit()
