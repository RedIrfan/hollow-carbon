tool
class_name Hitbox
extends Area2D

export var body_path : NodePath = ""

var body : Node = null
var attack_data = {
	"damage"  : 0,
	"hitbox_position" : self.global_position,
	"body" : null,
}
var areas = []


func _ready():
	self.connect("area_entered", self, "_on_area_entered")
	self.connect("area_exited", self, "_on_area_exited")
	
	add_to_group("Hitbox")
	
	set_collision_layer_bit(0, false)
	set_collision_layer_bit(9, true)
	
	set_collision_mask_bit(11, false)
	set_collision_mask_bit(10, true)
	
	body = get_node(body_path)


func set_damage(ndamage:int):
	attack_data["damage"] = ndamage
	
	if ndamage > 0:
		for area in areas:
			area.hurt(get_attack_data())


func get_attack_data():
	attack_data["hitbox_position"] = self.global_position
	attack_data["body"] = body
	
	return attack_data


func _on_area_entered(area):
	if area.is_in_group("Hurtbox"):
		if area.body != body:
			areas.append(area)
			if attack_data["damage"] > 0:
				area.hurt(get_attack_data())


func _on_area_exited(area):
	if areas.has(area):
		areas.remove(areas.find(area))


func _get_configuration_warning():
	if body_path == "":
		return "BODY IS NEEDED!"
	
	return ""
