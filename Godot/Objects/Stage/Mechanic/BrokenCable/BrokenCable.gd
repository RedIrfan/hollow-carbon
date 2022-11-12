extends Node2D

export var damage : int = 5
export var delay_duration : float = 0
export var electric_interval : float = 2
export var electric_duration : float = 0.2

enum states {
	STARTUP,
	IDLE,
	ELECTRIC
}
var state = states.STARTUP

onready var timer : Timer = $Timer
onready var animated_sprite : AnimatedSprite = $Pivot/AnimatedSprite
onready var hitbox : Hitbox = $Pivot/Hitbox


func _ready():
	timer.connect("timeout", self, "_on_timer_timeout")
	
	state = states.STARTUP
	if delay_duration != 0:
		timer.start(delay_duration)
	else:
		_on_timer_timeout()


func _on_timer_timeout():
	match state:
		states.STARTUP:
			set_idle()
		states.IDLE:
			set_electric()
		states.ELECTRIC:
			set_idle()


func set_idle():
	hitbox.set_damage(0)
	animated_sprite.play("default")
	state = states.IDLE
	timer.start(electric_interval)


func set_electric():
	hitbox.set_damage(damage)
	animated_sprite.play("Electric")
	state = states.ELECTRIC
	timer.start(electric_duration)
