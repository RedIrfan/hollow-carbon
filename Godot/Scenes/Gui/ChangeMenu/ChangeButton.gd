class_name ChangeButton
extends TextureButton

export(String, "Metal-Carbon", "Cerberus-Hercules", "Storm-Icarus") var content = "Metal-Carbon"
export(String, "Eye", "Core") var mode = "Eye"

var content_numbers = {
	"Metal-Carbon" : 0,
	"Cerberus-Hercules" : 1,
	"Storm-Icarus" : 2,
}
var change_master : GuiChild


func _ready():
	self.connect("button_down", self, "_on_focused")
	self.connect("focus_entered", self, "_on_focused")
	
	change_master = get_parent().get_parent().get_parent()
	
	match mode:
		"Eye":
			if content_numbers[content] == Global.get_eye():
				self.grab_focus()
		"Core":
			if content_numbers[content] == Global.get_core():
				self.grab_focus()
	


func _on_focused():
	if change_master.ready == false:
		yield(change_master, "ready")
	match mode:
		"Eye":
			change_master.set_eye(content_numbers[content], self.rect_global_position)
		"Core":
			change_master.set_core(content_numbers[content], self.rect_global_position)
