class_name EventHollowRootsWall
extends Event

export var hollow_roots_wall_path:NodePath = ""

var hollow_roots_wall : Node = null


func _ready():
	hollow_roots_wall = get_node(hollow_roots_wall_path)


func start():
	hollow_roots_wall.activate()
	yield(get_tree().create_timer(0.01), "timeout")
	exit()
