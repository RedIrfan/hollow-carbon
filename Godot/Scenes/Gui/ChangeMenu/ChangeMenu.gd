extends GuiChild

var selected_eye : int = Global.Eyes.METAL setget set_eye
var selected_core : int = Global.Cores.CARBON setget set_core

var ready : bool = false

onready var selected_core_rect : TextureRect = $SelectedCore
onready var selected_eye_rect : TextureRect = $SelectedEye


func _ready():
	ready = true


func physics_process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		exit()


func set_eye(new_eye, eye_position=Vector2.ZERO):
	selected_eye = new_eye
	selected_eye_rect.rect_global_position = eye_position


func set_core(new_core, core_position=Vector2.ZERO):
	selected_core = new_core
	selected_core_rect.rect_global_position = core_position
