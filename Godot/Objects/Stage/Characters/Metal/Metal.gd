extends Node2D

export var MAXIMUM_ENERGY : int = 100
export var speed : int = 10

var energy : float = 0 setget set_energy

var player : Node
var ball_position : Vector2 = Vector2.ZERO

onready var pivot : Node2D = $Pivot
onready var state_master : StateMaster = $StateMetalMaster


func _ready():
	player = Global.stage_master().player
	
	ball_position = pivot.position
	pivot.position = Vector2.ZERO


func _physics_process(delta):
	if player:
		var npos = player.global_position + ball_position
		npos.x = (player.global_position.x + (ball_position.x * pivot.scale.x)) 
		
		self.global_position = lerp(self.global_position, npos, speed * delta)
		
		pivot.scale.x = player.pivot.scale.x
		
		if Input.is_action_just_pressed("action_special"):
			state_master.attack()


func set_energy(nenergy:float):
	energy = clamp(nenergy, 0, MAXIMUM_ENERGY)
