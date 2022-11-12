extends GuiChild

onready var animation_player : AnimationPlayer = $AnimationPlayer
onready var sfx_slider : HSlider = $Items/GridContainer/SfxSlider
onready var music_slider : HSlider = $Items/GridContainer/MusicLabel2


func enter():
	.enter()
	
	sfx_slider.value = Global.get_sfx_volume()
	music_slider.value = Global.get_music_volume()
	
	animation_player.play("open")
	sfx_slider.grab_focus()


func exit():
	animation_player.play_backwards("open")
	yield(animation_player, "animation_finished")
	.exit()


func _on_ExitButton_pressed():
	exit()


func _on_SaveButton_pressed():
	Global.set_sfx_volume(sfx_slider.value)
	Global.set_music_volume(music_slider.value)
	
	$Items/HBoxContainer/ExitButton.grab_focus()


func _on_ResetButton_pressed():
	sfx_slider.value = Global.default_game_data['sfx_volume']
	music_slider.value = Global.default_game_data['music_volume']
	
	$Items/HBoxContainer/SaveButton.grab_focus()
