#Inherits CollisionShape3D Code
extends CollisionShape3D
#------------------------------------------------------------------------------#
#Variables
var entity
#Exported Variables
@export var template_mesh: PlaneMesh
#OnReady Variables
@onready var faces = template_mesh.get_faces()
@onready var snap = Vector3.ONE * template_mesh.size.x / 2
#------------------------------------------------------------------------------#
#Ready
func _ready():
	shape = ConcavePolygonShape3D.new()
	update_shape()
#------------------------------------------------------------------------------#
#Physics Process
func _physics_process(_delta):
	entity_collisions()
#------------------------------------------------------------------------------#
#Update Player Collisions
func entity_collisions():
	var entity_POS = entity.global_position
	var eRound_POS = entity_POS.snapped(snap) * Vector3(1, 0, 1)
	if !global_position == eRound_POS:
		global_position = eRound_POS
		update_shape()
#------------------------------------------------------------------------------#
#Update Collison Map
func update_shape():
	for f in faces.size():
		var global_vert = faces[f] + global_position
		faces[f].y = G.get_height(global_vert.x, global_vert.z)
	shape.set_faces(faces)
