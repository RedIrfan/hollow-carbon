class_name EventCameraPan
extends Event

var camera:Camera2D


func start():
	set_physics_process(true)
	camera = Global.stage_master().camera
	
	camera.pan(true, self.global_position)


func _physics_process(delta):
	if camera != null:
		var self_pos = self.global_position + camera.bonus_position
		if self_pos.distance_to(camera.global_position) <= 0.1:
			camera.pan(false)
			camera = null
			
			exit()
