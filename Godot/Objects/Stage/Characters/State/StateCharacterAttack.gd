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
		body.direction_x = 0
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
	hitbox.set_damage(0)
	body.animation_player.offset = Vector2.ZERO
	
	body.disconnect_from_animation(self, "_on_animation_finished")


func physics_process(_delta):
	if _get_hurt():
		fsm.enter_state("Hurt", {"skip" : invisible})


func activate_damage():
	_change_direction(states_direction[1])
	body.play_animation(animations[1])
	
	state = states.ACTIVE
	hitbox.set_damage(damage)


func _on_animation_finished():
	match state:
		states.STARTUP:
			activate_damage()
		states.ACTIVE:
			_change_direction(states_direction[2])
			body.play_animation(animations[2])
			
			state = states.RECOVERY
			hitbox.set_damage(0)
		states.RECOVERY:
			_end_state()


func _change_direction(dir:Vector2):
	body.direction_x = body.pivot.scale.x * dir.x


func _end_state():
	if ground == true:
		fsm.enter_state(fsm.initial_state.name)
	else:
		fsm.enter_state("Fall")
