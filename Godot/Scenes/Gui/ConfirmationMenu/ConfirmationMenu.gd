extends GuiChild

signal answered(confirmation_name, answer)

enum buttons{
	YES,
	NO
}

var confirmation_name :String
var answer : bool

onready var animation_player :AnimationPlayer = $AnimationPlayer


func enter():
	.enter()
	animation_player.play("open")


func exit():
	animation_player.play_backwards("open")
	yield(animation_player,"animation_finished")
	
	Global.pause(false)
	emit_signal("answered", confirmation_name, answer)
	.exit()


func insert_confirmation(new_confirmation_name:String, default_button:int=buttons.NO):
	confirmation_name = new_confirmation_name
	
	Global.pause(true)
	enter()
	yield(animation_player, "animation_finished")
	match default_button:
		buttons.YES:
			$Control/YesButton.grab_focus()
		buttons.NO:
			$Control/NoButton.grab_focus()


func _on_YesButton_pressed():
	_answer(true)
	exit()


func _on_NoButton_pressed():
	_answer(false)
	exit()


func _answer(bool_answer:bool):
	answer = bool_answer
