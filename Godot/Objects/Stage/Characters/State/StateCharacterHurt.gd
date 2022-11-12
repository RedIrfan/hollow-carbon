class_name StateCharacterHurt
extends StateCharacter

export var hurt_animation : String = "Hurt"
export var hurt_duration : float = 0.5
export var hurt_soundfx : AudioStreamSample
export var skips_stun : bool = false

var hurt_jump_velocity : float = 45
var hurt_speed : float = 45
var skipping : bool = false
var dead : bool = false

onready var hurt_timer : Timer = $HurtTimer


func _ready():
	add_to_group("Reseter")
	hurt_timer.connect("timeout", self, "_on_hurt_timeout")


func reset():
	dead = false


func play_sfx():
	Global.play_soundfx(body.global_position, hurt_soundfx)


func enter_condition(nbody, msg={}):
	body = nbody
	
	if process_health():
		return true
	
	if skips_stun == true:
		skip_stun()
		
		return false
	if msg.has("skip"):
		if msg["skip"] == true:
			skip_stun()
			
			return false
	return true


func enter(msg={}):
	play_sfx()
	body.sprite_switched = -1
	skipping = false
	
	if dead:
		fsm.enter_state("Dead")
		return
	
	body.speed = hurt_speed
	body.velocity.y = -hurt_jump_velocity
	
	var attacker_pos = body.attack_data["hitbox_position"]
	body.direction_x = 1 if attacker_pos.x < body.global_position.x else -1
	
	body.pivot.flash(true)
	body.play_animation(hurt_animation)
	
	hurt_timer.start(0.2)
	
	body.attack_data = null


func exit():
	body.sprite_switched = 1
	body.pivot.flash(false)
	body.direction_x = 0
	body.speed = body.DEFAULT_SPEED


func physics_process(_delta):
	if body.is_on_floor() and hurt_timer.is_stopped():
		fsm.enter_state(fsm.initial_state.name)


func process_health():
	body.health -= body.attack_data["damage"]
	
	if body.health <= 0:
		dead = true
		return true
	return false


func skip_stun():
	play_sfx()
	body.attack_data = null
	
	skipping = true
	body.pivot.flash(true)
	
	hurt_timer.start(0.1)


func _on_hurt_timeout():
	if skipping == true:
		body.pivot.flash(false)
