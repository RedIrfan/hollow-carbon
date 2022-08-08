tool
class_name Hurtbox
extends Area2D

export var body_path : NodePath = ""

var body : Node = null


func _ready():
	add_to_group("Hurtbox")
	
	set_collision_layer_bit(0, false)
	set_collision_layer_bit(10, true)
	
	set_collision_mask_bit(0, false)
	set_collision_mask_bit(9, true)
	
	body = get_node(body_path)


func hurt(attack_data):
	body.hurt(attack_data)


func _get_configuration_warning():
	if body_path == "":
		return "BODY IS NEEDED!"
	
	return ""
