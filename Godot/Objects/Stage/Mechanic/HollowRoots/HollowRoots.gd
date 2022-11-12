extends Node2D

export var area_path : NodePath =""
export var animation_speed : float = 1.0
export(String, "Opened", "Blocked") var starting_mode = "Opened"

enum modes{
	BLOCKED,
	OPENED,
}
var mode : int = modes.OPENED
var area : Area2D
var can_activate : bool = true
var saved_current_mode : int = 1

onready var animation_player : AnimationPlayer = $AnimationPlayer


func _ready():
	add_to_group("Reseter")
	add_to_group("ResetSaver")
	
	animation_player.connect("animation_finished", self, "_on_animation_finished")
	
	area = get_node(area_path)
	area.connect("body_entered", self, "_on_body_entered")
	
	saved_current_mode = modes.BLOCKED if starting_mode == "Blocked" else modes.OPENED
	reset()


func start():
	can_activate = false
	play_animation()


func reset():
	mode = saved_current_mode
	
	animation_player.play("RESET")
	if mode == modes.BLOCKED:
		animation_player.play("blocked")
	
	can_activate = true


func save_reset():
	saved_current_mode = mode


func play_animation():
	var anim = "Grow"
	if mode == modes.BLOCKED:
		anim += "Bacwards"
	animation_player.play(anim, -1, animation_speed)


func _on_animation_finished(animation):
	if animation == "Grow" or animation == "GrowBackwards":
		can_activate = false
		switch_mode()


func switch_mode():
	if mode == modes.BLOCKED:
		mode = modes.OPENED
	else:
		mode = modes.BLOCKED


func _on_body_entered(body):
	if body.is_in_group("Player") and can_activate == true:
		start()
