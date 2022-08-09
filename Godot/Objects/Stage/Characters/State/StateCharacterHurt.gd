class_name StateCharacterHurt
extends StateCharacter

export var hurt_animation : String = "Hurt"
export var hurt_duration : float = 0.5
export var skips_stun : bool = false

var hurt_jump_velocity : float = 45
var hurt_speed : float = 45
var skipping : bool = false

onready var hurt_timer : Timer = $HurtTimer


func _ready():
	hurt_timer.connect("timeout", self, "_on_hurt_timeout")


func enter_condition(nbody, msg={}):
	body = nbody
	if skips_stun == true:
		skip_stun()
		
		return false
	if msg.has("skip"):
		if msg["skip"] == true:
			skip_stun()
			
			return false
	return true


func enter(msg={}):
	skipping = false
	
	body.speed = hurt_speed
	body.velocity.y = -hurt_jump_velocity
	
	var attacker_pos = Vector2(body.attack_data["hitbox_position"].x, body.global_position.y)
	body.direction_x = body.global_position.direction_to(attacker_pos).x * -1
	
	body.pivot.flash(true)
	body.play_animation(hurt_animation)
	
	hurt_timer.start(0.01)
	
	body.attack_data = null


func exit():
	body.pivot.flash(false)
	body.direction_x = 0
	body.speed = body.DEFAULT_SPEED


func physics_process(_delta):
	if body.on_floor() and hurt_timer.is_stopped():
		fsm.enter_state(fsm.initial_state.name)


func skip_stun():
	body.attack_data = null
	
	skipping = true
	body.pivot.flash(true)
	
	hurt_timer.start(0.1)


func _on_hurt_timeout():
	if skipping == true:
		body.pivot.flash(false)
