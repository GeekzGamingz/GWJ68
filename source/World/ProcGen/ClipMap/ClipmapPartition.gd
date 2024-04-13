@tool
#Inherits MeshInstance3D Code
extends MeshInstance3D
#------------------------------------------------------------------------------#
#Variables
var x
var z
#------------------------------------------------------------------------------#
#OnReady Variables
@onready var length = ProjectSettings.get_setting("shader_globals/clipmap_partition_length").value
@onready var lod_step = ProjectSettings.get_setting("shader_globals/lod_step").value
@onready var lod = max(abs(x), abs(z)) * lod_step
@onready var subdivision_length = pow(2, lod)
@onready var subdivides = max(length / subdivision_length - 1, 0)
#------------------------------------------------------------------------------#
#Ready
func _ready():
	mesh = PlaneMesh.new()
	mesh.size = Vector2.ONE * length
	position = Vector3(x, 0, z) * length
	mesh.subdivide_width = subdivides
	mesh.subdivide_depth = subdivides
