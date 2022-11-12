extends GuiChild

var fade_mode : int = Tween.EASE_IN
var fade_colors = {
	"from" : Color(1,1,1,0),
	"to" : Color(1,1,1,1),
}
var fade_duration : float = 0.5
var fade_stay : bool = false

onready var panel : Panel = $Panel
onready var tween : Tween = $Tween


func set_fade(tween_ease_mode : int, from_fade_color : Color, to_fade_color: Color, new_fade_duration, new_fade_stay : bool = false):
	fade_mode = tween_ease_mode
	
	fade_colors["from"] = from_fade_color
	fade_colors["to"] = to_fade_color
	
	fade_duration = new_fade_duration
	
	fade_stay = new_fade_stay


func enter():
	.enter()
	tween.interpolate_property(panel, "modulate", fade_colors["from"], fade_colors["to"], fade_duration, Tween.TRANS_LINEAR, fade_mode)
	tween.start()
	
	if fade_stay == false:
		yield(tween, "tween_completed")
		exit()
