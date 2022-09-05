extends Node2D

export var MAXIMUM_ENERGY : int = 100
export var speed : int = 5

var energy : float = 0 setget set_energy

var player : Node
var ball_position : Vector2 = Vector2.ZERO
var startup : bool = false

onready var pivot : Node2D = $Pivot
onready var state_master : StateMaster = $StateMetalMaster
onready var animated_sprite = $Pivot/AnimatedSprite


func _ready():
	add_to_group("Reseter")
	player = Global.stage_master().player
	
	player.metal = self
	
	ball_position = pivot.position
	pivot.position = Vector2.ZERO
	
	get_tree().call_group("Metal Eyes", "blink")


func reset():
	energy = 0
	startup = false


func _physics_process(delta):
	if player:
		if startup == false:
			self.global_position = player.global_position + ball_position
			startup = true
		
		var npos = player.global_position + ball_position
		npos.x = (player.global_position.x + (ball_position.x * pivot.scale.x)) 
		
		self.global_position = lerp(self.global_position, npos, speed * delta)
		
		pivot.scale.x = player.pivot.scale.x * player.sprite_switched
		
		if Input.is_action_just_pressed("action_special"):
			state_master.attack()


func set_energy(nenergy:float):
	energy = clamp(nenergy, 0, MAXIMUM_ENERGY)


func eyes_black():
	animated_sprite.material.set_shader_param("replace_light", Color(0.5, 0.62, 0.65, 1))
	animated_sprite.material.set_shader_param("replace_medium", Color(0.2, 0.31, 0.49, 1))
	animated_sprite.material.set_shader_param("replace_dark", Color(0.09, 0.14, 0.37, 1))
