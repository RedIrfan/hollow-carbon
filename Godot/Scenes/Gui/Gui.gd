extends Control

signal gui_changed(to_gui)

var guis = {}
var current_gui = null
var last_gui = null


func _ready():
	add_to_group("Gui Master")
	
	for child in get_children():
		if child.is_in_group("Gui Child"):
			guis[child.name.to_lower()] = child


func enter_gui(gui_name:String):
	gui_name = gui_name.to_lower()
	if guis.has(gui_name):
		if current_gui:
			last_gui = current_gui
			last_gui.exit()
			yield(last_gui, "exited")
		current_gui = guis[gui_name]
		current_gui.enter()
		yield(get_tree().create_timer(0.01), "timeout")
		emit_signal("gui_changed", gui_name)


func _physics_process(delta):
	if current_gui:
		current_gui.physics_process(delta)


func get_gui(gui_name):
	gui_name = gui_name.to_lower()
	if guis.has(gui_name):
		return guis[gui_name]

