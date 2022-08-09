extends StateEnemy


func _ready():
	body.connect_to_animation(self, "_on_animation_finished")
