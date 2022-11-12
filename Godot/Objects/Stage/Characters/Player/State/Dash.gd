extends StatePlayer

var after_image = preload('res://Objects/Stage/Effects/AfterImage/AfterImage.tscn')
var dash_spark = preload("res://Objects/Stage/Effects/DashSpark/DashSpark.tscn")
var dust = preload("res://Objects/Stage/Effects/Dust/Dust.tscn")

export var dash_duration : float = 0.2
export var dash_speed : int = 200
export var cooldown_duration : float = 0.1
export var after_image_interval : float = 0.05
export var dust_interval : float = 0.1

onready var dash_timer : Timer = $DashTimer
onready var cooldown_timer : Timer = $CooldownTimer
onready var after_image_timer : Timer = $AfterImageTimer
onready var dust_timer : Timer = $DustTimer


func _ready():
	after_image_timer.connect("timeout", self, "_on_after_image_timer_timeout")


func enter_condition(_nbody, _msg={}) -> bool:
	if cooldown_timer.is_stopped():
		return true
	return false


func enter(msg={}):
	body.gravity = 0
	body.velocity.y = 0
	
	body.play_animation("Dash")
	
	body.speed = dash_speed
	
	dash_timer.start(dash_duration)
	after_image_timer.start(after_image_interval)
	dust_timer.start(dust_interval)
	
	var spark =  dash_spark.instance()
	spark.spawn(body, body.global_position)
	spark.scale.x = body.pivot.scale.x


func exit():
	body.gravity = Global.GRAVITY
	
	body.pivot.flash(false)
	
	dash_timer.stop()
	cooldown_timer.start(cooldown_duration)
	dust_timer.stop()
	
	if fsm.next_state.name != "Jump":
		body.speed = body.DEFAULT_SPEED
		after_image_timer.stop()


func physics_process(delta):
	if dash_timer.is_stopped() or _get_dash() == false:
		fsm.enter_state("idle")
	
	if _get_jump():
		fsm.enter_state("jump", {"dash": true})
	
	if _get_hurt():
		var decreased_damage = body.attack_data["damage"] / 2
		body.health -= decreased_damage
		if body.health > 0:
			body.attack_data = null
		else:
			fsm.enter_state("Hurt")
	
	if _get_attack():
		fsm.enter_state("DashSlash")


func _on_after_image_timer_timeout():
	var c = after_image.instance()
	c.spawn(body, body.global_position, {"animated_sprite" : body.animation_player, "color" : Vector3(0.24, 0.5, 0.7)})


func _on_DustTimer_timeout():
	var dust_object = dust.instance()
	dust_object.spawn(body, body.global_position)
