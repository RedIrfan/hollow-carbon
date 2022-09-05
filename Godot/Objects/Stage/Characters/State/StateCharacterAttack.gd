class_name StateCharacterAttack
extends StateCharacter

export var hitbox_path : NodePath
export var damage : int = 0
export(Array, String) var animations_name = [
	'startup_animation',
	'active_animation',
	'recovery_animation'
]
export(Array, String) var air_animations_name = [
	'startup_animation',
	'active_animation',
	'recovery_animation'
]
export var animation_offset : Vector2 = Vector2.ZERO
export(Array, Vector2) var states_direction = [
	Vector2(0,0),
	Vector2(0,0),
	Vector2(0,0)
]
export var move_speed : float = 0
export var invisible : bool = false
export var enter_state_to : String = ""
export var fall_state : String = "Fall"

var vel_y = 0
enum states {
	NONE,
	STARTUP,
	ACTIVE,
	RECOVERY,
}
var state = states.NONE

var animations = []

var ground : bool = true

var hitbox : Node


func _ready():
	if hitbox_path:
		hitbox = get_node(hitbox_path)


func enter(msg={}):
	if move_speed != 0:
		body.speed = move_speed
	
	body.connect_to_animation(self, "_on_animation_finished")
	
	body.animation_player.offset = animation_offset
	
	ground = true
	if air_animations_name[1] != "active_animation":
		if _get_fall() or msg.has("air"):
			ground = false
			animations = air_animations_name
	
	if ground == true:
		animations = animations_name
		
	if animations[0] != "startup_animation":
		_change_direction(states_direction[0])
		body.play_animation(animations[0])
		
		state = states.STARTUP
	else:
		activate_damage()


func exit():
	body.speed = body.DEFAULT_SPEED
	body.direction_x = 0
	_set_damage(0)
	body.animation_player.offset = Vector2.ZERO
	
	body.disconnect_from_animation(self, "_on_animation_finished")


func physics_process(delta):
	if vel_y != 0:
		body.velocity.y = vel_y
	
	
	if _get_hurt():
		fsm.enter_state("Hurt", {"skip" : invisible})


func activate_damage():
	_change_direction(states_direction[1])
	body.play_animation(animations[1])
	
	state = states.ACTIVE
	_set_damage(damage)


func _set_damage(ndamage:int):
	if hitbox_path:
		hitbox.set_damage(ndamage)


func _on_animation_finished():
	match state:
		states.STARTUP:
			activate_damage()
		states.ACTIVE:
			activate_recovery()
		states.RECOVERY:
			_end_state()


func activate_recovery():
	_change_direction(states_direction[2])
	body.play_animation(animations[2])
	
	state = states.RECOVERY
	_set_damage(0)


func _change_direction(dir:Vector2):
	body.direction_x = body.pivot.scale.x * dir.x
	vel_y = dir.y


func _end_state():
	if ground == true:
		if enter_state_to =="":
			fsm.enter_state(fsm.initial_state.name)
		else:
			fsm.enter_state(enter_state_to)
	else:
		fsm.enter_state(fall_state)
