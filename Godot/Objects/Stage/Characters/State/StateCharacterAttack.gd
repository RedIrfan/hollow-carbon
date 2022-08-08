class_name StateCharacterAttack
extends StateCharacter

export var animation_name : String = ""
export var damage : int = 0
export var air_animation_name :String = ""
export var animation_offset : Vector2 = Vector2.ZERO
export var hitbox_path : NodePath
export var startup_duration : float = 0.01
export var active_duration : float = 0.01

enum states {
	NONE,
	STARTUP,
	ACTIVE,
	RECOVERY,
}
var state = states.NONE

var ground : bool = true

var state_timer : Timer
var hitbox : Node


func _ready():
	state_timer = Timer.new()
	add_child(state_timer)
	
	state_timer.one_shot = true
	
	state_timer.connect("timeout", self, "_on_state_timeout")
	
	hitbox = get_node(hitbox_path)


func enter(msg={}):
	body.connect_to_animation(self, "_on_animation_finished")
	
	body.animation_player.offset = animation_offset
	
	ground = true
	if air_animation_name != "":
		if _get_fall() or msg.has("air"):
			ground = false
			body.play_animation(air_animation_name)
	
	if ground == true:
		body.direction_x = 0
		body.play_animation(animation_name)
	
	if startup_duration > 0:
		state = states.STARTUP
		state_timer.start(startup_duration)
	else:
		hitbox.set_damage(damage)
#		activate_damage()


func exit():
	hitbox.set_damage(0)
	body.animation_player.offset = Vector2.ZERO
	
	body.disconnect_from_animation(self, "_on_animation_finished")


func activate_damage():
	state = states.ACTIVE
	state_timer.start(active_duration)
	hitbox.set_damage(damage)


func _on_state_timeout():
	match state:
		states.STARTUP:
			activate_damage()
		states.ACTIVE:
			state = states.RECOVERY
			hitbox.set_damage(0)


func _on_animation_finished():
	if ground == true:
		fsm.enter_state(fsm.initial_state.name)
	else:
		fsm.enter_state("Fall")
