extends Effect

onready var animation: AnimatedSprite = $AnimatedSprite

var floating_speed :float = 20


func _ready():
	animation.play("default")


func _physics_process(delta):
	self.global_position.y -= floating_speed * delta


func _on_AnimatedSprite_animation_finished():
	_destroy()
