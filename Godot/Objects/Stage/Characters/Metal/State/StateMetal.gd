class_name StateMetal
extends State

export var metal_maximum_energy : int = 100
export var metal_speed : int = 5
export var recoil : Vector2 = Vector2(10, 0)
export var energy_reduction : float = 10
export var cooldown_duration  : float = 1
export(Array, Color) var eye_colors = [
	Color(0.59, 0.84, 0.69, 1), 
	Color(0.36, 0.76, 0.84, 1),
	Color(0.24, 0.5, 0.7, 1)
];

var cooldown_timer : Timer


func _ready():
	cooldown_timer = Timer.new()
	cooldown_timer.one_shot = true
	add_child(cooldown_timer)


func enter(msg={}):
	body.MAXIMUM_ENERGY = metal_maximum_energy
	body.speed = metal_speed


func attack():
	if cooldown_timer.is_stopped() and body.energy >= energy_reduction:
		body.energy -= energy_reduction
		body.global_position -= recoil * body.pivot.scale.x
		_attack_behaviour()
		
		cooldown_timer.start(cooldown_duration)


func _attack_behaviour():
	pass


func physics_process(_delta):
	if body.energy >= energy_reduction and cooldown_timer.is_stopped():
		eyes_color()
	else:
		body.eyes_black()


func eyes_color():
	var material = body.animated_sprite.material
	
	material.set_shader_param("replace_light", eye_colors[0])
	material.set_shader_param("replace_medium", eye_colors[1])
	material.set_shader_param("replace_dark", eye_colors[2])
