#Inherits SpringArm3D Code
extends SpringArm3D
#------------------------------------------------------------------------------#
#Variables
#Exported Variables
@export var mouse_sensitivity = 0.05
@export var pitch = Vector2(-90.0, 30)
@export_enum("First", "Third") var PointOfView: String
#OnReady Variables
@onready var camera = $Camera3D
#------------------------------------------------------------------------------#
#Ready
func _ready():
	set_as_top_level(true)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
#------------------------------------------------------------------------------#
#Camera Input
func _input(_event):
	if Input.is_action_just_pressed("action_camera"):
		match(PointOfView):
			"First": #Switch to Third
				PointOfView = "Third"
				spring_length = 3
				camera.v_offset = 2
			"Third": #Switch to First
				PointOfView = "First"
				spring_length = -1
				camera.v_offset = 1.25
#------------------------------------------------------------------------------#
func _unhandled_input(event: InputEvent):
	if event is InputEventMouseMotion:
		#Rotates and Limits Camera
		rotation_degrees.x -= event.relative.y * mouse_sensitivity
		rotation_degrees.x = clamp(rotation_degrees.x, pitch.x, pitch.y)
		#Overflow Protection
		rotation_degrees.y -= event.relative.x * mouse_sensitivity
		rotation_degrees.y = wrapf(rotation_degrees.y, 0.0, 360.0)
