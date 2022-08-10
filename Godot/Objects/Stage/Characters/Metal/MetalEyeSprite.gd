extends AnimatedSprite


func _ready():
	add_to_group("Metal Eyes")
	play("default")


func blink():
	play("blink")
