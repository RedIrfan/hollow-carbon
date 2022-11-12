extends AnimationPlayer


func _ready():
	add_to_group("Metal Eyes")
	
	play("RESET")


func blink():
	play("blink")
